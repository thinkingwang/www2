using System;
using System.Configuration;
using System.Data;
using System.IO;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Page = System.Web.UI.Page;
using System.Collections.Generic; 
public partial class DetectList : Page
{
        public string ffUrl;
        System.Web.UI.WebControls.GridView dgExport = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        PUBS.GetUpgradeTime();

        if (!IsPostBack)
        {
            ffUrl = Request.Url.ToString();
            ReloadIniFile();
            //tb_bzh.Text = Session["BZH_Start"].ToString();
            tbDelay.Text = Session["DelayMinute"].ToString();
            tb_AxleNum.Text = Session["MinAxleNum"].ToString();
            Menu1.Attributes.Add("onclick","alert('123')");
        } 
        
        if (Session["login"] == null)
            Response.Redirect(PUBS.HomePage);


        bt_user.Text = PUBS.Txt("权限管理");
        btRefresh.Text = PUBS.Txt("数据刷新");
        bt_filter.Text = PUBS.Txt("确定");
        bt_all.Text = PUBS.Txt("还原");
        dl_date.Items[0].Text = PUBS.Txt("全部");
        dl_date.Items[1].Text = PUBS.Txt("指定");
        GridView1.Columns[0].HeaderText = PUBS.Txt("检测时间");
        GridView1.Columns[1].HeaderText = PUBS.Txt("车组号");
        GridView1.Columns[2].HeaderText = PUBS.Txt("轴数");
        GridView1.Columns[3].HeaderText = PUBS.Txt("探伤");
        GridView1.Columns[4].HeaderText = PUBS.Txt("擦伤");
        GridView1.Columns[5].HeaderText = PUBS.Txt("轮径");
        GridView1.Columns[6].HeaderText = PUBS.Txt("踏面磨耗");
        GridView1.Columns[7].HeaderText = PUBS.Txt("轮缘厚度");
        GridView1.Columns[8].HeaderText = PUBS.Txt("轮缘高度");
        GridView1.Columns[9].HeaderText = PUBS.Txt("轮辋宽度");
        GridView1.Columns[10].HeaderText = PUBS.Txt("内侧距");
        LoginStatus2.LogoutText = PUBS.Txt("注销");
        string strJB = PUBS.Txt("级别") + ":";
        string s1 = PUBS.Txt("I");
        string s2 = PUBS.Txt("II");
        string s3 = PUBS.Txt("III");        
        dl_all.Items[3].Text = strJB + s1;
        dl_all.Items[4].Text = strJB + s2;
        dl_all.Items[5].Text = strJB + s3;

        dl_level.Items[3].Text = strJB + s1;
        dl_level.Items[4].Text = strJB + s2;
        dl_level.Items[5].Text = strJB + s3;
        dl_level.Items[6].Text = PUBS.Txt("停车");
        dl_level.Items[7].Text = PUBS.Txt("缺数");

        dl_level_cs.Items[3].Text = strJB + s1;
        dl_level_cs.Items[4].Text = strJB + s2;
        dl_level_cs.Items[5].Text = strJB + s3;


        dl_level_wx_lj.Items[3].Text = strJB + s1;
        dl_level_wx_lj.Items[4].Text = strJB + s2;
        dl_level_wx_lj.Items[5].Text = strJB + s3;

        dl_level_wx_tmmh.Items[3].Text = strJB + s1;
        dl_level_wx_tmmh.Items[4].Text = strJB + s2;
        dl_level_wx_tmmh.Items[5].Text = strJB + s3;

        dl_level_wx_lyhd.Items[3].Text = strJB + s1;
        dl_level_wx_lyhd.Items[4].Text = strJB + s2;
        dl_level_wx_lyhd.Items[5].Text = strJB + s3;

        dl_level_wx_lygd.Items[3].Text = strJB + s1;
        dl_level_wx_lygd.Items[4].Text = strJB + s2;
        dl_level_wx_lygd.Items[5].Text = strJB + s3;

        dl_level_wx_lwhd.Items[3].Text = strJB + s1;
        dl_level_wx_lwhd.Items[4].Text = strJB + s2;
        dl_level_wx_lwhd.Items[5].Text = strJB + s3;
        
        dl_level_wx_qr.Items[3].Text = strJB + s1;
        dl_level_wx_qr.Items[4].Text = strJB + s2;
        dl_level_wx_qr.Items[5].Text = strJB + s3;

        dl_level_wx_ncj.Items[3].Text = strJB + s1;
        dl_level_wx_ncj.Items[4].Text = strJB + s2;
        dl_level_wx_ncj.Items[5].Text = strJB + s3;


       
        if (!IsPostBack)
        {
            DropDownCalendar1.Text = DateTime.Today.ToString("yyyy-MM-dd");
            DropDownCalendar2.Text = DateTime.Today.ToString("yyyy-MM-dd");
            ViewState["sql1"] = PUBS.IniListDataSource(false);
            var roles = Roles.GetRolesForUser();
            var result = PUBS.GetRolePowerElements(roles[0]);
            for (int i = 0; i < Menu2.Items[0].ChildItems.Count; i++)
            {
                var item = Menu2.Items[0].ChildItems[i];
                if (result.Item1.Contains(item.Value))
                {
                    continue;
                }
                Menu2.Items[0].ChildItems.Remove(item);
                i--;
            }
            for (int i = 0; i < Menu1.Items[0].ChildItems.Count; i++)
            {
                var item = Menu1.Items[0].ChildItems[i];
                if (result.Item1.Contains(item.Value))
                {
                    continue;
                }
                Menu1.Items[0].ChildItems.Remove(item);
                i--;
            }
            if (result != null)
            {
                foreach (var item in result.Item1)
                {
                    var element = this.FindControl(item);
                    if (element != null)
                    {
                        element.Visible = true;
                    }
                }
                foreach (var item in result.Item2)
                {
                    var element = this.FindControl(item);
                    if (element != null)
                    {
                        element.Visible = false;
                    }
                }
            }
            //ViewState["sql1"] = string.Format("SELECT * FROM [V_Detect_kc] where engNum like '{0}%'  ORDER BY [testDateTime] DESC", Session["BZH_Start"].ToString());
            //ReloadIniFile();
        }
        Session["alert"] = Session["BoGao_Alert"];

