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
using Microsoft.Ajax.Utilities;

//using System.Xml.Linq;

public partial class Verify : System.Web.UI.Page
{
    public string datetimestr;
    public int axleNo;
    public int axleNum;
    public string bzh;
    public string carNo;
    public int wheelNo;
    public int wheelPos;
    public string[] sLevelStyle;

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



        DataTable t;
        datetimestr = Request.QueryString["datetimestr"];
        axleNo = int.Parse(Request.QueryString["axleNo"]);
        wheelNo = int.Parse(Request.QueryString["wheelNo"]);
        lb_datetime.Text = datetimestr;

        //升级前后，老数据用老样式，新数据用新样式    
        if (Convert.ToDateTime(datetimestr) < PUBS.DT_SP)
        {
            sLevelStyle = new string[5] { "", "background-color:Red", "background-color:Yellow;color: #000080", "background-color:Blue", "" };
            //sLinkStyle = new string[5] { "", "", "", "class=\"whitelink\"", "" };
        }
        else
        {
            sLevelStyle = new string[5] { "", "background-color:Red", "background-color:Yellow;color: #000080", "", "" };
            //sLinkStyle = new string[5] { "", "", "", "", "" };
        }               

        if (IsPostBack)
            return;

        //取编组号
        t = PUBS.sqlQuery(string.Format("select engNum, enginedirection, axleNum from detect where testDateTime='{0}'", datetimestr));
        axleNum = int.Parse(t.Rows[0]["axleNum"].ToString());
        bzh = t.Rows[0]["engNum"].ToString();
        lb_bzh.Text = bzh;

        //取检测数据
        System.Data.DataTable dt = PUBS.sqlQuery(string.Format("exec GetTrain '{0}'", datetimestr));
        DataView dv = new DataView(dt);
        dv.RowFilter = string.Format("axleNo={0} and wheelNo={1}", axleNo, wheelNo);
        carNo = dv[0]["carNo"].ToString();
        wheelPos = int.Parse(dv[0]["pos"].ToString());
        lb_carNo.Text = carNo;
        lb_wheelPos.Text = PUBS.LWXH[wheelPos].ToString();

        lb_ts.Text = dv[0]["sLevel_ts"].ToString();
        lb_ts.Style.Value = sLevelStyle[int.Parse(dv[0]["level"].ToString())];

        lb_cs.Text = dv[0]["sLevel_cs"].ToString();
        lb_cs.Style.Value = sLevelStyle[int.Parse(dv[0]["cslevel"].ToString())];

        lb_wx_lj.Text = dv[0]["lj"].ToString();
        lb_wx_lj.Style.Value = sLevelStyle[int.Parse(dv[0]["level_lj"].ToString())];
        lb_wx_ljc_z.Text = dv[0]["LjCha_Zhou"].ToString();
        lb_wx_ljc_z.Style.Value = sLevelStyle[int.Parse(dv[0]["level_LjCha_Zhou"].ToString())];
        lb_wx_ljc_j.Text = dv[0]["LjCha_ZXJ"].ToString();
        lb_wx_ljc_j.Style.Value = sLevelStyle[int.Parse(dv[0]["level_LjCha_ZXJ"].ToString())];
        lb_wx_ljc_c.Text = dv[0]["LjCha_Che"].ToString();
        lb_wx_ljc_c.Style.Value = sLevelStyle[int.Parse(dv[0]["level_LjCha_Che"].ToString())];
        lb_wx_lwhd.Text = dv[0]["lwhd"].ToString();
        lb_wx_lwhd.Style.Value = sLevelStyle[int.Parse(dv[0]["level_lwhd"].ToString())];
        lb_wx_lygd.Text = dv[0]["lygd"].ToString();
        lb_wx_lygd.Style.Value = sLevelStyle[int.Parse(dv[0]["level_lygd"].ToString())];
        lb_wx_tmmh.Text = dv[0]["tmmh"].ToString();
        lb_wx_tmmh.Style.Value = sLevelStyle[int.Parse(dv[0]["level_tmmh"].ToString())];
        lb_wx_lyhd.Text = dv[0]["lyhd"].ToString();
        lb_wx_lyhd.Style.Value = sLevelStyle[int.Parse(dv[0]["level_lyhd"].ToString())];
        lb_wx_qr.Text = dv[0]["qr"].ToString();
        lb_wx_qr.Style.Value = sLevelStyle[int.Parse(dv[0]["level_qr"].ToString())];
        lb_wx_ncj.Text = dv[0]["ncj"].ToString();
        lb_wx_ncj.Style.Value = sLevelStyle[int.Parse(dv[0]["level_ncj"].ToString())];



