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
    string[] sPos = new string[2] { "左", "右" };
    string[] sLevel = new string[5] { "", "1级", "2级", "3级", "无*" };
    //string[] sLevel_wx = new string[3] { "", "超限", "预警" };
    string[] LjCha_Bz;
    string[] sLevel_LjCha_Bz;
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
                bool dir = true;
                string sAxleNum = "", sCarNum = "", sInfor = "";
                string sql = string.Format("select axleNum, isnull(enginedirection,1) enginedirection, engNum, s_level_ts, bzh from V_Detect_kc where testdatetime='{0}'", datetimestr);
                string bzh = "";
                DataTable dtData = PUBS.sqlQuery(sql);
                if (dtData.Rows.Count > 0)
                {
                    axleNum = int.Parse(dtData.Rows[0][0].ToString());
                    sAxleNum = axleNum.ToString();
                    sCarNum = (axleNum / 4).ToString();
                    dir = Convert.ToBoolean(dtData.Rows[0]["enginedirection"].ToString());
                    bzh = dtData.Rows[0]["engNum"].ToString();

                    string sLevelTs = dtData.Rows[0]["s_level_ts"].ToString();
                    //停车　所有数据无效
                    if (sLevelTs == "停车")
                        sInfor = "本次检测过程中停车或速度异常，检测数据无效;";
                    //缺水　探伤无效
                    else if (sLevelTs == "无效")
                        sInfor = "本次检测缺少耦合剂，探伤数据无效;";
                    //无车号　数据不准确
                    if (bzh.StartsWith("未"))
                        sInfor += "本次检测因缺少车型车号，结果数据仅供参考;";

                    if (sInfor == "")
                        sInfor = "正常";
                }

                AddParameter("name", Application["SYS_NAME"].ToString());
                AddParameter("testDateTime", datetimestr);
                AddParameter("trainInfo", trainInfo);
                AddParameter("department", Session["Unit"].ToString());
                AddParameter("carNum", sCarNum);
                AddParameter("axleNum", sAxleNum);
                AddParameter("Operator", Membership.GetUser().UserName);
                AddParameter("Infor", sInfor);



                ReportViewer1.LocalReport.DataSources.Clear();

                DataTable dt = new DataTable();
                dt.Columns.Add("axleNo", System.Type.GetType("System.Int32"));//绝对轴号
                //dt.Columns.Add("carNo", System.Type.GetType("System.Int32"));
                dt.Columns.Add("carPos", System.Type.GetType("System.Int32"));
                dt.Columns.Add("carNo", System.Type.GetType("System.String"));
                //dt.Columns.Add("axleNo", System.Type.GetType("System.Int32"));
                dt.Columns.Add("axlePos", System.Type.GetType("System.Int32"));
                dt.Columns.Add("L_pos", System.Type.GetType("System.Int32"));
                dt.Columns.Add("R_pos", System.Type.GetType("System.Int32"));
                dt.Columns.Add("L_pos_s", System.Type.GetType("System.String"));
                dt.Columns.Add("R_pos_s", System.Type.GetType("System.String"));
                dt.Columns.Add("L_ts", System.Type.GetType("System.String"));
                dt.Columns.Add("R_ts", System.Type.GetType("System.String"));
                dt.Columns.Add("L_cs", System.Type.GetType("System.String"));
                dt.Columns.Add("L_cs_deep", System.Type.GetType("System.String"));
                dt.Columns.Add("R_cs", System.Type.GetType("System.String"));
                dt.Columns.Add("R_cs_deep", System.Type.GetType("System.String"));
                dt.Columns.Add("L_lj", System.Type.GetType("System.String"));
                dt.Columns.Add("L_tmmh", System.Type.GetType("System.String"));
                dt.Columns.Add("L_lyhd", System.Type.GetType("System.String"));
                dt.Columns.Add("L_lygd", System.Type.GetType("System.String"));
                dt.Columns.Add("L_lwhd", System.Type.GetType("System.String"));
                dt.Columns.Add("L_qr", System.Type.GetType("System.String"));
                dt.Columns.Add("ncj", System.Type.GetType("System.String"));
                dt.Columns.Add("R_lj", System.Type.GetType("System.String"));
                dt.Columns.Add("R_tmmh", System.Type.GetType("System.String"));
                dt.Columns.Add("R_lyhd", System.Type.GetType("System.String"));
                dt.Columns.Add("R_lygd", System.Type.GetType("System.String"));
                dt.Columns.Add("R_lwhd", System.Type.GetType("System.String"));
                dt.Columns.Add("R_qr", System.Type.GetType("System.String"));
                dt.Columns.Add("L_Ljc_Z", System.Type.GetType("System.String"));
                dt.Columns.Add("L_Ljc_J", System.Type.GetType("System.String"));
                dt.Columns.Add("L_Ljc_C", System.Type.GetType("System.String"));
                dt.Columns.Add("R_Ljc_Z", System.Type.GetType("System.String"));
                dt.Columns.Add("R_Ljc_J", System.Type.GetType("System.String"));
                dt.Columns.Add("R_Ljc_C", System.Type.GetType("System.String"));
                dt.PrimaryKey = new[] { dt.Columns["axleNo"] };

                for (int i = 0; i < axleNum; i++)
                {
                    dt.Rows.Add(i, 0, "", 0, 0, 0, "", "", "无", "无", "无", "无", "无", "无");
                }
                LjCha_Bz = new string[axleNum/16+1];
                sLevel_LjCha_Bz = new string[axleNum/16+1];
                    //dt.Rows.Add(i,(i / 4 + 1), carPos, PUBS.GetCarInfo(datetimestr, i), (i % 4 + 1), axleIndex, L_pos, R_pos, PUBS.LWXH[L_pos], PUBS.LWXH[R_pos], "无", "无", "无", "无", "无", "无");

                DataTable d = PUBS.sqlQuery(string.Format("exec GetTrain '{0}'", datetimestr));

                foreach (DataRow dr in d.Rows)
                {
                    int iAxleNo = int.Parse(dr["axleNo"].ToString());
                    if (iAxleNo % 16 == 0)
                    {
                        LjCha_Bz[iAxleNo / 16] = dr["LjCha_Bz"].ToString();
                        sLevel_LjCha_Bz[iAxleNo / 16] = dr["Level_LjCha_Bz"].ToString();
                    }
                    object[] key = new object[1] { iAxleNo };
                    DataRow drFind = dt.Rows.Find(key);
                    int pos;
                    if (drFind != null)
                    {
                        if (dr["wheelNo"].ToString() == "0")//左
                        {
                            drFind["carPos"] = int.Parse(dr["carPos"].ToString());
                            drFind["carNo"] = dr["carNo"];
                            drFind["axlePos"] = int.Parse(dr["axlePos"].ToString());
                            pos = int.Parse(dr["Pos"].ToString());
                            drFind["L_pos"] = pos;
                            drFind["L_pos_s"] = PUBS.LWXH[pos];

                            drFind["L_ts"] = dr["slevel_ts"];
                            drFind["L_cs"] = dr["slevel_cs"];
                            drFind["L_cs_deep"] = dr["deep"];
                            drFind["L_lj"] = GetWxDesc(dr["level_lj"].ToString(), dr["lj"].ToString());
                            drFind["L_tmmh"] = GetWxDesc(dr["level_tmmh"].ToString(), dr["tmmh"].ToString());
                            drFind["L_lyhd"] = GetWxDesc(dr["level_lyhd"].ToString(), dr["lyhd"].ToString());
                            drFind["L_lygd"] = GetWxDesc(dr["level_lygd"].ToString(), dr["lygd"].ToString());
                            drFind["L_lwhd"] = GetWxDesc(dr["level_lwhd"].ToString(), dr["lwhd"].ToString());
                            drFind["L_qr"] = GetWxDesc(dr["level_qr"].ToString(), dr["qr"].ToString());

                        }

                        else//右
                        {
                            drFind["carPos"] = int.Parse(dr["carPos"].ToString());
                            drFind["carNo"] = dr["carNo"];
                            drFind["axlePos"] = int.Parse(dr["axlePos"].ToString());
                            pos = int.Parse(dr["Pos"].ToString());
                            drFind["R_pos"] = pos;
                            drFind["R_pos_s"] = PUBS.LWXH[pos];
                            drFind["R_ts"] = dr["slevel_ts"];
                            drFind["R_cs"] = dr["slevel_cs"];
                            drFind["R_cs_deep"] = dr["deep"];
                            drFind["R_lj"] = GetWxDesc(dr["level_lj"].ToString(), dr["lj"].ToString());
                            drFind["R_tmmh"] = GetWxDesc(dr["level_tmmh"].ToString(), dr["tmmh"].ToString());
                            drFind["R_lyhd"] = GetWxDesc(dr["level_lyhd"].ToString(), dr["lyhd"].ToString());
                            drFind["R_lygd"] = GetWxDesc(dr["level_lygd"].ToString(), dr["lygd"].ToString());
                            drFind["R_lwhd"] = GetWxDesc(dr["level_lwhd"].ToString(), dr["lwhd"].ToString());
                            drFind["R_qr"] = GetWxDesc(dr["level_qr"].ToString(), dr["qr"].ToString());

                            drFind["R_Ljc_Z"] = GetWxDesc(dr["Level_LjCha_Zhou"].ToString(), dr["LjCha_Zhou"].ToString());
                            if ((pos == 1) || (pos == 5) || (pos == 8) || (pos == 4))
                                drFind["R_Ljc_J"] = GetWxDesc(dr["Level_LjCha_ZXJ"].ToString(), dr["LjCha_ZXJ"].ToString());
                            if ((pos == 8) || (pos == 1))
                                drFind["R_Ljc_C"] = GetWxDesc(dr["Level_LjCha_Che"].ToString(), dr["LjCha_Che"].ToString());


                            drFind["ncj"] = GetWxDesc(dr["level_ncj"].ToString(), dr["ncj"].ToString());
                        }
                    }
                }

                ReportDataSource rds = new ReportDataSource("DataSet1", dt);
                ReportViewer1.LocalReport.DataSources.Add(rds);
                string sLjCha_Unit = "";
                if (bzh.StartsWith("CRH2") || bzh.StartsWith("CRH380A"))
                    for (int i = 0; i < LjCha_Bz.Length; i++)
                    {
                        int u;
                        if (dir)
                            u = i + 1;
                        else
                            u = LjCha_Bz.Length - i;

                        sLjCha_Unit += string.Format("{0}单元:{1}　　　", u, GetWxDesc2(sLevel_LjCha_Bz[i], LjCha_Bz[i].ToString()));
                    }
                AddParameter("LjCha_Bz", sLjCha_Unit);

                ReportViewer1.LocalReport.DisplayName = string.Format("全编组检测报告({0} {1})", datetimestr.Replace(":", "").Replace("-", "").Replace("_", "").Replace(" ", "-"), trainInfo);
                ReportViewer1.LocalReport.Refresh();
            }
        }
    }
    private string GetWxDesc(string level, string value)
    {
        string s = "-";
        try
        {
            if ((level != "") && (double.Parse(value) != -1000))
            {
                int l = int.Parse(level);
                if ((l == 0) || (l > 2))
                    s = value;
                else
                    s = string.Format("{0}\r\n[{1}]", value, PUBS.sLevel[l]);
            }
        }
        catch
        { }
        return s;
    }
    private string GetWxDesc2(string level, string value)
    {
        string s = "-";
        try
        {
            if ((level != "") && (double.Parse(value) != -1000))
            {
                int l = int.Parse(level);
                if ((l == 0) || (l > 2))
                    s = value;
                else
                    s = string.Format("{0}[{1}]", value, PUBS.sLevel[l]);
            }
        }
        catch
        { }
        return s;
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
        saveRptAs("Word", string.Format("{2}({0} {1})", datetimestr.Replace(":", "").Replace("-", "").Replace("_", "").Replace(" ", "-"), trainInfo, PUBS.Txt("DetailReport")));
    }
}
