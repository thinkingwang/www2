using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Data.SqlClient;
//using System.Xml.Linq;

public partial class Verify : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["login"] == null)
            Response.Redirect(PUBS.HomePage);
        if (!IsPostBack)
        {
            GridView1.DataSource =
                PUBS.sqlQuery(
                    "select RANK() OVER (ORDER BY A.dt DESC) AS 序号, A.dt 日期,case isnull(C.DisplayName,A.name) when 'p807' then '外形系统' else isnull(C.DisplayName,A.name) end  操作者,B.name 操作,A.data 操作内容,A.ip 操作ip from dbo.log as A left join dbo.operate as B on A.op=B.id left join ASPNETDB.dbo.aspnet_Users as C on A.name=C.UserName order by A.dt desc");
            GridView1.DataBind();
        }
        var name = PUBS.GetUserDisplayName(Context.User.Identity.Name);
        LoginName2.FormatString = name;
    }
    protected void LoginStatus2_LoggedOut(object sender, EventArgs e)
    {
        Session.Remove("login");
        PUBS.Log(Request.UserHostAddress, Membership.GetUser().UserName, 0, this.GetType().FullName);
    }


   
    
    
    protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
    }




    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        //GridView1.DataSource =
        //    PUBS.sqlQuery(
        //        string.Format(
        //            "SELECT  *  FROM    ( select ROW_NUMBER() OVER ( ORDER BY A.dt DESC ) AS 序号, A.dt 日期,isnull(C.DisplayName,A.name) 操作者,B.name 操作,A.data 操作内容,A.ip 操作ip from dbo.log as A left join dbo.operate as B on A.op=B.id left join ASPNETDB.dbo.aspnet_Users as C on A.name=C.UserName) AS temp WHERE   temp.序号 BETWEEN {0} AND {1}",
        //            e.NewPageIndex * GridView1.PageSize, (e.NewPageIndex + 1) * GridView1.PageSize)
        //        );
        GridView1.DataSource =
            PUBS.sqlQuery(
                "select RANK() OVER (ORDER BY A.dt DESC) AS 序号, A.dt 日期,case isnull(C.DisplayName,A.name) when 'p807' then '外形系统' else isnull(C.DisplayName,A.name) end  操作者,B.name 操作,A.data 操作内容,A.ip 操作ip from dbo.log as A left join dbo.operate as B on A.op=B.id left join ASPNETDB.dbo.aspnet_Users as C on A.name=C.UserName order by A.dt desc");
        GridView1.DataBind();
    }
}
