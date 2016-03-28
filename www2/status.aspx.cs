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
using System.Drawing;


public partial class status : Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        //if (PUBS.dataDisk == null)
        //{
        //    IniFile ini = new IniFile(System.IO.Path.GetDirectoryName(Page.Request.PhysicalPath) + "\\tycho.ini");
        //    string s = ini.IniReadValue("常规", "datapath", "d:");
        //    PUBS.dataDisk = ini.IniReadValue("常规", "datapath", "d:").Substring(0, 2);
        //}




        //btRefresh.Text = PUBS.Txt("数据刷新");

        GridView1.Columns[0].HeaderText = PUBS.Txt("检测时间");
        GridView1.Columns[1].HeaderText = PUBS.Txt("车组号");
        GridView1.Columns[2].HeaderText = PUBS.Txt("轴数");
        GridView1.Columns[3].HeaderText = PUBS.Txt("探伤");
        GridView1.Columns[4].HeaderText = PUBS.Txt("擦伤");
        GridView1.Columns[5].HeaderText = PUBS.Txt("外形");
        //LoginStatus2.LogoutText = PUBS.Txt("注销");

        
       
        if (!IsPostBack)
        {

            ViewState["sql1"] = "SELECT * FROM [V_Detect_kc_outline] where bzh like 'CRH%'  ORDER BY [testDateTime] DESC";
            ReloadIniFile();
        }
        Session["alert"] = Application["BoGao_Alert"];

        //SqlDataSource1.FilterExpression = Convert.ToString(ViewState["sql1"]);
        SqlDataSource1.SelectCommand = Convert.ToString(ViewState["sql1"]);


        GridView1.Columns[3].Visible = (bool)Application["SYS_TS"];

        GridView1.Columns[4].Visible = (bool)Application["SYS_CS"];

        GridView1.Columns[5].Visible = (bool)Application["SYS_WX"];

        RefreshZhData();
        Refresh1Data();
        Refresh2Data();
        //延时显示结果
        int iDelay = 0;
        int.TryParse(Application["DelayMinute"].ToString(), out iDelay);
        if (iDelay > 0)
            //1.时间符合　2.强制放行　3.单轮对　4.全部正常
            SqlDataSource1.SelectCommand = string.Format("SELECT * FROM [V_Detect_kc_outline] where (testdatetime <dateadd(minute, -{0}, getdate())) or (isShow=1) or (AxleNum=1) or (s_level_ts='正常' and s_level_cs='正常' and s_level_M='正常') ORDER BY [testDateTime] DESC", iDelay);
    }

    private void ReloadIniFile()
    {
        IniFile ini = new IniFile(System.IO.Path.GetDirectoryName(Page.Request.PhysicalPath) + "\\tycho.ini");
        Application.Lock();
        Application.Set("double_BoGao_Red", Convert.ToInt32(ini.IniReadValue("波高", "double_red", "15")));
        Application.Set("double_BoGao_Yellow", Convert.ToInt32(ini.IniReadValue("波高", "double_yellow", "30")));
        Application.Set("single_BoGao_Red", Convert.ToInt32(ini.IniReadValue("波高", "single_red", "15")));
        Application.Set("single_BoGao_Yellow", Convert.ToInt32(ini.IniReadValue("波高", "single_yellow", "30")));
        Application.Set("angle_BoGao_Red", Convert.ToInt32(ini.IniReadValue("波高", "angle_red", "15")));
        Application.Set("angle_BoGao_Yellow", Convert.ToInt32(ini.IniReadValue("波高", "angle_yellow", "30")));
        Application.Set("BoGao_Alert", Convert.ToInt32(ini.IniReadValue("波高", "alert", "100")));
        Application.Set("Detector_zj_num", Convert.ToInt32(ini.IniReadValue("探头", "zj", "21")));
        Application.Set("Detector_double_num", (int)Application["Detector_zj_num"] * 4);
        Application.Set("Detector_single_num", (int)Application["Detector_zj_num"] * 2);
        Application.Set("Detector_angle_num", (int)Application["Detector_zj_num"] * 2);
        Application.Set("DataPath", ini.IniReadValue("常规", "datapath", ""));
        Application.Set("UnitName", ini.IniReadValue("常规", "unit", ""));
        Application.Set("double_flag_offset", Convert.ToInt32(ini.IniReadValue("探头", "double_flag_offset", "0")));
        Application.Set("single_flag_offset", Convert.ToInt32(ini.IniReadValue("探头", "single_flag_offset", "0")));
        Application.Set("angle_flag_offset", Convert.ToInt32(ini.IniReadValue("探头", "angle_flag_offset", "0")));
        Application.Set("Detector_double_len", Convert.ToInt32(ini.IniReadValue("探头", "double_len", "38")));
        Application.Set("Detector_single_len", Convert.ToInt32(ini.IniReadValue("探头", "single_len", "76")));
        Application.Set("Detector_angle_len", Convert.ToInt32(ini.IniReadValue("探头", "angle_len", "76")));
        Application.Set("double_start_offset", Convert.ToDouble(ini.IniReadValue("探头", "double_start_offset", "25")));
        Application.Set("single_start_offset", Convert.ToDouble(ini.IniReadValue("探头", "single_start_offset", "17")));
        Application.Set("angle_start_offset", Convert.ToDouble(ini.IniReadValue("探头", "angle_start_offset", "5")));
        Application.Set("single_mode", Convert.ToInt32(ini.IniReadValue("探头", "single_mode", "0")));
        Application.Set("video_forward", Convert.ToDouble(ini.IniReadValue("视频", "forward", "25")));
        Application.Set("video_last", Convert.ToDouble(ini.IniReadValue("视频", "last", "25")));
        Application.Set("whmsXmlDataPath", ini.IniReadValue("WHMS", "XmlDataPath", ""));
        Application.Set("SYS_TS", Convert.ToBoolean(ini.IniReadValue("SYSTEM","TS", "false")));
        Application.Set("SYS_CS", Convert.ToBoolean(ini.IniReadValue("SYSTEM", "CS", "false")));
        Application.Set("SYS_CS_IMAGE", Convert.ToBoolean(ini.IniReadValue("SYSTEM", "CS_IMAGE", "false")));
        Application.Set("SYS_WX", Convert.ToBoolean(ini.IniReadValue("SYSTEM", "WX", "false")));
        Application.Set("SYS_MODE", ini.IniReadValue("SYSTEM", "mode", "8UT"));
        Application.Set("SYS_NAME", ini.IniReadValue("SYSTEM", "name", "轮对在线综合检测系统"));
        Application.Set("URL_HXZY", ini.IniReadValue("HXZY", "url", ""));
        Application.Set("ScDeep", Convert.ToInt32(ini.IniReadValue("SYSTEM", "ScDeep", "0")));
        Application.Set("DelayMinute", Convert.ToInt32(ini.IniReadValue("SYSTEM", "DelayMinute", "0"))); 
        Application.UnLock();
    }


    protected void LoginStatus1_LoggedOut(object sender, EventArgs e)
    {
        Session.Remove("login");
        PUBS.Log(Request.UserHostAddress, Membership.GetUser().UserName, 0, this.GetType().FullName);
    }




    protected void GridView1_DataBound(object sender, EventArgs e)
    {
        for (int i = 0; i <= GridView1.Rows.Count - 1; i++)
        {
            bool haveAlarm = false;
            bool bTemp;
            TableCell cell = GridView1.Rows[i].Cells[3];
            bTemp = PUBS.ColorBug(ref cell);
            haveAlarm = haveAlarm || bTemp;

            cell = GridView1.Rows[i].Cells[4];
            bTemp = PUBS.ColorBug(ref cell);
            haveAlarm = haveAlarm || bTemp;

            cell = GridView1.Rows[i].Cells[5];
            bTemp = PUBS.ColorBug(ref cell);
            haveAlarm = haveAlarm || bTemp;

            cell = GridView1.Rows[i].Cells[6];
            bTemp = PUBS.ColorBug(ref cell);
            haveAlarm = haveAlarm || bTemp;






            cell = GridView1.Rows[i].Cells[0];
            TableCell cell2 = GridView1.Rows[i].Cells[7];
            if ((cell2.Text == "False") && haveAlarm)
            {
                cell.Style.Value = "background-repeat: no-repeat; background-image: url('image/new.gif')";
            }
                cell2.Text = "";

        }       
    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        string cmd = e.CommandName;
        if (cmd == "tycho")
        {
            string ss = (string)e.CommandArgument;
            Response.Redirect("rpt_train.aspx?field=" + ss);
        }
    }

    protected void btRefresh_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.Url.ToString()); 
    }
    private void DevStatus(ref Label tb, bool normal)
    {
        tb.Text = normal ? "正常" : "故障";
        tb.BackColor = normal ? Color.Lime : Color.Red;
        tb.ForeColor = Color.Black;

    }
    private void SwitchStatus(ref Label tb, bool on)
    {
        tb.ForeColor = on ? Color.Lime : Color.Gray;
    }
    private void SetStatus(ref Label tb, int level, string txt)
    {
        tb.Text = txt;
        switch (level)
        {
            case 1: tb.BackColor = Color.Red;
                tb.ForeColor = Color.Black;
                break;
            case 2: tb.BackColor = Color.Yellow;
                tb.ForeColor = Color.Black;
                break;
            case 3: tb.BackColor = Color.Lime;
                tb.ForeColor = Color.Black;
                break;
        }
        
    }

    private void GetDevLevel(string name, ref double uplevel1, ref double uplevel2, ref double lowlevel1, ref double lowlevel2)
    {
        System.Data.DataTable dt = PUBS.sqlQuery(string.Format("select * from thresholds_dev where name='{0}'", name));
        if ((dt != null) && (dt.Rows.Count > 0))
        {
            DataRow dr = dt.Rows[0];
            if (dr["up_level1"].ToString() !="")
                uplevel1 = (double)dr["up_level1"];
            if (dr["up_level2"].ToString() != "")
                uplevel2 = (double)dr["up_level2"];
            if (dr["low_level1"].ToString() != "")
                lowlevel1 = double.Parse(dr["low_level1"].ToString());
            if (dr["low_level2"].ToString() != "")
                lowlevel2 = double.Parse(dr["low_level2"].ToString());
        }
    }
    //剩余校验天数
    private void Refresh1Data()
    {
        System.Data.DataTable dt = PUBS.sqlQuery("select top 1 * from verify order by verifydate desc");
        double uplevel1=0; double uplevel2=0; double lowlevel1=0; double lowlevel2=7;
        GetDevLevel("verify", ref uplevel1, ref uplevel2, ref lowlevel1, ref lowlevel2);
        if (dt.Rows.Count > 0)
        {
            DateTime dt_verify = (DateTime)dt.Rows[0]["verifydate"];
            int sp = (int)(dt_verify.AddDays(30) - DateTime.Now.Date).TotalDays;
            int level;
            string gq = "剩余";
            if (sp > lowlevel2)
                level = 3;
            else if (sp > lowlevel1)
                level = 2;
            else
            {
                level = 1;
                gq = "过期";
            }
            SetStatus(ref lb_verify, level, gq + Math.Abs(sp).ToString()+"天");
        }
    }
    //可用磁盘空间
    private void Refresh2Data()
    {
        double uplevel1 = 0; double uplevel2 = 0; double lowlevel1 = 1; double lowlevel2 = 5;
        GetDevLevel("diskspace", ref uplevel1, ref uplevel2, ref lowlevel1, ref lowlevel2);
        double disk=0;
        string sDisk = "-";
        int level = 2; 
        try
        {
            disk = PUBS.GetDiskStatus(PUBS.dataDisk);
            if (disk > lowlevel2)
                level = 3;
            else if (disk > lowlevel1)
                level = 2;
            else
                level = 1;
        }
        catch
        { }
        sDisk = string.Format("{0:F1} GB", disk);
        SetStatus(ref lb_disk, level, sDisk);
    }
    private void RefreshZhData()
    {
        string strNull = "-";
        System.Data.DataTable dt = PUBS.sqlQuery("select * from SysStatus");
        if (dt.Rows.Count > 0)
        {
            lb_time.Text = dt.Rows[0]["testDatetime"].ToString();
            string strDatas = dt.Rows[0]["zhDatas"].ToString();
            if (strDatas != "")
            {
                byte[] datas = Convert.FromBase64String(strDatas);
                ZhParam zh = new ZhParam(datas);
                zh.scDeep = (int)Application["ScDeep"];
                lb_SysStatus.Text = zh.SysStatus;
                lb_Mode.Text = zh.Mode;
                lb_IsOnline.Text = zh.IsOnLine;
                lb_OnlineTimes.Text = zh.OnlineTimes.ToString();
                lb_direction.Text = zh.Direction;
                lb_wheelIn.Text = zh.WheelNum_in.ToString();
                lb_wheelPass.Text = zh.WheelNum_pass.ToString();
                lb_speedIn.Text = (zh.SpeedIn / 10.0).ToString("F1");
                lb_speedOut.Text = (zh.SpeedOut / 10.0).ToString("F1");
                //lb_comWord.Text = zh.ComWord.ToString("X2");
                DevStatus(ref lb_comWord, (zh.ComWord & 0x01) == 0);
                SwitchStatus(ref lb_pump, zh.PumpOn);
                lb_temp.Text = zh.Temperature.ToString();
                lb_waterTemp.Text = zh.WaterTemperature.ToString();
                lb_ATemp.Text = zh.ATemperature.ToString();
                lb_BTemp.Text = zh.BTemperature.ToString();
                lb_waterLevel.Text = zh.WaterLevel.ToString();
                SwitchStatus(ref lb_fan, zh.FanOn);
                SwitchStatus(ref lb_hot, zh.HotOn);
                byte b = zh.PortStatus;
                SwitchStatus(ref lb_IR1, (b & 0x01) == 0);
                SwitchStatus(ref lb_IR2, (b & 0x02) == 0);
                SwitchStatus(ref lb_IR3, (b & 0x04) == 0);
                SwitchStatus(ref lb_IR4, (b & 0x08) == 0);
                SwitchStatus(ref lb_SP1, (b & 0x10) == 0);
                SwitchStatus(ref lb_SP2, (b & 0x20) == 0);
                SwitchStatus(ref lb_SP3, (b & 0x40) == 0);
                SwitchStatus(ref lb_SP4, (b & 0x80) == 0);

            }
            else
            {
                lb_SysStatus.Text = strNull;
                lb_Mode.Text = strNull;
                lb_IsOnline.Text = strNull;
                lb_OnlineTimes.Text = strNull;
                lb_direction.Text = strNull;
                lb_wheelIn.Text = strNull;
                lb_wheelPass.Text = strNull;
                lb_speedIn.Text = strNull;
                lb_speedOut.Text = strNull;
                lb_comWord.Text = strNull;
                lb_pump.Text = strNull;
                lb_temp.Text = strNull;
                lb_waterTemp.Text = strNull;
                lb_ATemp.Text = strNull;
                lb_BTemp.Text = strNull;
                lb_waterLevel.Text = strNull;
                lb_fan.Text = strNull;
                lb_hot.Text = strNull;
                lb_IR1.Text = strNull;
                lb_IR2.Text = strNull;
                lb_IR3.Text = strNull;
                lb_IR4.Text = strNull;
                lb_SP1.Text = strNull;
                lb_SP2.Text = strNull;
                lb_SP3.Text = strNull;
                lb_SP4.Text = strNull;

            }

            //lb_diskFree.Text = disk;
            //if (diskFullWarning)
            //    lb_diskFree.BackColor =  Color.Red;


            //仪器状态
            strDatas = dt.Rows[0]["device"].ToString();
            if (Application["SYS_MODE"].ToString() == "12UT")
            {
                if (strDatas.Length == 25)
                {
                    DevStatus(ref lb_ut1, strDatas[1] == '1');
                    DevStatus(ref lb_ut2, strDatas[2] == '1');
                    DevStatus(ref lb_ut3, strDatas[3] == '1');
                    DevStatus(ref lb_ut4, strDatas[4] == '1');
                    DevStatus(ref lb_ut5, strDatas[5] == '1');
                    DevStatus(ref lb_ut6, strDatas[6] == '1');
                    DevStatus(ref lb_ut7, strDatas[7] == '1');
                    DevStatus(ref lb_ut8, strDatas[8] == '1');
                    DevStatus(ref lb_ut9, strDatas[9] == '1');
                    DevStatus(ref lb_ut10, strDatas[10] == '1');
                    DevStatus(ref lb_ut11, strDatas[11] == '1');
                    DevStatus(ref lb_ut12, strDatas[12] == '1');


                    DevStatus(ref lb_cy1, strDatas[13] == '1');
                    DevStatus(ref lb_cy2, strDatas[14] == '1');
                    DevStatus(ref lb_cy3, strDatas[15] == '1');
                    DevStatus(ref lb_cy4, strDatas[16] == '1');
                    DevStatus(ref lb_cy5, strDatas[17] == '1');
                    DevStatus(ref lb_cy6, strDatas[18] == '1');
                    DevStatus(ref lb_cy7, strDatas[19] == '1');
                    DevStatus(ref lb_cy8, strDatas[20] == '1');
                    DevStatus(ref lb_cy9, strDatas[21] == '1');
                    DevStatus(ref lb_cy10, strDatas[22] == '1');
                    DevStatus(ref lb_cy11, strDatas[23] == '1');
                    DevStatus(ref lb_cy12, strDatas[24] == '1');

                }
                else
                {
                    lb_ut1.Text = strNull;
                    lb_ut2.Text = strNull;
                    lb_ut3.Text = strNull;
                    lb_ut4.Text = strNull;
                    lb_ut5.Text = strNull;
                    lb_ut6.Text = strNull;
                    lb_ut7.Text = strNull;
                    lb_ut8.Text = strNull;
                    lb_ut9.Text = strNull;
                    lb_ut10.Text = strNull;
                    lb_ut11.Text = strNull;
                    lb_ut12.Text = strNull;

                    lb_cy1.Text = strNull;
                    lb_cy2.Text = strNull;
                    lb_cy3.Text = strNull;
                    lb_cy4.Text = strNull;
                    lb_cy5.Text = strNull;
                    lb_cy6.Text = strNull;
                    lb_cy7.Text = strNull;
                    lb_cy8.Text = strNull;
                    lb_cy9.Text = strNull;
                    lb_cy10.Text = strNull;
                    lb_cy11.Text = strNull;
                    lb_cy12.Text = strNull;

                }
            }
            else
            {
                if (strDatas.Length == 17)
                {
                    DevStatus(ref lb_ut1, strDatas[1] == '1');
                    DevStatus(ref lb_ut2, strDatas[2] == '1');
                    DevStatus(ref lb_ut3, strDatas[3] == '1');
                    DevStatus(ref lb_ut4, strDatas[4] == '1');
                    DevStatus(ref lb_ut5, strDatas[5] == '1');
                    DevStatus(ref lb_ut6, strDatas[6] == '1');
                    DevStatus(ref lb_ut7, strDatas[7] == '1');
                    DevStatus(ref lb_ut8, strDatas[8] == '1');


                    DevStatus(ref lb_cy1, strDatas[9] == '1');
                    DevStatus(ref lb_cy2, strDatas[10] == '1');
                    DevStatus(ref lb_cy3, strDatas[11] == '1');
                    DevStatus(ref lb_cy4, strDatas[12] == '1');
                    DevStatus(ref lb_cy5, strDatas[13] == '1');
                    DevStatus(ref lb_cy6, strDatas[14] == '1');
                    DevStatus(ref lb_cy7, strDatas[15] == '1');
                    DevStatus(ref lb_cy8, strDatas[16] == '1');

                }
                else
                {
                    lb_ut1.Text = strNull;
                    lb_ut2.Text = strNull;
                    lb_ut3.Text = strNull;
                    lb_ut4.Text = strNull;
                    lb_ut5.Text = strNull;
                    lb_ut6.Text = strNull;
                    lb_ut7.Text = strNull;
                    lb_ut8.Text = strNull;

                    lb_cy1.Text = strNull;
                    lb_cy2.Text = strNull;
                    lb_cy3.Text = strNull;
                    lb_cy4.Text = strNull;
                    lb_cy5.Text = strNull;
                    lb_cy6.Text = strNull;
                    lb_cy7.Text = strNull;
                    lb_cy8.Text = strNull;

                }

            }
        }
    }
}

//public class DevStatus
//{
//    //public Dev dev_freediskspace;
//    public DevStatus
//    {
//    }
//    public void Refrush()
//    {
        
//    }
//    public void Refrush(string name)
//    {
//        if (name == "FreeDiskSpace")
//        {
//            PUBS.GetDiskStatus(PUBS.dataDisk);
//        }
//    }

//}

//public class Dev
//{
//    public Label Lb_dev;
//    private string name;
//    public Dev(string name)
//    {
//        this.name = name;
//    }
//    public void SetLabel(Label lab)
//    {
//        this.Lb_dev = lab;
//    }
//    public virtual void GetValue()
//    {
//    }
//}




