using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;

public partial class check : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlDataSource ds = new SqlDataSource();
        ds.ConnectionString = ConfigurationManager.ConnectionStrings["tychoConnectionString"].ConnectionString;
        //ds.SelectCommand = "select B.testdatetime, B.BugNum, D.isView, D.engNum ";
        //ds.SelectCommand += "from (select testdatetime, count(*) BugNum from bugresult where level <=3 group by testdatetime) B, detect D ";
        //ds.SelectCommand += "where B.testdatetime=D.testdatetime and D.isView=0 and D.isValid=0 ";
        //ds.SelectCommand += "order by B.testdatetime desc";

        ds.SelectCommand =
            "select testdatetime, engNum, s_levelM from V_detect where isview=0 and (s_levelM = '1' or s_levelM = '2' or s_levelM = '3') order by testdatetime desc";

        DataView dv = (DataView)ds.Select(DataSourceSelectArguments.Empty);
        Response.Write("<RETURN>\r\n");
        Response.Write("<STATUES>1</STATUES>\r\n");
        Response.Write("<LIST>\r\n");

        foreach(DataRowView dr in dv)
        {
            Response.Write("<ALARM>\r\n");
            Response.Write("<DATETIME>"+dr["testdatetime"].ToString()+"</DATETIME>\r\n");
            Response.Write("<NO>" + dr["engNum"].ToString() + "</NO>\r\n");
            Response.Write("<LEVEL>" + dr["s_levelM"].ToString() + "</LEVEL>\r\n");
            Response.Write("</ALARM>\r\n");
        }

        Response.Write("</LIST>\r\n");
        Response.Write("</RETURN>");
    }
}