        //初始化复核人　选项

        dl_ts_who.Items.Clear();
        dl_ts_who.Items.Add("");
        t = PUBS.sqlQuery("select distinct ts_who from ReCheck");
        foreach (DataRow dr in t.Rows)
            dl_ts_who.Items.Add(dr[0].ToString());

        dl_cs_who.Items.Clear();
        dl_cs_who.Items.Add("");
        t = PUBS.sqlQuery("select distinct cs_who from ReCheck");
        foreach (DataRow dr in t.Rows)
            dl_cs_who.Items.Add(dr[0].ToString());

        dl_wx_who.Items.Clear();
        dl_wx_who.Items.Add("");
        t = PUBS.sqlQuery("select distinct wx_who from ReCheck");
        foreach (DataRow dr in t.Rows)
            dl_wx_who.Items.Add(dr[0].ToString());

        //如果有　取复核数据
        t = PUBS.sqlQuery(string.Format("select * from ReCheck where testdatetime='{0}' and axleNo={1} and wheelNo={2}", datetimestr, axleNo, wheelNo));
        if (t.Rows.Count > 0)
        {
            tb_ts_desc.Text = t.Rows[0]["ts_desc"].ToString();
            tb_cs_desc.Text = t.Rows[0]["cs_desc"].ToString();

            tb_wx_lj.Text = t.Rows[0]["wx_lj"].ToString();
            tb_wx_lyhd.Text = t.Rows[0]["wx_lyhd"].ToString();
            tb_wx_lygd.Text = t.Rows[0]["wx_lygd"].ToString(); 
            tb_wx_lwhd.Text = t.Rows[0]["wx_lwhd"].ToString();
            tb_wx_qr.Text = t.Rows[0]["wx_qr"].ToString();
            tb_wx_ncj.Text = t.Rows[0]["wx_ncj"].ToString();

            tb_ts_who.Text = t.Rows[0]["ts_who"].ToString();
            tb_cs_who.Text = t.Rows[0]["cs_who"].ToString();
            tb_wx_who.Text = t.Rows[0]["wx_who"].ToString();
            //增加处理人列
            lb_ts_operator.Text = PUBS.GetUserDisplayName(t.Rows[0]["ts_operator"].ToString());
            lb_cs_operator.Text = PUBS.GetUserDisplayName(t.Rows[0]["cs_operator"].ToString());
            lb_wx_operator.Text = PUBS.GetUserDisplayName(t.Rows[0]["wx_operator"].ToString());

            DropDownCalendar_ts.Text = (t.Rows[0]["ts_date"] == DBNull.Value) ? "" : Convert.ToDateTime(t.Rows[0]["ts_date"]).ToString("yyyy-MM-dd");
            DropDownCalendar_cs.Text = (t.Rows[0]["cs_date"] == DBNull.Value) ? "" : Convert.ToDateTime(t.Rows[0]["cs_date"]).ToString("yyyy-MM-dd");
            DropDownCalendar_wx.Text = (t.Rows[0]["wx_date"] == DBNull.Value) ? "" : Convert.ToDateTime(t.Rows[0]["wx_date"]).ToString("yyyy-MM-dd");

            tb_wx_lygd_TextChanged(tb_wx_lygd, EventArgs.Empty);
            SetLjCha_Z();
            SetLjCha_J();
            SetLjCha_C();

        }
    }
    protected void LoginStatus2_LoggedOut(object sender, EventArgs e)
    {
        Session.Remove("login");
        PUBS.Log(Request.UserHostAddress, Membership.GetUser().UserName, 0, this.GetType().FullName);
    }


    protected void dl_ts_who_SelectedIndexChanged(object sender, EventArgs e)
    {
        tb_ts_who.Text = dl_ts_who.SelectedItem.Text;
    }
    protected void dl_cs_who_SelectedIndexChanged(object sender, EventArgs e)
    {
        tb_cs_who.Text = dl_cs_who.SelectedItem.Text;
    }
    protected void dl_wx_who_SelectedIndexChanged(object sender, EventArgs e)
    {
        tb_wx_who.Text = dl_wx_who.SelectedItem.Text;
    }
    protected void btCommit_Click(object sender, EventArgs e)
    {
        if (Session["login"] == null)
            Response.Redirect(PUBS.HomePage);

        PUBS.sqlRun(string.Format("delete from ReCheck where testdatetime='{0}' and axleNo={1} and wheelNo={2}", datetimestr, axleNo, wheelNo));


        PUBS.sqlRun(
            string.Format(
                "insert into ReCheck (testdatetime, axleNo, wheelNo, ts_desc, cs_desc, wx_lj, wx_lyhd, wx_lygd, wx_lwhd, wx_qr, wx_ncj, ts_who, cs_who, wx_who, ts_date, cs_date, wx_date,ts_operator,cs_operator,wx_operator) values('{0}', {1}, {2}, '{3}', '{4}', {5}, {6}, {7}, {8}, {9}, {10},  '{11}', '{12}', '{13}', {14}, {15}, {16},'{17}','{17}','{17}')",
                datetimestr, axleNo, wheelNo, tb_ts_desc.Text, tb_cs_desc.Text,
                tb_wx_lj.Text == "" ? "null" : tb_wx_lj.Text, tb_wx_lyhd.Text == "" ? "null" : tb_wx_lyhd.Text,
                tb_wx_lygd.Text == "" ? "null" : tb_wx_lygd.Text, tb_wx_lwhd.Text == "" ? "null" : tb_wx_lwhd.Text,
                tb_wx_qr.Text == "" ? "null" : tb_wx_qr.Text, tb_wx_ncj.Text == "" ? "null" : tb_wx_ncj.Text,
                tb_ts_who.Text, tb_cs_who.Text, tb_wx_who.Text,
                DropDownCalendar_ts.Text == "" ? "null" : "'" + DropDownCalendar_ts.Text + "'",
                DropDownCalendar_cs.Text == "" ? "null" : "'" + DropDownCalendar_cs.Text + "'",
                DropDownCalendar_wx.Text == "" ? "null" : "'" + DropDownCalendar_wx.Text + "'", HttpContext.Current.User.Identity.Name));

        PUBS.sqlRun(
            string.Format(
                "insert into log_ReCheck (testdatetime, axleNo, wheelNo, ts_desc, cs_desc, wx_lj, wx_lyhd, wx_lygd, wx_lwhd, wx_qr, wx_ncj, ts_who, cs_who, wx_who, ts_date, cs_date, wx_date,ts_operator,cs_operator,wx_operator, CommitTime, UserName, fromIP) values('{0}', {1}, {2}, '{3}', '{4}', {5}, {6}, {7}, {8}, {9}, {10}, '{11}', '{12}', '{13}', {14}, {15}, {16}, '{20}', '{20}', '{20}', '{17}', '{18}', '{19}')",
                datetimestr, axleNo, wheelNo, tb_ts_desc.Text, tb_cs_desc.Text,
                tb_wx_lj.Text == "" ? "null" : tb_wx_lj.Text, tb_wx_lyhd.Text == "" ? "null" : tb_wx_lyhd.Text,
                tb_wx_lygd.Text == "" ? "null" : tb_wx_lygd.Text, tb_wx_lwhd.Text == "" ? "null" : tb_wx_lwhd.Text,
                tb_wx_qr.Text == "" ? "null" : tb_wx_qr.Text, tb_wx_ncj.Text == "" ? "null" : tb_wx_ncj.Text,
                tb_ts_who.Text, tb_cs_who.Text, tb_wx_who.Text,
                DropDownCalendar_ts.Text == "" ? "null" : "'" + DropDownCalendar_ts.Text + "'",
                DropDownCalendar_cs.Text == "" ? "null" : "'" + DropDownCalendar_cs.Text + "'",
                DropDownCalendar_wx.Text == "" ? "null" : "'" + DropDownCalendar_wx.Text + "'", DateTime.Now,
                Membership.GetUser().UserName, Request.UserHostAddress, HttpContext.Current.User.Identity.Name));

        //Response.Write("<script language=javascript>alert(\'复核数据已提交。\');</script>");
        Page.RegisterStartupScript("hello", "<script>alert(\'复核数据已提交\')</script>"); 
    }
    protected void tb_wx_lygd_TextChanged(object sender, EventArgs e)
    {
        float tmmh;
        DataTable t = PUBS.sqlQuery(string.Format("select dbo.GetWx_Tmmh('{0}', {1})", datetimestr, tb_wx_lygd.Text));
        if ((t!=null) && (t.Rows.Count > 0))
        {
            if (float.TryParse(t.Rows[0][0].ToString(), out tmmh))
            {
                tb_wx_tmmh.Text = tmmh.ToString();
                return;
            }
        }
        tb_wx_tmmh.Text = "-";
    }
    protected void SetLjCha_Z()
    {
        float ljCha_z;
        DataTable t = PUBS.sqlQuery(string.Format("select dbo.GetWx_LjCha_Z('{0}', {1})", datetimestr, axleNo));
        if ((t != null) && (t.Rows.Count > 0))
        {
            if (float.TryParse(t.Rows[0][0].ToString(), out ljCha_z))
            {
                tb_wx_ljc_z.Text = ljCha_z.ToString();
                return;
            }
        }
        tb_wx_ljc_z.Text = "-";
    }
    protected void SetLjCha_J()
    {
        float ljCha_j;
        DataTable t = PUBS.sqlQuery(string.Format("select dbo.GetWx_LjCha_J('{0}', {1})", datetimestr, axleNo));
        if ((t != null) && (t.Rows.Count > 0))
        {
            if (float.TryParse(t.Rows[0][0].ToString(), out ljCha_j))
            {
                tb_wx_ljc_j.Text = ljCha_j.ToString();
                return;
            }
        }
        tb_wx_ljc_j.Text = "-";
    }
    protected void SetLjCha_C()
    {
        float ljCha_c;
        DataTable t = PUBS.sqlQuery(string.Format("select dbo.GetWx_LjCha_C('{0}', {1})", datetimestr, axleNo));
        if ((t != null) && (t.Rows.Count > 0))
        {
            if (float.TryParse(t.Rows[0][0].ToString(), out ljCha_c))
            {
                tb_wx_ljc_c.Text = ljCha_c.ToString();
                return;
            }
        }
        tb_wx_ljc_c.Text = "-";
    }
    protected void tb_wx_lj_TextChanged(object sender, EventArgs e)
    {
        float ljCha;
        DataTable t;

        tb_wx_ljc_z.Text = "-";
        t = PUBS.sqlQuery(string.Format("select dbo.GetWx_LjCha_Z_if('{0}', {1}, {2}, {3})", datetimestr, axleNo, wheelNo, tb_wx_lj.Text));
        if ((t != null) && (t.Rows.Count > 0))
        {
            if (float.TryParse(t.Rows[0][0].ToString(), out ljCha))
            {
                tb_wx_ljc_z.Text = ljCha.ToString();
            }
        }


        tb_wx_ljc_j.Text = "-";
        t = PUBS.sqlQuery(string.Format("select dbo.GetWx_LjCha_J_if('{0}', {1}, {2}, {3})", datetimestr, axleNo, wheelNo, tb_wx_lj.Text));
        if ((t != null) && (t.Rows.Count > 0))
        {
            if (float.TryParse(t.Rows[0][0].ToString(), out ljCha))
            {
                tb_wx_ljc_j.Text = ljCha.ToString();
            }
        }


        tb_wx_ljc_c.Text = "-";
        t = PUBS.sqlQuery(string.Format("select dbo.GetWx_LjCha_C_if('{0}', {1}, {2}, {3})", datetimestr, axleNo, wheelNo, tb_wx_lj.Text));
        if ((t != null) && (t.Rows.Count > 0))
        {
            if (float.TryParse(t.Rows[0][0].ToString(), out ljCha))
            {
                tb_wx_ljc_c.Text = ljCha.ToString();
            }
        }

    }
    protected void bt_back_Click(object sender, EventArgs e)
    {
        //Response.Redirect(string.Format("Details_kc.aspx?field={0}", datetimestr).Replace(':', '_'));
    }
}
