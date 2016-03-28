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
    public int wheelPos;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["login"] == null)
            Response.Redirect(PUBS.HomePage);

        var name = PUBS.GetUserDisplayName(Context.User.Identity.Name);
        LoginName2.FormatString = name;

        strCarNo = Request.QueryString["CarNo"];

        wheelPos = int.Parse(Request.QueryString["wheelPos"]);
        string sql = "";
        sql += "select CONVERT(varchar(20), R.testDateTime, 120) testDateTime, R.axleNo, R.wheelNo, ";
        sql += "case P.Lj when -1000 then '-' else cast(P.Lj as varchar(20)) end as Lj, ";
        sql += "case P.TmMh when -1000 then '-' else cast(P.TmMh as varchar(20)) end as TmMh, "; 
        sql += "case P.LyHd when -1000 then '-' else cast(P.LyHd as varchar(20)) end as LyHd, ";
        sql += "case P.LyGd when -1000 then '-' else cast(P.LyGd as varchar(20)) end as LyGd, ";
        sql += "case P.LwHd when -1000 then '-' else cast(P.LwHd as varchar(20)) end as LwHd, ";
        sql += "case P.QR when -1000 then '-' else cast(P.QR as varchar(20)) end as QR, ";
        sql += "case P.Ncj when -1000 then '-' else cast(P.Ncj as varchar(20)) end as Ncj, ";
        sql += "case P.LjCha_Zhou when -1000 then '-' else cast(P.LjCha_Zhou as varchar(20)) end as LjCha_Zhou, ";
        sql += "case P.LjCha_ZXJ when -1000 then '-' else cast(P.LjCha_ZXJ as varchar(20)) end as LjCha_ZXJ, ";
        sql += "case P.LjCha_Che when -1000 then '-' else cast(P.LjCha_Che as varchar(20)) end as LjCha_Che, ";
        sql += "case P.LjCha_Bz when -1000 then '-' else cast(P.LjCha_Bz as varchar(20)) end as LjCha_Bz "; 
        sql += "from ProfileDetectResult_real R, ProfileDetectResult P ";
        sql += string.Format("where R.CarNo='{0}' and R.pos={1} ", strCarNo, wheelPos);
        sql += "and R.testDateTime = P.testDateTime ";
        sql += "and R.axleNo = P.axleNo ";
        sql += "and R.wheelNo = P.wheelNo ";
        sql += "order by R.testDateTime desc";

        SqlDataSource1.SelectCommand = sql;

        GridView1.DataBind();
    }

    protected void LoginStatus2_LoggedOut(object sender, EventArgs e)
    {
        Session.Remove("login");
        PUBS.Log(Request.UserHostAddress, Membership.GetUser().UserName, 0, this.GetType().FullName);
    }
}
