using System;
using System.CodeDom;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Globalization;
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
            var tb1 = PUBS.sqlQuery(string.Format("select content from treatmentsuggestion where name='一般处理意见'"));
            cb_advice.DataSource = tb1;
            cb_advice.DataBind();
            txt_desc.Text = Request["desc"];

            var tb2 =
                PUBS.sqlQuery(
                    string.Format(
                        "select recheckValue from recheckTable where testDateTime='{0}' and carNo='{1}' and wheelPos='{2}' and checkItem='{3}'",
                        Request["testDateTime"], Request["carNo"], Request["zxj"] + "转向架","同转向架轮径差"));
            if (tb2 != null && tb2.Rows.Count > 0)
            {
                txt_ljcha_che.Text = tb2.Rows[0]["recheckValue"].ToString();
            }
        }
    }

    /// <summary>
    /// 获取检测值项
    /// </summary>
    /// <returns></returns>
    private string GetTestKey()
    {
        return "ljcha_che";
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
        var zxj = Request["zxj"];
        var checkItem = "同转向架轮径差";
        if (testDateTime == null || carNo == null||zxj==null)
        {
            return;
        }
        var text = RecheckLjc();
       if (text == null)
       {
           ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "alert",
               "alert('" + "请手动输入同车轮径差复核值或者填写至少两个轮子的轮径复核值" + "');", true);
       }
       txt_ljcha_che.Text = text.ToString();
        var recheckPerson = cb_recheckPerson.Text;
        var recheckOperator = Request["recheckOperator"];
        if (string.IsNullOrEmpty(recheckOperator))
        {
            recheckOperator = PUBS.GetUserDisplayName(Context.User.Identity.Name);
        }
        var advice = cb_advice.Text;
        var desc = txt_desc.Text;
        var sql1 = string.Format(
            "exec [dbo].[SetRecheck] '{0}'," +
            "'{1}','{2}'," +
            "'{3}','{4}','{5}'," +
            "'{6}','{7}','{8}','{9}'", testDateTime, carNo, zxj + "转向架", checkItem, GridView1.DataKeys[0]["同转向架轮径差"], text, recheckPerson, advice,
            recheckOperator, desc);
        PUBS.sqlQuery(sql1);
       for (int i =0;i<GridView1.Rows.Count;i++)
       {
           var recheckLj = GridView1.Rows[i].Cells[GridView1.Rows[i].Cells.Count - 1].FindControl("txt_recheckValue") as TextBox;
           if (string.IsNullOrEmpty(recheckLj.Text))
           {
               continue;
           }
           var axleNo = GridView1.DataKeys[i]["axleNo"];
           var wheelNo = GridView1.DataKeys[i]["wheelNo"];
           SaveRecheck(testDateTime, recheckLj.Text, axleNo, wheelNo);
       }


       ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "alert",
           "alert('" + "复核数据已提交" + "');", true);
    }

    private static void SaveRecheck( string testDateTime,
        string recheckValue,  object axleNo,
        object wheelNo)
    {
        var item = "wx_lj";
        var sql = string.Format(
            "if(not exists(select * from recheck where testdatetime='{0}' and axleNo={1} and wheelNo={2})) " +
            "insert into recheck (testDateTime,axleNo,wheelNo) values('{0}',{1},{2})" +
            "update recheck set {3}='{4}' where testDateTime='{0}' and axleNo={1} and wheelNo={2}",
            testDateTime, axleNo, wheelNo, item, recheckValue);
        PUBS.sqlQuery(sql);
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
    protected void GridView1_PreRender(object sender, EventArgs e)
    {
        txt_ljcha_che.Text = RecheckLjc().ToString();
    }

    private decimal? RecheckLjc()
    {
        var recheckLjs = new List<decimal>();
        foreach (GridViewRow row in GridView1.Rows)
        {
            var textBox = row.Cells[row.Cells.Count - 1].FindControl("txt_recheckValue") as TextBox;
            if (textBox == null)
            {
                continue;
            }
            var cellText = textBox.Text;
            if (cellText != null)
            {
                decimal value;
                if (decimal.TryParse(cellText, out value))
                {
                    recheckLjs.Add(value);
                }
            }
        }
        if (recheckLjs.Count <= 1)
        {
            decimal ret;
            if (decimal.TryParse(txt_ljcha_che.Text, out ret))
            {
                return ret;
            }
            return null;
        }
        recheckLjs.Sort();
        var data = Math.Abs(recheckLjs[recheckLjs.Count - 1] - recheckLjs[0]);
        if (txt_ljcha_che.Text!=""&&txt_ljcha_che.Text != data.ToString(CultureInfo.InvariantCulture))
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "alert",
                "alert('" + "同转向架轮径差，由复核轮径自动计算得出" + "');", true);
        }
        return data;
    } 
}
