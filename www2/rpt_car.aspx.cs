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
    string[] sLevel = new string[3] { "", "一级报警", "二级报警" };
    //string[] sLevel_wx = new string[3] { "", "超限", "预警" };
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["login"] == null)
            Response.Redirect(PUBS.HomePage);

        if (PUBS.GetUserLevel() > 1)
            Response.Redirect("invalid.html");

        if (!IsPostBack)
        {
            datetimestr = Request.QueryString["field"];
            carNo = int.Parse(Request.QueryString["carNo"]);
            if (datetimestr != null)
            {
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
                string carInfo = PUBS.GetCarInfo(datetimestr, carNo * 4);

                ReportParameter rptPara0 = new ReportParameter("name", Application["SYS_NAME"].ToString());
                ReportParameter rptPara1 = new ReportParameter("testDateTime", datetimestr);
                trainInfo = PUBS.GetTrainInfo(datetimestr);
                ReportParameter rptPara2 = new ReportParameter("trainInfo", trainInfo);
                ReportParameter rptPara3 = new ReportParameter("department", Session["Unit"].ToString());
                ReportParameter rptPara4 = new ReportParameter("carNum", sCarNum);
                ReportParameter rptPara5 = new ReportParameter("axleNum", sAxleNum);
                ReportParameter rptPara6 = new ReportParameter("carNo", (carNo+1).ToString());
                ReportParameter rptPara7 = new ReportParameter("carInfo", carInfo);
                ReportParameter rptPara8 = new ReportParameter("Operator", Membership.GetUser().UserName);


                ReportViewer1.LocalReport.DataSources.Clear();

                DataTable dt = new DataTable();
                dt.Columns.Add("carNo", System.Type.GetType("System.Int32"));
                dt.Columns.Add("carInfo", System.Type.GetType("System.String"));
                dt.Columns.Add("axleNo", System.Type.GetType("System.Int32"));
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
                dt.PrimaryKey = new[] { dt.Columns["carNo"], dt.Columns["axleNo"] };
                for (int i = 0; i < 4; i++)
                {
                    dt.Rows.Add(carNo, carInfo, (i + 1), "√", "√", "√", "√", "√", "√");
                    if (axleNum == 1)//单轮对测试
                        break;
                }


                //探伤数据
                {
                    sql = string.Format("select testDateTime, axleNo, wheelNo, min(level) level from bugresult where testdatetime='{0}' and level <=2  and axleNo/4={1} and isbug=1 GROUP BY testDateTime, axleNo, wheelNo order by level ", datetimestr, carNo);
                    dtData = PUBS.sqlQuery(sql);
                    //int count = dtData.Rows.Count;
                    //if (count == 0)
                    //    desc = "未见二级以上缺陷报警";
                    //else
                    //    desc = string.Format("发现有二级以上缺陷报警车轮{0}个", count);

                    //rptPara4 = new ReportParameter("desc_ts", desc);

                    foreach (DataRow dr in dtData.Rows)
                    {
                        int axleNo = int.Parse(dr["axleNo"].ToString());
                        //int carNo = axleNo / 4 + 1;
                        int axleNoInCar = axleNo % 4 + 1;
                        object[] key = new object[2] { carNo, axleNoInCar };
                        DataRow drFind = dt.Rows.Find(key);
                        if (dr["wheelNo"].ToString() == "0")
                            drFind["L_ts"] = sLevel[int.Parse(dr["level"].ToString())];
                        else
                            drFind["R_ts"] = sLevel[int.Parse(dr["level"].ToString())];
                    }



                }
                //擦伤数据
                {
                    sql = string.Format("select testDateTime, axleNo, wheelNo, max(scratch_depth) deep, min(level) level from ScratchDetectResult where testdatetime='{0}' and level <=2  and axleNo/4={1} and isbug=1 GROUP BY testDateTime, axleNo, wheelNo order by level", datetimestr, carNo);
                    dtData = PUBS.sqlQuery(sql);
                    //int count = dtData.Rows.Count;
                    //if (count == 0)
                    //    desc = "未见二级以上擦伤报警";
                    //else
                    //    desc = string.Format("发现有二级以上擦伤报警车轮{0}个", count);

                    foreach (DataRow dr in dtData.Rows)
                    {
                        int axleNo = int.Parse(dr["axleNo"].ToString());
                        double deep = double.Parse(dr["deep"].ToString());
                        //int carNo = axleNo / 4 + 1;
                        int axleNoInCar = axleNo % 4 + 1;
                        object[] key = new object[2] { carNo, axleNoInCar };
                        DataRow drFind = dt.Rows.Find(key);
                        if (dr["wheelNo"].ToString() == "0")
                            drFind["L_cs"] = sLevel[int.Parse(dr["level"].ToString())];
                        else
                            drFind["R_cs"] = sLevel[int.Parse(dr["level"].ToString())];
                    }

                }
                //外形数据
                {
                    sql = string.Format("select * from ProfileDetectResult where testdatetime='{0}' and axleNo/4={1}", datetimestr, carNo);
                    dtData = PUBS.sqlQuery(sql);
                    foreach (DataRow dr in dtData.Rows)
                    {
                        int axleNo = int.Parse(dr["axleNo"].ToString());
                        //int carNo = axleNo / 4 + 1;
                        int axleNoInCar = axleNo % 4 + 1;
                        object[] key = new object[2] { carNo, axleNoInCar };
                        DataRow drFind = dt.Rows.Find(key);
                        if (dr["wheelNo"].ToString() == "0")
                        {
                            drFind["L_lj"] = GetWxDesc(dr["level_lj"].ToString(), dr["lj"].ToString());
                            drFind["L_tmmh"] = GetWxDesc(dr["level_tmmh"].ToString(), dr["tmmh"].ToString());
                            drFind["L_lyhd"] = GetWxDesc(dr["level_lyhd"].ToString(), dr["lyhd"].ToString());
                            drFind["L_lygd"] = GetWxDesc(dr["level_lygd"].ToString(), dr["lygd"].ToString());
                            drFind["L_lwhd"] = GetWxDesc(dr["level_lwhd"].ToString(), dr["lwhd"].ToString());
                            drFind["L_qr"] = GetWxDesc(dr["level_qr"].ToString(), dr["qr"].ToString());
                            drFind["ncj"] = GetWxDesc(dr["level_ncj"].ToString(), dr["ncj"].ToString());

                        }
                        else
                        {
                            drFind["R_lj"] = GetWxDesc(dr["level_lj"].ToString(), dr["lj"].ToString());
                            drFind["R_tmmh"] = GetWxDesc(dr["level_tmmh"].ToString(), dr["tmmh"].ToString());
                            drFind["R_lyhd"] = GetWxDesc(dr["level_lyhd"].ToString(), dr["lyhd"].ToString());
                            drFind["R_lygd"] = GetWxDesc(dr["level_lygd"].ToString(), dr["lygd"].ToString());
                            drFind["R_lwhd"] = GetWxDesc(dr["level_lwhd"].ToString(), dr["lwhd"].ToString());
                            drFind["R_qr"] = GetWxDesc(dr["level_qr"].ToString(), dr["qr"].ToString());
                            drFind["ncj"] = GetWxDesc(dr["level_ncj"].ToString(), dr["ncj"].ToString());

                        }
                    }
                }
                ReportDataSource rds = new ReportDataSource("DataSet1", dt);
                ReportViewer1.LocalReport.DataSources.Add(rds);
                ReportViewer1.LocalReport.SetParameters(new ReportParameter[] { rptPara0, rptPara1, rptPara2, rptPara3, rptPara4, rptPara5, rptPara6, rptPara7, rptPara8 });

                ReportViewer1.LocalReport.Refresh();
            }
        }
    }
    private string GetWxDesc(string level, string value)
    {
        string s;
        if (level == "")
            s = "-";
        else
        {
            int l = int.Parse(level);
            if ((l==0) || (l>2))
                s = value;
            else
                s = string.Format("{0}\r\n[{1}]", value , PUBS.sLevel[l]);
        }
        return s;
    }

    //private string GetValueDesc(string name, string value)
    //{
    //    string[] sLevel = new string[3] { "正常", "预警", "超限" };
    //    int updown, level;
    //    string desc;
    //    PUBS.GetProfileStatus(name, double.Parse(value), out updown, out level, out desc);
    //    if ((level > 0) && (level < sLevel.Length))
    //        return string.Format("{0} [{1}]",  value, sLevel[level]);
    //    else
    //        return value;
    //}
    protected void LoginStatus2_LoggedOut(object sender, EventArgs e)
    {
        Session.Remove("login");
        PUBS.Log(Request.UserHostAddress, Membership.GetUser().UserName, 0, this.GetType().FullName);

    }
}
