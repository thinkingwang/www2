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
    public int axleNo;
    public int carNo;
    public int axleNoInCar;
    public int wheelNo;
    private DataTable dtData;
    PrnWhmsWheel prn;

    protected void Page_Load(object sender, EventArgs e)
    {
        //DataView dv;
        //DataTable dt;
        //dtData = new DataTable();
        //dtData.Columns.Add("X", Type.GetType("System.Double"));
        //dtData.Columns.Add("Y", Type.GetType("System.Double")); 
    
        //datetimestr = Request.QueryString["datetimestr"];
        //axleNo = int.Parse(Request.QueryString["axleNo"]);
        //carNo = axleNo/4 + 1;
        //axleNoInCar = axleNo%4 + 1;
        //if (Request.QueryString["wheelNo"] != null)
        //{
        //    wheelNo = int.Parse(Request.QueryString["wheelNo"]);
        //}

        if (Session["login"] == null)
            Response.Redirect(PUBS.HomePage); 
        
        if (PUBS.GetUserLevel() > 1)
            Response.Redirect("invalid.html");

        var name = PUBS.GetUserDisplayName(Context.User.Identity.Name);
        LoginName2.FormatString = name;
        if (!IsPostBack)
        {
            if (Session["PrnWhmsWheel"] != null)
            {
                prn = (PrnWhmsWheel)Session["PrnWhmsWheel"];

                AddParameter("name", Session["SYS_NAME"].ToString());
                AddParameter("testDateTime", prn.testDateTime);
                AddParameter("trainInfo", prn.trainInfo);
                AddParameter("carInfo", prn.carInfo);
                AddParameter("pos", prn.pos);
                AddParameter("carIndex", prn.carIndex);
                AddParameter("axleIndex", prn.axleIndex);
                AddParameter("img", prn.image);
                AddParameter("department", Session["Unit"].ToString());
                AddParameter("Operator", Membership.GetUser().UserName);

                string sql = string.Format("select axleNum, s_level_ts, bzh from V_Detect_kc where testdatetime='{0}'", prn.testDateTime);
                DataTable dtData = PUBS.sqlQuery(sql);
                string sInfor = "";
                if (dtData.Rows.Count > 0)
                {
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

                AddParameter("Infor", sInfor);   
            
                DataTable dt = new DataTable();
                dt.Columns.Add("name", System.Type.GetType("System.String"));
                dt.Columns.Add("value", System.Type.GetType("System.String"));
                dt.Columns.Add("result", System.Type.GetType("System.String"));
                dt.Columns.Add("threshold", System.Type.GetType("System.String"));
                int updown;
                string desc;
                string trainType;
                int p =  prn.trainInfo.IndexOf('-');
                if (p > 0)
                    trainType = prn.trainInfo.Substring(0, p);
                else
                    trainType = "default";



                PUBS.GetProfileStatus(trainType, prn.powerType, "WX_LJ", prn.v_wheelSize, out updown, out desc);
                dt.Rows.Add("轮径",prn.v_wheelSize, PUBS.sLevel[prn.l_wheelSize], desc);

                PUBS.GetProfileStatus(trainType, prn.powerType, "WX_LJC_Z", prn.v_LJC_Z, out updown, out desc);
                dt.Rows.Add("同轴差", prn.v_LJC_Z, PUBS.sLevel[prn.l_LJC_Z], desc);
                PUBS.GetProfileStatus(trainType, prn.powerType, "WX_LJC_J", prn.v_LJC_J, out updown, out desc);
                dt.Rows.Add("同架差", prn.v_LJC_J, PUBS.sLevel[prn.l_LJC_J], desc);
                PUBS.GetProfileStatus(trainType, prn.powerType, "WX_LJC_C", prn.v_LJC_C, out updown, out desc);
                dt.Rows.Add("同车差", prn.v_LJC_C, PUBS.sLevel[prn.l_LJC_C], desc);
                PUBS.GetProfileStatus(trainType, prn.powerType, "WX_LJC_B", prn.v_LJC_B, out updown, out desc);
                dt.Rows.Add("同车组差", prn.v_LJC_B, PUBS.sLevel[prn.l_LJC_B], desc);

                PUBS.GetProfileStatus(trainType, prn.powerType, "WX_TMMH", prn.v_tmmh, out updown, out desc);
                dt.Rows.Add("踏面磨耗", prn.v_tmmh, PUBS.sLevel[prn.l_tmmh], desc);

                PUBS.GetProfileStatus(trainType, prn.powerType, "WX_LYHD", prn.v_lyhd, out updown, out desc);
                dt.Rows.Add("轮缘厚度", prn.v_lyhd, PUBS.sLevel[prn.l_lyhd], desc);

                PUBS.GetProfileStatus(trainType, prn.powerType, "WX_LYGD", prn.v_lygd, out updown, out desc);
                dt.Rows.Add("轮缘高度", prn.v_lygd, PUBS.sLevel[prn.l_lygd], desc);

                PUBS.GetProfileStatus(trainType, prn.powerType, "WX_LWHD", prn.v_lwhd, out updown, out desc);
                dt.Rows.Add("轮辋宽度", prn.v_lwhd, PUBS.sLevel[prn.l_lwhd], desc);

                PUBS.GetProfileStatus(trainType, prn.powerType, "WX_QR", prn.v_qr, out updown, out desc);
                dt.Rows.Add("QR值", prn.v_qr, PUBS.sLevel[prn.l_qr], desc);

                PUBS.GetProfileStatus(trainType, prn.powerType, "WX_NCJ", prn.v_ncj, out updown, out desc);
                dt.Rows.Add("内侧距", prn.v_ncj, PUBS.sLevel[prn.l_ncj], desc);

                ReportDataSource rds = new ReportDataSource("DataSet1", dt);
                ReportViewer1.LocalReport.DataSources.Clear();
                ReportViewer1.LocalReport.DataSources.Add(rds);
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
        string d = prn.testDateTime;
        //文件名不能有中文
        saveRptAs("Word", string.Format("{3}({0} {1} {2})", d.Replace(":", "").Replace("-", "").Replace("_", "").Replace(" ", "-"), prn.trainInfo, prn.pos.Replace("车", "").Replace("左", "L").Replace("右", "R"), PUBS.Txt("ProfileReport")));
    }
}
