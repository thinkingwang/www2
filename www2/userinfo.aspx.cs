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

public partial class userinfo : System.Web.UI.Page
{
    public string username;
    public MembershipUser mu;
    public string js;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["login"] == null)
            Response.Redirect(PUBS.HomePage);
        var name = PUBS.GetUserDisplayName(Context.User.Identity.Name);
        LoginName2.FormatString = name;
        var userName = Request["userName"];
        if (!string.IsNullOrEmpty(userName))
        {
            ChangePassword1.UserName = userName;

            mu = Membership.GetUser(userName);
            username = mu.UserName;
            string[] jsArr = Roles.GetRolesForUser(userName);
            foreach (string jss in jsArr)
            {
                js += jss + "　";
            }
        }
        else
        {
            mu = Membership.GetUser();
            username = mu.UserName;
            string[] jsArr = Roles.GetRolesForUser();
            foreach (string jss in jsArr)
            {
                js += jss + "　";
            }
        }

    }
    protected void LoginStatus2_LoggedOut(object sender, EventArgs e)
    {
        Session.Remove("login");
        PUBS.Log(Request.UserHostAddress, Membership.GetUser().UserName, 0, this.GetType().FullName);

    }
    protected void bt_back_Click(object sender, EventArgs e)
    {
        Response.Redirect("DetectList.aspx");
    }
    protected void ChangePassword1_ChangedPassword(object sender, EventArgs e)
    {
        PUBS.Log(Request.UserHostAddress, Membership.GetUser().UserName, 3, this.GetType().FullName);
    }
}
