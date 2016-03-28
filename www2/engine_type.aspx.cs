using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

public partial class engine_engine : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["login"] == null)
            Response.Redirect("login.aspx");

        var name = PUBS.GetUserDisplayName(Context.User.Identity.Name);
        //LoginName2.FormatString = name;
    }
    protected void LoginStatus2_LoggedOut(object sender, EventArgs e)
    {
        Session.Remove("login");
        PUBS.Log(Request.UserHostAddress, Membership.GetUser().UserName, 0, this.GetType().FullName);
    }
    protected void bt_insert_Click1(object sender, EventArgs e)
    {
        try
        {
            TextBox tb_id = GridView1.FooterRow.FindControl("tb_id") as TextBox;
            //TextBox tb_name = GridView1.FooterRow.FindControl("tb_name") as TextBox;
            SqlDataSource_engineType.InsertParameters["id"].DefaultValue = tb_id.Text;
            //SqlDataSource_engineType.InsertParameters["name"].DefaultValue = tb_name.Text;
            SqlDataSource_engineType.Insert();
            //PUBS.Log(Request.UserHostAddress, Membership.GetUser().UserName, 11, tb_name.Text);
        }
        catch
        {
            string Message = "增加数据失败，请检查录入数据是否正确！";
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "alert", "alert('" + Message + "');", true);
        }

    }
    protected void bt_add_Click(object sender, EventArgs e)
    {
        GridView1.ShowFooter = !GridView1.ShowFooter;
        if (GridView1.ShowFooter)
            bt_add.Text = "取  消";
        else
            bt_add.Text = "新  增";

    }
    protected void bt_back_Click(object sender, EventArgs e)
    {
        Response.Redirect("DetectList.aspx");

    }
    protected void GridView1_RowUpdated(object sender, GridViewUpdatedEventArgs e)
    {
        //PUBS.Log(Request.UserHostAddress, Membership.GetUser().UserName, 9, e.OldValues[0].ToString() + " to " +e.NewValues[0].ToString());
    }
    protected void GridView1_RowDeleted(object sender, GridViewDeletedEventArgs e)
    {
        //PUBS.Log(Request.UserHostAddress, Membership.GetUser().UserName, 10, e.Values[0].ToString());
    }

}
