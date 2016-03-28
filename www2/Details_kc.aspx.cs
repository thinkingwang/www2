using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Drawing;
using System.Globalization;
using System.IO;
using System.Data.SqlClient;


public partial class Details_kc : System.Web.UI.Page
{
    protected string m_sDateTime;
    protected int m_iAxleNum;
    protected int m_scratchNum;

    public string m_sEngineNoA;
    public string m_sEngineNoB;
    public string m_sName;
    public bool m_bIsTypical;
    public bool m_bIsView;

    public double m_dbWheelSize;               //轮径
    public string m_sEngineNo;          //机车号
    public string m_sEngineName;        //机车名称
    public string m_sEngNum;        //纯机车号
    public bool m_direction;        //机车方向
    public DateTime m_dt;               //检测日期时间
    public double m_inSpeed;                   //进线速度
    public double m_outSpeed;                  //离线速度
    public double m_waterTemp;                 //水温
    public double m_temperature;               //气温

    public int m_total_bugNum;      //探头BUG总数
    public int m_total_ActBugNum;//实际经过整理的BUG总数
    public int m_total_RimBugNum;//轮缘BUG总数

    public string m_picFullName;
    public static int m_pic_index=1;
    public string D1;
    public string D2;
    public string m_VideoIP;
    public string m_VideoPasswd; 
    public int m_BackDeep = 1;
    private DataTable dtThresholds;
    public string[] LjCha_Bz;
    public int[] Level_LjCha_Bz;
    public string sTestDateTime;
    string bzh;
    public bool bReAnalysis;
    CheckBox[] chks;
    public int waterLevel = 0;
    public bool haveSpeed;

    public string status = "";   //状态:  缺水　停车　无号 　or  OK

