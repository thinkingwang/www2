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

    public string strCarNo;
    private DataTable dtData;

    public int axlePos;
    public int wheelPos;
    private int screenPix;
    public int tableWidth;
    public string trainType;
    public int iShengYuDays;
    public string sShengYu;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["login"] == null)
            Response.Redirect(PUBS.HomePage);

        var name = PUBS.GetUserDisplayName(Context.User.Identity.Name);
        LoginName2.FormatString = name;
        screenPix = int.Parse(Session["screen_pix"].ToString());
        tableWidth = screenPix - 100;
        
        strCarNo = Request.QueryString["CarNo"];

        wheelPos = int.Parse(Request.QueryString["wheelPos"]);


        DataTable dirt = PUBS.sqlQuery(string.Format("select top 1 testDateTime from carlist where carNo='{0}' order by testDateTime desc", strCarNo));
        string sDateTime = dirt.Rows[0]["testDateTime"].ToString();
        dirt = PUBS.sqlQuery(string.Format("select engNum from detect where testDateTime='{0}'", sDateTime));
        string bzh = dirt.Rows[0]["engNum"].ToString();
        if (bzh.IndexOf('-') >= 0)
            trainType = bzh.Substring(0, bzh.IndexOf('-'));
        else
            trainType = "default";

        string sql = "";
        try
        {
            sql = string.Format("select top 1 P.testdatetime, P.lj ");
            sql += "from ProfileDetectResult_real R, ProfileDetectResult P ";
            sql += string.Format("where R.CarNo='{0}' and R.pos={1} ", strCarNo, wheelPos);
            sql += "and R.testDateTime = P.testDateTime ";
            sql += "and R.axleNo = P.axleNo ";
            sql += "and R.wheelNo = P.wheelNo ";
            sql += "order by P.testdatetime desc";
            dtData = PUBS.sqlQuery(sql);
            double ljNow = double.Parse(dtData.Rows[0]["lj"].ToString());
            DateTime dtNow = Convert.ToDateTime(dtData.Rows[0]["testdatetime"].ToString());

            sql = string.Format("select top 1 P.testdatetime, P.lj ");
            sql += "from ProfileDetectResult_real R, ProfileDetectResult P ";
            sql += string.Format("where R.CarNo='{0}' and R.pos={1} ", strCarNo, wheelPos);
            sql += "and R.testDateTime = P.testDateTime ";
            sql += "and R.axleNo = P.axleNo ";
            sql += "and R.wheelNo = P.wheelNo ";
            sql += "and p.lj !=-1000 ";
            sql += "and p.testdatetime < DATEADD(d,-90, getdate()) ";
            sql += "order by P.testdatetime desc";
            dtData = PUBS.sqlQuery(sql);
            if (dtData.Rows.Count == 0)
            {
                sShengYu = "目前无法估算";
            }
            else
            {
                double ljFirst = double.Parse(dtData.Rows[0]["lj"].ToString());
                DateTime dtFirst = Convert.ToDateTime(dtData.Rows[0]["testdatetime"].ToString());

                DataTable dt = PUBS.sqlQuery(string.Format("select * from thresholds where trainType='{0}' and name='WX_LJ'", trainType));
                double ljLevelLow = double.Parse(dt.Rows[0]["low_level1"].ToString());

                TimeSpan ts = dtNow - dtFirst;

                iShengYuDays = (int)Math.Floor((ljNow - ljLevelLow) / ((ljFirst - ljNow) / ts.TotalDays));
                if (iShengYuDays > 365)
                    sShengYu = string.Format("{0}年{1}天", iShengYuDays / 365, iShengYuDays % 365);
                else
                    sShengYu = string.Format("{0}天", iShengYuDays);
            }
        }
        catch
        {
            sShengYu = "";
        }

        sql = "";
        sql += "select R.testDateTime, R.axleNo, R.wheelNo, P.Lj, P.TmMh, P.LyHd, P.LyGd, P.LwHd, P.QR, P.Ncj , P.LjCha_Zhou as LJC_Z, P.LjCha_ZXJ as LJC_J, P.LjCha_Che as LJC_C, P.LjCha_Bz  as LJC_B ";
        sql += "from ProfileDetectResult_real R, ProfileDetectResult P ";
        sql += string.Format("where R.CarNo='{0}' and R.pos={1} ", strCarNo, wheelPos);
        sql += "and R.testDateTime = P.testDateTime ";
        sql += "and R.axleNo = P.axleNo ";
        sql += "and R.wheelNo = P.wheelNo ";

        dtData = PUBS.sqlQuery(sql);

        Draw(Chart_lj, "lj");
        Draw(Chart_ljc_Z, "LJC_Z");
        Draw(Chart_ljc_J, "LJC_J");
        Draw(Chart_ljc_C, "LJC_C");
        Draw(Chart_ljc_B, "LJC_B");
        Draw(Chart_tmmh, "tmmh");
        Draw(Chart_lyhd, "lyhd");
        Draw(Chart_lygd, "lygd");
        Draw(Chart_lwhd, "lwhd");
        Draw(Chart_qr, "qr");
        Draw(Chart_ncj, "ncj");
    }

    private void Draw(Chart theChart, string key)
    {
        theChart.Width = tableWidth - 180;
        DataTable drs = dtData.Select(string.Format("{0}<>-1000", key), "testDateTime").CopyToDataTable();
        theChart.Series[0].Points.DataBindXY(drs.Rows, "testdatetime", drs.Rows, key);
        theChart.Series[0].LegendText = "检测数据";
        double maxY;
        double minY;
        double maxV = double.Parse(drs.Compute(string.Format("Max({0})", key), "").ToString());
        double minV = double.Parse(drs.Compute(string.Format("Min({0})", key), "").ToString());
        //theChart.ChartAreas[0].AxisY.Maximum = maxY;
        //theChart.ChartAreas[0].AxisY.Minimum = minY;
        DataTable dt = PUBS.sqlQuery(string.Format("select * from thresholds where trainType='{1}' and name='WX_{0}'", key, trainType));
        double levelup = double.Parse(dt.Rows[0]["up_level1"].ToString());
        string flag;
        if (levelup != 2000)
        {
            flag = "报警上限";
            theChart.Series.Add(new Series(flag));
            theChart.Series[flag].ChartType = SeriesChartType.FastLine;
            theChart.Series[flag].Color = System.Drawing.Color.DarkRed;
            theChart.Series[flag].Points.AddXY(drs.Rows[0]["testDateTime"], levelup);
            theChart.Series[flag].Points.AddXY(drs.Rows[drs.Rows.Count - 1]["testDateTime"], levelup);
            theChart.Series[flag].LegendText = string.Format("{0}{1}mm", flag, levelup);
        }
        double leveldown = double.Parse(dt.Rows[0]["low_level1"].ToString());
        if (leveldown != -1000)
        {
            flag = "报警下限";
            theChart.Series.Add(new Series(flag));
            theChart.Series[flag].ChartType = SeriesChartType.FastLine;
            theChart.Series[flag].Color = System.Drawing.Color.DarkRed;
            theChart.Series[flag].Points.AddXY(drs.Rows[0]["testDateTime"], leveldown);
            theChart.Series[flag].Points.AddXY(drs.Rows[drs.Rows.Count - 1]["testDateTime"], leveldown);
            theChart.Series[flag].LegendText = string.Format("{0}{1}mm", flag, leveldown);
        }
        maxY = maxV;
        minY = maxV;

        if (key == "lj")
        {
            maxY = double.Parse(dt.Rows[0]["standard"].ToString())+5;
            minY = leveldown -5;
        }
        else if (key == "LJC_Z")
        {
            //if (levelup == 1000)
            //    maxY = maxV;
            //else
            //    maxY = levelup + levelup*0.1;
            maxY = 20;
            minY = -10;
        }
        else if (key == "LJC_J")
        {
            maxY = 20;
            minY = -10;
        }
        else if (key == "LJC_C")
        {
            maxY = 40;
            minY = -10;
        }
        else if (key == "LJC_B")
        {
            maxY = 60;
            minY = -10;
        }

        else if (key == "tmmh")
        {
            maxY = levelup + 2;
            minY = minV;
        }
        else if (key == "lyhd")
        {
            maxY = maxV + 5;
            minY = leveldown -2;
        }
        else if (key == "lygd")
        {
            maxY = levelup + 2;
            minY = minV;
        }
        else if (key == "lwhd")
        {
            maxY = 140;
            minY = 130;
        }
        else if (key == "qr")
        {
            maxY = maxV+5;
            minY = leveldown - 1;
        }
        else if (key == "ncj")
        {
            maxY = levelup + 5;
            minY = leveldown - 5;
        }
        theChart.ChartAreas[0].AxisY.Maximum = maxY;
        theChart.ChartAreas[0].AxisY.Minimum = minY;
 
    }
    protected void LoginStatus2_LoggedOut(object sender, EventArgs e)
    {
        Session.Remove("login");
        PUBS.Log(Request.UserHostAddress, Membership.GetUser().UserName, 0, this.GetType().FullName);

    }
}
