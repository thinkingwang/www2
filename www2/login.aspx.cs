using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Net.Mime;
using System.Web;
using System.Web.Security;
using System.Web.Services.Discovery;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections.Generic; 
public partial class _Default : System.Web.UI.Page
{
    public static string HomePage;
    public string m_sUnitName;
    protected void Page_Load(object sender, EventArgs e)
    {
            bool isCs;
            //if (Request.QueryString["type"] != null)
            //{
            //    string type = Request.QueryString["type"].ToString();
            //    isCs = (type == "cs");
            //}
            //else
            //    isCs = false;

            //if (Session["RunType"] == null)
            //{

            //    if (isCs)
            //        Session.Add("RunType", "cs");
            //    else
            //        Session.Add("RunType", "bs");
            //}
            //PUBS.HomePage = Request.Url.ToString();
        if (Request.Url.Port == 80)
            Session.Add("RunType", "bs");
        else
            Session.Add("RunType", "cs");

        IniFile ini = new IniFile(System.IO.Path.GetDirectoryName(Page.Request.PhysicalPath) + "\\tycho.ini");
        string lang;// = ini.IniReadValue("常规", "language", "cn");
        DataTable dt = PUBS.sqlQuery("select * from language");

        if (Request.QueryString["language"] != null)
        {
            SetLang(Request.QueryString["language"].ToString());
        }
        else
        {
            if (GetLang() == "")
            {
                SetLang("cn");
            }
        }
        lang = GetLang();

        PUBS.dic = new Dictionary<string, string>();
        foreach (DataRow dr in dt.Rows)
        {
            if (lang == "en")
            {

                PUBS.dic.Add(dr["id"].ToString(), dr["en"].ToString());
            }
            else
            {

                PUBS.dic.Add(dr["id"].ToString(), dr["cn"].ToString());
            }
        }


        //IniFile ini = new IniFile(System.IO.Path.GetDirectoryName(Page.Request.PhysicalPath) + "\\tycho.ini");
        string unit = ini.IniReadValue("常规", "unit", "");
        Session.Add("Unit", unit);
        m_sUnitName = unit;// +" " + PUBS.Txt("车辆段");//"车辆段";department
        Application["css"] = "css/tycho/tycho.css";
        Login1.UserNameLabelText = PUBS.Txt("用户名");
        Login1.PasswordLabelText = PUBS.Txt("密码");
        //Login1.TitleText = PUBS.Txt("login"];
        Login1.LoginButtonText = PUBS.Txt("登录");
    }
    private void SetLang(string s)
    {
        //HttpCookie cok = Request.Cookies["Tycho_language"];
        //if (cok == null)
        //{
        //    cok = new HttpCookie("Tycho_language"); //初使化并设置Cookie的名称
        //    cok.Domain = "tycho.com";
        //    cok.Values.Add("language", s);
        //    DateTime dt = DateTime.Now;
        //    //TimeSpan ts = new TimeSpan(1, 0, 1, 0, 0); //过期时间为1分钟
        //    cok.Expires = dt.AddDays(7);//.Add(ts); //设置过期时间
        //    //cok.Expires = DateTime.MaxValue;
        //    Response.Cookies.Add(cok);
        //}
        //else
        //{
        //    cok.Values["language"] = s;
        //    Response.AppendCookie(cok);
        //}
        if (GetLang() == "")
            PUBS.sqlRun(string.Format("insert into General values('{0}', '{1}')", Request.UserHostAddress, s));
        else
        {
            PUBS.sqlRun(string.Format("update General set value ='{1}' where name='{0}'", Request.UserHostAddress, s));
        }
    }

    private string GetLang()
    {
        //if (Request.Cookies["Tycho_language"] != null)
        //{
        //    return Request.Cookies["Tycho_language"]["language"];
        //}
        //return "";
        DataTable dt = PUBS.sqlQuery(string.Format("select * from General where name='{0}'", Request.UserHostAddress));
        if (dt==null || dt.Rows.Count == 0)
            return "";
        return dt.Rows[0]["value"].ToString();
    }
    protected void Login1_LoggedIn(object sender, EventArgs e)
    {
        Session["login"] = DateTime.Now;
        
        Session["screen_pix"] = Convert.ToInt32(screen_pix.Value);

        PUBS.Log(Request.UserHostAddress, Login1.UserName, 1, "");
        PUBS.LogVersion();
    }
    protected void Login1_LoginError(object sender, EventArgs e)
    {
        PUBS.Log(Request.UserHostAddress, Login1.UserName, 101, "");
        
    }
}
