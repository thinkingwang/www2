using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
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
        var name = PUBS.GetUserDisplayName(Context.User.Identity.Name);
        LoginName2.FormatString = name;
        if (!IsPostBack)
        {
            if (GetCurrentUserLevel() != 1)
            {
                bt_need.Visible = false;
                createRoleBtn.Visible = false;
            }
        }
    }

    protected void bt_need_Click(object sender, EventArgs e)
    {
        if (GetCurrentUserLevel() != 1)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "alert", "alert('" + "非管理员不允许增加用户" + "');", true);
            return;
        }
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
        if (dropDown.SelectedValue != e.OldValues["UserName"].ToString())
        {
            if (GetCurrentUserLevel() != 1)
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "alert", "alert('" + "非管理员不允许操作角色,角色列不更新" + "');", true);
                return;
            }
            var roles = Roles.GetRolesForUser(e.OldValues["UserName"].ToString());
            foreach (var role in roles)
            {
                Roles.RemoveUserFromRole(e.OldValues["UserName"].ToString(), role);
            }
            Roles.AddUserToRole(e.OldValues["UserName"].ToString(), dropDown.SelectedValue);
        }
        PUBS.Log(Request.UserHostAddress, PUBS.GetCurrentUser(), 31, PUBS.GetLogContect(',', "更改的用户名为：" + e.OldValues["UserName"]));
    }
    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        var user = Context.User.Identity.Name;
        var roleLogin = Roles.GetRolesForUser(user)[0];
        var levelLogin = PUBS.GetRoleLevel(roleLogin).TrimEnd('级');
        var row = GridView1.Rows[e.RowIndex];
        if (row != null)
        {
            var roleName = row.Cells[3].FindControl("RoleName") as Label;
            if (roleName == null)
            {
                return;
            }
            var level = PUBS.GetRoleLevel(roleName.Text).TrimEnd('级');
            if (Convert.ToInt32(level) <= Convert.ToInt32(levelLogin))
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "alert", "alert('" + "无权操作" + "');", true);
                e.Cancel = true;
                return;
            }
        }
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
        PUBS.Log(Request.UserHostAddress, PUBS.GetCurrentUser(), 5, PUBS.GetLogContect(',', "删除的用户名为：" + userName));
    }

    public int GetCurrentUserLevel()
    {
        var user = Context.User.Identity.Name;
        var roleLogin = Roles.GetRolesForUser(user)[0];
        var levelLogin = PUBS.GetRoleLevel(roleLogin).TrimEnd('级');
        return Convert.ToInt32(levelLogin);
    }
    public int GetRoleLevel(string roleName)
    {
        var level = PUBS.GetRoleLevel(roleName).TrimEnd('级');
        return Convert.ToInt32(level);
    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        var name = e.CommandName;
        var row = GridView1.Rows[Convert.ToInt16(e.CommandArgument)];
        var userName = row.Cells[1].Text;
        if (name == "changePassword")
        {
            var user = Context.User.Identity.Name;
            var roleLogin = Roles.GetRolesForUser(user)[0];
            var levelLogin = PUBS.GetRoleLevel(roleLogin).TrimEnd('级');
            var roleName = row.Cells[3].FindControl("RoleName") as Label;
            if (roleName == null)
            {
                return;
            }
            var level = PUBS.GetRoleLevel(roleName.Text).TrimEnd('级');
            if (Convert.ToInt32(level) <= Convert.ToInt32(levelLogin)&&user!=row.Cells[1].Text)
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "alert", "alert('" + "无权操作" + "');",
                    true);
                return;
            }
            Response.Redirect(String.Format("/userinfo.aspx?userName={0}", userName));
        }
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            SetLevelValue(e, "RoleName","dl_roles");
            SetLevelValue(e, "Department", "DepartList");
            var roleName = e.Row.Cells[3].FindControl("RoleName") as Label;
            var userName = e.Row.Cells[1].Text;
            if (roleName == null)
            {
                return;
            }
            if (GetCurrentUserLevel() >= GetRoleLevel(roleName.Text) && Context.User.Identity.Name != userName)
            {
                var btn = e.Row.Cells[5].Controls[0] as LinkButton;
                if (btn != null)
                {
                    btn.Enabled = false;
                    btn.ForeColor = Color.Gray;
                }
                btn = e.Row.Cells[5].Controls[2] as LinkButton;
                if (btn != null)
                {
                    btn.Enabled = false;
                    btn.ForeColor = Color.Gray;
                }
                btn = e.Row.Cells[6].Controls[0] as LinkButton;
                if (btn != null)
                {
                    btn.Enabled = false;
                }
            }
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
        if (GetCurrentUserLevel() != 1)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "alert", "alert('" + "非管理员不允许操作角色" + "');", true);
            return;
        }
        Response.Redirect("newRole.aspx");
    }
    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {
        var user = Context.User.Identity.Name;
        var roleLogin = Roles.GetRolesForUser(user)[0];
        var levelLogin = PUBS.GetRoleLevel(roleLogin).TrimEnd('级');
        var row = GridView1.Rows[e.NewEditIndex];
        if (row != null)
        {
            var roleName = row.Cells[3].FindControl("RoleName") as Label;
            if (roleName == null)
            {
                return;
            }
            var level = PUBS.GetRoleLevel(roleName.Text).TrimEnd('级');
            if (Convert.ToInt32(level) <= Convert.ToInt32(levelLogin) && user != row.Cells[1].Text)
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "alert", "alert('" + "无权操作" + "');", true);
                e.Cancel = true;
            }
        }
    }
}
