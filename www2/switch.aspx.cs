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

public partial class Switch : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["login"] == null)
            Response.Redirect(PUBS.HomePage);
        var name = PUBS.GetUserDisplayName(Context.User.Identity.Name);
        LoginName2.FormatString = name;
        Refrush();

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
    protected void btRefrush_Click(object sender, EventArgs e)
    {
        Refrush();
    }
    protected void btRun_Click(object sender, EventArgs e)
    {
        SetSwitch("On");
        Refrush();
    }
    protected void btPause_Click(object sender, EventArgs e)
    {
        SetSwitch("Off");
        Refrush();
    }
    private void SetSwitch(string s)
    {
        DataTable dt = PUBS.sqlQuery("select value from General where name = 'SwitchNow'");
        if (dt.Rows.Count > 0)
        {
            PUBS.sqlRun(string.Format("update General set value='{0}' where name = 'SwitchNow'", s));
        }
        else
        {
            PUBS.sqlRun(string.Format("insert into General values('SwitchNow', '{0}')", s));
        }
        PUBS.Log(Request.UserHostAddress, Membership.GetUser().UserName, 104, s);
    }
    private void Refrush()
    {
        string sOn = "检测";
        string sOff = "不检测";
        bool bSwitch=false;
        DataTable dt = PUBS.sqlQuery("select value from General where name = 'SwitchNow'");
        if (dt.Rows.Count > 0)
        {
            if (dt.Rows[0][0].ToString() == "On")
                bSwitch = true;
        }
        else
        {
            dt = PUBS.sqlQuery("select value from General where name = 'SwitchDefault'");
            if (dt.Rows.Count > 0)
            {
                if (dt.Rows[0][0].ToString() == "On")
                    bSwitch = true;
            }
            else//两项都没有
            {
                bSwitch = true;
            }
        }

        if (bSwitch)
        {
            lbStatus.Text = sOn;
            lbStatus.BackColor = System.Drawing.Color.Green;
        }
        else
        {
            lbStatus.Text = sOff;
            lbStatus.BackColor = System.Drawing.Color.Red;
        }
    }

}
