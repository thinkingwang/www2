using System;
using System.CodeDom;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using Microsoft.Ajax.Utilities;

//using System.Xml.Linq;

public partial class Verify : System.Web.UI.Page
{
   

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["login"] == null)
            Response.Redirect(PUBS.HomePage);
        if (PUBS.GetUserLevel() > 1)
        {
            Response.Write("<script>alert(\'无权限\');</script>");
            Response.Redirect(PUBS.HomePage);
        }

        var name = PUBS.GetUserDisplayName(Context.User.Identity.Name);
        LoginName2.FormatString = name;
        if (!IsPostBack)
        {
            var testDateTime = Request["testDateTime"];
            var carNo = Request["carNo"];
            var wheelPos = Request["wheelPos"];
            if (testDateTime == null || carNo == null || wheelPos == null )
            {
                return;
            }
             
            txt_desc.Text = Request["desc"];
            if (Request["checkItem"] != "探伤" && Request["checkItem"] != "擦伤")
            {
               var tb1 = PUBS.sqlQuery(string.Format("select content from treatmentsuggestion where name='一般处理意见'"));
                cb_advice.DataSource = tb1;
                cb_advice.DataBind();
            }
            if (Request["checkItem"] == "探伤")
            {
                var tb1 = PUBS.sqlQuery(string.Format("select content from treatmentsuggestion where name='探伤处理意见'"));
                if (tb1 == null || tb1.Rows.Count == 0)
                {
                    return;
                }
                cb_advice.DataSource = tb1;
                cb_advice.DataBind();
            }
            //txt_recheckOperator.Text = Request["recheckOperator"];
        }
    }

    /// <summary>
    /// 获取检测值项
    /// </summary>
    /// <returns></returns>
    private string GetTestKey()
    {
        switch (Request["checkItem"])
        {
            case "踏面磨耗":
                return "TmMh";
            case "内侧距":
                return "Ncj";
            case "轮缘厚度":
                return "LyHd";
            case "轮缘高度":
                return "LyGd";
            case "轮辋宽度":
                return "LwHd";
            case "QR值":
                return "QR";
            default:
                return "lj";
        }
    }

    /// <summary>
    /// 获取检测值项
    /// </summary>
    /// <returns></returns>
    private string GetRecheckValue()
    {
        var testDateTime = Request["testDateTime"];
        var carNo = Request["carNo"];
        var wheelPos = Request["wheelPos"];
        var checkItem = Request["checkItem"];
        if (testDateTime == null || carNo == null || wheelPos == null || checkItem == null)
        {
            return null;
        }
        var tb1 = PUBS.sqlQuery(string.Format("exec dbo.GetWheelDataByCarNoAndWheelPos '{0}','{1}','{2}'", testDateTime, carNo, wheelPos));
        if (tb1 == null)
        {
            return null;
        }
        var axleNo = tb1.Rows[0]["axleNo"];
        var wheelNo = tb1.Rows[0]["wheelNo"];
        var sql = string.Format("exec dbo.GetValueByCheckItemFromRecheck '{0}',{1},{2},'{3}'", testDateTime, axleNo,
            wheelNo, checkItem);
        var tb = PUBS.sqlQuery(sql);
        if (tb == null || tb.Rows.Count == 0)
        {
            return null;
        }
        var recheckValue = tb.Rows[0]["recheckValue"].ToString();
        return recheckValue;
    }
    protected void LoginStatus2_LoggedOut(object sender, EventArgs e)
    {
        Session.Remove("login");
        PUBS.Log(Request.UserHostAddress, Membership.GetUser().UserName, 0, this.GetType().FullName);
    }


   /// <summary>
   /// 提交保存复核数据
   /// </summary>
   /// <param name="sender"></param>
   /// <param name="e"></param>
    protected void btCommit_Click(object sender, EventArgs e)
    {
        if (Session["login"] == null)
            Response.Redirect(PUBS.HomePage);
        var testDateTime = Request["testDateTime"];
        var carNo = Request["carNo"];
        var wheelPos = Request["wheelPos"];
        if (testDateTime == null || carNo == null || wheelPos == null)
        {
            return;
        }
       
        var advice = cb_advice.Text;
        var desc = txt_desc.Text;
        var recheckPerson = cb_recheckPerson.Text;
        var recheckOperator = Request["recheckOperator"];
        if (string.IsNullOrEmpty(recheckOperator))
        {
            recheckOperator = PUBS.GetUserDisplayName(Context.User.Identity.Name);
        }
        var sql1 = string.Format(
            "exec [dbo].[SetRecheckForTanShang] '{0}'," +
            "'{1}','{2}'," +
            "'{3}','{4}','{5}'," +
            "'{6}'", testDateTime, carNo, wheelPos + "位", recheckPerson, advice,
            recheckOperator, desc);
        PUBS.sqlQuery(sql1);
        ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "alert",
            "alert('" + "复核数据已提交" + "');", true);
    }
    
    protected void bt_back_Click(object sender, EventArgs e)
    {
        //Response.Redirect(string.Format("Details_kc.aspx?field={0}", datetimestr).Replace(':', '_'));
    }
    protected void cb_recheckPerson_PreRender(object sender, EventArgs e)
    {
        if (IsPostBack)
        {
            return;
        }
        var item = cb_recheckPerson.Items.FindByText(Request["recheckPerson"]);
        if (item == null)
        {
            return;
        }
        cb_recheckPerson.Text = Request["recheckPerson"];
    }

    protected void cb_advice_PreRender(object sender, EventArgs e)
    {
        if (IsPostBack)
        {
            return;
        }
        var item = cb_advice.Items.FindByText(Request["advice"]);
        if (item == null)
        {
            return;
        }
        cb_advice.Text = Request["advice"];
    }
}
