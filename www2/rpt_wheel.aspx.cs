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
using System.Xml;
public partial class whms_wheel : System.Web.UI.Page
{
    public string carInfo;
    public string datetimestr;
    int axleNum;
    public int axleNo;
    public int carNo;
    public int axleNoInCar;
    public int wheelNo;
    private DataTable dtData;
    string trainInfo;
    string[] sPos = new string[2] { "左", "右" };
    string[] sLevel = new string[3] { "", "一级报警", "二级报警" };
    //string[] sLevel_wx = new string[3] { "", "超限", "预警" };
    string[] sAngle = new string[2] { "顺时针", "逆时针" };


    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["login"] == null)
            Response.Redirect(PUBS.HomePage);

        if (PUBS.GetUserLevel() > 1)
            Response.Redirect("invalid.html");

        if (!IsPostBack)
        {
            datetimestr = Request.QueryString["field"];
            string sAxleNo = Request.QueryString["axleNo"];
            string sWheelNo = Request.QueryString["wheelNo"];
            if ((datetimestr != null) && (sAxleNo != null) && (sWheelNo != null))
            {
                axleNo = int.Parse(sAxleNo);
                wheelNo = int.Parse(sWheelNo);
                carInfo = PUBS.GetCarInfo(datetimestr, axleNo);

                string desc;
                string sAxleNum = "", sCarNum = "";
                string sql = string.Format("select axleNum from detect where testdatetime='{0}'", datetimestr);
                DataTable dtData = PUBS.sqlQuery(sql);
                if (dtData.Rows.Count > 0)
                {
                    axleNum = int.Parse(dtData.Rows[0][0].ToString());
                    sAxleNum = axleNum.ToString();
                    sCarNum = (axleNum / 4).ToString();
                }

                ReportParameter rptPara0 = new ReportParameter("name", Application["SYS_NAME"].ToString());
                ReportParameter rptPara1 = new ReportParameter("testDateTime", datetimestr);
                trainInfo = PUBS.GetTrainInfo(datetimestr);
                ReportParameter rptPara2 = new ReportParameter("trainInfo", trainInfo);
                ReportParameter rptPara3 = new ReportParameter("department", Session["Unit"].ToString());
                ReportParameter rptPara4 = new ReportParameter("carIndex", (axleNo/4 +1).ToString());
                ReportParameter rptPara5 = new ReportParameter("axleNum", sAxleNum);
                ReportParameter rptPara6 = new ReportParameter("carNum", sCarNum);
                ReportParameter rptPara7 = new ReportParameter("axleIndex", (axleNo % 4 + 1).ToString());
                ReportParameter rptPara8 = new ReportParameter("pos", sPos[wheelNo]);
                ReportParameter rptPara9 = new ReportParameter("carInfo", carInfo);

                string sd = (string.Format("http://192.168.0.5:8081/OneWheelDatasService.asmx/getTSWheelReportPic?testDateTime={0}&axleNo={1}&wheelNo={2}", datetimestr, axleNo, wheelNo));

                XmlDocument x = new XmlDocument();
                x.Load(sd);
                string p = x.InnerText;
                ReportParameter rptPara10 = new ReportParameter("img", p);
                ReportParameter rptPara11 = new ReportParameter("Operator", Membership.GetUser().UserName);
                ReportViewer1.LocalReport.DataSources.Clear();
                //探伤数据
                {
                    sql = string.Format("select * from bugresult where testdatetime='{0}' and axleno={1} and wheelno={2} and level<=2 and isbug=1  order by level, pos_deep desc", datetimestr, axleNo, wheelNo);
                    dtData = PUBS.sqlQuery(sql);
                    int count = dtData.Rows.Count;
                    if (count == 0)
                        desc = "未见二级以上缺陷报警";
                    else
                        desc = string.Format("发现有二级以上缺陷报警车轮{0}个", count);

                    DataTable dt = new DataTable();
                    dt.Columns.Add("index", System.Type.GetType("System.String"));
                    dt.Columns.Add("level", System.Type.GetType("System.String"));
                    dt.Columns.Add("angle", System.Type.GetType("System.String"));
                    dt.Columns.Add("deep", System.Type.GetType("System.String"));
                    dt.Columns.Add("detectors", System.Type.GetType("System.String"));
                    dt.Columns.Add("desc", System.Type.GetType("System.String"));
                    dt.PrimaryKey = new[] { dt.Columns["index"] };


                    int index = 1;

                    foreach (DataRow dr in dtData.Rows)
                    {
                        string sDetectors = "";
                        int i = int.Parse(dr["num_double"].ToString());
                        if (i > 0)
                            sDetectors += string.Format("直探头{0}个;", i);
                        i = int.Parse(dr["num_single"].ToString());
                        if (i > 0)
                            sDetectors += string.Format("大角度探头{0}个;", i);
                        i = int.Parse(dr["num_angle"].ToString());
                        if (i > 0)
                            sDetectors += string.Format("小角度探头{0}个;", i);
                       
                        string sAngleDesc = string.Format("{0}{1}度", sAngle[wheelNo], dr["pos_angle"].ToString());
                        double deep = double.Parse(dr["pos_deep"].ToString());
                        string sDeep = "";
                        if (deep > 0)
                            sDeep = deep.ToString();
                        dt.Rows.Add((index++).ToString(), sLevel[int.Parse(dr["level"].ToString())], sAngleDesc, sDeep, sDetectors, dr["desc"].ToString());
                    }


                    ReportDataSource rds = new ReportDataSource("DataSet1", dt);
                    ReportViewer1.LocalReport.DataSources.Add(rds);
                }
                ////擦伤数据
                //{
                //    sql = string.Format("select testDateTime, axleNo, wheelNo, max(scratch_depth) deep, min(level) level from ScratchDetectResult where testdatetime='{0}' and level <=2 and isbug=1 GROUP BY testDateTime, axleNo, wheelNo order by level", datetimestr);
                //    dtData = PUBS.sqlQuery(sql);
                //    int count = dtData.Rows.Count;
                //    if (count == 0)
                //        desc = "未见二级以上擦伤报警";
                //    else
                //        desc = string.Format("发现有二级以上擦伤报警车轮{0}个", count);
                //    rptPara7 = new ReportParameter("desc_cs", desc);
                //    DataTable dt = new DataTable();
                //    dt.Columns.Add("carNo", System.Type.GetType("System.String"));
                //    dt.Columns.Add("carInfo", System.Type.GetType("System.String"));
                //    dt.Columns.Add("axleNo", System.Type.GetType("System.String"));
                //    dt.Columns.Add("pos", System.Type.GetType("System.String"));
                //    dt.Columns.Add("desc", System.Type.GetType("System.String"));
                //    dt.Columns.Add("deep", System.Type.GetType("System.String"));
                //    foreach (DataRow dr in dtData.Rows)
                //    {
                //        int axleNo = int.Parse(dr["axleNo"].ToString());
                //        string carInfo = PUBS.GetCarInfo(datetimestr, axleNo);
                //        double deep = double.Parse(dr["deep"].ToString());
                //        dt.Rows.Add((axleNo / 4 + 1).ToString(), carInfo, (axleNo % 4 + 1).ToString(), sPos[int.Parse(dr["wheelNo"].ToString())], sLevel[int.Parse(dr["level"].ToString())], deep.ToString("F2"));
                //    }


                //    ReportDataSource rds = new ReportDataSource("DataSet2", dt);
                //    ReportViewer1.LocalReport.DataSources.Add(rds);
                //}
                ////外形数据
                //{
                //    desc = "";
                //    sql = string.Format("select count(*) from ProfileDetectResult where testdatetime='{0}' and level_lj>0 and level_lj<=2 and axleNo <{1}", datetimestr, axleNum);
                //    dtData = PUBS.sqlQuery(sql);
                //    int count = int.Parse(dtData.Rows[0][0].ToString());
                //    if (count > 0)
                //        desc += string.Format("发现轮径预警或超限车轮{0}个;", count);
                //    sql = string.Format("select count(*) from ProfileDetectResult where testdatetime='{0}' and level_tmmh>0 and level_tmmh<=2 and axleNo <{1}", datetimestr, axleNum);
                //    dtData = PUBS.sqlQuery(sql);
                //    count = int.Parse(dtData.Rows[0][0].ToString());
                //    if (count > 0)
                //        desc += string.Format("发现踏面磨耗预警或超限车轮{0}个;", count);
                //    sql = string.Format("select count(*) from ProfileDetectResult where testdatetime='{0}' and level_lyhd>0 and level_lyhd<=2 and axleNo <{1}", datetimestr, axleNum);
                //    dtData = PUBS.sqlQuery(sql);
                //    count = int.Parse(dtData.Rows[0][0].ToString());
                //    if (count > 0)
                //        desc += string.Format("发现轮缘厚度预警或超限车轮{0}个;", count);
                //    sql = string.Format("select count(*) from ProfileDetectResult where testdatetime='{0}' and level_lwhd>0 and level_lwhd<=2 and axleNo <{1}", datetimestr, axleNum);
                //    dtData = PUBS.sqlQuery(sql);
                //    count = int.Parse(dtData.Rows[0][0].ToString());
                //    if (count > 0)
                //        desc += string.Format("发现轮辋厚度预警或超限车轮{0}个;", count);
                //    sql = string.Format("select count(*) from ProfileDetectResult where testdatetime='{0}' and level_ncj>0 and level_ncj<=2 and axleNo <{1}", datetimestr, axleNum);
                //    dtData = PUBS.sqlQuery(sql);
                //    count = int.Parse(dtData.Rows[0][0].ToString()) / 2;
                //    if (count > 0)
                //        desc += string.Format("发现内侧距预警或超限车轴{0}个;", count);
                //    sql = string.Format("select count(*) from ProfileDetectResult where testdatetime='{0}' and (level_ncj is null) and axleNo <{1}", datetimestr, axleNum);
                //    dtData = PUBS.sqlQuery(sql);
                //    count = int.Parse(dtData.Rows[0][0].ToString()) / 2;
                //    if (count > 0)
                //        desc += string.Format("有未检测内侧距数据车轴{0}个;", count);
                //    sql = string.Format("select count(*) from ProfileDetectResult where testdatetime='{0}' and ((level_lj is null) or (level_tmmh is null) or (level_lyhd is null) or (level_lwhd is null)) and axleNo <{1}", datetimestr, axleNum);
                //    dtData = PUBS.sqlQuery(sql);
                //    count = int.Parse(dtData.Rows[0][0].ToString());
                //    if (count > 0)
                //        desc += string.Format("有未检测数据车轮{0}个;", count);

                //    if (desc == "")
                //        desc = "未见异常。";

                //    rptPara8 = new ReportParameter("desc_wx", desc); DataTable dt = new DataTable();
                //    dt.Columns.Add("carNo", System.Type.GetType("System.String"));
                //    dt.Columns.Add("carInfo", System.Type.GetType("System.String"));
                //    dt.Columns.Add("axleNo", System.Type.GetType("System.String"));
                //    dt.Columns.Add("pos", System.Type.GetType("System.String"));
                //    dt.Columns.Add("lj", System.Type.GetType("System.String"));
                //    dt.Columns.Add("tmmh", System.Type.GetType("System.String"));
                //    dt.Columns.Add("lyhd", System.Type.GetType("System.String"));
                //    dt.Columns.Add("lwhd", System.Type.GetType("System.String"));
                //    dt.Columns.Add("ncj", System.Type.GetType("System.String"));
                //    dt.PrimaryKey = new[] { dt.Columns["carNo"], dt.Columns["axleNo"], dt.Columns["pos"] };
                //    //lj
                //    sql = string.Format("select testDateTime, axleNo, wheelNo, min(level_lj) level from ProfileDetectResult where testdatetime='{0}' and level_lj >0 and level_lj<=2  and axleNo <{1} GROUP BY testDateTime, axleNo, wheelNo order by level", datetimestr, axleNum);
                //    dtData = PUBS.sqlQuery(sql);
                //    foreach (DataRow dr in dtData.Rows)
                //    {
                //        int axleNo = int.Parse(dr["axleNo"].ToString());
                //        string carInfo = PUBS.GetCarInfo(datetimestr, axleNo);
                //        dt.Rows.Add((axleNo / 4 + 1).ToString(), carInfo, (axleNo % 4 + 1).ToString(), sPos[int.Parse(dr["wheelNo"].ToString())], sLevel_wx[int.Parse(dr["level"].ToString())], "", "", "", "");
                //    }
                //    //tmmh
                //    sql = string.Format("select testDateTime, axleNo, wheelNo, min(level_tmmh) level from ProfileDetectResult where testdatetime='{0}' and level_tmmh >0 and level_tmmh <=2 and axleNo <{1} GROUP BY testDateTime, axleNo, wheelNo order by level", datetimestr, axleNum);
                //    dtData = PUBS.sqlQuery(sql);
                //    foreach (DataRow dr in dtData.Rows)
                //    {
                //        int axleNo = int.Parse(dr["axleNo"].ToString());
                //        string pos = sPos[int.Parse(dr["wheelNo"].ToString())];
                //        string carInfo = PUBS.GetCarInfo(datetimestr, axleNo);
                //        string carNo = (axleNo / 4 + 1).ToString();
                //        string axleNoInCar = (axleNo % 4 + 1).ToString();
                //        string level = sLevel_wx[int.Parse(dr["level"].ToString())];
                //        object[] key = new object[3] { carNo, axleNoInCar, pos };
                //        DataRow drFind = dt.Rows.Find(key);
                //        if (drFind == null)
                //            dt.Rows.Add(carNo, carInfo, axleNoInCar, pos, "", level, "", "", "");
                //        else
                //            drFind["tmmh"] = level;
                //    }
                //    //lyhd
                //    sql = string.Format("select testDateTime, axleNo, wheelNo, min(level_lyhd) level from ProfileDetectResult where testdatetime='{0}' and level_lyhd >0 and level_lyhd <=2 and axleNo <{1} GROUP BY testDateTime, axleNo, wheelNo order by level", datetimestr, axleNum);
                //    dtData = PUBS.sqlQuery(sql);
                //    foreach (DataRow dr in dtData.Rows)
                //    {
                //        int axleNo = int.Parse(dr["axleNo"].ToString());
                //        string pos = sPos[int.Parse(dr["wheelNo"].ToString())];
                //        string carInfo = PUBS.GetCarInfo(datetimestr, axleNo);
                //        string carNo = (axleNo / 4 + 1).ToString();
                //        string axleNoInCar = (axleNo % 4 + 1).ToString();
                //        string level = sLevel_wx[int.Parse(dr["level"].ToString())];
                //        object[] key = new object[3] { carNo, axleNoInCar, pos };
                //        DataRow drFind = dt.Rows.Find(key);
                //        if (drFind == null)
                //            dt.Rows.Add(carNo, carInfo, axleNoInCar, pos, "", "", level, "", "");
                //        else
                //            drFind["lyhd"] = level;
                //    }
                //    //lwhd
                //    sql = string.Format("select testDateTime, axleNo, wheelNo, min(level_lwhd) level from ProfileDetectResult where testdatetime='{0}' and level_lwhd >0 and level_lwhd <=2 and axleNo <{1} GROUP BY testDateTime, axleNo, wheelNo order by level", datetimestr, axleNum);
                //    dtData = PUBS.sqlQuery(sql);
                //    foreach (DataRow dr in dtData.Rows)
                //    {
                //        int axleNo = int.Parse(dr["axleNo"].ToString());
                //        string pos = sPos[int.Parse(dr["wheelNo"].ToString())];
                //        string carInfo = PUBS.GetCarInfo(datetimestr, axleNo);
                //        string carNo = (axleNo / 4 + 1).ToString();
                //        string axleNoInCar = (axleNo % 4 + 1).ToString();
                //        string level = sLevel_wx[int.Parse(dr["level"].ToString())];
                //        object[] key = new object[3] { carNo, axleNoInCar, pos };
                //        DataRow drFind = dt.Rows.Find(key);
                //        if (drFind == null)
                //            dt.Rows.Add(carNo, carInfo, axleNoInCar, pos, "", "", "", level, "");
                //        else
                //            drFind["lwhd"] = level;
                //    }
                //    //ncj
                //    sql = string.Format("select testDateTime, axleNo, wheelNo, min(level_ncj) level from ProfileDetectResult where testdatetime='{0}' and level_ncj >0 and level_ncj <=2 and axleNo <{1} GROUP BY testDateTime, axleNo, wheelNo order by level", datetimestr, axleNum);
                //    dtData = PUBS.sqlQuery(sql);
                //    foreach (DataRow dr in dtData.Rows)
                //    {
                //        int axleNo = int.Parse(dr["axleNo"].ToString());
                //        string pos = sPos[int.Parse(dr["wheelNo"].ToString())];
                //        string carInfo = PUBS.GetCarInfo(datetimestr, axleNo);
                //        string carNo = (axleNo / 4 + 1).ToString();
                //        string axleNoInCar = (axleNo % 4 + 1).ToString();
                //        string level = sLevel_wx[int.Parse(dr["level"].ToString())];
                //        object[] key = new object[3] { carNo, axleNoInCar, pos };
                //        DataRow drFind = dt.Rows.Find(key);
                //        if (drFind == null)
                //            dt.Rows.Add(carNo, carInfo, axleNoInCar, pos, "", "", "", "", level);
                //        else
                //            drFind["ncj"] = level;
                //    }
                //    //
                //    ReportDataSource rds = new ReportDataSource("DataSet3", dt);
                //    ReportViewer1.LocalReport.DataSources.Add(rds);
                //}
                ReportViewer1.LocalReport.SetParameters(new ReportParameter[] { rptPara0, rptPara1, rptPara2, rptPara3, rptPara4, rptPara5, rptPara6, rptPara7, rptPara8, rptPara9, rptPara10, rptPara11});

                ReportViewer1.LocalReport.Refresh();
            }
        }
    }

    protected void LoginStatus2_LoggedOut(object sender, EventArgs e)
    {
        Session.Remove("login");
        PUBS.Log(Request.UserHostAddress, Membership.GetUser().UserName, 0, this.GetType().FullName);

    }
}
