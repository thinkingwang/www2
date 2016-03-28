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
    public int axleNo;
    public int carNo;
    public int axleNoInCar;
    public int wheelNo;
    private DataTable dtData;
    PrnWhmsWheel prn;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["login"] == null)
            Response.Redirect(PUBS.HomePage);

        if (PUBS.GetUserLevel() > 1)
            Response.Redirect("invalid.html");

        var name = PUBS.GetUserDisplayName(Context.User.Identity.Name);
        LoginName2.FormatString = name;
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
        if (!IsPostBack)
        {
            if (Session["PrnWhmsWheel"] != null)
            {
                prn = (PrnWhmsWheel)Session["PrnWhmsWheel"];

                ReportParameter rptPara0 = new ReportParameter("name", Application["SYS_NAME"].ToString());
                ReportParameter rptPara1 = new ReportParameter("testDateTime", prn.testDateTime);
                ReportParameter rptPara2 = new ReportParameter("trainInfo", prn.trainInfo);
                ReportParameter rptPara3 = new ReportParameter("carInfo", prn.carInfo);
                //ReportParameter rptPara4 = new ReportParameter("pos", prn.pos);
                ReportParameter rptPara5 = new ReportParameter("carIndex", prn.carIndex);
                ReportParameter rptPara6 = new ReportParameter("axleIndex", prn.axleIndex);
                //ReportParameter rptPara7 = new ReportParameter("img", prn.image);
                ReportParameter rptPara8 = new ReportParameter("department", Session["Unit"].ToString());
                ReportParameter rptPara9 = new ReportParameter("Operator", Membership.GetUser().UserName);

                ReportViewer1.LocalReport.SetParameters(new ReportParameter[] { rptPara0, rptPara1, rptPara2, rptPara3, rptPara5, rptPara6, rptPara8, rptPara9 });



               
                DataTable dt = new DataTable();
                dt.Columns.Add("axle", System.Type.GetType("System.String"));
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
                dt.PrimaryKey = new[] { dt.Columns["axle"] };

                string sql = string.Format("select *, axleNo%4+1 axle from ProfileDetectResult where testDateTime = '{0}' and axleNo/4 +1 = {1} ", prn.testDateTime, prn.carIndex);
                DataTable dtData = PUBS.sqlQuery(sql);
                foreach (DataRow dr in dtData.Rows)
                {
                    object[] key = new object[1];
                    key[0] = dr["axle"].ToString();
                    DataRow drFind = dt.Rows.Find(key);
                    if (drFind == null)
                    {
                        if (dr["wheelNo"].ToString() == "1")
                            dt.Rows.Add(dr["axle"].ToString(), "", "", "", "", GetValueDesc("WX_NCJ", dr["ncj"].ToString()), dr["lj"].ToString(), dr["tmmh"].ToString(), dr["lyhd"].ToString(), dr["lwhd"].ToString());
                        else
                            dt.Rows.Add(dr["axle"].ToString(), dr["lj"].ToString(), dr["tmmh"].ToString(), dr["lyhd"].ToString(), dr["lygd"].ToString(), dr["lwhd"].ToString(), dr["qr"].ToString(), GetValueDesc("WX_NCJ", dr["ncj"].ToString()), "", "", "", "", "", "");

                    }
                    else
                    {
                        drFind["R_lj"] = dr["lj"];
                        drFind["R_tmmh"] = dr["tmmh"];
                        drFind["R_lyhd"] = dr["lyhd"];
                        drFind["R_lygd"] = dr["lygd"];
                        drFind["R_lwhd"] = dr["lwhd"];
                        drFind["R_qr"] = dr["qr"];
                    }
                }



                //int updown, level;
                //string desc;
                //PUBS.GetProfileStatus("WX_LJ", double.Parse(prn.v_wheelSize), out updown, out level, out desc);
                //dt.Rows.Add("轮径",prn.v_wheelSize, sLevel[level], desc);

                //PUBS.GetProfileStatus("WX_TMMH", double.Parse(prn.v_tmmh), out updown, out level, out desc);
                //dt.Rows.Add("踏面磨耗", prn.v_tmmh, sLevel[level], desc);

                //PUBS.GetProfileStatus("WX_LYHD", double.Parse(prn.v_lyhd), out updown, out level, out desc);
                //dt.Rows.Add("轮缘厚度", prn.v_lyhd, sLevel[level], desc);

                //PUBS.GetProfileStatus("WX_LWHD", double.Parse(prn.v_lwhd), out updown, out level, out desc);
                //dt.Rows.Add("轮辋厚度", prn.v_lwhd, sLevel[level], desc);

                //PUBS.GetProfileStatus("WX_NCJ", double.Parse(prn.v_ncj), out updown, out level, out desc);
                //dt.Rows.Add("内侧距", prn.v_ncj, sLevel[level], desc);

                ReportDataSource rds = new ReportDataSource("DataSet1", dt);

                DataTable dtThreshold = PUBS.sqlQuery("select case name when 'wx_lj' then '轮径' when 'wx_tmmh' then '踏面磨耗' when 'wx_lyhd' then '轮缘厚度' when 'wx_lygd' then '轮缘高度' when 'wx_lwhd' then '轮辋宽度' when 'wx_qr' then 'QR值' when 'wx_ncj' then '内侧距' end [name], [desc] from thresholds  where name like 'WX_%'");
                
                ReportDataSource rds2 = new ReportDataSource("DataSet2", dtThreshold);
                ReportViewer1.LocalReport.DataSources.Clear();
                ReportViewer1.LocalReport.DataSources.Add(rds);
                ReportViewer1.LocalReport.DataSources.Add(rds2);
                ReportViewer1.LocalReport.Refresh();
            }
        }
    }

    private string GetValueDesc(string name, string value)
    {
        //int updown, level;
        //string desc;
        //PUBS.GetProfileStatus(name, value, out updown, out desc);
        ////if ((level > 0) && (level < PUBS.sLevel.Length))
        ////    return string.Format("{0} [{1}]",  value, PUBS.sLevel[level]);
        ////else
            return value;
    }
    protected void LoginStatus2_LoggedOut(object sender, EventArgs e)
    {
        Session.Remove("login");
        PUBS.Log(Request.UserHostAddress, Membership.GetUser().UserName, 0, this.GetType().FullName);

    }
}
