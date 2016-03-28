using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;

//using System.Xml.Linq;

public partial class Verify : System.Web.UI.Page
{
    public string datetimestr;
    public int axleNo;
    public int axleNum;
    public string bzh;
    public string carNo;
    public int wheelNo;
    public int wheelPos;
    public string[] sLevelStyle;
    public string sL1 = PUBS.Txt("I");
    public string sL2 = PUBS.Txt("II");
    public string sL3 = PUBS.Txt("III");
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
        if (!Page.IsPostBack)
        {
            GridView1.DataBind();
            GridView1.ShowFooter = false;
            datepickerEnd.Text = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            datepickerStart.Text = DateTime.Now.AddDays(-7).ToString("yyyy-MM-dd HH:mm:ss");
        }
        ScriptManager.RegisterStartupScript(Page, typeof(string), "reload", "reload();", true);
    }
    protected void LoginStatus2_LoggedOut(object sender, EventArgs e)
    {
        Session.Remove("login");
        PUBS.Log(Request.UserHostAddress, Membership.GetUser().UserName, 0, this.GetType().FullName);
    }


   
    
    protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
    }
   

    protected void SelectAllWhprBtn_Click(object sender, EventArgs e)
    {
        foreach (ListItem item in CheckBoxList1.Items)
        {
            item.Selected = true;
        }
    }

    protected void SelectAllCsBtn_Click(object sender, EventArgs e)
    {
        foreach (ListItem item in CheckBoxList2.Items)
        {
            item.Selected = true;
        }
    }
    protected void SelectAllTsBtn_Click(object sender, EventArgs e)
    {
        foreach (ListItem item in CheckBoxList3.Items)
        {
            item.Selected = true;
        }
    }

    protected void CheckBtn_OnClick(object sender, EventArgs e)
    {
        DataTable tb = new DataTable();
        var engNum = DropDownList1.Text;
        var startTime = datepickerStart.Text;
        var endTime = datepickerEnd.Text;
        if (string.IsNullOrEmpty(startTime) || string.IsNullOrEmpty(endTime))
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "alert",
                "alert('" + "“开始时间”和“结束时间”不能为空！" + "');", true);
            return;
        }
        var itemsProfiles = from ListItem item in CheckBoxList1.Items
            where item.Selected
            select new Tuple<string, string>(item.Text, item.Value);
        var itemsCaShangs = from ListItem item in CheckBoxList2.Items
            where item.Selected
            select new Tuple<string, string>(item.Text, item.Value);
        var itemsTanShangs = from ListItem item in CheckBoxList3.Items
            where item.Selected
            select new Tuple<string, string>(item.Text, item.Value);
        StringBuilder profileFields = new StringBuilder();
        StringBuilder csFields = new StringBuilder();
        foreach (Tuple<string, string> profile in itemsProfiles)
        {
            profileFields.Append(profile.Item1 + '&' + profile.Item2 + '$');
        }
        foreach (Tuple<string, string> profile in itemsCaShangs)
        {
            csFields.Append(profile.Item1 + '&' + profile.Item2 + '$');
        }
        if (profileFields.Length > 0)
        {
            profileFields.Remove(profileFields.Length - 1, 1);
        }
        if (csFields.Length > 0)
        {
            csFields.Remove(csFields.Length - 1, 1);
        }
        var carNo = DropDownList3.Text == "全部" ? "All" : DropDownList3.Text;
        var wheelPos = DropDownList2.Text == "全部" ? "All" : DropDownList2.SelectedValue;
        var sql = string.Format("exec dbo.gethistorydata '{0}' ,'{1}','{2}','{3}','{4}','{5}','{6}'", startTime, endTime,
            engNum, carNo, wheelPos, profileFields, csFields);
        tb =
            PUBS.sqlQuery(string.Format("exec dbo.gethistorydata '{0}' ,'{1}','{2}','{3}','{4}','{5}','{6}'", startTime,
                endTime, engNum, carNo, wheelPos, profileFields, csFields));
        GridView1.DataSource = tb;
        GridView1.DataBind();
    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        var a = GridView1.PageIndex;
        var b = GridView1.PageSize;
    }

    private void BindCarNo()
    {
        var engNum = DropDownList1.Text;
        var tb = PUBS.sqlQuery(
            string.Format(
                "select carNo from carlist where testdatetime in(select top 1 A.testDatetime from Detect as A left join CarList as B on A.testDatetime=B.testDateTime where A.engNum='{0}' order by A.testDateTime desc)",
                engNum));
        var row = tb.NewRow();
        row[0] = "全部";
        tb.Rows.InsertAt(row, 0);
        DropDownList3.Items.Clear();
        DropDownList3.DataSource = tb;
        DropDownList3.DataBind();
    }
    protected void DropDownList1_PreRender(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindCarNo();
        }
    }
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindCarNo();
    }

   
    
   

    protected void DownloadBtn_OnClick(object sender, EventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            //调用导出方法  
            ExportGridViewForUTF8(GridView1, DateTime.Now.ToString("yyyyMMddHHmmssfff") + ".xls");
        }
        else
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "alert", "alert('" + "没有数据可导出，请先查询数据!" + "');", true);
            
            //obo.Common.MessageBox.Show(this, "没有数据可导出，请先查询数据!");
        }
    }

    /// <summary>  
    /// 重载，否则出现“类型“GridView”的控件“GridView1”必须放在具有 runat=server 的窗体标... ”的错误  
    /// </summary>  
    /// <param name="control"></param>  
    public override void VerifyRenderingInServerForm(Control control)
    {
        //base.VerifyRenderingInServerForm(control);  
    }

    /// <summary>  
    /// 导出方法  
    /// </summary>  
    /// <param name="GridView"></param>  
    /// <param name="filename">保存的文件名称</param>  
    private void ExportGridViewForUTF8(GridView GridView, string filename)
    {

        string attachment = "attachment; filename=" + filename;

        Response.ClearContent();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", attachment);

        Response.Charset = "UTF-8";
        Response.ContentEncoding = System.Text.Encoding.GetEncoding("UTF-8");
        Response.ContentType = "application/ms-excel";
        System.IO.StringWriter sw = new System.IO.StringWriter();

        HtmlTextWriter htw = new HtmlTextWriter(sw);
        GridView.RenderControl(htw);

        Response.Output.Write(sw.ToString());
        Response.Flush();
        Response.End();

    }
    /// <summary>
    /// 外形全不选
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void UnSelectAllWhprBtn_Click(object sender, EventArgs e)
    {
        foreach (ListItem item in CheckBoxList1.Items)
        {
            item.Selected = false;
        }
    }

    /// <summary>
    /// 擦伤全不选
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void UnSelectAllCsBtn_Click(object sender, EventArgs e)
    {
        foreach (ListItem item in CheckBoxList2.Items)
        {
            item.Selected = false;
        }
    }

    /// <summary>
    /// 探伤全不选
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void UnSelectAllTsBtn_Click(object sender, EventArgs e)
    {

        foreach (ListItem item in CheckBoxList3.Items)
        {
            item.Selected = false;
        }
    }

}
