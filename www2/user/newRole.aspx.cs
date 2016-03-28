using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
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
        if (!IsPostBack)
        {
            BindRoles();
        }
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


    protected void CreateUserWizard1_CreateUserError(object sender, CreateUserErrorEventArgs e)
    {
        //Response.Write("<script language=javascript>alert(\'创建新用户失败：\r用户名长度不能超过20字符\');</script>");

    }

    public void createRoles()
    {
        try
        {
            if (!Roles.RoleExists(txtrolename.Text))
            {
                
                Roles.CreateRole(txtrolename.Text);
                BindRoles();
                Label1.Text = "增加角色\"" + txtrolename.Text + "\"成功";
            }
            else
            {
                Label1.Text = "该角色已经存在";
            }
        }
        catch (Exception ex)
        {
            Label1.Text = ex.Message;
        }
    }
    public void BindRoles()
    {
        lstRoles.DataSource = PUBS.GetRoles();
        lstRoles.DataTextField = "RoleName";
        lstRoles.DataValueField = "RoleName";
        lstRoles.DataBind();
    }

    protected void roleCreateBtn_OnClick(object sender, EventArgs e)
    {
        createRoles();
    }

    protected void roleDeleteBtn_OnClick(object sender, EventArgs e)
    {
        try
        {
            if (!Roles.RoleExists(lstRoles.Text))
            {
                Label1.Text = "删除角色失败，请选择要删除的角色";
            }
            else
            {
                Roles.DeleteRole(lstRoles.Text);
                BindRoles();
                Label1.Text = "删除角色\""+ lstRoles.Text +"\"成功";
            }
        }
        catch (Exception ex)
        {
            Label1.Text = ex.Message;
        }
    }

    /// <summary>
    /// 编辑角色
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void roleEditBtn_OnClick(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(lstRoles.Text))
        {
            Label1.Text = "请先选择角色，才可以进行编辑";
            return;
        }
        Response.Redirect("roleEdit.aspx?roleName=" + lstRoles.Text);
    }
}
