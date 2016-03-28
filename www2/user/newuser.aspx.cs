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
//using System.Xml.Linq;

public partial class newuser : System.Web.UI.Page
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
    }
    protected void CreateUserWizard1_CreatedUser(object sender, EventArgs e)
    {
        var userName = CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("UserName") as TextBox;
            Roles.AddUserToRole(userName.Text, dl_roles.SelectedValue);
            
            PUBS.Log(Request.UserHostAddress, Membership.GetUser().UserName, 4, CreateUserWizard1.UserName);
    }
    protected void LoginStatus2_LoggedOut(object sender, EventArgs e)
    {
        Session.Remove("login");
        PUBS.Log(Request.UserHostAddress, Membership.GetUser().UserName, 0, this.GetType().FullName);
    }
    protected void bt_back_Click(object sender, EventArgs e)
    {
        Response.Redirect("userList.aspx");
    }
    protected void CreateUserWizard1_CreatingUser(object sender, LoginCancelEventArgs e)
    {
        if (CreateUserWizard1.UserName.Length > 20)
        {
            e.Cancel = true;
            Label1.Visible = true;
        }
        else
            Label1.Visible = false;
    }
    protected void CreateUserWizard1_CreateUserError(object sender, CreateUserErrorEventArgs e)
    {
        //Response.Write("<script language=javascript>alert(\'创建新用户失败：\r用户名长度不能超过20字符\');</script>");

    }
}
