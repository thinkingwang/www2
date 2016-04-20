using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.DataVisualization.Charting;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using Microsoft.Reporting.WebForms;

public partial class whms_wheel : System.Web.UI.Page
{
    private string xmlDataPath;
    public string datetimestr;
    int axleNum;
    public int axleNo;
    public int carNo;
    public int axleNoInCar;
    public int wheelNo;
    private DataTable dtData;
    PrnWhmsWheel prn;
    string trainInfo;
    //string[] sPos = new string[2] { "左", "右" };
    //string[] sLevel = new string[3] { "", "一级报警", "二级报警" };
    //string[] sLevel_wx = new string[3] { "", "超限", "预警" };
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["login"] == null)
            Response.Redirect(PUBS.HomePage);

        if (PUBS.GetUserLevel() > 1)
            Response.Redirect("invalid.html");

        datetimestr = Request.QueryString["field"];
        trainInfo = PUBS.GetTrainInfo(datetimestr);

        if (!IsPostBack)
        {
            if (datetimestr != null)
            {
                string desc;
                string sAxleNum = "", sCarNum = "", sInfor = "";
                string sql = string.Format("select axleNum, s_level_ts, bzh from V_Detect_kc where testdatetime='{0}'", datetimestr);
                DataTable dtData = PUBS.sqlQuery(sql);
                if (dtData.Rows.Count > 0)
                {
                    axleNum = int.Parse(dtData.Rows[0][0].ToString());
                    sAxleNum = axleNum.ToString();
                    sCarNum = (axleNum / 4).ToString();
                    string sLevelTs = dtData.Rows[0]["s_level_ts"].ToString();
                    //停车　所有数据无效
                    if (sLevelTs == "停车")
                        sInfor = "本次检测过程中停车或速度异常，检测数据无效;";
                    //缺水　探伤无效
                    else if (sLevelTs == "无效")
                        sInfor = "本次检测缺少耦合剂，探伤数据无效;";
                    //无车号　数据不准确
                    if (dtData.Rows[0]["bzh"].ToString().StartsWith("未"))
                        sInfor += "本次检测因缺少车型车号，结果数据仅供参考;";

                    if (sInfor == "")
                        sInfor = "正常";
                }

                AddParameter("name", Session["SYS_NAME"].ToString());
                AddParameter("testDateTime", datetimestr);
                AddParameter("trainInfo", trainInfo);
                AddParameter("department", Session["Unit"].ToString());
                AddParameter("axleNum", sAxleNum);
                AddParameter("carNum", sCarNum);
                AddParameter("Operator", Membership.GetUser().UserName);
                AddParameter("Infor", sInfor);


                sql = string.Format("select * from DetectStatus where testdatetime='{0}'", datetimestr);
                dtData = PUBS.sqlQuery(sql);
                if (dtData.Rows.Count > 0)
                {
                    string strDatas = dtData.Rows[0]["zhDatas"].ToString();
                    if (strDatas != "")
                    {
                        byte[] datas = Convert.FromBase64String(strDatas);
                        ZhParam zh = new ZhParam(datas);
                        AddParameter("zh_status", zh.SysStatus);
                        AddParameter("zh_mode", zh.Mode);
                        AddParameter("zh_trainStatus", zh.IsOnLine);
                        AddParameter("zh_onlineTimes", zh.OnlineTimes.ToString() + " 秒");
                        AddParameter("zh_direction", zh.Direction);
                        AddParameter("zh_wheelIn", zh.WheelNum_in.ToString());
                        AddParameter("zh_wheelPass", zh.WheelNum_pass.ToString());
                        AddParameter("zh_speedIn", (zh.SpeedIn / 10.0).ToString("F1")+" km/h");
                        AddParameter("zh_speedOut", (zh.SpeedOut / 10.0).ToString("F1") + " km/h");
                        //AddParameter("zh_commFlag", zh.ComWord.ToString("X2"));
                        AddParameter("zh_commFlag", DevStatus((zh.ComWord & 0x01) == 0));
                        AddParameter("zh_pump", SwitchStatus(zh.PumpOn));
                        AddParameter("zh_water", zh.WaterLevel.ToString() + " mm");
                        byte b = zh.PortStatus;
                        AddParameter("zh_IR1", SwitchStatus((b & 0x01) == 0));
                        AddParameter("zh_IR2", SwitchStatus((b & 0x02) == 0));
                        AddParameter("zh_IR3", SwitchStatus((b & 0x04) == 0));
                        AddParameter("zh_IR4", SwitchStatus((b & 0x08) == 0));
                        AddParameter("zh_SP1", SwitchStatus((b & 0x10) == 0));
                        AddParameter("zh_SP2", SwitchStatus((b & 0x20) == 0));
                        AddParameter("zh_SP3", SwitchStatus((b & 0x40) == 0));
                        AddParameter("zh_SP4", SwitchStatus((b & 0x80) == 0));
                        AddParameter("zh_temp", zh.Temperature.ToString() + " ℃");
                        AddParameter("zh_tempWater", zh.WaterTemperature.ToString() + " ℃");
                        AddParameter("zh_tempA", zh.ATemperature.ToString() + " ℃");
                        AddParameter("zh_tempB", zh.BTemperature.ToString() + " ℃");
                        AddParameter("zh_fan", SwitchStatus(zh.FanOn));
                        AddParameter("zh_hot", SwitchStatus(zh.HotOn));

                    }
                    strDatas = dtData.Rows[0]["device"].ToString();
                    if (strDatas.Length == 17)
                    {
                        AddParameter("UT1", DevStatus(strDatas[1] == '1'));
                        AddParameter("UT2", DevStatus(strDatas[2] == '1'));
                        AddParameter("UT3", DevStatus(strDatas[3] == '1'));
                        AddParameter("UT4", DevStatus(strDatas[4] == '1'));
                        AddParameter("UT5", DevStatus(strDatas[5] == '1'));
                        AddParameter("UT6", DevStatus(strDatas[6] == '1'));
                        AddParameter("UT7", DevStatus(strDatas[7] == '1'));
                        AddParameter("UT8", DevStatus(strDatas[8] == '1'));
                        AddParameter("CY1", DevStatus(strDatas[9] == '1'));
                        AddParameter("CY2", DevStatus(strDatas[10] == '1'));
                        AddParameter("CY3", DevStatus(strDatas[11] == '1'));
                        AddParameter("CY4", DevStatus(strDatas[12] == '1'));
                        AddParameter("CY5", DevStatus(strDatas[13] == '1'));
                        AddParameter("CY6", DevStatus(strDatas[14] == '1'));
                        AddParameter("CY7", DevStatus(strDatas[15] == '1'));
                        AddParameter("CY8", DevStatus(strDatas[16] == '1'));
                    }
                }

                ReportViewer1.LocalReport.DataSources.Clear();
                dtData = new DataTable();
                ReportDataSource rds = new ReportDataSource("DataSet1",dtData);
                ReportViewer1.LocalReport.DataSources.Add(rds);
                ReportViewer1.LocalReport.DisplayName = string.Format("系统状态报告({0} {1})",datetimestr.Replace(":", "").Replace("-", "").Replace("_", "").Replace(" ", "-"), trainInfo);



                ReportViewer1.LocalReport.Refresh();
            }
        }
    }

    private string SwitchStatus(bool status)
    {
        if (status)
            return "On";
        else
            return "Off";
    }
    private string DevStatus(bool status)
    {
        if (status)
            return "正常";
        else
            return "故障";
    }
    private void AddParameter(string name, string value)
    {
        ReportParameter rptPara0 = new ReportParameter(name, value);
        ReportViewer1.LocalReport.SetParameters(rptPara0);
    }
    protected void LoginStatus2_LoggedOut(object sender, EventArgs e)
    {
        Session.Remove("login");
        PUBS.Log(Request.UserHostAddress, Membership.GetUser().UserName, 0, this.GetType().FullName);

    }
    /// <summary>
    /// 导出报表
    /// </summary>
    /// <param name="s_rptType">文件类型：Word PDF Excel</param>
    /// <param name="fileName">文件名</param>
    private void saveRptAs(String s_rptType, string fileName)
    {

        Warning[] warnings;
        string[] streamids;
        string mimeType;
        string encoding;
        string extension;

        byte[] bytes = ReportViewer1.LocalReport.Render(
        s_rptType, null, out mimeType, out encoding, out extension,
        out streamids, out warnings);

        /*
        FileStream stream = File.OpenWrite(@"C:\Documents and Settings\michael.shorten\Local 
        Settings\Temp\sample.pdf");
        stream.Write(bytes, 0, bytes.Length);
        stream.Close();
        */

        Response.Buffer = true;
        Response.Clear();
        Response.ContentType = mimeType;
        Response.AddHeader("content-disposition", "attachment; filename=" + fileName + "." + extension);
        Response.BinaryWrite(bytes);
        Response.Flush();

    }
    protected void bt_export_Click(object sender, EventArgs e)
    {
        saveRptAs("Word", string.Format("{2}({0} {1})", datetimestr.Replace(":", "").Replace("-", "").Replace("_", "").Replace(" ", "-"), trainInfo, PUBS.Txt("StatusReport")));
    }
}
