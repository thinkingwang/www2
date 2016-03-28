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
using System.Net;

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
                ReportViewer1.ProcessingMode = ProcessingMode.Remote;

                ReportViewer1.ServerReport.ReportServerCredentials = new CustomReportCredentials("tychoReport", "Tk_webreport", "");
                ReportViewer1.ServerReport.ReportServerUrl = new Uri("http://192.168.5.204/reportserver");
                ReportViewer1.ServerReport.ReportPath = "/报表项目1/Report1"; 
                ReportParameter rptPara1 = new ReportParameter("testdatetime", datetimestr);
                //ReportViewer1.ServerReport.ReportServerCredentials.NetworkCredentials = new System.Net.NetworkCredential("administrator", "MyServer123", "");
                ReportViewer1.ServerReport.SetParameters(rptPara1);
                ReportViewer1.ServerReport.Refresh();
            }
        }
    }
    public class CustomReportCredentials : IReportServerCredentials
    {
        private string _UserName;
        private string _PassWord;
        private string _DomainName;

        public CustomReportCredentials(string UserName, string PassWord, string DomainName)
        {
            _UserName = UserName;
            _PassWord = PassWord;
            _DomainName = DomainName;
        }

        public System.Security.Principal.WindowsIdentity ImpersonationUser
        {
            get { return null; }
        }

        public ICredentials NetworkCredentials
        {
            get { return new NetworkCredential(_UserName, _PassWord, _DomainName); }
        }

        public bool GetFormsCredentials(out Cookie authCookie, out string user,
         out string password, out string authority)
        {
            authCookie = null;
            user = password = authority = null;
            return false;
        }
    }

    protected void LoginStatus2_LoggedOut(object sender, EventArgs e)
    {
        Session.Remove("login");
        PUBS.Log(Request.UserHostAddress, Membership.GetUser().UserName, 0, this.GetType().FullName);

    }
}