    protected void Page_PreInit(object sender, EventArgs e)
    {
        if (Session["login"] == null)
            Response.Redirect(PUBS.HomePage);

        m_VideoPasswd = Application["VideoPW"].ToString();

        m_sDateTime = Request.QueryString["field"].Replace('_', ':');
        bReAnalysis = Request.QueryString["reanalysis"] != null;
        if (m_sDateTime == null)
            Response.Redirect("blank.htm");

        if (Session["mDateTime"] == null)
            Session.Add("mDateTime", m_sDateTime);
        else
            Session["mDateTime"] = m_sDateTime;

        //System.Data.DataView dv = (System.Data.DataView)SqlDataSource6.Select(DataSourceSelectArguments.Empty);
        //dtThresholds = dv.Table;

        //SqlDataSource1.SelectParameters.Clear();
        //SqlDataSource1.SelectParameters.Add("sDateTime", m_sDateTime);
        System.Data.DataView dv = (System.Data.DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);
        System.Data.DataTable dt = dv.Table;

        m_iAxleNum = Convert.ToInt32(dv[0]["axleNum"]);
        if (m_iAxleNum > 16)
        {
            LjCha_Bz = new string[m_iAxleNum / 16 +1];
            Level_LjCha_Bz = new int[m_iAxleNum / 16 +1];
        }
        else
        {
            LjCha_Bz = new string[1];
            Level_LjCha_Bz = new int[1];
        }

        m_scratchNum = Convert.ToInt32(dv[0]["scratchNum1"]);

        if (dv[0]["waterLevel"] != DBNull.Value)
            waterLevel = Convert.ToInt32(dv[0]["waterLevel"]);

        bzh = dv[0]["bzh"].ToString();

        m_dt = Convert.ToDateTime(dv[0]["testDateTime"]);
        sTestDateTime = m_dt.ToString("yyyy-MM-dd HH:mm:ss");

        m_bIsTypical = (bool)dv[0]["IsTypical"];

        status = dv[0]["status"].ToString();

        m_bIsView = !(PUBS.sqlQuery(string.Format("select * from checkTime where testDateTime='{0}' and userName ='{1}'", m_sDateTime, Membership.GetUser().UserName)).Rows.Count == 0);

        haveSpeed = PUBS.sqlQuery(string.Format("select * from speed where testDateTime='{0}'", m_sDateTime)).Rows.Count > 0;

        //m_bIsView = (bool)dv[0]["IsView"];


        Session["engNum"] = m_sEngineNoA;
        Session["AxleNum"] = m_iAxleNum;
        if (m_scratchNum == -1)
            Session["scratchNum"] = "-";
        else
            Session["scratchNum"] = "无";


        if (m_bIsTypical)
        {
            DetailsView1.SkinID = "blue";

            //btTypical.Text = "取消典型";
        }
        else
        {
            DetailsView1.SkinID = "yellow";

            //btTypical.Text = "设为典型";
        }

        bt_SelectTrain.Text = PUBS.Txt("选择列车");
        bt_proc.Text = PUBS.Txt("处理完成");
        bt_update.Text = PUBS.Txt("更新");
        RadioButton1.Text = PUBS.Txt("正面进线");
        RadioButton2.Text = PUBS.Txt("机房室内");
        RadioButton3.Text = PUBS.Txt("机房门口");
        RadioButton4.Text = PUBS.Txt("侧面进线");
        DetailsView1.Fields[0].HeaderText = PUBS.Txt("检测时间") + ":";
        DetailsView1.Fields[1].HeaderText = PUBS.Txt("车组号") + ":";
        DetailsView1.Fields[2].HeaderText = PUBS.Txt("进线速度") + ":";
        DetailsView1.Fields[3].HeaderText = PUBS.Txt("离线速度") + ":";
        //DetailsView1.Fields[4].HeaderText = PUBS.Txt("水温") + ":";
        DetailsView1.Fields[4].HeaderText = PUBS.Txt("端位") + ":";
        DetailsView1.Fields[5].HeaderText = PUBS.Txt("轴数") + ":";
        LoginStatus1.LogoutText = PUBS.Txt("注销");
        bt_compare.Text = PUBS.Txt("比对");
        bt_updateCarNo.Text = PUBS.Txt("更新");
        btTypical.Text = PUBS.Txt("锁定");
        btNoTypical.Text = PUBS.Txt("解锁");

        //地铁离线速度不显示，因为只有一个速度值，是从外形取的
        if (PUBS.TYPE == "地铁")
            DetailsView1.Fields[3].Visible = false;
        var name = PUBS.GetUserDisplayName(Context.User.Identity.Name);
        LoginName1.FormatString = name;
    } 

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["login"] == null)
            Response.Redirect(PUBS.HomePage);

        if (Session["detectorType"] != null)
            Session.Remove("detectorType");

        if (Session["detectorNo"] != null)
            Session.Remove("detectorNo");

        if (Session["pre_detectorType"] != null)
            Session.Remove("pre_detectorType");

        if (Session["pre_detectorNo"] != null)
            Session.Remove("pre_detectorNo");

        double d = (double)Application["video_forward"];
        D1 = m_dt.AddSeconds(-d).ToString("yyyy-MM-dd HH:mm:ss");
        d = (double)Application["video_last"];
        D2 = m_dt.AddSeconds(d).ToString("yyyy-MM-dd HH:mm:ss");
        //D1 = "2012-08-31 11:27:15";
        //D2 = "2012-08-31 11:28:15";
        //m_VideoIP = "192.168.5.201";
        m_VideoIP = Request.Url.Host;

        if (PUBS.GetUserLevel() <= 1)
        {
            bt_proc.Visible = (m_bIsView == false);

            if (m_bIsTypical)
            {
                btTypical.Visible = false;
                btNoTypical.Visible = (PUBS.GetUserLevel() < 1);
            }
            else
            {
                btTypical.Visible = true;
                btNoTypical.Visible = false;
            }
            btReAnalysis.Visible = true;
        }
        else
        {
            bt_proc.Visible = false;
            btTypical.Visible = false;
            btNoTypical.Visible = false;
            btReAnalysis.Visible = false;
        }

        chks = new CheckBox[8];
        chks[0] = chk_21;
        chks[1] = chk_22;
        chks[2] = chk_23;
        chks[3] = chk_24;
        chks[4] = chk_25;
        chks[5] = chk_26;
        chks[6] = chk_27;
        chks[7] = chk_28;

        chk_21_CheckedChanged(chk_21, EventArgs.Empty);
    }

    protected void LoginStatus1_LoggedOut(object sender, EventArgs e)
    {
        Session.Remove("login");
        PUBS.Log(Request.UserHostAddress, Membership.GetUser().UserName, 0, this.GetType().FullName);
    }


    protected void btTypical_Click(object sender, EventArgs e)
    {


        //btTypical.Text = m_bIsTypical ? "取消典型" : "设为典型";
        if (PUBS.GetUserLevel() <= 1)
        {
            m_bIsTypical = !m_bIsTypical;
            PUBS.sqlRun(string.Format("update detect set isTypical = {1} where testdatetime='{0}'", sTestDateTime, Convert.ToInt16(m_bIsTypical)));
            if (m_bIsTypical)
                PUBS.Log(Request.UserHostAddress, Membership.GetUser().UserName, 102, "lock");
            else
                PUBS.Log(Request.UserHostAddress, Membership.GetUser().UserName, 103, "unlock");

            bt_proc.Visible = (m_bIsView == false);

            if (m_bIsTypical)
            {
                btTypical.Visible = false;
                btNoTypical.Visible = (PUBS.GetUserLevel() < 1);
            }
            else
            {
                btTypical.Visible = true;
                btNoTypical.Visible = false;
            }
        }
    }
    protected void bt_update_Click(object sender, EventArgs e)
    {
        if (PUBS.TYPE == "客车")
        {
            PUBS.sqlRun(string.Format("update detect set engNum = '{1}' where testdatetime='{0}'", sTestDateTime, DropDownList1.SelectedValue));
            //SqlDataSource1.DataBind();
            DetailsView1.DataBind();
            //UpdatePanel1.Update();
        }
        else
        {
            uint h;
            if ((tbBzNo1.Text.Length == 4) && (uint.TryParse(tbBzNo1.Text, out h)))
            {
                string bzh = "";
                bzh = string.Format("{0}-{1}", dlTrainType.Text, tbBzNo1.Text);
                if ((tbBzNo2.Text.Length == 4) && (uint.TryParse(tbBzNo2.Text, out h)))
                {
                    bzh = string.Format("{0}_{1}-{2}", bzh, dlTrainType.Text,tbBzNo2.Text);
                }
                PUBS.sqlRun(string.Format("declare @out int;exec RepairCarListForNewTrain '{0}', '{1}', {2}, @out output", sTestDateTime, bzh, dlDir.SelectedValue));
                //PUBS.Log(
                //DetailsView1.DataBind();
                string url = Request.Url.ToString();
                if (!url.EndsWith("&reanalysis=1"))
                    url += "&reanalysis=1";
                Response.Redirect(url);
            }
        }
    }
    public string GetProfileFlag(string trainType, int powerType, string name, string sValue, int level)
    {
        string ret="";
        if (sValue == "-")
            return ret;
        double value = double.Parse(sValue);
        int updown;

        string desc;
        PUBS.GetProfileStatus(trainType, powerType, name, sValue, out updown, out desc);

        if (level > 0)
        {
            string strColor="";
            switch (level)
            {
                case 1:
                    strColor = "red";
                    break;
                case 2:
                    strColor = "yellow";
                    break;
                case 3:
                    strColor = "blue";
                    break;
            }
            string flag="";
            switch (updown)
            {
                case 1:flag = "↑";
                    break;
                case -1:flag = "↓";
                    break;
                case 0:flag = "";
                    break;
            }
            ret = string.Format("<span style=\"color: {0}; font-weight: bold; font-size: medium;\">{1}</span>", strColor, flag);
        }
        return ret;
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        string sIndex = HidCarIndex.Value;
        string sDt = m_dt.ToString("yyyy-MM-dd HH:mm:ss");
        PUBS.sqlRun(string.Format("delete from carlist where testDateTime='{0}' and posNo={1}", sDt, sIndex));
        PUBS.sqlRun(string.Format("insert into carlist ([testDateTime], [posNo], [carNo]) values('{0}',{1},'{2}')", sDt, sIndex, lbCarNo.Text));
    }
    public string GetCarNo(string datetimestr, int index)
    {
        string ret = "";
        DataTable dt = PUBS.sqlQuery(string.Format("select * from carlist where testdatetime='{0}' and posNo={1}", datetimestr, index));
        if (dt.Rows.Count > 0)
            ret = dt.Rows[0]["CarNo"].ToString();
        return ret;
    }
    protected void Button5_Click(object sender, EventArgs e)
    {

        string s1 = dl_type1.SelectedValue;
        string s2 = dl_type2.SelectedValue;
        string sCarNo = tb_CarNo.Text;

        //HidCarNo.Value = string.Format("{0}-{1}-{2}", s2, s1, sCarNo);
        //lbCarNo.Text = string.Format("{0}-{1}-{2}", s2, s1, sCarNo);
        HidCarNo.Value = string.Format("{0}-{1}", s2, sCarNo);
        lbCarNo.Text = string.Format("{0}-{1}", s2, sCarNo);
        bt_updateCarNo.Enabled = true;
    }
    public void GetSwStatus(object d, out int imgId, out string tip)
    {
        byte status;
        tip = "";
        string s = d.ToString();
        if (s == "")//缺失　灰色
        {
            imgId = 3;
            tip = PUBS.Txt("数据缺失");
        }
        else
        {
            //status = byte.Parse(s);
            //if (status == 0)//正常　绿色
            //{
            //    imgId = 0;
            //    tip = PUBS.Txt("正常");
            //}
            //else
            //{
            //    if ((status & 0x02) != 0)       //无效　红色
            //        imgId = 2;
            //    else if ((status & 0x10) != 0)//停车　桔色
            //        imgId = 4;
            //    else//其它　黄色
            //        imgId = 1;
            //    if ((status & 0x01) != 0)
            //        tip += PUBS.Txt("速度异常")+";";
            //    if ((status & 0x02) != 0)
            //        tip += PUBS.Txt("数据无效")+";";
            //    if ((status & 0x04) != 0)
            //        tip += PUBS.Txt("脉冲不全")+";";
            //    if ((status & 0x08) != 0)
            //        tip += PUBS.Txt("开关异常")+";";
            //    if ((status & 0x10) != 0)
            //        tip += PUBS.Txt("异常停车")+";";
            //    if ((status & 0x20) != 0)
            //        tip += PUBS.Txt("两轮在线") + ";";
            //}

            //２０１６.０２.１７　只要求缺数和脉冲不全　两种状态
            status = byte.Parse(s);
            if ((status & 0x04) != 0)
            {
                imgId = 1;
                tip += PUBS.Txt("脉冲不全");
            }
            else //其他正常　绿色
            {
                imgId = 0;
                tip = PUBS.Txt("正常");
            }
        }        
    }
    public void GetCwStatus(object d, out int imgId, out string tip)
    {
        byte status;
        string s = d.ToString();
        if (s == "")//缺失　灰色
        {
            imgId = 3;
            tip = PUBS.Txt("数据缺失");
        }
        else
        {
            status = byte.Parse(s);
            if (status == 1)//正常　绿色
            {
                imgId = 0;
                tip = PUBS.Txt("正常");
            }
            else if (status == 0)
            {
                imgId = 2;
                tip = PUBS.Txt("异常");
            }
            else
            {
                imgId = 4;
                tip = PUBS.Txt("未知");
            }
        }
    }

    protected void bt_print_Click(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("rpt_train.aspx?field={0}", m_sDateTime));
    }
    protected void bt_print_detail_Click(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("rpt_train_detail2.aspx?field={0}", m_sDateTime));
    }
    protected void bt_proc_Click(object sender, EventArgs e)
    {
        if (PUBS.isTychoAdmin())
        {
            PUBS.sqlRun(string.Format("update detect set isShow=1 where testdatetime='{0}'", m_sDateTime));
            PUBS.Log(Request.UserHostAddress, Membership.GetUser().UserName, 56, "Show " + m_sDateTime);
        }
        else
        {
            PUBS.sqlRun(string.Format("update detect set isview=1, procUser='{1}' where testdatetime='{0}'", m_sDateTime, Membership.GetUser().UserName));
            bt_proc.Visible = false;
            PUBS.Log(Request.UserHostAddress, Membership.GetUser().UserName, 6, this.GetType().FullName);
            PUBS.sqlRun(string.Format("insert into checkTime values ('{0}', '{1}', '{2}')", m_sDateTime, Membership.GetUser().UserName, DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));
        }

        Response.Redirect("DetectList.aspx");
    }
    protected void bt_print_status_Click(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("rpt_system.aspx?field={0}", m_sDateTime));
    }
    protected void bt_SelectTrain_Click(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("Detectlist.aspx"));
    }
    /// <summary>
    /// 获取浏览器类型版本号
    /// </summary>
    /// <returns>浏览器类型版本号</returns>
    public string GetClientBrowserVersions()
    {
        string browserVersions = string.Empty;
        HttpBrowserCapabilities hbc = HttpContext.Current.Request.Browser;
        string browserType = hbc.Browser.ToString();     //获取浏览器类型
        string browserVersion = hbc.Version.ToString();    //获取版本号
        browserVersions = browserType + browserVersion;
        return browserVersions;
    }
    protected void bt_history_Click(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("Detectlist.aspx?bzh={0}", bzh));
    }
    protected void btReAnalysis_Click(object sender, EventArgs e)
    {
        PUBS.sqlRun(string.Format("exec ReAnalysis '{0}'", m_sDateTime));
        bt_SelectTrain_Click(bt_SelectTrain, EventArgs.Empty);
    }
    protected void chk_21_CheckedChanged(object sender, EventArgs e)
    {
        //CheckBox ck = (CheckBox)sender;
        foreach (CheckBox ck in chks)
        {
            int index = int.Parse(ck.Text) - 1;
            if (ck.Checked)
            {

                Chart_speed.Series[index].Points.Clear();

                DataTable dtSpeed = PUBS.sqlQuery(string.Format("select axleNo, speed from speed where testdatetime='{0}' and deviceId={1}", sTestDateTime, index + 21));
                if (dtSpeed != null)
                foreach (DataRow dr in dtSpeed.Rows)
                {
                    Chart_speed.Series[index].Points.AddXY(int.Parse(dr[0].ToString()) + 1, double.Parse(dr[1].ToString()));
                }
            }
        }
    }

}
