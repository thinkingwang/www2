using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

public partial class engine_engine : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["login"] == null)
            Response.Redirect("login.aspx");

        var name = PUBS.GetUserDisplayName(Context.User.Identity.Name);
        LoginName2.FormatString = name;
    }
    protected void LoginStatus2_LoggedOut(object sender, EventArgs e)
    {
        Session.Remove("login");
        PUBS.Log(Request.UserHostAddress, Membership.GetUser().UserName, 0, this.GetType().FullName);
    }
    protected void bt_insert_Click1(object sender, EventArgs e)
    {
        try
        {
            TextBox tb_id = GridView1.FooterRow.FindControl("tb_id") as TextBox;
            DropDownList ddl_trainLocation = GridView1.FooterRow.FindControl("ddl_trainLocation") as DropDownList;
            //TextBox tb_name = GridView1.FooterRow.FindControl("tb_name") as TextBox;
            SqlDataSource_engineType.InsertParameters["id"].DefaultValue = tb_id.Text;
            SqlDataSource_engineType.InsertParameters["trainLocation"].DefaultValue = ddl_trainLocation.SelectedValue;
            //SqlDataSource_engineType.InsertParameters["name"].DefaultValue = tb_name.Text;
            SqlDataSource_engineType.Insert();
            //PUBS.Log(Request.UserHostAddress, Membership.GetUser().UserName, 11, tb_name.Text);
            var log = PUBS.GetLogContect(',', "增加的新车组，车号，归属地分别为：",
                tb_id.Text, PUBS.GetEngine_TypeLocation(ddl_trainLocation.SelectedValue));
            PUBS.Log(Request.UserHostAddress, PUBS.GetCurrentUser(), 11, log);
        }
        catch
        {
            string Message = "增加数据失败，请检查录入数据是否正确！";
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "alert", "alert('" + Message + "');", true);
        }

    }
    protected void bt_add_Click(object sender, EventArgs e)
    {
        GridView1.ShowFooter = !GridView1.ShowFooter;
        if (GridView1.ShowFooter)
            bt_add.Text = "取  消";
        else
            bt_add.Text = "新  增";

    }
    protected void bt_back_Click(object sender, EventArgs e)
    {
        Response.Redirect("DetectList.aspx");

    }
    protected void GridView1_RowUpdated(object sender, GridViewUpdatedEventArgs e)
    {
        //PUBS.Log(Request.UserHostAddress, Membership.GetUser().UserName, 9, e.OldValues[0].ToString() + " to " +e.NewValues[0].ToString());
    }
    protected void GridView1_RowDeleted(object sender, GridViewDeletedEventArgs e)
    {
        var log = PUBS.GetLogContect(',', "删除车组",
             "");
        PUBS.Log(Request.UserHostAddress, PUBS.GetCurrentUser(), 10, log);
        //PUBS.Log(Request.UserHostAddress, Membership.GetUser().UserName, 10, e.Values[0].ToString());
    }

    protected void bt_addBash_Click(object sender, EventArgs e)
    {
        var trainType = txt_trainType.Text;
        if (string.IsNullOrEmpty(trainType))
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "alert", "alert('" + "车号不能为空" + "');", true);
            return;
        }
        if (string.IsNullOrEmpty(txt_start.Text) || string.IsNullOrEmpty(txt_end.Text))
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "alert", "alert('" + "车号开始和结束数字不能为空" + "');", true);
            return;
        }
        var start = Convert.ToInt32(txt_start.Text);
        var end = Convert.ToInt32(txt_end.Text);
        var location = ddl_trainLocationAdd.SelectedValue;
        if (end < start)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "alert", "alert('" + "车号开始数字必须大于等于结束数字" + "');", true);
            return;
        }
        for (int i = start; i <= end; i++)
        {
            //TextBox tb_name = GridView1.FooterRow.FindControl("tb_name") as TextBox;
            SqlDataSource_engineType.InsertParameters["id"].DefaultValue = trainType + "-" + i;
            SqlDataSource_engineType.InsertParameters["trainLocation"].DefaultValue = location;
            //SqlDataSource_engineType.InsertParameters["name"].DefaultValue = tb_name.Text;
            SqlDataSource_engineType.Insert(); 
            var log = PUBS.GetLogContect(',', "增加的新车组，车号，归属地分别为：",
                 trainType + "-" + i, PUBS.GetEngine_TypeLocation(location));
            PUBS.Log(Request.UserHostAddress, PUBS.GetCurrentUser(), 11, log);
        }
    }

    protected void bt_addBash_Start(object sender, EventArgs e)
    {
        if (bt_addBash.Text == "批量增加")
        {
            bt_addBash.Text = "结束批量增加";
            panel_bash.Visible = true;
        }
        else
        {
            bt_addBash.Text = "批量增加";
            panel_bash.Visible = false;
        }
    }
    protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        var index = GridView1.EditIndex;
        var row = GridView1.Rows[index];
        var drop = row.FindControl("ddl_trainLocation") as DropDownList;
        var id = row.FindControl("lb_id") as Label;
        if (drop == null||id==null)
        {
            e.Cancel = true;
            return;
        }
        Session["trainLocation"] = drop.SelectedValue;
        Session["id"] = id.Text;
        SqlDataSource_engineType.Update();
    }
    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {

        var index = e.RowIndex;
        var row = GridView1.Rows[index];
        var id = row.FindControl("lb_id") as Label;
        if ( id == null)
        {
            e.Cancel = true;
            return;
        }
        Session["id"] = id.Text;
        SqlDataSource_engineType.Delete();
    }
}
