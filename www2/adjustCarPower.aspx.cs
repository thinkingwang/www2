﻿using System;
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
            GetBind(-1);
            var trainType = Request["trainType"];
            var trainNoFrom = Request["trainNoFrom"];
            var trainNoTo = Request["trainNoTo"];
            txt_trainType.Text = trainType;
            txt_startNo.Text = trainNoFrom;
            txt_endNo.Text = trainNoTo;
            txt_carNum.Text = "8";
        }
        var name = PUBS.GetUserDisplayName(Context.User.Identity.Name);
        LoginName2.FormatString = name;
    }

    protected void LoginStatus2_LoggedOut(object sender, EventArgs e)
    {
        Session.Remove("login");
        PUBS.Log(Request.UserHostAddress, Membership.GetUser().UserName, 0, this.GetType().FullName);
    }

    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {    
        GetBind(-1);
    }
    
    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GetBind(e.NewEditIndex);
        var sql =
            string.Format(
                "select powerType from CRH_Car where trainType='{0}' and trainNoFrom={2} and trainNoTo={3} and carPos={1}",
                GridView1.Rows[e.NewEditIndex].Cells[0].Text, GridView1.Rows[e.NewEditIndex].Cells[1].Text,
                GridView1.Rows[e.NewEditIndex].Cells[3].Text, GridView1.Rows[e.NewEditIndex].Cells[4].Text);
       var tb =  PUBS.sqlQuery(sql);
        var drop = GridView1.Rows[e.NewEditIndex].Cells[5].FindControl("ddl_powerType") as DropDownList;
        if (drop == null)
        {
            return;
        }
        if (tb != null)
        {
            drop.SelectedValue = tb.Rows[0]["powerType"].ToString();
        }
    }
    protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        var row = GridView1.Rows[e.RowIndex];
        var trainType = row.Cells[0].Text;
        var carPos = row.Cells[1].Text;
        var carNo = row.Cells[2].Controls[0] as TextBox;
        if (carNo == null) throw new ArgumentNullException("carNo");
        var trainNoFrom = row.Cells[3].Text;
        var trainNoTo = row.Cells[4].Text;
        var axleType = row.Cells[5].Controls[0] as TextBox;
        var dir = row.Cells[6].Controls[0] as CheckBox;
        var powerType = row.Cells[7].FindControl("ddl_powerType") as DropDownList;
        if (powerType != null&&axleType != null)
        {
            var txt = powerType.SelectedValue;
                PUBS.sqlQuery(
                    string.Format(
                        "update CRH_Car set carNo='{0}',axleType='{1}',dir={2},powerType='{3}' where trainType='{4}' and trainNoFrom={6} and trainNoTo={7} and carPos='{5}'",
                        carNo.Text, axleType.Text, dir != null && dir.Checked ? 1 : 0, txt, trainType, carPos, trainNoFrom, trainNoTo));
                var log = PUBS.GetLogContect(',', "更新车组车厢型号配置，车型，车厢序号,车厢号，轴类型，方向，动拖类型分别为：",
                      trainType, carPos, carNo.Text, axleType.Text, dir != null && dir.Checked ? "1" : "0", powerType.Text);
                PUBS.Log(Request.UserHostAddress, PUBS.GetCurrentUser(), 24, log);
        }
        GetBind(-1);
    }
   
    protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GetBind(-1);
    }
    private void GetBind(int index)
    {
        GridView1.EditIndex = index;
        using (
            var conn =
                new SqlConnection(
                    System.Configuration.ConfigurationManager.ConnectionStrings["tychoConnectionString"]
                        .ConnectionString))
        {
            var trainType = Request["trainType"];
            var trainNoFrom = Request["trainNoFrom"];
            var trainNoTo = Request["trainNoTo"];
            SqlCommand cmd = new SqlCommand() { Connection = conn };
            conn.Open();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText =
                string.Format("select * from CRH_Car where trainType='{0}' and trainNoFrom={1} and trainNoTo={2}",
                    trainType, trainNoFrom, trainNoTo);
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            var set = new DataSet();
            adapter.Fill(set);
            GridView1.DataSource = set;
            GridView1.DataBind();
        }
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
    }


   

    protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetBind(-1);
    }

    protected void NewTrainType_Click(object sender, EventArgs e)
    {
        var trainType = txt_trainType.Text;
        var carNum = Convert.ToInt32(txt_carNum.Text);
        var trainNoFrom = Convert.ToInt32(txt_startNo.Text);
        var trainNoTo = Convert.ToInt32(txt_endNo.Text);
        PUBS.sqlQuery(
            string.Format(
                "declare @carNum int set @carNum = {1} if(exists(select * from dbo.CRH_Car where trainType='{0}' and trainNoFrom={2} and trainNoTo={3}))" +
                " delete from dbo.CRH_Car where trainType='{0}'  and trainNoFrom={2} and trainNoTo={3} " +
                "while(@carNum>0) " +
                "begin " +
                "insert into dbo.CRH_Car (trainType,carPos,trainNoFrom,trainNoTo,dir) values('{0}',@carNum -1,{2},{3},0)" +
                " set @carNum = @carNum - 1 " +
                "end", trainType, carNum,trainNoFrom,trainNoTo));
        GetBind(-1);
        var log = PUBS.GetLogContect(',', "新增车组车厢型号配置，车型,车号开始数字，车号结束数字分别为：",
              trainType,trainNoFrom.ToString(),trainNoTo.ToString());
        PUBS.Log(Request.UserHostAddress, PUBS.GetCurrentUser(), 22, log);
    }

    protected void DeleteTrainBtn_OnClick(object sender, EventArgs e)
    {
        var trainType = Request["trainType"];
        if (string.IsNullOrEmpty(trainType))
        {
            return;
        }
        PUBS.sqlQuery(
            string.Format(
                "if(exists(select * from dbo.CRH_Car where trainType='{0}'))" +
                " delete from dbo.CRH_Car where trainType='{0}' " , trainType));
        GetBind(-1);
        var log = PUBS.GetLogContect(',', "删除车组车厢型号配置，车型为：",
              trainType);
        PUBS.Log(Request.UserHostAddress, PUBS.GetCurrentUser(), 23, log);
    }
    protected void bt_back_Click(object sender, EventArgs e)
    {
        Response.Redirect("DetectList.aspx");
    }
    protected void GridView1_DataBound(object sender, EventArgs e)
    {
        for (int i = 0; i <= GridView1.Rows.Count - 1; i++)
        {
            var label = GridView1.Rows[i].Cells[5].FindControl("lb_powerType") as Label;
            if (label == null)
            {
                continue;
            }
            if (label.Text == "0")
            {
                label.Text = "拖车";
                continue;
            }
            label.Text = "动车";
        }
    }
}
