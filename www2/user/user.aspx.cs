using System;
using System.Collections;
using System.Configuration;
using System.Data;
//using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
//using System.Xml.Linq;

public partial class user_user : System.Web.UI.Page
{
    public string username;
    public MembershipUser mu;
    public string js;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["login"] == null)
            Response.Redirect(PUBS.HomePage);

        
        username = Request.QueryString["name"];
        mu = Membership.GetUser(username);
        string[] jsArr = Roles.GetRolesForUser(mu.UserName);
        foreach (string jss in jsArr)
        {
            js += jss + "　";
        }

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (username == "admin")
            Response.Write("<script language=javascript>alert(\'管理员admin不能被删除！\');</script>");
        else
        {
            Membership.DeleteUser(username);
            PUBS.Log(Request.UserHostAddress, Membership.GetUser().UserName, 5, username);

            Response.Redirect("userList.aspx");
        }
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        if (mu.IsLockedOut)
        {
            mu.UnlockUser();
        }
        Random r = new Random();
        string password = r.Next(100000, 1000000).ToString(); //重置一个随机密码
        mu.ChangePassword(mu.ResetPassword(), password);
        PUBS.Log(Request.UserHostAddress, Membership.GetUser().UserName, 3, mu.UserName);

        Response.Write("<script language=javascript>alert(\'密码已初始化为："+password+"\');</script>");
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
}
