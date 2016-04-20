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
using System.IO;

public partial class whms_wheel : System.Web.UI.Page
{
    private string xmlDataPath;
    public string datetimestr;
    public int axleNo; 
    public int axleNum;
    public int carNo;
    public int axleNoInCar;
    public int wheelNo;
    public string carInfo;
    private DataTable dtData;
    DataTable dt0,dt1;
    public int  wheelPos_L, wheelPos_R;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["login"] == null)
            Response.Redirect(PUBS.HomePage);


        var name = PUBS.GetUserDisplayName(Context.User.Identity.Name);
        LoginName2.FormatString = name;
        DataView dv;
        
        dtData = new DataTable();
        dtData.Columns.Add("X", Type.GetType("System.Double"));
        dtData.Columns.Add("Y", Type.GetType("System.Double")); 
    
        datetimestr = Request.QueryString["datetimestr"];
        SqlDataSource1.SelectCommand = string.Format("select * from WhmsTime where tychoTime='{0}'", datetimestr);
        dv = (DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);
        dt0 = dv.Table;
        if (dt0.Rows.Count == 0)
            Response.Redirect("nofile.html");
        DateTime dtTest = (DateTime)dt0.Rows[0]["whmsTime"];
        xmlDataPath = string.Format("{0}\\{1}", Session["whmsXmlDataPath"], dtTest.ToString("yyyyMMdd_HHmmss")); //@"E:\tycho\P807\INSTALLER\doc";
        axleNo = int.Parse(Request.QueryString["axleNo"]);
        carNo = axleNo/4 + 1;
        axleNoInCar = axleNo%4 + 1;
        carInfo = PUBS.GetCarInfo(datetimestr, axleNo);

        DataTable t = PUBS.sqlQuery(string.Format("select engNum, enginedirection, axleNum from detect where testDateTime='{0}'", datetimestr));
        bool dirv=Convert.ToBoolean(t.Rows[0]["enginedirection"].ToString());
        axleNum = int.Parse(t.Rows[0]["axleNum"].ToString());
        string sCzh = t.Rows[0]["engNum"].ToString();
        int dir=1;
        if (!dirv)
            dir = 2;
        string sqlstr = "select CONVERT(varchar(20), testDateTime, 120) testDateTime , axleNo, wheelNo, dbo.GetPowerTypeByAxleNo(testDateTime, axleNo) powerType, xmlFile, dbo.carPos(axleNo/4, {3}, {2}) as carPos, dbo.axlePos('{5}',axleNo,{2}) as axlePos, dbo.wheelPos('{5}', axleNo, wheelNo, {2}) as wheelPos, axleNo+1 AS axleNo1," +
        "case Lj  when '-1000' then '-' else cast(Lj AS varchar(20)) end  AS str_Lj, " +
        "case TmMh  when '-1000' then '-' else cast(TmMh AS varchar(20)) end AS str_Tmmh, " +
        "case LyHd  when '-1000' then '-' else cast(LyHd AS varchar(20)) end AS str_Lyhd, " +
        "case LyGd  when '-1000' then '-' else cast(LyGd AS varchar(20)) end AS str_Lygd, " +
        "case LwHd  when '-1000' then '-' else cast(LwHd AS varchar(20)) end AS str_Lwhd, " +
        "case QR  when '-1000' then '-' else cast(QR AS varchar(20)) end  AS str_Qr, " +
        "case Ncj  when '-1000' then '-' else cast(Ncj AS varchar(20)) end AS str_Ncj," +
        "case wheelNo when 0 then '左轮' else '右轮' end as wheelNo_s, " +
        "case LjCha_Zhou when null then '-' when -1000 then '-' else str(LjCha_Zhou,6,1) end LjCha_Zhou, " +
        "case LjCha_ZXJ when null then '-' when -1000 then '-' else str(LjCha_ZXJ,6,1) end LjCha_ZXJ, " +
        "case LjCha_Che when null then '-' when -1000 then '-' else str(LjCha_Che,6,1) end LjCha_Che, " +
        "case LjCha_Bz when null then '-' when -1000 then '-' else str(LjCha_Bz,6,1) end LjCha_Bz, " +
        "isnull(Level_lj, 4) Level_lj,isnull(Level_LjCha_Bz, 4) Level_LjCha_Bz,isnull(Level_LjCha_Che, 4) Level_LjCha_Che,isnull(Level_LjCha_Zhou, 4) Level_LjCha_Zhou,isnull(Level_LjCha_ZXJ, 4) Level_LjCha_ZXJ,isnull(Level_lwhd, 4) Level_lwhd,isnull(Level_lygd, 4) Level_lygd,isnull(Level_lyhd, 4) Level_lyhd,isnull(Level_ncj, 4) Level_ncj,isnull(Level_qr, 4) Level_qr,isnull(Level_tmmh, 4) Level_tmmh "+
        "from ProfileDetectResult where testdatetime='{0}' and axleNo={1} and wheelNo={4}";

        SqlDataSource_L.SelectCommand =
            string.Format(sqlstr, datetimestr, axleNo, dir, axleNum/4, 0, sCzh);
        SqlDataSource_R.SelectCommand =
            string.Format(sqlstr, datetimestr, axleNo, dir, axleNum/4, 1, sCzh);

        dv = (DataView)SqlDataSource_L.Select(DataSourceSelectArguments.Empty);
        dt0 = dv.Table;
        string xmlFileL = string.Format("{0}\\{1}", xmlDataPath, dt0.Rows[0]["xmlFile"]);
        dv = (DataView)SqlDataSource_R.Select(DataSourceSelectArguments.Empty);
        dt1 = dv.Table;
        string xmlFileR = string.Format("{0}\\{1}", xmlDataPath, dt1.Rows[0]["xmlFile"]);
        try
        {
            draw(Chart1, xmlFileL, false);
            draw(Chart2, xmlFileR, true);
        }
        catch
        { }
        if (Request.QueryString["wheelNo"] != null)
        {
            wheelNo = int.Parse(Request.QueryString["wheelNo"]);
            if (wheelNo == 0)
                PanelR.Visible = false;
            else
                PanelL.Visible = false;
        }

        wheelPos_L = int.Parse(dt0.Rows[0]["wheelPos"].ToString());
        wheelPos_R = int.Parse(dt1.Rows[0]["wheelPos"].ToString());
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
        if (dt != null)
        {
            foreach (DataRow dr in dt.Rows)
                dtData.Rows.Add(double.Parse(dr["X"].ToString()), double.Parse(dr["Y"].ToString()));
        }
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
    protected void bt_prn_Click(object sender, EventArgs e)
    {
        PrnWhmsWheel prn = new PrnWhmsWheel();
        prn.testDateTime = datetimestr;
        prn.trainInfo = PUBS.GetTrainInfo(datetimestr);
        prn.carInfo = carInfo;

        MemoryStream ms = new MemoryStream();
        byte[] byteImage;
        if (wheelNo == 0)
        {
            prn.powerType = int.Parse(dt0.Rows[0]["powerType"].ToString());
            prn.pos = PUBS.LWXH[int.Parse(dt0.Rows[0]["wheelPos"].ToString())];
            prn.carIndex = dt0.Rows[0]["carPos"].ToString();
            prn.axleIndex = dt0.Rows[0]["axlePos"].ToString(); 
            prn.v_wheelSize = dt0.Rows[0]["str_lj"].ToString();
            prn.v_LJC_Z = dt0.Rows[0]["LjCha_Zhou"].ToString();
            prn.v_LJC_J = dt0.Rows[0]["LjCha_ZXJ"].ToString();
            prn.v_LJC_C = dt0.Rows[0]["LjCha_Che"].ToString();
            prn.v_LJC_B = dt0.Rows[0]["LjCha_Bz"].ToString();
            prn.v_lwhd = dt0.Rows[0]["str_lwhd"].ToString();
            prn.v_lyhd = dt0.Rows[0]["str_lyhd"].ToString();
            prn.v_lygd = dt0.Rows[0]["str_lygd"].ToString();
            prn.v_tmmh = dt0.Rows[0]["str_tmmh"].ToString();
            prn.v_qr = dt0.Rows[0]["str_qr"].ToString();
            prn.v_ncj = dt0.Rows[0]["str_ncj"].ToString();
            Chart1.SaveImage(ms, ChartImageFormat.Jpeg);
            prn.l_wheelSize = int.Parse(dt0.Rows[0]["Level_lj"].ToString());
            prn.l_LJC_Z = int.Parse(dt0.Rows[0]["Level_LjCha_Zhou"].ToString());
            prn.l_LJC_J = int.Parse(dt0.Rows[0]["Level_LjCha_ZXJ"].ToString());
            prn.l_LJC_C = int.Parse(dt0.Rows[0]["Level_LjCha_Che"].ToString());
            prn.l_LJC_B = int.Parse(dt0.Rows[0]["Level_LjCha_Bz"].ToString());
            prn.l_tmmh = int.Parse(dt0.Rows[0]["Level_tmmh"].ToString());
            prn.l_lygd = int.Parse(dt0.Rows[0]["Level_lygd"].ToString());
            prn.l_lyhd = int.Parse(dt0.Rows[0]["Level_lyhd"].ToString());
            prn.l_lwhd = int.Parse(dt0.Rows[0]["Level_lwhd"].ToString());
            prn.l_qr = int.Parse(dt0.Rows[0]["Level_qr"].ToString());
            prn.l_ncj = int.Parse(dt0.Rows[0]["Level_ncj"].ToString());

       }
        else
        {
            prn.powerType = int.Parse(dt1.Rows[0]["powerType"].ToString());
            prn.pos = PUBS.LWXH[int.Parse(dt1.Rows[0]["wheelPos"].ToString())];
            prn.carIndex = dt1.Rows[0]["carPos"].ToString();
            prn.axleIndex = dt1.Rows[0]["axlePos"].ToString();
            prn.v_wheelSize = dt1.Rows[0]["str_lj"].ToString();
            prn.v_LJC_Z = dt1.Rows[0]["LjCha_Zhou"].ToString();
            prn.v_LJC_J = dt1.Rows[0]["LjCha_ZXJ"].ToString();
            prn.v_LJC_C = dt1.Rows[0]["LjCha_Che"].ToString();
            prn.v_LJC_B = dt1.Rows[0]["LjCha_Bz"].ToString();
            prn.v_lwhd = dt1.Rows[0]["str_lwhd"].ToString();
            prn.v_lyhd = dt1.Rows[0]["str_lyhd"].ToString();
            prn.v_lygd = dt1.Rows[0]["str_lygd"].ToString();
            prn.v_tmmh = dt1.Rows[0]["str_tmmh"].ToString();
            prn.v_qr = dt1.Rows[0]["str_qr"].ToString();
            prn.v_ncj = dt1.Rows[0]["str_ncj"].ToString();
            Chart2.SaveImage(ms, ChartImageFormat.Jpeg);
            prn.l_wheelSize = int.Parse(dt1.Rows[0]["Level_lj"].ToString());
            prn.l_LJC_Z = int.Parse(dt1.Rows[0]["Level_LjCha_Zhou"].ToString());
            prn.l_LJC_J = int.Parse(dt1.Rows[0]["Level_LjCha_ZXJ"].ToString());
            prn.l_LJC_C = int.Parse(dt1.Rows[0]["Level_LjCha_Che"].ToString());
            prn.l_LJC_B = int.Parse(dt1.Rows[0]["Level_LjCha_Bz"].ToString());
            prn.l_tmmh = int.Parse(dt1.Rows[0]["Level_tmmh"].ToString());
            prn.l_lygd = int.Parse(dt1.Rows[0]["Level_lygd"].ToString());
            prn.l_lyhd = int.Parse(dt1.Rows[0]["Level_lyhd"].ToString());
            prn.l_lwhd = int.Parse(dt1.Rows[0]["Level_lwhd"].ToString());
            prn.l_qr = int.Parse(dt1.Rows[0]["Level_qr"].ToString());
            prn.l_ncj = int.Parse(dt1.Rows[0]["Level_ncj"].ToString());
        }

        byteImage = new Byte[ms.Length];
        byteImage = ms.ToArray();
        prn.image = Convert.ToBase64String(byteImage);

        Session.Add("PrnWhmsWheel", prn);
        Response.Redirect("whms_wheel_prn.aspx");
    }
    protected void bt_prn_car_Click(object sender, EventArgs e)
    {
        PrnWhmsWheel prn = new PrnWhmsWheel();
        prn.testDateTime = datetimestr;
        prn.trainInfo = PUBS.GetTrainInfo(datetimestr);
        prn.carInfo = carInfo;
        prn.carIndex = carNo.ToString();
        prn.axleIndex = axleNoInCar.ToString();
        Session.Add("PrnWhmsWheel", prn);
        Response.Redirect("whms_car_prn.aspx");
    }
    protected void bt_prn_R_Click(object sender, EventArgs e)
    {
        wheelNo = 1;
        bt_prn_Click(bt_prn_R, EventArgs.Empty);
    }
    protected void bt_history_Click(object sender, EventArgs e)
    {
        string href = string.Format("whms_history_wheelData.aspx?CarNo={0}&wheelPos={1}", carInfo, wheelPos_L);
        Response.Redirect(href);
    }
    protected void bt_analyse_Click(object sender, EventArgs e)
    {
        string href = string.Format("whms_history.aspx?CarNo={0}&wheelPos={1}", carInfo, wheelPos_L);
        Response.Redirect(href);
    }
    protected void bt_history_R_Click(object sender, EventArgs e)
    {
        string href = string.Format("whms_history_wheelData.aspx?CarNo={0}&wheelPos={1}", carInfo, wheelPos_R);
        Response.Redirect(href);
    }
    protected void bt_analyse_R_Click(object sender, EventArgs e)
    {
        string href = string.Format("whms_history.aspx?CarNo={0}&wheelPos={1}", carInfo, wheelPos_R);
        Response.Redirect(href);
    }
}
