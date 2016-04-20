using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using AjaxControlToolkit;

//using System.Xml.Linq;

public partial class Verify : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["login"] == null)
            Response.Redirect(PUBS.HomePage);
        var name = PUBS.GetUserDisplayName(Context.User.Identity.Name);
        LoginName2.FormatString = name;
        if (!Page.IsPostBack)
        {
            datepickerEnd.Text = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            datepickerStart.Text = DateTime.Now.AddDays(-7).ToString("yyyy-MM-dd HH:mm:ss");
            Panel1.Visible = false;
            Panel2.Visible = false;
            Panel3.Visible = false;
        }
        ScriptManager.RegisterStartupScript(Page, typeof(string), "reload", "reload();", true);
    }
    protected void LoginStatus2_LoggedOut(object sender, EventArgs e)
    {
        Session.Remove("login");
        PUBS.Log(Request.UserHostAddress, Membership.GetUser().UserName, 0, this.GetType().FullName);
    }

    /// <summary>
    /// 探伤全不选
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void UnSelectAllTsBtn_Click(object sender, EventArgs e)
    {

        foreach (ListItem item in CheckBoxList3.Items)
        {
            item.Selected = false;
        }
    }

    /// <summary>
    /// 擦伤全不选
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void UnSelectAllCsBtn_Click(object sender, EventArgs e)
    {
        foreach (ListItem item in CheckBoxList2.Items)
        {
            item.Selected = false;
        }
    }

    /// <summary>
    /// 外形全不选
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void UnSelectAllWhprBtn_Click(object sender, EventArgs e)
    {
        foreach (ListItem item in CheckBoxList1.Items)
        {
            item.Selected = false;
        }
    }
   
    
    protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GridView1.EditIndex = -1;
        Check();
    }
   

    protected void SelectAllWhprBtn_Click(object sender, EventArgs e)
    {
        foreach (ListItem item in CheckBoxList1.Items)
        {
            item.Selected = true;
        }
    }

    protected void SelectAllCsBtn_Click(object sender, EventArgs e)
    {
        foreach (ListItem item in CheckBoxList2.Items)
        {
            item.Selected = true;
        }
    }
    protected void SelectAllTsBtn_Click(object sender, EventArgs e)
    {
        foreach (ListItem item in CheckBoxList3.Items)
        {
            item.Selected = true;
        }
    }

    protected void CheckBtn_OnClick(object sender, EventArgs e)
    {
        Check();
    }

    private void Check()
    {
        GridView1.DataSource = null;
        Panel1.Visible = false;
        GridView1.DataBind();
        GridView2.DataSource = null;
        Panel2.Visible = false;
        GridView2.DataBind();
        GridView3.DataSource = null;
        Panel3.Visible = false;
        GridView3.DataBind();
        var engNum = DropDownList1.Text;
        var alarmLevel = DropDownList4.Text;
        var startTime = datepickerStart.Text;
        var endTime = datepickerEnd.Text;
        var carNo = DropDownList3.Text == "全部" ? "All" : DropDownList3.Text;
        var wheelPos = DropDownList2.Text == "全部" ? "All" : DropDownList2.SelectedValue;
        if (string.IsNullOrEmpty(startTime) || string.IsNullOrEmpty(endTime))
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "alert",
                "alert('" + "“开始时间”和“结束时间”不能为空！" + "');", true);
            return;
        }
        var itemsProfiles = from ListItem item in CheckBoxList1.Items
                            where item.Selected
                            select item.Text;
        var itemsCaShangs = from ListItem item in CheckBoxList2.Items
                            where item.Selected
                            select item.Text;
        var itemsTanShangs = from ListItem item in CheckBoxList3.Items
                             where item.Selected
                             select item.Text;
        var enumerable = itemsProfiles as IList<string> ?? itemsProfiles.ToList();
        if (enumerable.Any())
        {
            Panel1.Visible = true;
            StringBuilder profileFields = new StringBuilder();
            foreach (string profile in enumerable)
            {
                profileFields.Append(profile);
            }
            //外形报警数据绑定
            var sql = string.Format("exec dbo.GetAlarmDataForWaiXing '{0}' ,'{1}','{2}','{3}','{4}','{5}','{6}'",
                startTime,
                endTime, engNum, carNo, wheelPos, alarmLevel, profileFields);
            var tbWaixing =
                PUBS.sqlQuery(string.Format(
                    "exec dbo.GetAlarmDataForWaiXing '{0}' ,'{1}','{2}','{3}','{4}','{5}','{6}'", startTime,
                    endTime, engNum, carNo, wheelPos, alarmLevel, profileFields));
            if (tbWaixing != null && GridView1.Columns.Count <= 1)
            {
                foreach (DataColumn c in tbWaixing.Columns)
                {
                    if (c.ColumnName == "轴号"||c.ColumnName=="轮号")
                    {
                        continue;
                    }
                    BoundField cc = new BoundField(); //或者 CheckBoxField()
                    cc.HeaderText = c.ColumnName;
                    cc.DataField = c.ColumnName;
                    GridView1.Columns.Insert(GridView1.Columns.Count - 1, cc);
                }
                GridView1.DataKeyNames = new[] { "轴号", "轮号" };
            }
            GridView1.DataSource = tbWaixing;
            GridView1.DataBind();
        }
        if (itemsCaShangs.Any())
        {
            Panel3.Visible = true;
            //擦伤报警数据绑定
            var caTanshang = PUBS.sqlQuery(string.Format("exec dbo.GetAlarmDataForCaShang '{0}' ,'{1}','{2}','{3}','{4}','{5}'", startTime,
                endTime, engNum, carNo, wheelPos, alarmLevel));
            if (caTanshang != null && GridView3.Columns.Count <= 1)
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
                }
            GridView3.DataKeyNames = new[] { "轴号", "轮号" };
            GridView3.DataSource = caTanshang;
            GridView3.DataBind();
        }
        if (itemsTanShangs.Any())
        {
            Panel2.Visible = true;
            //探伤报警数据绑定
            var tbTanshang = PUBS.sqlQuery(string.Format("exec dbo.GetAlarmDataForTanShang '{0}' ,'{1}','{2}','{3}','{4}','{5}'", startTime,
                endTime, engNum, carNo, wheelPos, alarmLevel));
            if (tbTanshang != null && GridView2.Columns.Count <= 1)
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
            }
            GridView2.DataSource = tbTanshang;
            GridView2.DataBind();
        }

    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        var a = GridView1.PageIndex;
        var b = GridView1.PageSize;
    }
    private int GetIndexOfColumn(GridView gv,string fieldName)
    {
        foreach (DataControlField column in gv.Columns)
        {
            if (column.HeaderText == fieldName)
            {
                return gv.Columns.IndexOf(column);
            }
        }
        throw  new Exception("GridView表不存在该列");
    }

    private void BindCarNo()
    {
        var engNum = DropDownList1.Text;
        var tb = PUBS.sqlQuery(
            string.Format(
                "select carNo from carlist where testdatetime in(select top 1 A.testDatetime from Detect as A left join CarList as B on A.testDatetime=B.testDateTime where A.engNum='{0}' order by A.testDateTime desc)",
                engNum));
        var row = tb.NewRow();
        row[0] = "全部";
        tb.Rows.InsertAt(row, 0);
        DropDownList3.Items.Clear();
        DropDownList3.DataSource = tb;
        DropDownList3.DataBind();
    }
    protected void DropDownList1_PreRender(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DropDownList1.Items.Insert(0, new ListItem("全部", "All"));
            BindCarNo();
        }
    }
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindCarNo();
    }

   
    
   

    protected void DownloadBtn_OnClick(object sender, EventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            //调用导出方法  
            ExportGridViewForUTF8(GridView1, DateTime.Now.ToString("yyyyMMddHHmmssfff") + ".xls");
        }
        else
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "alert", "alert('" + "没有数据可导出，请先查询数据!" + "');", true);
            
            //obo.Common.MessageBox.Show(this, "没有数据可导出，请先查询数据!");
        }
    }

    /// <summary>  
    /// 重载，否则出现“类型“GridView”的控件“GridView1”必须放在具有 runat=server 的窗体标... ”的错误  
    /// </summary>  
    /// <param name="control"></param>  
    public override void VerifyRenderingInServerForm(Control control)
    {
        //base.VerifyRenderingInServerForm(control);  
    }

    /// <summary>  
    /// 导出方法  
    /// </summary>  
    /// <param name="GridView"></param>  
    /// <param name="filename">保存的文件名称</param>  
    private void ExportGridViewForUTF8(GridView GridView, string filename)
    {

        string attachment = "attachment; filename=" + filename;

        Response.ClearContent();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", attachment);

        Response.Charset = "UTF-8";
        Response.ContentEncoding = System.Text.Encoding.GetEncoding("UTF-8");
        Response.ContentType = "application/ms-excel";
        System.IO.StringWriter sw = new System.IO.StringWriter();

        HtmlTextWriter htw = new HtmlTextWriter(sw);
        GridView.RenderControl(htw);

        Response.Output.Write(sw.ToString());
        Response.Flush();
        Response.End();

    }

    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GridView1.EditIndex = e.NewEditIndex;
        Check();
    }



    protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        var row = GridView1.Rows[e.RowIndex];
        var combox = row.Cells[8].FindControl("cb_recheckPerson") as ComboBox;
        var recheckPerson = "";
        if (combox != null)
        {
            recheckPerson = combox.Text;
        }
        var operate = e.OldValues["处理人"] == null ? PUBS.GetUserDisplayName(Context.User.Identity.Name) : e.OldValues["处理人"].ToString();
        var sql = string.Format(
            "exec [dbo].[SetRecheck] '{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}','{10}'",
            row.Cells[1].Text, row.Cells[3].Text, row.Cells[4].Text, row.Cells[5].Text, row.Cells[6].Text
            , e.NewValues["复核值"], row.Cells[8].Text, recheckPerson, e.NewValues["处理意见"], operate, e.NewValues["备注"]);
        PUBS.sqlQuery(sql);
        GridView1.EditIndex = -1;
        Check();
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
                Response.Redirect("checkLjcha_zhou.aspx?testDateTime=" + row.Cells[1].Text + "&carNo=" +
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
    

    protected void btn_display_OnClick(object sender, EventArgs e)
    {
        if (btn_display.Text == "隐藏")
        {
            btn_display.Text = "显示";
            GridView1.Visible = false;
            return;
        }
        btn_display.Text = "隐藏";
        GridView1.Visible = true;
    }

    protected void btn_displayForTanShang_OnClick(object sender, EventArgs e)
    {
        if (btn_displayForTanShang.Text == "隐藏")
        {
            btn_displayForTanShang.Text = "显示";
            GridView2.Visible = false;
            return;
        }
        btn_displayForTanShang.Text = "隐藏";
        GridView2.Visible = true;
    }

    protected void btn_downloadTanShang_OnClick(object sender, EventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            //调用导出方法  
            ExportGridViewForUTF8(GridView2, DateTime.Now.ToString("yyyyMMddHHmmssfff") + ".xls");
        }
        else
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "alert", "alert('" + "没有数据可导出，请先查询数据!" + "');", true);

            //obo.Common.MessageBox.Show(this, "没有数据可导出，请先查询数据!");
        }
    }

    protected void btn_downloadCaShang_OnClick(object sender, EventArgs e)
    {
        if (GridView3.Rows.Count > 0)
        {
            //调用导出方法  
            ExportGridViewForUTF8(GridView3, DateTime.Now.ToString("yyyyMMddHHmmssfff") + ".xls");
        }
        else
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "alert", "alert('" + "没有数据可导出，请先查询数据!" + "');", true);

            //obo.Common.MessageBox.Show(this, "没有数据可导出，请先查询数据!");
        }
    }

    protected void btn_displayForCaShang_OnClick(object sender, EventArgs e)
    {
        if (btn_displayForCaShang.Text == "隐藏")
        {
            btn_displayForCaShang.Text = "显示";
            GridView3.Visible = false;
            return;
        }
        btn_displayForCaShang.Text = "隐藏";
        GridView3.Visible = true;
    }
}
