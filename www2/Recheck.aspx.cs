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
using System.Linq;
using AjaxControlToolkit;

//using System.Xml.Linq;

public partial class Verify : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["login"] == null)
            Response.Redirect(PUBS.HomePage);
        if (!IsPostBack)
        {
        }
        var name = PUBS.GetUserDisplayName(Context.User.Identity.Name);
        LoginName2.FormatString = name;
        if (!Page.IsPostBack)
        {
            var sql1 = string.Format("exec dbo.GetAlarmDataForWaiXing '{0}' ,'{0}','All','All','All','All','ALL'",
                Request["datetimeStr"]);
            var tbWaixing =
                PUBS.sqlQuery(string.Format("exec dbo.GetAlarmDataForWaiXing '{0}' ,'{0}','All','All','All','All','ALL'", Request["datetimeStr"]));

            if (tbWaixing != null && tbWaixing.Rows.Count > 0 && GridView1.Columns.Count <= 1)
            {
                foreach (DataColumn c in tbWaixing.Columns)
                {
                    if (c.ColumnName == "轴号" || c.ColumnName == "轮号")
                    {
                        continue;
                    }
                    BoundField cc = new BoundField(); //或者 CheckBoxField()
                    cc.HeaderText = c.ColumnName;
                    cc.DataField = c.ColumnName;
                    GridView1.Columns.Insert(GridView1.Columns.Count - 1, cc);
                }
                GridView1.DataKeyNames = new[] { "轴号", "轮号" };
                GridView1.DataSource = tbWaixing;
                GridView1.DataBind();
            }
            else
            {
                Panel1.Visible = false;
            }
            var sql = string.Format("exec dbo.GetAlarmDataForTanShang '{0}' ,'{0}','All','All','All','All'",
                Request["datetimeStr"]);
            var tbTanshang =
                PUBS.sqlQuery(string.Format("exec dbo.GetAlarmDataForTanShang '{0}' ,'{0}','All','All','All','All'", Request["datetimeStr"]));

            if (tbTanshang != null&&tbTanshang.Rows.Count > 0 && GridView2.Columns.Count <= 1)
            {
                foreach (DataColumn c in tbTanshang.Columns)
                {
                    if (c.ColumnName == "轴号" || c.ColumnName == "轮号")
                    {
                        continue;
                    }
                    BoundField cc = new BoundField(); //或者 CheckBoxField()
                    cc.HeaderText = c.ColumnName;
                    cc.DataField = c.ColumnName;
                    GridView2.Columns.Insert(GridView2.Columns.Count - 1, cc);
                }
                GridView2.DataKeyNames = new[] { "轴号", "轮号" };
                GridView2.DataSource = tbTanshang;
                GridView2.DataBind();
            }
            else
            {
                Panel2.Visible = false;
            }
            var caTanshang =
                PUBS.sqlQuery(string.Format("exec dbo.GetAlarmDataForCaShang '{0}' ,'{0}','All','All','All','All'", Request["datetimeStr"]));

            if (caTanshang != null && caTanshang.Rows.Count > 0 && GridView3.Columns.Count <= 1)
            {
                foreach (DataColumn c in caTanshang.Columns)
                {
                    if (c.ColumnName == "轴号" || c.ColumnName == "轮号")
                    {
                        continue;
                    }
                    BoundField cc = new BoundField(); //或者 CheckBoxField()
                    cc.HeaderText = c.ColumnName;
                    cc.DataField = c.ColumnName;
                    GridView3.Columns.Insert(GridView3.Columns.Count - 1, cc);
                }
                GridView3.DataKeyNames = new[] { "轴号", "轮号" };
                GridView3.DataSource = caTanshang;
                GridView3.DataBind();
            }
            else
            {
                Panel3.Visible = false;
            }
        }
    }
    protected void LoginStatus2_LoggedOut(object sender, EventArgs e)
    {
        Session.Remove("login");
        PUBS.Log(Request.UserHostAddress, Membership.GetUser().UserName, 0, this.GetType().FullName);
    }


    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GridView1.EditIndex = e.NewEditIndex;
        GridView1.DataBind();
    }


    protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        var row = GridView1.Rows[e.RowIndex];
        var combox = row.Cells[8].FindControl("cb_recheckPerson") as ComboBox;
        if (combox != null)
        {
            Session["recheckPerson"] = combox.Text;
        }
        Session["testDatetime"] = e.OldValues["检测时间"];
        Session["carNo"] = e.OldValues["车厢号"];
        Session["wheelPos"] = e.OldValues["位置"];
        Session["checkItem"] = e.OldValues["检测项"];
        Session["checkValue"] = e.OldValues["检测值"];
        Session["recheckValue"] = e.NewValues["复核值"];
        Session["level"] = e.OldValues["报警级别"];
        Session["recheckDesc"] = e.NewValues["处理意见"];
        if (e.OldValues["处理人"] == null)
        {
            Session["operator"] = PUBS.GetUserDisplayName(Context.User.Identity.Name);
        }
        else
        {
            Session["operator"] = e.OldValues["处理人"];
        }
        Session["description"] = e.NewValues["备注"];
        PUBS.Log(Request.UserHostAddress, PUBS.GetCurrentUser(), 0, this.GetType().FullName);
        GridView1.EditIndex = -1;
        GridView1.DataBind();
        var log =
            PUBS.GetDatatableLogdata(
                string.Format(
                    "select testDateTime 检测时间,carNo 车厢号,wheelPos 轮位,checkItem 检测项,checkValue 检测值 ,recheckValue 复核值,recheckPerson 复核人,operator 处理人, recheckDesc 处理意见,Decription 备注 " +
                    "from recheckTable where testDateTime='{0}' and carNo='{1}' and wheelPos='{2}' and checkItem='{3}'",
                    Session["testDatetime"], Session["carNo"], Session["wheelPos"], Session["checkItem"]));
        if (log == null || log.Count == 0)
        {
            return;
        }
        PUBS.Log(Request.UserHostAddress,PUBS.GetCurrentUser(),32,log.First());
    }
    protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {

    }
   

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowState == (DataControlRowState.Edit | DataControlRowState.Alternate) || e.Row.RowState == DataControlRowState.Edit)
        {
            TextBox curText;
            for (int i = 0; i < e.Row.Cells.Count; i++)
            {
                if (e.Row.Cells[i].Controls.Count != 0)
                {
                    curText = e.Row.Cells[i].Controls[0] as TextBox;
                    if (curText != null)
                    {
                        //curText.Width = Unit.Pixel(80);//寬度自己設
                        curText.Width = Unit.Percentage(100);//寬度自己設
                        continue;
                    }
                    var sql = string.Format(
                        "select recheckPerson from dbo.recheckTable where testDatetime='{0}' and carNo='{1}' and wheelPos='{2}' and checkItem='{3}'",
                        e.Row.Cells[1].Text, e.Row.Cells[3].Text, e.Row.Cells[4].Text, e.Row.Cells[5].Text);
                    var table =
                        PUBS.sqlQuery(sql);
                    if (table == null || table.Rows.Count == 0)
                    {
                        continue;
                    }
                    var recheckPerson = table.Rows[0]["recheckPerson"].ToString();
                    if (!string.IsNullOrEmpty(recheckPerson))
                    {
                        var combox = e.Row.FindControl("cb_recheckPerson") as ComboBox;
                        if (combox == null)
                        {
                            continue;
                        }
                        var item = combox.Items.FindByText(recheckPerson);
                        if (item != null)
                        {
                            combox.Text = recheckPerson;
                        }
                    }
                }
            }
        }
    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        var gv = e.CommandSource as GridView;
        if (gv == null)
        {
            return;
        }
        var row = gv.Rows[Convert.ToInt32(e.CommandArgument)];
        var commPara = "&advice=" + row.Cells[GetIndexOfColumn(gv, "处理意见")].Text + "&desc=" + row.Cells[GetIndexOfColumn(gv, "处理结论")].Text + "&recheckPerson=" + row.Cells[GetIndexOfColumn(gv, "复核人")].Text + "&recheckOperator=" +
                       row.Cells[GetIndexOfColumn(gv, "处理人")].Text;

        int wheelPos;
        switch (row.Cells[GetIndexOfColumn(gv, "检测项")].Text)
        {
            case "同轴轮径差":
                wheelPos = Convert.ToInt32(row.Cells[GetIndexOfColumn(gv, "位置")].Text.TrimEnd('轴'));
                Response.Redirect("checkLjcha_zhou.aspx?testDateTime=" + row.Cells[GetIndexOfColumn(gv, "检测时间")].Text + "&carNo=" +
                                  row.Cells[GetIndexOfColumn(gv, "车厢号")].Text + "&axlePos=" + wheelPos + commPara);
                break;
            case "内侧距":
                wheelPos = Convert.ToInt32(row.Cells[GetIndexOfColumn(gv, "位置")].Text.TrimEnd('轴'));
                Response.Redirect("checkWaiXingSimple.aspx?testDateTime=" + row.Cells[GetIndexOfColumn(gv, "检测时间")].Text + "&checkItem=" + row.Cells[GetIndexOfColumn(gv, "检测项")].Text + "&carNo=" +
                                  row.Cells[GetIndexOfColumn(gv, "车厢号")].Text + "&wheelPos=" + wheelPos + commPara);
                break;
            case "同转向架轮径差":
                var zxj = Convert.ToInt32(row.Cells[GetIndexOfColumn(gv, "位置")].Text.ElementAt(0).ToString());
                Response.Redirect("checkLjcha_zxj.aspx?testDateTime=" + row.Cells[GetIndexOfColumn(gv, "检测时间")].Text + "&carNo=" +
                                  row.Cells[GetIndexOfColumn(gv, "车厢号")].Text + "&zxj=" + zxj + commPara);
                break;
            case "同车轮径差":
                Response.Redirect("checkLjcha_che.aspx?testDateTime=" + row.Cells[GetIndexOfColumn(gv, "检测时间")].Text + "&carNo=" +
                                  row.Cells[GetIndexOfColumn(gv, "车厢号")].Text + commPara);
                break;
            case "整车差":
                Response.Redirect("checkLjcha_bz.aspx?testDateTime=" + row.Cells[GetIndexOfColumn(gv, "检测时间")].Text + commPara);
                break;
            default:
                wheelPos = Convert.ToInt32(row.Cells[GetIndexOfColumn(gv, "位置")].Text.TrimEnd('位'));
                Response.Redirect("checkWaiXingSimple.aspx?testDateTime=" + row.Cells[GetIndexOfColumn(gv, "检测时间")].Text + "&checkItem=" + row.Cells[GetIndexOfColumn(gv, "检测项")].Text + "&carNo=" +
                                  row.Cells[GetIndexOfColumn(gv, "车厢号")].Text + "&wheelPos=" + wheelPos + commPara);
                break;
        }

    }

    protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        var gv = e.CommandSource as GridView;
        if (gv == null)
        {
            return;
        }
        var row = gv.Rows[Convert.ToInt32(e.CommandArgument)];
        if (gv.DataKeys[row.RowIndex] == null)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "alert", "alert('" + "该数据才数据库检索失败" + "');", true);
            return;
        }
        var wheelNo = gv.DataKeys[row.RowIndex]["轮号"];
        var axleNo = gv.DataKeys[row.RowIndex]["轴号"];
        var commPara = "&advice=" + row.Cells[GetIndexOfColumn(gv, "处理意见")].Text + "&desc=" + row.Cells[GetIndexOfColumn(gv, "处理结论")].Text + "&recheckPerson=" + row.Cells[GetIndexOfColumn(gv, "复核人")].Text + "&recheckOperator=" +
                       row.Cells[GetIndexOfColumn(gv, "处理人")].Text;
        Response.Redirect("checkTanShang.aspx?testDateTime=" + row.Cells[GetIndexOfColumn(gv, "检测时间")].Text + "&carNo=" +
                          row.Cells[GetIndexOfColumn(gv, "车厢号")].Text + "&axleNo=" +
                          axleNo + "&wheelNo=" + wheelNo + "&wheelPos=" + row.Cells[GetIndexOfColumn(gv, "位置")].Text.TrimEnd('位') + commPara);

    }
    protected void GridView3_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        var gv = e.CommandSource as GridView;
        if (gv == null)
        {
            return;
        }
        var row = gv.Rows[Convert.ToInt32(e.CommandArgument)];
        var commPara = "&advice=" + row.Cells[GetIndexOfColumn(gv, "处理意见")].Text + "&desc=" + row.Cells[GetIndexOfColumn(gv, "处理结论")].Text + "&recheckPerson=" + row.Cells[GetIndexOfColumn(gv, "复核人")].Text + "&recheckOperator=" +
                       row.Cells[GetIndexOfColumn(gv, "处理人")].Text;
        Response.Redirect("checkCaShang.aspx?testDateTime=" + row.Cells[GetIndexOfColumn(gv, "检测时间")].Text + "&carNo=" +
                          row.Cells[GetIndexOfColumn(gv, "车厢号")].Text + "&wheelPos=" + row.Cells[GetIndexOfColumn(gv, "位置")].Text.TrimEnd('位') + commPara);

    }
    private int GetIndexOfColumn(GridView gv, string fieldName)
    {
        foreach (DataControlField column in gv.Columns)
        {
            if (column.HeaderText == fieldName)
            {
                return gv.Columns.IndexOf(column);
            }
        }
        throw new Exception("GridView表不存在该列");
    }
    

}
