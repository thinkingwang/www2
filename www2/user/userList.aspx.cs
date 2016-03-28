using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
//using System.Linq;
using System.Web;
using System.Web.ApplicationServices;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
//using System.Xml.Linq;

public partial class user_userList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["login"] == null)
            Response.Redirect(PUBS.HomePage);
        if (PUBS.GetUserLevel() != 0)
        {
            Response.Write("<script>alert(\'无权限\');</script>");
            Response.Redirect(PUBS.HomePage);
        }
        var name = PUBS.GetUserDisplayName(Context.User.Identity.Name);
        LoginName2.FormatString = name;

    }

    protected void bt_need_Click(object sender, EventArgs e)
    {
        Response.Redirect("newuser.aspx");
    }
    protected void LoginStatus2_LoggedOut(object sender, EventArgs e)
    {
        Session.Remove("login");
        PUBS.Log(Request.UserHostAddress, Membership.GetUser().UserName, 0, this.GetType().FullName);

    }
    protected void bt_back_Click(object sender, EventArgs e)
    {
        Response.Redirect("../DetectList.aspx");
    }
    protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        Session["DisplayName"] = e.NewValues["DisplayName"];
        Session["UserName"] = e.OldValues["UserName"];
        var row = GridView1.Rows[e.RowIndex];
        DropDownList dropDown = row.FindControl("dl_roles") as DropDownList;
        DropDownList dropDownde = row.FindControl("DepartList") as DropDownList;
        if (dropDownde != null)
        {
            Session["Department"] = dropDownde.Text;
        }
        if (dropDown == null)
        {
            return;
        }
        var roles = Roles.GetRolesForUser(e.OldValues["UserName"].ToString());
        foreach (var role in roles)
        {
            Roles.RemoveUserFromRole(e.OldValues["UserName"].ToString(), role);
        }
        Roles.AddUserToRole(e.OldValues["UserName"].ToString(), dropDown.SelectedValue);
    }
    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        var userName = e.Values["UserName"].ToString();
        SqlDataSource1.DeleteCommand = string.Format(
            "declare @userId uniqueidentifier" +
            " if(exists(select * from aspnet_Users where UserName='{0}')) " +
            "begin " +
            "select @userId=UserId from aspnet_Users where UserName='{0}' " +
            "delete from aspnet_Membership where UserId=@userId " +
            "delete from aspnet_UsersInRoles where UserId=@userId " +
            "delete from aspnet_Users where UserName='{0}' end",
            userName);
        SqlDataSource1.Delete();
    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        
        var name = e.CommandName;
        var row = GridView1.Rows[Convert.ToInt16(e.CommandArgument)];
        var userName = row.Cells[1].Text;
        if (name == "changePassword")
        {
            Response.Redirect(String.Format("/userinfo.aspx?userName={0}", userName));
        }
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            SetLevelValue(e, "RoleName","dl_roles");
            SetLevelValue(e, "Department", "DepartList");
            //dpdListUp3.Enabled = false;
        }
    }

    private  void SetLevelValue(GridViewRowEventArgs e, string element,string id)
    {
        Label up3Value = e.Row.FindControl(element) as Label;
        if (up3Value == null)
        {
            var value = DataBinder.Eval(e.Row.DataItem, element).ToString();
            var up3Tbx = e.Row.FindControl(id) as DropDownList;
            if (up3Tbx == null)
            {
                return;
            }
            up3Tbx.Text = value;
        }
        else
        {
            up3Value.Text = DataBinder.Eval(e.Row.DataItem, element).ToString();
        }
    }

    protected void createRole_Click(object sender, EventArgs e)
    {
        Response.Redirect("newRole.aspx");
    }
}
