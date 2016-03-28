using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Data.SqlClient;
using AjaxControlToolkit;

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
        if (!IsPostBack)
        {
        }
        var name = PUBS.GetUserDisplayName(Context.User.Identity.Name);
        LoginName2.FormatString = name;
        if (!Page.IsPostBack)
        {
            GridView1.DataBind();
            GridView1.ShowFooter = false;
        }
    }
    protected void LoginStatus2_LoggedOut(object sender, EventArgs e)
    {
        Session.Remove("login");
        PUBS.Log(Request.UserHostAddress, Membership.GetUser().UserName, 0, this.GetType().FullName);
    }


    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GridView1.EditIndex = e.NewEditIndex;
        GridView1.DataBind();
    }


    protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        var row = GridView1.Rows[e.RowIndex];
        var combox = row.Cells[8].FindControl("cb_recheckPerson") as ComboBox;
        if (combox != null)
        {
            Session["recheckPerson"] = combox.Text;
        }
        Session["testDatetime"] = e.OldValues["检测时间"];
        Session["carNo"] = e.OldValues["车厢号"];
        Session["wheelPos"] = e.OldValues["轮位"];
        Session["checkItem"] = e.OldValues["检测项"];
        Session["checkValue"] = e.OldValues["检测值"];
        Session["recheckValue"] = e.NewValues["复核值"];
        Session["level"] = e.OldValues["报警级别"];
        Session["recheckDesc"] = e.NewValues["处理意见"];
        if (e.OldValues["处理人"] == null)
        {
            Session["operator"] = PUBS.GetUserDisplayName(Context.User.Identity.Name);
        }
        else
        {
            Session["operator"] = e.OldValues["处理人"];
        }
        Session["description"] = e.NewValues["备注"];
        GridView1.EditIndex = -1;
        GridView1.DataBind();
    }
    protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
    }
   

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowState == (DataControlRowState.Edit | DataControlRowState.Alternate) || e.Row.RowState == DataControlRowState.Edit)
        {
            TextBox curText;
            for (int i = 0; i < e.Row.Cells.Count; i++)
            {
                if (e.Row.Cells[i].Controls.Count != 0)
                {
                    curText = e.Row.Cells[i].Controls[0] as TextBox;
                    if (curText != null)
                    {
                        //curText.Width = Unit.Pixel(80);//寬度自己設
                        curText.Width = Unit.Percentage(100);//寬度自己設
                        continue;
                    }
                    var sql = string.Format(
                        "select recheckPerson from dbo.recheckTable where testDatetime='{0}' and carNo='{1}' and wheelPos='{2}' and checkItem='{3}'",
                        e.Row.Cells[1].Text, e.Row.Cells[3].Text, e.Row.Cells[4].Text, e.Row.Cells[5].Text);
                    var table =
                        PUBS.sqlQuery(sql);
                    if (table == null || table.Rows.Count == 0)
                    {
                        continue;
                    }
                    var recheckPerson = table.Rows[0]["recheckPerson"].ToString();
                    if (!string.IsNullOrEmpty(recheckPerson))
                    {
                        var combox = e.Row.FindControl("cb_recheckPerson") as ComboBox;
                        if (combox == null)
                        {
                            continue;
                        }
                        var item = combox.Items.FindByText(recheckPerson);
                        if (item != null)
                        {
                            combox.Text = recheckPerson;
                        }
                    }
                }
            }
        }
    }

}
