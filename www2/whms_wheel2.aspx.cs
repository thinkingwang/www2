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

public partial class whms_wheel : System.Web.UI.Page
{
    private string xmlDataPath;
    public string datetimestr;
    public int axleNo;
    public int carNo;
    public int axleNoInCar;
    public int wheelNo;
    private DataTable dtData;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["login"] == null)
            Response.Redirect(PUBS.HomePage);
        var name = PUBS.GetUserDisplayName(Context.User.Identity.Name);
        LoginName2.FormatString = name;
        DataView dv;
        DataTable dt;
        dtData = new DataTable();
        dtData.Columns.Add("X", Type.GetType("System.Double"));
        dtData.Columns.Add("Y", Type.GetType("System.Double")); 
    
        datetimestr = Request.QueryString["datetimestr"];
        SqlDataSource1.SelectCommand = string.Format("select * from WhmsTime where tychoTime='{0}'", datetimestr);
        dv = (DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);
        dt = dv.Table;
        if (dt.Rows.Count == 0)
            Response.Redirect("nofile.html");
        DateTime dtTest = (DateTime)dt.Rows[0]["whmsTime"];
        xmlDataPath = string.Format("{0}\\{1}", Session["whmsXmlDataPath"], dtTest.ToString("yyyyMMdd_HHmmss")); //@"E:\tycho\P807\INSTALLER\doc";
        axleNo = int.Parse(Request.QueryString["axleNo"]);
        carNo = axleNo/4 + 1;
        axleNoInCar = axleNo%4 + 1;
        SqlDataSource_L.SelectCommand =
            string.Format("select * , case wheelNo when 0 then '左轮' else '右轮' end as wheelNo_s from ProfileDetectResult where testdatetime='{0}' and axleNo={1} and wheelNo=0",
                          datetimestr, axleNo);
        SqlDataSource_R.SelectCommand =
            string.Format("select * , case wheelNo when 0 then '左轮' else '右轮' end as wheelNo_s from ProfileDetectResult where testdatetime='{0}' and axleNo={1} and wheelNo=1",
                          datetimestr, axleNo);

        dv = (DataView)SqlDataSource_L.Select(DataSourceSelectArguments.Empty);
        dt = dv.Table;
        string xmlFileL = string.Format("{0}\\{1}", xmlDataPath, dt.Rows[0]["xmlFile"]);
        dv = (DataView)SqlDataSource_R.Select(DataSourceSelectArguments.Empty);
        dt = dv.Table;
        string xmlFileR = string.Format("{0}\\{1}", xmlDataPath, dt.Rows[0]["xmlFile"]);
        draw(Chart1, xmlFileL, false);
        draw(Chart2, xmlFileR, true);
        if (Request.QueryString["wheelNo"] != null)
        {
            wheelNo = int.Parse(Request.QueryString["wheelNo"]);
            if (wheelNo == 0)
                PanelR.Visible = false;
            else
                PanelL.Visible = false;
        }
    }
    private void draw(Chart theChart, string file, bool rotate)
    {
        int R = 1;
        if (rotate)
            R = -1;
        DataSet DS = new DataSet();
        DS.ReadXml(file);
        DataTable dt = DS.Tables["Prpt"];
        dtData.Clear();
        foreach (DataRow dr in dt.Rows)
            dtData.Rows.Add(double.Parse(dr["X"].ToString()), double.Parse(dr["Y"].ToString()));
        DataRow[] drs = dtData.Select("", "X");
        theChart.Series[0].Points.Clear();
        theChart.Series[1].Points.Clear();
        foreach (DataRow dr in drs)
        {
            theChart.Series[0].Points.AddXY(R * double.Parse(dr["X"].ToString()), double.Parse(dr["Y"].ToString()));
        }
        theChart.Series[1].Points.AddXY(R * double.Parse(DS.Tables["FT"].Rows[0]["X"].ToString()), double.Parse(DS.Tables["FT"].Rows[0]["Y"].ToString()));
        theChart.Series[1].Points.AddXY(R * double.Parse(DS.Tables["FB"].Rows[0]["X"].ToString()), double.Parse(DS.Tables["FB"].Rows[0]["Y"].ToString()));
        theChart.Series[1].Points.AddXY(R * double.Parse(DS.Tables["TD"].Rows[0]["X"].ToString()), double.Parse(DS.Tables["TD"].Rows[0]["Y"].ToString()));
        theChart.Series[1].Points.AddXY(R * double.Parse(DS.Tables["RE"].Rows[0]["X"].ToString()), double.Parse(DS.Tables["RE"].Rows[0]["Y"].ToString()));
        DS.Dispose();
    }
    protected void LoginStatus2_LoggedOut(object sender, EventArgs e)
    {
        Session.Remove("login");
        PUBS.Log(Request.UserHostAddress, Membership.GetUser().UserName, 0, this.GetType().FullName);

    }
}
