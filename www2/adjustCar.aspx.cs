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
            NewTrainBtn.Text = "开始增加";
            CancelBtn.Visible = false;
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
        Session["OldTrainNoFrom"] = e.OldValues["trainNoFrom"];
        Session["OldTrainNoTo"] = e.OldValues["trainNoTo"];
        Session["TrainNoFrom"] = e.NewValues["trainNoFrom"];
        Session["TrainNoTo"] = e.NewValues["trainNoTo"];
        Session["TrainType"] = e.NewValues["trainType"];
        Session["Format"] = e.NewValues["format"];
        var row = GridView1.Rows[e.RowIndex];
    }
    
    protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
    }
    protected void NewTrainType_Click(object sender, EventArgs e)
    {
        if (!GridView1.ShowFooter)
        {
            GridView1.ShowFooter = true;
            NewTrainBtn.Text = "增加";
            CancelBtn.Visible = true;
            return;
        }
        TextBox trainType = GridView1.FooterRow.FindControl("trainTypeTxt") as TextBox;
        TextBox trainNoFrom = GridView1.FooterRow.FindControl("trainNoFromTxt") as TextBox;
        TextBox trainNoTo = GridView1.FooterRow.FindControl("trainNoToTxt") as TextBox;
        TextBox format = GridView1.FooterRow.FindControl("formatTxt") as TextBox;
        if (trainNoFrom.Text == "" || trainNoTo.Text == "")
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "alert", "alert('" + "“车号开始数字”和“车号结束数字”不能为空！" + "');", true);
            return;
        }
        Session["TrainType"] = trainType.Text;
        Session["TrainNoFrom"] = trainNoFrom.Text;
        Session["TrainNoTo"] = trainNoTo.Text;
        Session["Format"] = format.Text;
        SqlDataSource1.Insert();
    }
    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        var row = GridView1.Rows[e.RowIndex];
        var a = row.FindControl("trainNoFromLbl") as Label;
        var b = row.FindControl("trainNoToLbl") as Label;
        SqlDataSource1.DeleteCommand = string.Format(
            "delete from dbo.TrainType where trainNoFrom={0} and trainNoTo={1}", a.Text, b.Text);
        SqlDataSource1.Delete();
    }

    protected void Cancel_Click(object sender, EventArgs e)
    {
        CancelBtn.Visible = false;
        GridView1.ShowFooter = false;
        NewTrainBtn.Text = "开始增加";
    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "check")
        {
            Response.Redirect("adjustCarPower.aspx?trainType=" + e.CommandArgument);
        }
    }

}
