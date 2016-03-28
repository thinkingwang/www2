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
    int iDirection;
    int axleNum;
    public int axleNo;
    public int carNo;
    public int axleNoInCar;
    //public int wheelNo;
    private DataTable dtData;
    PrnWhmsWheel prn;
    string trainInfo;
    string[] sPos = new string[2] { "左", "右" };
    string[] sLevel = new string[3] { "", "一级报警", "二级报警" };
    //string[] sLevel_wx = new string[3] { "", "超限", "预警" };
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["login"] == null)
            Response.Redirect(PUBS.HomePage);

        if (PUBS.GetUserLevel() > 1)
            Response.Redirect("invalid.html");

        datetimestr = Request.QueryString["field"];
        trainInfo = PUBS.GetTrainInfo(datetimestr);

        sLevel[1] = PUBS.Txt("I") + " 级报警";
        sLevel[2] = PUBS.Txt("II") + " 级报警";

        if (!IsPostBack)
        {
            if (datetimestr != null)
            {
                string desc;
                string sAxleNum = "", sCarNum = "", sInfor = "";
                string sql = string.Format("select axleNum, engineDirection, s_level_ts, bzh from V_Detect_kc where testdatetime='{0}'", datetimestr);
                DataTable dtData = PUBS.sqlQuery(sql);
                if (dtData.Rows.Count > 0)
                {
                    axleNum = int.Parse(dtData.Rows[0][0].ToString());
                    sAxleNum = axleNum.ToString();
                    sCarNum = (axleNum / 4).ToString();
                    iDirection = Convert.ToInt32(dtData.Rows[0][1]);
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

                AddParameter("name", Application["SYS_NAME"].ToString());
                AddParameter("testDateTime", datetimestr);
                AddParameter("trainInfo", trainInfo);
                AddParameter("department", Session["Unit"].ToString());
                AddParameter("axleNum", sAxleNum);
                AddParameter("carNum", sCarNum);
                AddParameter("Operator", Membership.GetUser().UserName);
                AddParameter("Infor", sInfor);



                ReportViewer1.LocalReport.DataSources.Clear();
                //探伤数据
                {
                    sql = string.Format("select testDateTime, axleNo, wheelNo, min(level) level, dbo.carPos(axleNo/4, {3}/4, {2}) carPos, dbo.axlePos('{1}', axleNo, {2}) axlePos,  dbo.wheelPos('{1}',axleNo,wheelNo,{2}) wheelPos from bugresult where testdatetime='{0}' and level <=2 and isbug=1 GROUP BY testDateTime, axleNo, wheelNo order by axleNo, wheelNo, level ", datetimestr, trainInfo, iDirection, axleNum);
                    dtData = PUBS.sqlQuery(sql);
                    int count = dtData.Rows.Count;
                    if (count == 0)
                        desc = "未见"+ sLevel[2] +"以上缺陷报警";
                    else
                    {
                        sql = string.Format("select testDateTime, axleNo, wheelNo, level from bugresult where testdatetime='{0}' and level =1 and isbug=1 ", datetimestr);
                        DataTable dtData1 = PUBS.sqlQuery(sql);
                        int count1 = dtData1.Rows.Count;
                        sql = string.Format("select testDateTime, axleNo, wheelNo, level from bugresult where testdatetime='{0}' and level =2 and isbug=1 ", datetimestr);
                        DataTable dtData2 = PUBS.sqlQuery(sql);
                        int count2 = dtData2.Rows.Count;
                        desc = string.Format("发现有{3}以上缺陷报警车轮{0}个。共有{4}{1}处,{3}{2}处", count, count1, count2, sLevel[2], sLevel[1]);

                    }

                    AddParameter("desc_ts", desc);

                    DataTable dt = new DataTable();
                    dt.Columns.Add("carNo", System.Type.GetType("System.String"));
                    dt.Columns.Add("carInfo", System.Type.GetType("System.String"));
                    dt.Columns.Add("axleNo", System.Type.GetType("System.String"));
                    dt.Columns.Add("pos", System.Type.GetType("System.String"));
                    dt.Columns.Add("desc", System.Type.GetType("System.String"));
                    dt.Columns.Add("deep", System.Type.GetType("System.String"));



                    foreach (DataRow dr in dtData.Rows)
                    {
                        int axleNo = int.Parse(dr["axleNo"].ToString());
                        int wheelNo = int.Parse(dr["wheelNo"].ToString());
                        string carInfo = PUBS.GetCarInfo(datetimestr, axleNo);

                        int wheelPos = int.Parse(dr["wheelPos"].ToString());
                        int axlePos = int.Parse(dr["axlePos"].ToString());
                        string carNo = dr["carPos"].ToString();


                        dt.Rows.Add(carNo, carInfo, axlePos.ToString(), PUBS.LWXH[wheelPos], sLevel[int.Parse(dr["level"].ToString())], "");
                    }

                    //if (dt.Rows.Count > 0)
                    //    dt = dt.Select("", "carNo, axleNo, pos desc").CopyToDataTable();
                    ReportDataSource rds = new ReportDataSource("DataSet1", dt);
                    ReportViewer1.LocalReport.DataSources.Add(rds);
                }
                //擦伤数据
                {
                    sql = string.Format("select testDateTime, axleNo, wheelNo, max(scratch_depth) deep, min(level) level , dbo.carPos(axleNo/4, {3}/4, {2}) carPos, dbo.axlePos('{1}', axleNo, {2}) axlePos,  dbo.wheelPos('{1}',axleNo,wheelNo,{2}) wheelPos from ScratchDetectResult where testdatetime='{0}' and level <=2 and isbug=1 GROUP BY testDateTime, axleNo, wheelNo order by level", datetimestr, trainInfo, iDirection, axleNum);
                    dtData = PUBS.sqlQuery(sql);
                    int count = dtData.Rows.Count;
                    if (count == 0)
                        desc = "未见"+ sLevel[2] +"以上擦伤报警";
                    else
                        desc = string.Format("发现有{1}以上擦伤报警车轮{0}个", count, sLevel[2]);

                    AddParameter("desc_cs", desc);

                    DataTable dt = new DataTable();
                    dt.Columns.Add("carNo", System.Type.GetType("System.String"));
                    dt.Columns.Add("carInfo", System.Type.GetType("System.String"));
                    dt.Columns.Add("axleNo", System.Type.GetType("System.String"));
                    dt.Columns.Add("pos", System.Type.GetType("System.String"));
                    dt.Columns.Add("desc", System.Type.GetType("System.String"));
                    dt.Columns.Add("deep", System.Type.GetType("System.String"));
                    foreach (DataRow dr in dtData.Rows)
                    {
                        int axleNo = int.Parse(dr["axleNo"].ToString());
                        int wheelNo = int.Parse(dr["wheelNo"].ToString());
                        string carInfo = PUBS.GetCarInfo(datetimestr, axleNo);
                        double deep = double.Parse(dr["deep"].ToString());
                        int wheelPos = int.Parse(dr["wheelPos"].ToString());
                        int axlePos = int.Parse(dr["axlePos"].ToString());
                        string carNo = dr["carPos"].ToString();
                        dt.Rows.Add(carNo, carInfo, axlePos.ToString(), PUBS.LWXH[wheelPos], sLevel[int.Parse(dr["level"].ToString())], deep.ToString("F2"));
                    }

                    if (dt.Rows.Count > 0)
                        dt = dt.Select("", "carNo, axleNo, pos desc").CopyToDataTable();
                    ReportDataSource rds = new ReportDataSource("DataSet2", dt);
                    ReportViewer1.LocalReport.DataSources.Add(rds);
                }
                //外形数据
                {
                    desc = "";
                    sql = string.Format("select count(*) from ProfileDetectResult where testdatetime='{0}' and level_lj>0 and level_lj<=2 and axleNo <{1}", datetimestr, axleNum);
                    dtData = PUBS.sqlQuery(sql);
                    int count = int.Parse(dtData.Rows[0][0].ToString());
                    if (count > 0)
                        desc += string.Format("发现轮径预警或超限车轮{0}个;\r\n", count);


                    sql = string.Format("select count(*) from ProfileDetectResult where testdatetime='{0}' and Level_LjCha_Zhou>0 and Level_LjCha_Zhou<=2 and axleNo <{1}", datetimestr, axleNum);
                    dtData = PUBS.sqlQuery(sql);
                    count = int.Parse(dtData.Rows[0][0].ToString());
                    if (count > 0)
                        desc += string.Format("发现同轴轮径差预警或超限车轴{0}处;\r\n", count/2);

                    sql = string.Format("select count(*) from ProfileDetectResult where testdatetime='{0}' and Level_LjCha_ZXJ>0 and Level_LjCha_ZXJ<=2 and axleNo <{1}", datetimestr, axleNum);
                    dtData = PUBS.sqlQuery(sql);
                    count = int.Parse(dtData.Rows[0][0].ToString());
                    if (count > 0)
                        desc += string.Format("发现同转向架轮径差预警或超限{0}处;\r\n", count / 4);

                    sql = string.Format("select count(*) from ProfileDetectResult where testdatetime='{0}' and Level_LjCha_Che>0 and Level_LjCha_Che<=2 and axleNo <{1}", datetimestr, axleNum);
                    dtData = PUBS.sqlQuery(sql);
                    count = int.Parse(dtData.Rows[0][0].ToString());
                    if (count > 0)
                        desc += string.Format("发现同车厢轮径差预警或超限{0}处;\r\n", count / 8);

                    sql = string.Format("select count(*) from ProfileDetectResult where testdatetime='{0}' and Level_LjCha_Bz>0 and Level_LjCha_Bz<=2 and axleNo <{1}", datetimestr, axleNum);
                    dtData = PUBS.sqlQuery(sql);
                    count = int.Parse(dtData.Rows[0][0].ToString());
                    if (count > 0)
                        desc += string.Format("发现同一车辆单元轮径差预警或超限;\r\n");

                    sql = string.Format("select count(*) from ProfileDetectResult where testdatetime='{0}' and level_tmmh>0 and level_tmmh<=2 and axleNo <{1}", datetimestr, axleNum);
                    dtData = PUBS.sqlQuery(sql);
                    count = int.Parse(dtData.Rows[0][0].ToString());
                    if (count > 0)
                        desc += string.Format("发现踏面磨耗预警或超限车轮{0}个;\r\n", count);
                    sql = string.Format("select count(*) from ProfileDetectResult where testdatetime='{0}' and level_lyhd>0 and level_lyhd<=2 and axleNo <{1}", datetimestr, axleNum);
                    dtData = PUBS.sqlQuery(sql);
                    count = int.Parse(dtData.Rows[0][0].ToString());
                    if (count > 0)
                        desc += string.Format("发现轮缘厚度预警或超限车轮{0}个;\r\n", count);
                    sql = string.Format("select count(*) from ProfileDetectResult where testdatetime='{0}' and level_lygd>0 and level_lygd<=2 and axleNo <{1}", datetimestr, axleNum);
                    dtData = PUBS.sqlQuery(sql);
                    count = int.Parse(dtData.Rows[0][0].ToString());
                    if (count > 0)
                        desc += string.Format("发现轮缘高度预警或超限车轮{0}个;\r\n", count);
                    sql = string.Format("select count(*) from ProfileDetectResult where testdatetime='{0}' and level_lwhd>0 and level_lwhd<=2 and axleNo <{1}", datetimestr, axleNum);
                    dtData = PUBS.sqlQuery(sql);
                    count = int.Parse(dtData.Rows[0][0].ToString());
                    if (count > 0)
                        desc += string.Format("发现轮辋宽度预警或超限车轮{0}个;\r\n", count);
                    sql = string.Format("select count(*) from ProfileDetectResult where testdatetime='{0}' and level_qr>0 and level_qr<=2 and axleNo <{1}", datetimestr, axleNum);
                    dtData = PUBS.sqlQuery(sql);
                    count = int.Parse(dtData.Rows[0][0].ToString());
                    if (count > 0)
                        desc += string.Format("发现QR值预警或超限车轮{0}个;\r\n", count);
                    sql = string.Format("select count(*) from ProfileDetectResult where testdatetime='{0}' and level_ncj>0 and level_ncj<=2 and axleNo <{1}", datetimestr, axleNum);
                    dtData = PUBS.sqlQuery(sql);
                    count = int.Parse(dtData.Rows[0][0].ToString())/2;
                    if (count > 0)
                        desc += string.Format("发现内侧距预警或超限车轴{0}个;\r\n", count);
                    sql = string.Format("select count(*) from ProfileDetectResult where testdatetime='{0}' and (level_ncj is null) and axleNo <{1}", datetimestr, axleNum);
                    dtData = PUBS.sqlQuery(sql);
                    count = int.Parse(dtData.Rows[0][0].ToString()) / 2;
                    if (count > 0)
                        desc += string.Format("有未检测内侧距数据车轴{0}个;\r\n", count);
                    sql = string.Format("select count(*) from ProfileDetectResult where testdatetime='{0}' and ((level_lj is null) or (level_tmmh is null) or (level_lyhd is null) or (level_lwhd is null) or (level_qr is null) or (level_lygd is null)) and axleNo <{1}", datetimestr, axleNum);
                    dtData = PUBS.sqlQuery(sql);
                    count = int.Parse(dtData.Rows[0][0].ToString());
                    if (count > 0)
                        desc += string.Format("有未检测数据车轮{0}个;\r\n", count);

                    if (desc == "")
                        desc = "未见异常。";

                    AddParameter("desc_wx", desc); 

                    DataTable dt = new DataTable();
                    dt.Columns.Add("carNo", System.Type.GetType("System.String"));
                    dt.Columns.Add("carInfo", System.Type.GetType("System.String"));
                    dt.Columns.Add("axleNo", System.Type.GetType("System.String"));
                    dt.Columns.Add("pos", System.Type.GetType("System.String"));
                    dt.Columns.Add("lj", System.Type.GetType("System.String"));
                    dt.Columns.Add("tmmh", System.Type.GetType("System.String"));
                    dt.Columns.Add("lyhd", System.Type.GetType("System.String"));
                    dt.Columns.Add("lwhd", System.Type.GetType("System.String"));
                    dt.Columns.Add("ncj", System.Type.GetType("System.String"));
                    dt.Columns.Add("lygd", System.Type.GetType("System.String"));
                    dt.Columns.Add("qr", System.Type.GetType("System.String"));
                    dt.PrimaryKey = new[] { dt.Columns["carNo"], dt.Columns["axleNo"], dt.Columns["pos"] };
                    //lj
                    sql = string.Format("select testDateTime, axleNo, wheelNo, min(level_lj) level , dbo.carPos(axleNo/4, {1}/4, {3}) carPos, dbo.axlePos('{2}', axleNo, {3}) axlePos,  dbo.wheelPos('{2}',axleNo,wheelNo,{3}) wheelPos from ProfileDetectResult where testdatetime='{0}' and level_lj >0 and level_lj<=2  and axleNo <{1} GROUP BY testDateTime, axleNo, wheelNo order by level", datetimestr, axleNum, trainInfo, iDirection);
                    dtData = PUBS.sqlQuery(sql);
                    foreach (DataRow dr in dtData.Rows)
                    {
                        int axleNo = int.Parse(dr["axleNo"].ToString());
                        string carInfo = PUBS.GetCarInfo(datetimestr, axleNo);
                        int wheelPos = int.Parse(dr["wheelPos"].ToString());
                        int axlePos = int.Parse(dr["axlePos"].ToString());
                        string carNo = dr["carPos"].ToString();
                        dt.Rows.Add(carNo, carInfo, axlePos.ToString(), PUBS.LWXH[wheelPos], PUBS.sLevel[int.Parse(dr["level"].ToString())], "", "", "", "");
                    }
                    //tmmh
                    sql = string.Format("select testDateTime, axleNo, wheelNo, min(level_tmmh) level,dbo.carPos(axleNo/4, {1}/4, {3}) carPos,  dbo.axlePos('{2}', axleNo, {3}) axlePos,  dbo.wheelPos('{2}',axleNo,wheelNo,{3}) wheelPos  from ProfileDetectResult where testdatetime='{0}' and level_tmmh >0 and level_tmmh <=2 and axleNo <{1} GROUP BY testDateTime, axleNo, wheelNo order by level", datetimestr, axleNum, trainInfo, iDirection);
                    dtData = PUBS.sqlQuery(sql);
                    foreach (DataRow dr in dtData.Rows)
                    {
                        int axleNo = int.Parse(dr["axleNo"].ToString());
                        string pos = sPos[int.Parse(dr["wheelNo"].ToString())];
                        string carInfo = PUBS.GetCarInfo(datetimestr, axleNo);
                        string carNo = dr["carPos"].ToString();
                        string level = PUBS.sLevel[int.Parse(dr["level"].ToString())];
                        object[] key = new object[3]{carNo, axleNoInCar, pos};
                        int wheelPos = int.Parse(dr["wheelPos"].ToString());
                        int axlePos = int.Parse(dr["axlePos"].ToString());
                        DataRow drFind = dt.Rows.Find(key);
                        if (drFind == null)
                            dt.Rows.Add(carNo, carInfo, axlePos.ToString(), PUBS.LWXH[wheelPos], "", level, "", "", "");
                        else
                            drFind["tmmh"] = level;
                    }
                    //lyhd
                    sql = string.Format("select testDateTime, axleNo, wheelNo, min(level_lyhd) level,dbo.carPos(axleNo/4, {1}/4, {3}) carPos,  dbo.axlePos('{2}', axleNo, {3}) axlePos,  dbo.wheelPos('{2}',axleNo,wheelNo,{3}) wheelPos  from ProfileDetectResult where testdatetime='{0}' and level_lyhd >0 and level_lyhd <=2 and axleNo <{1} GROUP BY testDateTime, axleNo, wheelNo order by level", datetimestr, axleNum, trainInfo, iDirection);
                    dtData = PUBS.sqlQuery(sql);
                    foreach (DataRow dr in dtData.Rows)
                    {
                        int axleNo = int.Parse(dr["axleNo"].ToString());
                        string pos = sPos[int.Parse(dr["wheelNo"].ToString())];
                        string carInfo = PUBS.GetCarInfo(datetimestr, axleNo);
                        string carNo = dr["carPos"].ToString();
                        string level = PUBS.sLevel[int.Parse(dr["level"].ToString())];
                        object[] key = new object[3] { carNo, axleNoInCar, pos };
                        int wheelPos = int.Parse(dr["wheelPos"].ToString());
                        int axlePos = int.Parse(dr["axlePos"].ToString());
                        DataRow drFind = dt.Rows.Find(key);
                        if (drFind == null)
                            dt.Rows.Add(carNo, carInfo, axlePos.ToString(), PUBS.LWXH[wheelPos], "", "", level, "", "");
                        else
                            drFind["lyhd"] = level;
                    }
                    //lygd
                    sql = string.Format("select testDateTime, axleNo, wheelNo, min(level_lygd) level, dbo.carPos(axleNo/4, {1}/4, {3}) carPos, dbo.axlePos('{2}', axleNo, {3}) axlePos,  dbo.wheelPos('{2}',axleNo,wheelNo,{3}) wheelPos  from ProfileDetectResult where testdatetime='{0}' and level_lygd >0 and level_lygd <=2 and axleNo <{1} GROUP BY testDateTime, axleNo, wheelNo order by level", datetimestr, axleNum, trainInfo, iDirection);
                    dtData = PUBS.sqlQuery(sql);
                    foreach (DataRow dr in dtData.Rows)
                    {
                        int axleNo = int.Parse(dr["axleNo"].ToString());
                        string pos = sPos[int.Parse(dr["wheelNo"].ToString())];
                        string carInfo = PUBS.GetCarInfo(datetimestr, axleNo);
                        string carNo = dr["carPos"].ToString();
                        string level = PUBS.sLevel[int.Parse(dr["level"].ToString())];
                        object[] key = new object[3] { carNo, axleNoInCar, pos };
                        int wheelPos = int.Parse(dr["wheelPos"].ToString());
                        int axlePos = int.Parse(dr["axlePos"].ToString());
                        DataRow drFind = dt.Rows.Find(key);
                        if (drFind == null)
                            dt.Rows.Add(carNo, carInfo, axlePos.ToString(), PUBS.LWXH[wheelPos], "", "", level, "", "");
                        else
                            drFind["lygd"] = level;
                    }
                    //lwhd
                    sql = string.Format("select testDateTime, axleNo, wheelNo, min(level_lwhd) level, dbo.carPos(axleNo/4, {1}/4, {3}) carPos, dbo.axlePos('{2}', axleNo, {3}) axlePos,  dbo.wheelPos('{2}',axleNo,wheelNo,{3}) wheelPos  from ProfileDetectResult where testdatetime='{0}' and level_lwhd >0 and level_lwhd <=2 and axleNo <{1} GROUP BY testDateTime, axleNo, wheelNo order by level", datetimestr, axleNum, trainInfo, iDirection);
                    dtData = PUBS.sqlQuery(sql);
                    foreach (DataRow dr in dtData.Rows)
                    {
                        int axleNo = int.Parse(dr["axleNo"].ToString());
                        string pos = sPos[int.Parse(dr["wheelNo"].ToString())];
                        string carInfo = PUBS.GetCarInfo(datetimestr, axleNo);
                        string carNo = dr["carPos"].ToString();
                        string level = PUBS.sLevel[int.Parse(dr["level"].ToString())];
                        object[] key = new object[3] { carNo, axleNoInCar, pos };
                        int wheelPos = int.Parse(dr["wheelPos"].ToString());
                        int axlePos = int.Parse(dr["axlePos"].ToString());
                        DataRow drFind = dt.Rows.Find(key);
                        if (drFind == null)
                            dt.Rows.Add(carNo, carInfo, axlePos.ToString(), PUBS.LWXH[wheelPos], "", "", "", level, "");
                        else
                            drFind["lwhd"] = level;
                    }
                    //qr
                    sql = string.Format("select testDateTime, axleNo, wheelNo, min(level_qr) level, dbo.carPos(axleNo/4, {1}/4, {3}) carPos, dbo.axlePos('{2}', axleNo, {3}) axlePos,  dbo.wheelPos('{2}',axleNo,wheelNo,{3}) wheelPos  from ProfileDetectResult where testdatetime='{0}' and level_qr >0 and level_qr <=2 and axleNo <{1} GROUP BY testDateTime, axleNo, wheelNo order by level", datetimestr, axleNum, trainInfo, iDirection);
                    dtData = PUBS.sqlQuery(sql);
                    foreach (DataRow dr in dtData.Rows)
                    {
                        int axleNo = int.Parse(dr["axleNo"].ToString());
                        string pos = sPos[int.Parse(dr["wheelNo"].ToString())];
                        string carInfo = PUBS.GetCarInfo(datetimestr, axleNo);
                        string carNo = dr["carPos"].ToString();
                        string level = PUBS.sLevel[int.Parse(dr["level"].ToString())];
                        object[] key = new object[3] { carNo, axleNoInCar, pos };
                        int wheelPos = int.Parse(dr["wheelPos"].ToString());
                        int axlePos = int.Parse(dr["axlePos"].ToString());
                        DataRow drFind = dt.Rows.Find(key);
                        if (drFind == null)
                            dt.Rows.Add(carNo, carInfo, axlePos.ToString(), PUBS.LWXH[wheelPos], "", "", level, "", "");
                        else
                            drFind["qr"] = level;
                    }
                    //ncj
                    sql = string.Format("select testDateTime, axleNo, wheelNo, min(level_ncj) level, dbo.carPos(axleNo/4, {1}/4, {3}) carPos, dbo.axlePos('{2}', axleNo, {3}) axlePos,  dbo.wheelPos('{2}',axleNo,wheelNo,{3}) wheelPos  from ProfileDetectResult where testdatetime='{0}' and level_ncj >0 and level_ncj <=2 and axleNo <{1} GROUP BY testDateTime, axleNo, wheelNo order by level", datetimestr, axleNum, trainInfo, iDirection);
                    dtData = PUBS.sqlQuery(sql);
                    foreach (DataRow dr in dtData.Rows)
                    {
                        int axleNo = int.Parse(dr["axleNo"].ToString());
                        string pos = sPos[int.Parse(dr["wheelNo"].ToString())];
                        string carInfo = PUBS.GetCarInfo(datetimestr, axleNo);
                        string carNo = dr["carPos"].ToString();
                        string level = PUBS.sLevel[int.Parse(dr["level"].ToString())];
                        object[] key = new object[3] { carNo, axleNoInCar, pos };
                        int wheelPos = int.Parse(dr["wheelPos"].ToString());
                        int axlePos = int.Parse(dr["axlePos"].ToString());
                        DataRow drFind = dt.Rows.Find(key);
                        if (drFind == null)
                            dt.Rows.Add(carNo, carInfo, axlePos.ToString(), PUBS.LWXH[wheelPos], "", "", "", "", level);
                        else
                            drFind["ncj"] = level;
                    }
                    //
                    if (dt.Rows.Count > 0)
                        dt = dt.Select("", "carNo, axleNo, pos desc").CopyToDataTable();
                    ReportDataSource rds = new ReportDataSource("DataSet3", dt);
                    ReportViewer1.LocalReport.DataSources.Add(rds);
                }

                ReportViewer1.LocalReport.DisplayName = string.Format("全编组故障报告({0} {1})", datetimestr.Replace(":", "").Replace("-", "").Replace("_", "").Replace(" ", "-"), trainInfo);

                ReportViewer1.LocalReport.Refresh();
            }
        }
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
        saveRptAs("Word", string.Format("{2}({0} {1})", datetimestr.Replace(":", "").Replace("-", "").Replace("_", "").Replace(" ", "-"), trainInfo, PUBS.Txt("BriefReport")));
    }
}
