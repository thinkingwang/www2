using System;
using System.Collections;
using System.Collections.Generic;
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
        if (!IsPostBack)
        {
            var text = Request["roleName"];
            if (string.IsNullOrEmpty(text))
            {
                return;
            }
            tb_RoleName.Text = text;
            ddl_RoleLevel.Text = PUBS.GetRoleLevel(text);
            txt_desc.Text = PUBS.GetRoleDesc(text);
        }
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
    
  
   

    protected void createRole_Click(object sender, EventArgs e)
    {
        Response.Redirect("newRole.aspx");
    }
    protected void submit_btn_Click(object sender, EventArgs e)
    {
        var roleNameOld = Request["roleName"];
        var roleNameNew = tb_RoleName.Text;
        var desc = txt_desc.Text;
        var roleLevel = ddl_RoleLevel.Text;
        List<Tuple<string,bool>> lists = new List<Tuple<string, bool>>();
        foreach (GridViewRow row in GridView1.Rows)
        {
            var checkBox = row.Cells[2].FindControl("isAllowed") as CheckBox;
            if (checkBox == null)
            {
                continue;
            }
            lists.Add(new Tuple<string,bool>(row.Cells[1].Text,checkBox.Checked));
        }
        PUBS.SetRole(roleNameOld, roleNameNew, desc, roleLevel, lists);
    }
    protected void cancel_btn_Click(object sender, EventArgs e)
    {
        Response.Redirect("../DetectList.aspx");
    }
}
