using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public partial class CheckClear : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        int ret = 0;
        string sDateTime = Request.QueryString["datetime"];
        if (sDateTime != null)
        {
            //string s = HttpUtility.UrlDecode(sDateTime);
            SqlDataSource ds = new SqlDataSource();
            ds.ConnectionString = ConfigurationManager.ConnectionStrings["tychoConnectionString"].ConnectionString;
            ds.UpdateCommand = "update detect set isView=1 where testDateTime='" + sDateTime + "'";
            ds.Update();
            //PUBS.Log(Request.UserHostAddress, "Remote Alarm", 100, sDateTime);
            //单独更新，不能用PUBS
            Log(Request.UserHostAddress, "Remote Alarm", 100, sDateTime);
            ret = 1;
        }
        Response.Write("<RETURN>\r\n");
        Response.Write("<STATUES>"+ret.ToString()+"</STATUES>\r\n");
        Response.Write("</RETURN>");
    }
    public static void Log(string sIP, string sName, int iOP, string sData)
    {
        try
        {
            PUBS.sqlRun(string.Format("insert into log values('{0}', '{1}', '{2}', {3}, '{4}')",
                                      DateTime.Now.ToShortDateString() + " " + DateTime.Now.ToLongTimeString(), sName,
                                      sIP, iOP, sData));
        }
        catch
        {
        }
    }

}
