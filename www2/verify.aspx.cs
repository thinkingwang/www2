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

public partial class Verify : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["login"] == null)
            Response.Redirect(PUBS.HomePage);
        if (PUBS.GetUserLevel() > 1)
        {
            Response.Write("<script>alert(\'无权限\');</script>");
            Response.Redirect(PUBS.HomePage);
        }


        var name = PUBS.GetUserDisplayName(Context.User.Identity.Name);
        LoginName2.FormatString = name;

        string vDate = Request.QueryString["field"];
        if (vDate != null)
        {
            DataTable dt = PUBS.sqlQuery(string.Format("select * from verify where verifydate='{0}'", vDate));
            if ((dt != null) && (dt.Rows.Count > 0))
            {
                DropDownCalendar1.Text = ((DateTime)dt.Rows[0]["verifydate"]).ToString("yyyy-MM-dd");
                tb_name.Text = dt.Rows[0]["name"].ToString();
                tb_desc.Text = dt.Rows[0]["desc"].ToString();

                DropDownCalendar1.ReadOnly = true;
                img_from.Visible = false;
                tb_name.ReadOnly = true;
                tb_desc.ReadOnly = true;

                lb_title.Text = "校验记录";
                btCommit.Visible = false;
                btAdd.Visible = true;
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
    protected void btCommit_Click(object sender, EventArgs e)
    {
        try
        {
            string sDesc = tb_desc.Text.Replace("'", "''");
            PUBS.sqlRun(string.Format("insert into Verify values('{0}', '{1}', '{2}', '{3}')", DropDownCalendar1.Text, tb_name.Text, sDesc, DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));
            Response.Redirect("verify.aspx");
        }
        catch {}
    }
    protected void btAdd_Click(object sender, EventArgs e)
    {
        Response.Redirect("verify.aspx");
    }
}
