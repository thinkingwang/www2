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

                ReportParameter rptPara0 = new ReportParameter("name", Application["SYS_NAME"].ToString());
                ReportParameter rptPara1 = new ReportParameter("testDateTime", datetimestr);
                trainInfo = PUBS.GetTrainInfo(datetimestr);
                ReportParameter rptPara2 = new ReportParameter("trainInfo", trainInfo);
                ReportParameter rptPara3 = new ReportParameter("department", Session["Unit"].ToString());
                ReportParameter rptPara5 = new ReportParameter("axleNum", sAxleNum);
                ReportParameter rptPara6 = new ReportParameter("carNum", sCarNum);
                ReportParameter rptPara4;
                ReportParameter rptPara7 = new ReportParameter("desc_cs", "");
                ReportParameter rptPara8 = new ReportParameter("desc_wx", "");
                ReportParameter rptPara9 = new ReportParameter("Operator", Membership.GetUser().UserName);



                ReportViewer1.LocalReport.DataSources.Clear();
                //探伤数据
                {
                    //sql = string.Format("select testDateTime, axleNo, wheelNo, min(level) level from bugresult where testdatetime='{0}' and level <=2 and isbug=1 GROUP BY testDateTime, axleNo, wheelNo order by axleNo, wheelNo, level ", datetimestr);
                    sql = string.Format("select axleNo, wheelNo,  sum(case level when 1 then 1 else 0 end) as level1, sum(case level when 2 then 1 else 0 end) as level2  from bugresult where testdatetime='{0}' and level <=2 and isbug=1 group by axleNo, wheelNo order by axleNo, wheelNo", datetimestr);
                    dtData = PUBS.sqlQuery(sql);
                    int count = dtData.Rows.Count;
                    if (count == 0)
                        desc = "未见二级以上缺陷报警";
                    else
                    {
                        sql = string.Format("select testDateTime, axleNo, wheelNo, level from bugresult where testdatetime='{0}' and level =1 and isbug=1 ", datetimestr);
                        DataTable dtData1 = PUBS.sqlQuery(sql);
                        int count1 = dtData1.Rows.Count;
                        sql = string.Format("select testDateTime, axleNo, wheelNo, level from bugresult where testdatetime='{0}' and level =2 and isbug=1 ", datetimestr);
                        DataTable dtData2 = PUBS.sqlQuery(sql);
                        int count2 = dtData2.Rows.Count;
                        desc = string.Format("发现有二级以上缺陷报警车轮{0}个。\r\n共有一级报警{1}处,二级报警{2}处,合计{3}处", count, count1, count2, count1+count2);

                    }

                    rptPara4 = new ReportParameter("desc_ts", desc);

                    DataTable dt = new DataTable();
                    dt.Columns.Add("carNo", System.Type.GetType("System.String"));
                    dt.Columns.Add("carInfo", System.Type.GetType("System.String"));
                    dt.Columns.Add("axleNo", System.Type.GetType("System.String"));
                    dt.Columns.Add("pos", System.Type.GetType("System.String"));
                    dt.Columns.Add("numOfLevel1", System.Type.GetType("System.Int32"));
                    dt.Columns.Add("numOfLevel2", System.Type.GetType("System.Int32"));


                    
                    foreach (DataRow dr in dtData.Rows)
                    {
                        int axleNo = int.Parse(dr["axleNo"].ToString());
                        string carInfo = PUBS.GetCarInfo(datetimestr, axleNo);

                        dt.Rows.Add((axleNo / 4 + 1).ToString(), carInfo, (axleNo % 4 + 1).ToString(), sPos[int.Parse(dr["wheelNo"].ToString())], int.Parse(dr["level1"].ToString()), int.Parse(dr["level2"].ToString()));
                    }

                    //if (dt.Rows.Count > 0)
                    //    dt = dt.Select("", "carNo, axleNo, pos desc").CopyToDataTable();
                    ReportDataSource rds = new ReportDataSource("DataSet1", dt);
                    ReportViewer1.LocalReport.DataSources.Add(rds);
                   
                }


                ReportViewer1.LocalReport.SetParameters(new ReportParameter[] { rptPara0, rptPara1, rptPara2, rptPara3, rptPara4, rptPara5, rptPara6, rptPara7, rptPara8, rptPara9 });
                ReportViewer1.LocalReport.DisplayName = string.Format("全编组故障报告({0} {1})", datetimestr.Replace(":", "").Replace("-", "").Replace("_", "").Replace(" ", "-"), trainInfo);

                ReportViewer1.LocalReport.Refresh();
            }
        }
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
