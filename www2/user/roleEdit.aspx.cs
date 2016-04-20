using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
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
        TreeView1.ShowCheckBoxes = TreeNodeTypes.All;
        TreeView1.Attributes.Add("onclick", "postBackByObject()");
        if (!IsPostBack)
        {
            var text = Request["roleName"];
            var list = PUBS.GetPowersForRole(text);
            SetTreeState(list, TreeView1.Nodes[0]);
            if (string.IsNullOrEmpty(text))
            {
                return;
            }
            tb_RoleName.Text = text;
            ddl_RoleLevel.Text = PUBS.GetRoleLevel(text);
            txt_desc.Text = PUBS.GetRoleDesc(text);
        }
    }

    private void SetTreeState(List<string> list, TreeNode node)
    {
        if (list.Contains(node.Text))
        {
            node.Checked = true;
        }
        if (node.ChildNodes.Count > 0)
        {
            foreach (TreeNode childNode in node.ChildNodes)
            {
                SetTreeState(list,childNode);
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
        Response.Redirect("../DetectList.aspx");
    }

    protected void submit_btn_Click(object sender, EventArgs e)
    {
        var roleNameOld = Request["roleName"];
        var roleNameNew = tb_RoleName.Text;
        var desc = txt_desc.Text;
        var roleLevel = ddl_RoleLevel.Text;
        List<Tuple<string,bool>> lists = new List<Tuple<string, bool>>();
        foreach (TreeNode checkedNode in TreeView1.CheckedNodes)
        {
            if (checkedNode.Text == "权限")
            {
                continue;
            }
            lists.Add(new Tuple<string, bool>(checkedNode.Text, true));
        }
        //foreach (GridViewRow row in GridView1.Rows)
        //{
        //    var checkBox = row.Cells[2].FindControl("isAllowed") as CheckBox;
        //    if (checkBox == null)
        //    {
        //        continue;
        //    }
        //    lists.Add(new Tuple<string,bool>(row.Cells[1].Text,checkBox.Checked));
        //}
        PUBS.SetRole(roleNameOld, roleNameNew, desc, roleLevel, lists);
        var log = PUBS.GetLogContect(',', "更改角色权限，角色名为：",
            roleNameOld,
            "，更改后角色名，描述，权限等级分别为",
            roleNameNew,
            desc, roleLevel);
        PUBS.Log(Request.UserHostAddress, PUBS.GetCurrentUser(), 30, log);
    }
    protected void cancel_btn_Click(object sender, EventArgs e)
    {
        Response.Redirect("../DetectList.aspx");
    }
    protected void TreeView1_TreeNodeCheckChanged(object sender, TreeNodeEventArgs e)
    {
        SetChildChecked(e.Node);
    }

    private void SetParent(TreeNode node)
    {
        if (node == null)
        {
            return;
        }
        var parent = node.Parent;
        var select = parent != null && parent.ChildNodes.Cast<TreeNode>().All(childNode => childNode.Checked);
        if (select)
        {
            parent.Checked = true;
        }
        select = parent != null && parent.ChildNodes.Cast<TreeNode>().All(childNode => !childNode.Checked);
        if (select)
        {
            parent.Checked = false;
        }
        SetParent(node.Parent);
    }
    private void SetChildChecked(TreeNode parentNode)
    {
        SetParent(parentNode);
        foreach (TreeNode node in parentNode.ChildNodes)
        {
            node.Checked = parentNode.Checked;

            if (node.ChildNodes.Count > 0)
            {
                SetChildChecked(node);
            }
        }
    }
}