        //SqlDataSource1.FilterExpression = Convert.ToString(ViewState["sql1"]);
        if (Request.QueryString["bzh"] != null)
            SqlDataSource1.SelectCommand = string.Format("SELECT * FROM [V_Detect_kc] where bzh = '{0}'", Request.QueryString["bzh"]);
        else
            SqlDataSource1.SelectCommand = Convert.ToString(ViewState["sql1"]);


        GridView1.Columns[3].Visible = (bool)Session["SYS_TS"];

        GridView1.Columns[4].Visible = (bool)Session["SYS_CS"];

        GridView1.Columns[5].Visible = (bool)Session["SYS_WX"];
        GridView1.Columns[6].Visible = (bool)Session["SYS_WX"];
        GridView1.Columns[7].Visible = (bool)Session["SYS_WX"];
        GridView1.Columns[8].Visible = (bool)Session["SYS_WX"];
        GridView1.Columns[9].Visible = (bool)Session["SYS_WX"];
        GridView1.Columns[10].Visible = (bool)Session["SYS_WX"];
        GridView1.Columns[11].Visible = (bool)Session["SYS_WX"];
        var name = PUBS.GetUserDisplayName(Context.User.Identity.Name);
        LoginName2.FormatString = name;
       
    }

    private void ReloadIniFile()
    {
        IniFile ini = new IniFile(System.IO.Path.GetDirectoryName(Page.Request.PhysicalPath) + "\\tycho.ini");
        Session.Add("double_BoGao_Red", Convert.ToInt32(ini.IniReadValue("波高", "double_red", "15")));
        Session.Add("double_BoGao_Yellow", Convert.ToInt32(ini.IniReadValue("波高", "double_yellow", "30")));
        Session.Add("single_BoGao_Red", Convert.ToInt32(ini.IniReadValue("波高", "single_red", "15")));
        Session.Add("single_BoGao_Yellow", Convert.ToInt32(ini.IniReadValue("波高", "single_yellow", "30")));
        Session.Add("angle_BoGao_Red", Convert.ToInt32(ini.IniReadValue("波高", "angle_red", "15")));
        Session.Add("angle_BoGao_Yellow", Convert.ToInt32(ini.IniReadValue("波高", "angle_yellow", "30")));
        Session.Add("BoGao_Alert", Convert.ToInt32(ini.IniReadValue("波高", "alert", "100")));
        Session.Add("Detector_zj_num", Convert.ToInt32(ini.IniReadValue("探头", "zj", "21")));
        Session.Add("Detector_double_num", (int)Session["Detector_zj_num"] * 4);
        Session.Add("Detector_single_num", (int)Session["Detector_zj_num"] * 2);
        Session.Add("Detector_angle_num", (int)Session["Detector_zj_num"] * 2);
        Session.Add("DataPath", ini.IniReadValue("常规", "datapath", ""));
        Session.Add("UnitName", ini.IniReadValue("常规", "unit", ""));
        Session.Add("double_flag_offset", Convert.ToInt32(ini.IniReadValue("探头", "double_flag_offset", "0")));
        Session.Add("single_flag_offset", Convert.ToInt32(ini.IniReadValue("探头", "single_flag_offset", "0")));
        Session.Add("angle_flag_offset", Convert.ToInt32(ini.IniReadValue("探头", "angle_flag_offset", "0")));
        Session.Add("Detector_double_len", Convert.ToInt32(ini.IniReadValue("探头", "double_len", "38")));
        Session.Add("Detector_single_len", Convert.ToInt32(ini.IniReadValue("探头", "single_len", "76")));
        Session.Add("Detector_angle_len", Convert.ToInt32(ini.IniReadValue("探头", "angle_len", "76")));
        Session.Add("double_start_offset", Convert.ToDouble(ini.IniReadValue("探头", "double_start_offset", "25")));
        Session.Add("single_start_offset", Convert.ToDouble(ini.IniReadValue("探头", "single_start_offset", "17")));
        Session.Add("angle_start_offset", Convert.ToDouble(ini.IniReadValue("探头", "angle_start_offset", "5")));
        Session.Add("single_mode", Convert.ToInt32(ini.IniReadValue("探头", "single_mode", "0")));
        Session.Add("video_forward", Convert.ToDouble(ini.IniReadValue("视频", "forward", "25")));
        Session.Add("video_last", Convert.ToDouble(ini.IniReadValue("视频", "last", "25")));
        Session.Add("whmsXmlDataPath", ini.IniReadValue("WHMS", "XmlDataPath", ""));
        Session.Add("SYS_TS", Convert.ToBoolean(ini.IniReadValue("SYSTEM", "TS", "false")));
        Session.Add("SYS_TS_url", ini.IniReadValue("SYSTEM", "TS_URL", ""));
        Session.Add("SYS_CS", Convert.ToBoolean(ini.IniReadValue("SYSTEM", "CS", "false")));
        Session.Add("SYS_CS_url", ini.IniReadValue("SYSTEM", "CS_URL", ""));
        Session.Add("SYS_CS_IMAGE", Convert.ToBoolean(ini.IniReadValue("SYSTEM", "CS_IMAGE", "false")));
        Session.Add("SYS_WX", Convert.ToBoolean(ini.IniReadValue("SYSTEM", "WX", "false")));
        Session.Add("SYS_NAME", ini.IniReadValue("SYSTEM", "name", "轮对在线综合检测系统"));
        Session.Add("SYS_MODE", ini.IniReadValue("SYSTEM", "mode", "8UT"));
        Session.Add("BZH_Start", ini.IniReadValue("SYSTEM", "BZH_START", ""));
        Session.Add("MinAxleNum", Convert.ToInt32(ini.IniReadValue("SYSTEM", "MinAxleNum", "1")));
        Session.Add("URL_HXZY", ini.IniReadValue("HXZY", "url", ""));
        Session.Add("DelayMinute", Convert.ToInt32(ini.IniReadValue("SYSTEM", "DelayMinute", "0")));
        Session.Add("VideoPW", ini.IniReadValue("SYSTEM", "VideoPW", "12345"));
        Session.Add("SYS_Have_Threshold_Config", Convert.ToBoolean(ini.IniReadValue("SYSTEM", "ThresholdConfig", "false")));
        string[] pos = ini.IniReadValue("WheelPos", "WheelPos", "①, ②, ③, ④, ⑤, ⑥, ⑦, ⑧").Split(',');
        if (pos.Length == 8)
        {
            for(int i=1;i<=8;i++)
                PUBS.LWXH[i] = pos[i-1];
        }


    }
    /// <summary>
    /// 数据筛选
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btFilterClick(object sender, EventArgs e)
    {
        //SELECT * FROM [V_Detect_kc] ORDER BY [testDateTime] DESC
        string cmd = "SELECT * FROM [V_Detect_kc]";
        string sJoin = " where ";
        int p = 0;
        //SqlDataSource1.FilterParameters.Clear();

        if (dl_date.SelectedValue != "All")
        {
            //if (tb_startDate.Text != "")
            {
                cmd += sJoin + string.Format("testDateTime >= '{0}' ", DropDownCalendar1.Text + " 00:00:00");
                sJoin = " AND ";
            }
            //if (tb_endDate.Text != "")
            {
                cmd += sJoin + string.Format("testDateTime <= '{0}' ", DropDownCalendar2.Text + " 23:59:59");
            }
        }

        try
        {
            UInt16 axleNum = UInt16.Parse(tb_AxleNum.Text);

            cmd += sJoin + string.Format("AxleNum {1} {0} ", axleNum.ToString(), dl_axle.SelectedValue);
            sJoin = " AND ";
        }
        catch (Exception)
        {
        }

        try
        {

            if (tb_bzh.Text != "")
            {
                cmd += sJoin + string.Format("bzh like '%{0}%' ", tb_bzh.Text);
               sJoin = " AND ";
            }

        }
        catch (Exception)
        {
        }

        try
        {

            if (tb_cxh.Text != "")
            {
                cmd += sJoin + string.Format("testdatetime in (select testdatetime from carlist where carno like '%{0}%')", tb_cxh.Text);
                sJoin = " AND ";
            }

        }
        catch (Exception)
        {
        }

        try
        {

            if (dl_lock.SelectedValue != "All")
            {
                cmd += sJoin + string.Format("isTypical={0}", dl_lock.SelectedValue);
                sJoin = " AND ";
            }

        }
        catch (Exception)
        {
        }




        //升级日期后，不再显示３级报警；但之前的要保留，还要能查到
        //全部
        if (dl_all.SelectedValue != "All")
        {
            string qs = "((s_level_ts = '{0}') OR (ltrim(s_level_cs) = '{0}') OR (s_level_M_Lj = '{0}') OR (s_level_M_Tmmh = '{0}') OR (s_level_M_Lyhd = '{0}') OR (s_level_M_Lygd = '{0}') OR (s_level_M_Lwhd = '{0}') OR (s_level_M_Qr = '{0}') OR (s_level_M_Ncj = '{0}'))";
            if (dl_all.SelectedValue == "1")
                cmd += sJoin + string.Format(qs, 1);
            else if (dl_all.SelectedValue == "2")
                cmd += sJoin + string.Format(qs, 2);
            else if (dl_all.SelectedValue == "3")
                cmd += sJoin + string.Format("(({0}) AND (testdatetime < dbo.GetUpgradeTime()))", string.Format(qs, 3));
            else if (dl_all.SelectedValue == "True")
                cmd += sJoin + string.Format("({0} or {1} or (({2}) AND (testdatetime < dbo.GetUpgradeTime())))", string.Format(qs, 1), string.Format(qs, 2), string.Format(qs, 3));
            else if (dl_all.SelectedValue == "False")
            {
                qs = qs.Replace(" OR ", " AND ");
                qs = qs.Replace(" = ", " != ");
                cmd += sJoin + string.Format("({0} and {1} and {2})", string.Format(qs, 1), string.Format(qs, 2), string.Format(qs, 3));
            }

            sJoin = " AND ";
        }
        //探伤
        if (dl_level.SelectedValue != "All")
        {
            if (dl_level.SelectedValue == "1")
                cmd += sJoin + string.Format("s_level_ts = '1'");
            else if (dl_level.SelectedValue == "2")
                cmd += sJoin + string.Format("s_level_ts = '2'");
            else if (dl_level.SelectedValue == "3")
                cmd += sJoin + string.Format("((s_level_ts = '3') AND (testdatetime < dbo.GetUpgradeTime()))");
            else if (dl_level.SelectedValue == "True")
                cmd += sJoin + string.Format("(s_level_ts = '1' or s_level_ts = '2' or ((s_level_ts = '3') AND (testdatetime < dbo.GetUpgradeTime())))");
            else if (dl_level.SelectedValue == "False")
                cmd += sJoin + string.Format("s_level_ts like '正常%'");
            else if (dl_level.SelectedValue == "Stop")
                cmd += sJoin + string.Format("s_level_ts = '停车'");
            else if (dl_level.SelectedValue == "QueShu")
                cmd += sJoin + string.Format("s_level_ts = '缺数'");
            sJoin = " AND ";
        }
        //擦伤
        if (dl_level_cs.SelectedValue != "All")
        {
            if (dl_level_cs.SelectedValue == "1")
                cmd += sJoin + string.Format("ltrim(s_level_cs) = '1'");
            else if (dl_level_cs.SelectedValue == "2")
                cmd += sJoin + string.Format("ltrim(s_level_cs) = '2'");
            else if (dl_level_cs.SelectedValue == "3")
                cmd += sJoin + string.Format("(ltrim(s_level_cs) = '3'  AND (testdatetime < dbo.GetUpgradeTime()))");
            else if (dl_level_cs.SelectedValue == "True")
                cmd += sJoin + string.Format("(ltrim(s_level_cs) = '1' or ltrim(s_level_cs) = '2' or (ltrim(s_level_cs) = '3'  AND (testdatetime < dbo.GetUpgradeTime())))");
            else if (dl_level_cs.SelectedValue == "False")
                cmd += sJoin + string.Format("s_level_cs like '正常%'");

            sJoin = " AND ";
        }
        //外形
        if (dl_level_wx_lj.SelectedValue != "All")
        {
            if (dl_level_wx_lj.SelectedValue == "1")
                cmd += sJoin + string.Format("s_level_M_Lj = '1'");
            else if (dl_level_wx_lj.SelectedValue == "2")
                cmd += sJoin + string.Format("s_level_M_Lj = '2'");
            else if (dl_level_wx_lj.SelectedValue == "3")
                cmd += sJoin + string.Format("s_level_M_Lj = '3'");
            else if (dl_level_wx_lj.SelectedValue == "True")
                cmd += sJoin + string.Format("(s_level_M_Lj = '1' or s_level_M_Lj = '2' or s_level_M_Lj = '3')");
            else if (dl_level_wx_lj.SelectedValue == "False")
                cmd += sJoin + string.Format("(s_level_M_Lj like '正常%' or s_level_M_Lj = '-')");

            sJoin = " AND ";
        }

        if (dl_level_wx_tmmh.SelectedValue != "All")
        {
            if (dl_level_wx_tmmh.SelectedValue == "1")
                cmd += sJoin + string.Format("s_level_M_Tmmh = '1'");
            else if (dl_level_wx_tmmh.SelectedValue == "2")
                cmd += sJoin + string.Format("s_level_M_Tmmh = '2'");
            else if (dl_level_wx_tmmh.SelectedValue == "3")
                cmd += sJoin + string.Format("s_level_M_Tmmh = '3'");
            else if (dl_level_wx_tmmh.SelectedValue == "True")
                cmd += sJoin + string.Format("(s_level_M_Tmmh = '1' or s_level_M_Tmmh = '2' or s_level_M_Tmmh = '3')");
            else if (dl_level_wx_tmmh.SelectedValue == "False")
                cmd += sJoin + string.Format("(s_level_M_Tmmh like '正常%' or s_level_M_Tmmh = '-')");

            sJoin = " AND ";
        }

        if (dl_level_wx_lyhd.SelectedValue != "All")
        {
            if (dl_level_wx_lyhd.SelectedValue == "1")
                cmd += sJoin + string.Format("s_level_M_Lyhd = '1'");
            else if (dl_level_wx_lyhd.SelectedValue == "2")
                cmd += sJoin + string.Format("s_level_M_Lyhd = '2'");
            else if (dl_level_wx_lyhd.SelectedValue == "3")
                cmd += sJoin + string.Format("s_level_M_Lyhd = '3'");
            else if (dl_level_wx_lyhd.SelectedValue == "True")
                cmd += sJoin + string.Format("(s_level_M_Lyhd = '1' or s_level_M_Lyhd = '2' or s_level_M_Lyhd = '3')");
            else if (dl_level_wx_lyhd.SelectedValue == "False")
                cmd += sJoin + string.Format("(s_level_M_Lyhd like '正常%' or s_level_M_Lyhd = '-')");

            sJoin = " AND ";
        }

        if (dl_level_wx_lygd.SelectedValue != "All")
        {
            if (dl_level_wx_lygd.SelectedValue == "1")
                cmd += sJoin + string.Format("s_level_M_Lygd = '1'");
            else if (dl_level_wx_lygd.SelectedValue == "2")
                cmd += sJoin + string.Format("s_level_M_Lygd = '2'");
            else if (dl_level_wx_lygd.SelectedValue == "3")
                cmd += sJoin + string.Format("s_level_M_Lygd = '3'");
            else if (dl_level_wx_lygd.SelectedValue == "True")
                cmd += sJoin + string.Format("(s_level_M_Lygd = '1' or s_level_M_Lygd = '2' or s_level_M_Lygd = '3')");
            else if (dl_level_wx_lygd.SelectedValue == "False")
                cmd += sJoin + string.Format("(s_level_M_Lygd like '正常%' or s_level_M_Lygd = '-')");

            sJoin = " AND ";
        }

        if (dl_level_wx_lwhd.SelectedValue != "All")
        {
            if (dl_level_wx_lwhd.SelectedValue == "1")
                cmd += sJoin + string.Format("s_level_M_Lwhd = '1'");
            else if (dl_level_wx_lwhd.SelectedValue == "2")
                cmd += sJoin + string.Format("s_level_M_Lwhd = '2'");
            else if (dl_level_wx_lwhd.SelectedValue == "3")
                cmd += sJoin + string.Format("s_level_M_Lwhd = '3'");
            else if (dl_level_wx_lwhd.SelectedValue == "True")
                cmd += sJoin + string.Format("(s_level_M_Lwhd = '1' or s_level_M_Lwhd = '2' or s_level_M_Lwhd = '3')");
            else if (dl_level_wx_lwhd.SelectedValue == "False")
                cmd += sJoin + string.Format("(s_level_M_Lwhd like '正常%' or s_level_M_Lwhd = '-')");

            sJoin = " AND ";
        }

        if (dl_level_wx_qr.SelectedValue != "All")
        {
            if (dl_level_wx_qr.SelectedValue == "1")
                cmd += sJoin + string.Format("s_level_M_Qr = '1'");
            else if (dl_level_wx_qr.SelectedValue == "2")
                cmd += sJoin + string.Format("s_level_M_Qr = '2'");
            else if (dl_level_wx_qr.SelectedValue == "3")
                cmd += sJoin + string.Format("s_level_M_Qr = '3'");
            else if (dl_level_wx_qr.SelectedValue == "True")
                cmd += sJoin + string.Format("(s_level_M_Qr = '1' or s_level_M_Qr = '2' or s_level_M_Qr = '3')");
            else if (dl_level_wx_qr.SelectedValue == "False")
                cmd += sJoin + string.Format("(s_level_M_Qr like '正常%' or s_level_M_Qr = '-')");

            sJoin = " AND ";
        }

        if (dl_level_wx_ncj.SelectedValue != "All")
        {
            if (dl_level_wx_ncj.SelectedValue == "1")
                cmd += sJoin + string.Format("s_level_M_Ncj = '1'");
            else if (dl_level_wx_ncj.SelectedValue == "2")
                cmd += sJoin + string.Format("s_level_M_Ncj = '2'");
            else if (dl_level_wx_ncj.SelectedValue == "3")
                cmd += sJoin + string.Format("s_level_M_Ncj = '3'");
            else if (dl_level_wx_ncj.SelectedValue == "True")
                cmd += sJoin + string.Format("(s_level_M_Ncj = '1' or s_level_M_Ncj = '2' or s_level_M_Ncj = '3')");
            else if (dl_level_wx_ncj.SelectedValue == "False")
                cmd += sJoin + string.Format("(s_level_M_Ncj like '正常%' or s_level_M_Ncj = '-')");

            sJoin = " AND ";
        }        
        cmd += " ORDER BY [testDateTime] DESC";
        ViewState["sql1"] = cmd;
        try
        {
            SqlDataSource1.SelectCommand = cmd;
            GridView1.DataBind();
        }
        catch
        {
            Response.Write("<script>alert(\'查询条件错误！\');</script>");
        }



    }
    /// <summary>
    /// 还原
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void bt_all_Click(object sender, EventArgs e)
    {

        //string cmd = "SELECT * FROM [V_Detect_kc] ORDER BY [testDateTime] DESC";
        string cmd =  PUBS.IniListDataSource(true);
        ViewState["sql1"] = cmd;

        SqlDataSource1.FilterExpression = "";
        SqlDataSource1.FilterParameters.Clear();


        dl_date.SelectedValue = "All";
        dl_date_SelectedIndexChanged(dl_date, EventArgs.Empty);
        tb_bzh.Text = "";
        tb_cxh.Text = "";
        tb_AxleNum.Text = "";
        dl_level.SelectedValue = "All";
        dl_level_cs.SelectedValue = "All";
        dl_level_wx_lj.SelectedValue = "All";
        dl_level_wx_tmmh.SelectedValue = "All";
        dl_level_wx_lyhd.SelectedValue = "All";
        dl_level_wx_lygd.SelectedValue = "All";
        dl_level_wx_lwhd.SelectedValue = "All";
        dl_level_wx_qr.SelectedValue = "All";
        dl_level_wx_ncj.SelectedValue = "All";
        dl_lock.SelectedValue = "All";
        dl_all.SelectedValue = "All";



        dl_axle.SelectedValue = ">";
        tb_AxleNum.Text = "0";
        //dl_valid.SelectedValue = "All";
        SqlDataSource1.SelectCommand = cmd;
        GridView1.DataBind();
    }

    protected void LoginStatus1_LoggedOut(object sender, EventArgs e)
    {
        Session.Remove("login");
        PUBS.Log(Request.UserHostAddress, Membership.GetUser().UserName, 0, this.GetType().FullName);
    }


    protected void bt_user_Click(object sender, EventArgs e)
    {
        Response.Redirect("user/userList.aspx");
    }
    protected void bt_engine_Click(object sender, EventArgs e)
    {
        Response.Redirect("engine_type.aspx");
    }

    protected void dl_date_SelectedIndexChanged(object sender, EventArgs e)
    {
        bool b = (dl_date.SelectedValue != "All");
        DropDownCalendar1.Visible = b;
        DropDownCalendar2.Visible = b;
        lb_from.Visible = b;
        lb_to.Visible = b;
        img_from.Visible = b;
        img_to.Visible = b;
    }
    protected void dgExport_DataBound(object sender, EventArgs e)
    {
        //GridView dgExport = (GridView)sender;
        for (int i = 0; i <= dgExport.Rows.Count - 1; i++)
        {
            bool haveAlarm = false;
            bool bTemp;
            TableCell cell = dgExport.Rows[i].Cells[0];
            string s = cell.Text;
            DateTime dt = Convert.ToDateTime(s);
            //升级以前的数据，还要按原来的方式显示
            if (dt < PUBS.DT_SP)
            {
                cell = dgExport.Rows[i].Cells[3];
                bTemp = PUBS.ColorBug_OldVersion(ref cell);
                haveAlarm = haveAlarm || bTemp;

                cell = dgExport.Rows[i].Cells[4];
                bTemp = PUBS.ColorBug_OldVersion(ref cell);
                haveAlarm = haveAlarm || bTemp;

                cell = dgExport.Rows[i].Cells[5];
                bTemp = PUBS.ColorBug_OldVersion(ref cell);
                haveAlarm = haveAlarm || bTemp;

                cell = dgExport.Rows[i].Cells[6];
                bTemp = PUBS.ColorBug_OldVersion(ref cell);
                haveAlarm = haveAlarm || bTemp;

                cell = dgExport.Rows[i].Cells[7];
                bTemp = PUBS.ColorBug_OldVersion(ref cell);
                haveAlarm = haveAlarm || bTemp;

                cell = dgExport.Rows[i].Cells[8];
                bTemp = PUBS.ColorBug_OldVersion(ref cell);
                haveAlarm = haveAlarm || bTemp;

                cell = dgExport.Rows[i].Cells[9];
                bTemp = PUBS.ColorBug_OldVersion(ref cell);
                haveAlarm = haveAlarm || bTemp;

                cell = dgExport.Rows[i].Cells[10];
                bTemp = PUBS.ColorBug_OldVersion(ref cell);
                haveAlarm = haveAlarm || bTemp;

                cell = dgExport.Rows[i].Cells[11];
                bTemp = PUBS.ColorBug_OldVersion(ref cell);
                haveAlarm = haveAlarm || bTemp;
            }
            else
            {

                cell = dgExport.Rows[i].Cells[3];
                bTemp = PUBS.ColorBug(ref cell);
                haveAlarm = haveAlarm || bTemp;

                cell = dgExport.Rows[i].Cells[4];
                bTemp = PUBS.ColorBug(ref cell);
                haveAlarm = haveAlarm || bTemp;

                cell = dgExport.Rows[i].Cells[5];
                bTemp = PUBS.ColorBug(ref cell);
                haveAlarm = haveAlarm || bTemp;

                cell = dgExport.Rows[i].Cells[6];
                bTemp = PUBS.ColorBug(ref cell);
                haveAlarm = haveAlarm || bTemp;

                cell = dgExport.Rows[i].Cells[7];
                bTemp = PUBS.ColorBug(ref cell);
                haveAlarm = haveAlarm || bTemp;

                cell = dgExport.Rows[i].Cells[8];
                bTemp = PUBS.ColorBug(ref cell);
                haveAlarm = haveAlarm || bTemp;

                cell = dgExport.Rows[i].Cells[9];
                bTemp = PUBS.ColorBug(ref cell);
                haveAlarm = haveAlarm || bTemp;

                cell = dgExport.Rows[i].Cells[10];
                bTemp = PUBS.ColorBug(ref cell);
                haveAlarm = haveAlarm || bTemp;

                cell = dgExport.Rows[i].Cells[11];
                bTemp = PUBS.ColorBug(ref cell);
                haveAlarm = haveAlarm || bTemp;
            }


            //cell = dgExport.Rows[i].Cells[0];
            //TableCell cell2 = dgExport.Rows[i].Cells[13];
            //if ((cell2.Text == "False") && haveAlarm)
            //{
            //    cell.Style.Value = "background-repeat: no-repeat; background-image: url('image/new.gif')";
            //}
            //cell2.Text = "";

            //TableCell cell3 = GridView1.Rows[i].Cells[14];
            //if (cell3.Text == "True")
            //{
            //    cell.Style.Value = "background-repeat: no-repeat; background-image: url('image/lock.ico')";
            //}
            //cell3.Text = "";


        }
    }
    protected void GridView1_DataBound(object sender, EventArgs e)
    {
        GridView theGrid = (GridView)sender;
        for (int i = 0; i <= theGrid.Rows.Count - 1; i++)
        {
            bool haveAlarm = false;
            bool bTemp;
            TableCell cell = theGrid.Rows[i].Cells[0];
            cell.Text = (i+1).ToString();

             cell = theGrid.Rows[i].Cells[1];
            string s;
            if (cell.Text == "")
                s = (cell.Controls[0] as HyperLink).Text;
            else
                s = cell.Text;

            DateTime dt = Convert.ToDateTime(s);
            //升级以前的数据，还要按原来的方式显示
            if (dt < PUBS.DT_SP)
            {
                cell = theGrid.Rows[i].Cells[4];
                bTemp = PUBS.ColorBug_OldVersion(ref cell);
                haveAlarm = haveAlarm || bTemp;

                cell = theGrid.Rows[i].Cells[5];
                bTemp = PUBS.ColorBug_OldVersion(ref cell);
                haveAlarm = haveAlarm || bTemp;

                cell = theGrid.Rows[i].Cells[6];
                bTemp = PUBS.ColorBug_OldVersion(ref cell);
                haveAlarm = haveAlarm || bTemp;

                cell = theGrid.Rows[i].Cells[7];
                bTemp = PUBS.ColorBug_OldVersion(ref cell);
                haveAlarm = haveAlarm || bTemp;

                cell = theGrid.Rows[i].Cells[8];
                bTemp = PUBS.ColorBug_OldVersion(ref cell);
                haveAlarm = haveAlarm || bTemp;

                cell = theGrid.Rows[i].Cells[9];
                bTemp = PUBS.ColorBug_OldVersion(ref cell);
                haveAlarm = haveAlarm || bTemp;

                cell = theGrid.Rows[i].Cells[10];
                bTemp = PUBS.ColorBug_OldVersion(ref cell);
                haveAlarm = haveAlarm || bTemp;

                cell = theGrid.Rows[i].Cells[11];
                bTemp = PUBS.ColorBug_OldVersion(ref cell);
                haveAlarm = haveAlarm || bTemp;

                cell = theGrid.Rows[i].Cells[12];
                bTemp = PUBS.ColorBug_OldVersion(ref cell);
                haveAlarm = haveAlarm || bTemp;
            }
            else
            {

                cell = theGrid.Rows[i].Cells[4];
                bTemp = PUBS.ColorBug(ref cell);
                haveAlarm = haveAlarm || bTemp;

                cell = theGrid.Rows[i].Cells[5];
                bTemp = PUBS.ColorBug(ref cell);
                haveAlarm = haveAlarm || bTemp;

                cell = theGrid.Rows[i].Cells[6];
                bTemp = PUBS.ColorBug(ref cell);
                haveAlarm = haveAlarm || bTemp;

                cell = theGrid.Rows[i].Cells[7];
                bTemp = PUBS.ColorBug(ref cell);
                haveAlarm = haveAlarm || bTemp;

                cell = theGrid.Rows[i].Cells[8];
                bTemp = PUBS.ColorBug(ref cell);
                haveAlarm = haveAlarm || bTemp;

                cell = theGrid.Rows[i].Cells[9];
                bTemp = PUBS.ColorBug(ref cell);
                haveAlarm = haveAlarm || bTemp;

                cell = theGrid.Rows[i].Cells[10];
                bTemp = PUBS.ColorBug(ref cell);
                haveAlarm = haveAlarm || bTemp;

                cell = theGrid.Rows[i].Cells[11];
                bTemp = PUBS.ColorBug(ref cell);
                haveAlarm = haveAlarm || bTemp;

                cell = theGrid.Rows[i].Cells[12];
                bTemp = PUBS.ColorBug(ref cell);
                haveAlarm = haveAlarm || bTemp;
            }
            if (haveAlarm)
            {
                var btn = theGrid.Rows[i].FindControl("btnrecheck") as Button;
                if (btn != null)
                {
                    btn.Enabled = true;
                }
            }
            if (theGrid.Rows[i].Cells.Count >= 16)
            {
                cell = theGrid.Rows[i].Cells[0];
                TableCell cell2 = theGrid.Rows[i].Cells[15];
                if ((cell2.Text == "False") && haveAlarm)
                {
                    cell.Style.Value = "background-repeat: no-repeat; background-image: url('image/new.gif')";
                }
                cell2.Text = "";

                TableCell cell3 = theGrid.Rows[i].Cells[16];
                if (cell3.Text == "True")
                {
                    cell.Style.Value = "background-repeat: no-repeat; background-image: url('image/lock.ico')";
                }
                cell3.Text = "";

                TableCell cell4 = theGrid.Rows[i].Cells[13];
                if (cell4.Text == "本所"||cell4.Text=="本局")
                {

                    cell4.Style.Value = "background-repeat: no-repeat; background-position: center center; background-image: url('image/our.gif')";
                }
                else if (cell4.Text == "本段")
                {
                    cell4.Style.Value =
                        "background-repeat: no-repeat; background-position: center center; background-image: url('image/our1.gif')";
                }
                else
                {
                    cell4.Style.Value =
                        "background-repeat: no-repeat; background-position: center center; background-image: url('image/others.gif')";
                }
                var btn = theGrid.Rows[i].Cells[17].FindControl("btnrecheck") as Button;
                if (btn != null)
                {
                    var sql = string.Format("select dbo.[GetRecheckState]('{0}') as state", s);
                    var tb = PUBS.sqlQuery(sql);
                    var count = Convert.ToInt32(tb.Rows[0]["state"]);
                    if (count ==1)
                    {
                        btn.Text = "已复核";
                    }
                }

                cell4.Text = "";
            }
        }       
    }
    protected void btSaveExcel_Click(object sender, EventArgs e)
    {
        //System.Data.DataView dv = (System.Data.DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);
        //System.Data.DataTable dt = dv.Table;
        //DataTableToExcel(dt, "c:\\test.xlsx");

        //outExcel();

        //DataTable dtData = (DataTable)ViewState["ExeclOutput"];


        form1.Target = "_blank";

        string[] headinfo = (string[])ViewState["headinfo"];

        //System.Web.UI.WebControls.DataGrid dgExport = null;
        //System.Web.UI.WebControls.GridView dgExport = null;
        // 当前对话
        System.Web.HttpContext curContext = System.Web.HttpContext.Current;
        // IO用于导出并返回excel文件
        System.IO.StringWriter strWriter = null;
        System.Web.UI.HtmlTextWriter htmlWriter = null;

        // 设置编码和附件格式
        string style = @"<style> .text { mso-number-format:\@; } </script> ";
        string FileName;
        FileName = "" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".xls";
        curContext.Response.AppendHeader("Content-Disposition", "attachment;filename=" + FileName);
        curContext.Response.Charset = "UTF-8";
        curContext.Response.ContentEncoding = System.Text.Encoding.Default;
        curContext.Response.ContentType = "Session/ms-excel";

        // 导出excel文件
        strWriter = new System.IO.StringWriter();
        htmlWriter = new System.Web.UI.HtmlTextWriter(strWriter);

        // 为了解决dgData中可能进行了分页的情况，需要重新定义一个无分页的DataGrid
        dgExport = new System.Web.UI.WebControls.GridView();//.DataGrid();
        dgExport.DataBinding += new EventHandler(dgExport_DataBound);
        dgExport.DataSource = SqlDataSource1;
        dgExport.AllowPaging = false;
        dgExport.AutoGenerateColumns = false;
        dgExport.Columns.Clear();
        Label label = new Label();
        label.ID = "number";
        label.Text = "<%# Container.DataItemIndex + 1%>";
        TemplateField t0 = new TemplateField();
        t0.HeaderText = "序号";
        t0.ItemTemplate = new TemplateBuilder();
        t0.ItemTemplate.InstantiateIn(label);
        dgExport.Columns.Add(t0);
        BoundField b0 = new BoundField();
        b0.DataField = "testDateTime";
        b0.HeaderText = "时间";
        dgExport.Columns.Add(b0);
        BoundField b1 = new BoundField();
        b1.DataField = "bzh";
        b1.HeaderText = "车组号";
        dgExport.Columns.Add(b1);
        BoundField b2 = new BoundField();
        b2.DataField = "AxleNum";
        b2.HeaderText = "轴号";
        dgExport.Columns.Add(b2);
        BoundField b3 = new BoundField();
        b3.DataField = "s_level_ts";
        b3.HeaderText = "探伤";
        dgExport.Columns.Add(b3);
        BoundField b4 = new BoundField();
        b4.DataField = "s_level_cs";
        b4.HeaderText = "擦伤";
        dgExport.Columns.Add(b4);
        BoundField b5 = new BoundField();
        b5.DataField = "s_level_M_Lj";
        b5.HeaderText = "轮径";
        dgExport.Columns.Add(b5);
        BoundField b6 = new BoundField();
        b6.DataField = "s_level_M_TmMh";
        b6.HeaderText = "踏面磨耗";
        dgExport.Columns.Add(b6);
        BoundField b7 = new BoundField();
        b7.DataField = "s_level_M_LyHd";
        b7.HeaderText = "轮缘厚度";
        dgExport.Columns.Add(b7);
        BoundField b8 = new BoundField();
        b8.DataField = "s_level_M_Lygd";
        b8.HeaderText = "轮缘高度";
        dgExport.Columns.Add(b8);
        BoundField b9 = new BoundField();
        b9.DataField = "s_level_M_LwHd";
        b9.HeaderText = "轮辋宽度";
        dgExport.Columns.Add(b9);
        BoundField b10 = new BoundField();
        b10.DataField = "s_level_M_Qr";
        b10.HeaderText = "QR值";
        dgExport.Columns.Add(b10);
        BoundField b11 = new BoundField();
        b11.DataField = "s_level_M_Ncj";
        b11.HeaderText = "内侧距";
        dgExport.Columns.Add(b11);     

        dgExport.DataBind();

        int lines = dgExport.Rows.Count;

        GridView1_DataBound(dgExport, EventArgs.Empty);

        // 返回客户端
        dgExport.RenderControl(htmlWriter);
        //curContext.Response.Write(style);//调用格式化字符串
        curContext.Response.Write(strWriter.ToString());
        curContext.Response.End();

    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        string cmd = e.CommandName;
        if (cmd == "tycho")
        {
            string ss = (string)e.CommandArgument;
            Response.Redirect("rpt_train.aspx?field=" + ss);
        }
        if (cmd == "recheck")
        {
            Response.Redirect("Recheck.aspx?datetimestr=" + Convert.ToDateTime(e.CommandArgument).ToString("yyyy-MM-dd HH:mm:ss"));
        }
    }
    protected void bt_car_Click(object sender, EventArgs e)
    {
        Response.Redirect("Details_kc_car.aspx?carNo=" + tb_car.Text);
    }
    protected void btRefresh_Click(object sender, EventArgs e)
    {
        Response.Redirect("DetectList.aspx"); 
    }
    /// <summary>
    /// 建立复杂表头
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void GridView1_RowCreated(object sender, GridViewRowEventArgs e)
    {
        try
        {
            switch (e.Row.RowType)
            {
                case DataControlRowType.Header://被创建的行是标题行
                    TableCellCollection tcHeader = e.Row.Cells;//取得标题行的单元格集合
                    tcHeader.Clear();//清空标题行的单元格集合
                    int i = 2;
                    TableCell tc;

                    tc = new TableHeaderCell();
                    tc.Attributes.Add("rowspan", "2"); //跨2行
                    tc.Text = "序号";
                    tcHeader.Add(tc);
                    //添加一级表头
                    tc = new TableHeaderCell();
                    tc.Attributes.Add("rowspan", "2"); //跨2行
                    //tc.Attributes.Add("bgcolor", "white");
                    tc.Text = "检测时间";
                    tcHeader.Add(tc);

                    tc = new TableHeaderCell();
                    tc.Attributes.Add("rowspan", "2"); //跨2行
                    tc.Text = "车组号";
                    tcHeader.Add(tc);

                    tc = new TableHeaderCell();
                    tc.Attributes.Add("rowspan", "2"); //跨2行
                    tc.Text = "轴数";
                    tcHeader.Add(tc);

                    if ((bool)Session["SYS_TS"])
                    {
                        tc = new TableHeaderCell();
                        tc.Attributes.Add("rowspan", "2"); //跨2行
                        tc.Text = "探伤";
                        tcHeader.Add(tc);
                    }

                    if ((bool)Session["SYS_CS"])
                    {
                        tc = new TableHeaderCell();
                        tc.Attributes.Add("rowspan", "2"); //跨2行
                        tc.Text = "擦伤";
                        tcHeader.Add(tc);
                    }

                    if ((bool)Session["SYS_WX"])
                    {
                        tc = new TableHeaderCell();
                        tc.Attributes.Add("colspan", "7"); //跨5列
                        tc.Text = "外形尺寸";
                        tcHeader.Add(tc);
                    }
                    tc = new TableHeaderCell();
                    tc.Attributes.Add("rowspan", "2"); //跨2行
                    tc.Text = "所属";
                    tcHeader.Add(tc);
                    
                    
                    tc = new TableHeaderCell();
                    tc.Attributes.Add("rowspan", "2"); //跨2行
                    tc.Text = "";
                    tcHeader.Add(tc);

                    tc = new TableHeaderCell();
                    tc.Attributes.Add("rowspan", "2"); //跨2行
                    tc.Text = "";
                    tcHeader.Add(tc);

                    tc = new TableHeaderCell();
                    tc.Attributes.Add("rowspan", "2"); //跨2行
                    tc.Text = "";
                    tcHeader.Add(tc);

                    tc = new TableHeaderCell();
                    tc.Attributes.Add("rowspan", "2"); //跨2行
                    tc.Text = "</th></tr><tr>";
                    tcHeader.Add(tc);

                    //添加二级表头
                    if ((bool)Session["SYS_WX"])
                    {

                        tc = new TableHeaderCell();
                        tc.Attributes.Add("bgcolor", "LightSteelBlue");
                        tc.Text = "车轮<br/>直径";
                        tcHeader.Add(tc);

                        tc = new TableHeaderCell();
                        tc.Attributes.Add("bgcolor", "LightSteelBlue");
                        tc.Text = "踏面<br/>磨耗";
                        tcHeader.Add(tc);

                        tc = new TableHeaderCell();
                        tc.Attributes.Add("bgcolor", "LightSteelBlue");
                        tc.Text = "轮缘<br/>厚度";
                        tcHeader.Add(tc);

                        tc = new TableHeaderCell();
                        tc.Attributes.Add("bgcolor", "LightSteelBlue");
                        tc.Text = "轮缘<br/>高度";
                        tcHeader.Add(tc);

                        tc = new TableHeaderCell();
                        tc.Attributes.Add("bgcolor", "LightSteelBlue");
                        tc.Text = "轮辋<br/>宽度";
                        tcHeader.Add(tc);

                        tc = new TableHeaderCell();
                        tc.Attributes.Add("bgcolor", "LightSteelBlue");
                        tc.Text = "QR<br/>值";
                        tcHeader.Add(tc);

                        tc = new TableHeaderCell();
                        tc.Attributes.Add("bgcolor", "LightSteelBlue");
                        tc.Text = "内<br/>侧距</th></tr><tr>";
                        tcHeader.Add(tc);
                    }

                    break;
            }
        }
        catch
        { }
    }
    protected void bt_Verify_Click(object sender, EventArgs e)
    {
        Response.Redirect("Verify.aspx");
    }
    protected void btSwitch_Click(object sender, EventArgs e)
    {
        Response.Redirect("switch.aspx");
    }
    protected void btSetDelay_Click(object sender, EventArgs e)
    {
        ushort delay;
        if (ushort.TryParse(tbDelay.Text, out delay))
        {
            IniFile ini = new IniFile(System.IO.Path.GetDirectoryName(Page.Request.PhysicalPath) + "\\tycho.ini");
            ini.IniWriteValue("SYSTEM", "DelayMinute", delay.ToString());
            ReloadIniFile();
        }
        else
        {
            Response.Write(string.Format("<script language=javascript>alert(\'{0} 延时时间错误\');</script>", tbDelay.Text));
        }
    }
    protected void bt_threshold_Click(object sender, EventArgs e)
    {
        Response.Redirect("adjustThresholds.aspx");
    }
    protected void Menu2_MenuItemClick(object sender, MenuEventArgs e)
    {
        switch (e.Item.Text)
        {
            case "门限配置":
                Response.Redirect("~/adjustThresholds.aspx");
                break;
            case "车组配置":
                Response.Redirect("~/engine_type.aspx");
                break;
            case "车型配置":
                Response.Redirect("~/adjustCar.aspx");
                break;
            default:
                break;
        }
    }
    protected void Menu1_MenuItemClick(object sender, MenuEventArgs e)
    {
        switch (e.Item.Text)
        {
            case "综合查询":
                this.Page.ClientScript.RegisterStartupScript(this.GetType(), "testPage", "<script>openad();</script>");
                break;
            case "历史查询":
                Response.Redirect("~/HistoryCheck.aspx");
                break;
            case "超限查询":
                Response.Redirect("~/AlarmCheck.aspx");
                break;
            default:
                break;
        }
    }

    protected void bt_log_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/operateLog.aspx");
    }
}


