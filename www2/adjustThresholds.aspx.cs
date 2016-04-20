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
    public string datetimestr;
    public int axleNo;
    public int axleNum;
    public string bzh;
    public string carNo;
    public int wheelNo;
    public int wheelPos;
    public string[] sLevelStyle;
    public string sL1 = PUBS.Txt("I");
    public string sL2 = PUBS.Txt("II");
    public string sL3 = PUBS.Txt("III");
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["login"] == null)
            Response.Redirect(PUBS.HomePage);
        if (!IsPostBack)
        {
            using (
                var conn =
                    new SqlConnection(
                        System.Configuration.ConfigurationManager.ConnectionStrings["tychoConnectionString"]
                            .ConnectionString))
            {
                SqlCommand cmd = new SqlCommand() {Connection = conn};
                conn.Open();
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = string.Format("exec dbo.GetThresholds '{0}','{1}'", "default", "1");
                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                var set = new DataSet();
                adapter.Fill(set);
                GridView1.DataSource = set;
                GridView1.DataBind();
                cmd.CommandText = "SELECT DISTINCT [trainType] FROM [thresholds]";
                adapter = new SqlDataAdapter(cmd);
                set = new DataSet();
                adapter.Fill(set);
                DropDownList1.SelectedValue = "default";
                DropDownList2.SelectedValue = "1";
            }
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
    }
    protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        ICollection colKeys = e.NewValues.Keys;
        using (var conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["tychoConnectionString"].ConnectionString))
        {
            SqlCommand cmd = new SqlCommand() { Connection = conn };
            conn.Open();
            cmd.CommandType = CommandType.Text;
            var row = GridView1.Rows[e.RowIndex];
            var trainType = row.Cells[0].Text;
            var name = "";
            switch (row.Cells[2].Text) { 
                case "擦伤深度":
                    name = "CS_SD";
                    break;
                case "轮径":
                    name = "WX_LJ";
                    break;
                case "同编组轮径差":
                    name = "WX_LJC_B";
                    break;
                case "同车轮径差":
                    name = "WX_LJC_C";
                    break;
                case "同转向架轮径差":
                    name = "WX_LJC_J";
                    break;
                case "同轴轮径差":
                    name = "WX_LJC_Z";
                    break;
                case "轮辋宽度":
                    name = "WX_LWHD";
                    break;
                case "轮缘高度":
                    name = "WX_LYGD";
                    break;
                case "轮缘厚度":
                    name = "WX_LYHD";
                    break;
                case "内侧距":
                    name = "WX_NCJ";
                    break;
                case "QR值":
                    name = "WX_QR";
                    break;
                case "踏面磨耗":
                    name = "WX_TMMH";
                    break;
            }
            var desc = " ";
            var up3 = GetTextValue(row, "up3ck", "up3tbx");
            var up2 = GetTextValue(row, "up2ck", "up2tbx");
            var up1= GetTextValue(row, "up1ck", "up1tbx");
            var low3 = GetTextValue(row, "low3ck", "low3tbx");
            var low2 = GetTextValue(row, "low2ck", "low2tbx");
            var low1 = GetTextValue(row, "low1ck", "low1tbx");
            if (!up1.Equals("2000") && !up2.Equals("2000") && !low2.Equals("-1000") && !low1.Equals("-1000"))
            {
                desc = string.Format("大于{0}mm或小于{1}mm预警，大于{2}mm或小于{3}mm报警",
                    up2.Replace(".00", ""),
                    low2.Replace(".00", ""),
                    up1.Replace(".00", ""),
                    low1.Replace(".00", ""));
            }
            if (!up1.Equals("2000") && up2.Equals("2000") && !low2.Equals("-1000") && !low1.Equals("-1000"))
            {
                desc = string.Format("小于{0}mm预警，大于{1}mm或小于{2}mm报警",
                    low2.Replace(".00", ""),
                    up1.Replace(".00", ""),
                    low1.Replace(".00", ""));
            }
            if (up1.Equals("2000") && !up2.Equals("2000") && !low2.Equals("-1000") && !low1.Equals("-1000"))
            {
                desc = string.Format("大于{0}mm或小于{1}mm预警，小于{2}mm报警", Convert.ToString((object)up2),
                    low2.Replace(".00", ""),
                    low1.Replace(".00", ""));
            }
            if (up1.Equals("2000") && up2.Equals("2000") && !low2.Equals("-1000") && !low1.Equals("-1000"))
            {
                desc = string.Format("小于{0}mm预警，小于{1}mm报警", low2.Replace(".00", ""),
                    low1.Replace(".00", ""));
            }

            if (!up1.Equals("2000") && !up2.Equals("2000") && low2.Equals("-1000") && !low1.Equals("-1000"))
            {
                desc = string.Format("大于{0}mm预警，大于{1}mm或小于{2}mm报警",
                    up2.Replace(".00", ""),
                    up1.Replace(".00", ""),
                    low1.Replace(".00", ""));
            }
            if (!up1.Equals("2000") && !up2.Equals("2000") && !low2.Equals("-1000") && low1.Equals("-1000"))
            {
                desc = string.Format("大于{0}mm或小于{1}mm预警，大于{2}mm报警",
                    up2.Replace(".00", ""),
                    low2.Replace(".00", ""),
                    up1.Replace(".00", ""));
            }
            if (!up1.Equals("2000") && !up2.Equals("2000") && low2.Equals("-1000") && low1.Equals("-1000"))
            {
                desc = string.Format("大于{0}mm预警，大于{1}mm报警", up2.Replace(".00", ""),
                    up1.Replace(".00", ""));
            }


            if (!up1.Equals("2000") && up2.Equals("2000") && low2.Equals("-1000") && !low1.Equals("-1000"))
            {
                desc = string.Format("大于{0}mm或小于{1}mm报警", up1.Replace(".00", ""),
                    low1.Replace(".00", ""));
            }
            if (!up1.Equals("2000") && up2.Equals("2000") && !low2.Equals("-1000") && low1.Equals("-1000"))
            {
                desc = string.Format("小于{0}mm预警，大于{1}mm报警", low2.Replace(".00", ""),
                    up1.Replace(".00", ""));
            }
            if (!up1.Equals("2000") && up2.Equals("2000") && low2.Equals("-1000") && low1.Equals("-1000"))
            {
                desc = string.Format("大于{0}mm报警", up1.Replace(".00", ""));
            }


            if (up1.Equals("2000") && !up2.Equals("2000") && low2.Equals("-1000") && !low1.Equals("-1000"))
            {
                desc = string.Format("大于{0}mm预警，小于{1}mm报警", up2.Replace(".00", ""),
                    low1.Replace(".00", ""));
            }
            if (up1.Equals("2000") && !up2.Equals("2000") && !low2.Equals("-1000") && low1.Equals("-1000"))
            {
                desc = string.Format("大于{0}mm或小于{1}mm预警", up2.Replace(".00", ""),
                    low2.Replace(".00", ""));
            }
            if (up1.Equals("2000") && !up2.Equals("2000") && low2.Equals("-1000") && low1.Equals("-1000"))
            {
                desc = string.Format("大于{0}mm预警", up2.Replace(".00", ""));
            }


            if (up1.Equals("2000") && up2.Equals("2000") && low2.Equals("-1000") && !low1.Equals("-1000"))
            {
                desc = string.Format("小于{0}mm报警", low1.Replace(".00", ""));
            }
            if (up1.Equals("2000") && up2.Equals("2000") && !low2.Equals("-1000") && low1.Equals("-1000"))
            {
                desc = string.Format("小于{0}mm预警", low2.Replace(".00", ""));
            }
            desc = "'" + desc + "'";
            cmd.CommandText = string.Format("update thresholds set up_level3={0}, up_level2={1}, up_level1={2}, low_level3={3}," +
                " low_level2={4}, low_level1={5} ,[desc]={6} where [trainType]='{7}' and [name]='{8}'", up3, up2, up1, low3, low2, low1, desc, trainType, name);
            cmd.ExecuteNonQuery();
            foreach (var data in colKeys)
            {
                if (data.ToString() == "trainType" || data.ToString() == "name")
                {
                    continue;
                }
                var b = e.NewValues[data];
                if (b == null)
                {
                    continue;
                }
                switch (data.ToString())
                {
                    case "desc":
                        break;
                    case "powerType":
                        break;

                }
                if (data.ToString() == "desc")
                {
                    b = "'" + b + "'";
                }
                cmd.CommandText = string.Format("update thresholds set [{0}]={1} where [trainType]='{2}' and [name]='{3}'", data, b, trainType, name);
                cmd.ExecuteNonQuery();
            }
            var log = PUBS.GetLogContect(',', "更新阈值表，车型为：",
                  trainType);
            PUBS.Log(Request.UserHostAddress, PUBS.GetCurrentUser(), 27, log); 
        }
        GetBind(-1);
    }
    private static string GetTextValue(GridViewRow row, string ckId,string tbxId)
    {
        var up3 = "";
        CheckBox up3ck = row.FindControl(ckId) as CheckBox;
        TextBox up3tbx = row.FindControl(tbxId) as TextBox;
        if (up3ck.Checked || string.IsNullOrWhiteSpace(up3tbx.Text))
        {
            if (ckId.Contains("up"))
            {

                up3 = "2000";
            }
            else
            {
                up3 = "-1000";
            }
        }
        else
        {
            up3 = up3tbx.Text;
        }
        return up3;
    }
    protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GetBind(-1);
        //foreach (GridViewRow row in GridView1.Rows)
        //{
        //    if (row.RowType == DataControlRowType.DataRow)
        //    {
        //        DropDownList dpdListEstatus = row.FindControl("dpdListEstatus") as DropDownList;
        //        dpdListEstatus.Enabled = false;
        //    }
        //}
    }
    private void GetBind(int index)
    {
        using (var conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["tychoConnectionString"].ConnectionString))
        {
            SqlCommand cmd = new SqlCommand() { Connection = conn };
            conn.Open();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = string.Format("exec dbo.GetThresholds '{0}','{1}'", DropDownList1.Text, DropDownList2.Text);
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            var set = new DataSet();
            adapter.Fill(set);
            GridView1.DataSource = set;
            GridView1.EditIndex = index;//退出编辑状态
            GridView1.DataBind();
        } 
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            SetLevelValue(e, "up_level3","up3Value", "up3tbx", "up3ck");

            SetLevelValue(e, "up_level2", "up2Value", "up2tbx", "up2ck");
            SetLevelValue(e, "up_level1", "up1Value", "up1tbx", "up1ck");
            SetLevelValue(e, "low_level3", "low3Value", "low3tbx", "low3ck");
            SetLevelValue(e, "low_level2", "low2Value", "low2tbx", "low2ck");
            SetLevelValue(e, "low_level1", "low1Value", "low1tbx", "low1ck");
            //dpdListUp3.Enabled = false;
        }
        
    }

    private static void SetLevelValue(GridViewRowEventArgs e,string element,string valueId,string txtId,string ckId )
    {

        Label up3Value = e.Row.FindControl(valueId) as Label;
        if (up3Value == null)
        {
            var value = DataBinder.Eval(e.Row.DataItem, element).ToString();
            TextBox up3tbx = e.Row.FindControl(txtId) as TextBox;
            CheckBox up3ck = e.Row.FindControl(ckId) as CheckBox;
            if (value == "无")
            {
                up3ck.Checked = true;
                up3tbx.Visible = false;
            }
            else
            {
                up3tbx.Text = value;
            }
        }
        else
        {
            up3Value.Text = DataBinder.Eval(e.Row.DataItem, element).ToString();
        }
    }

    protected void cb_CheckedChanged(object sender, EventArgs e)
    {
        var ck = sender as CheckBox;
        if (ck == null) {
            return;
        }
        switch (ck.ID) {
            case "up3ck":
                checkChanged(ck, "up3tbx");
                break;
            case "up2ck":
                checkChanged(ck, "up2tbx");
                break;
            case "up1ck":
                checkChanged(ck, "up1tbx");
                break;
            case "low3ck":
                checkChanged(ck, "low3tbx");
                break;
            case "low2ck":
                checkChanged(ck, "low2tbx");
                break;
            case "low1ck":
                checkChanged(ck, "low1tbx");
                break;
        }
    }

    private void checkChanged(CheckBox ck,string tbxId)
    {
        var row = GridView1.Rows[GridView1.EditIndex];
        TextBox up3tbx = row.FindControl(tbxId) as TextBox;
        if (!ck.Checked)
        {
            up3tbx.Visible = true;
        }
        else
        {
            up3tbx.Visible = false;
        }
    }
    protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetBind(-1);
    }
    protected void NewTrainType_Click(object sender, EventArgs e)
    {
        var defaultThresholds = PUBS.sqlQuery(string.Format("select * from dbo.thresholds where trainType='{0}'", "default"));
        foreach (DataRow row in defaultThresholds.Rows)
        {
            row["trainType"] = trainTypeTxt.Text;
        }
        PUBS.BatchInsertIntoDataBase(defaultThresholds, "dbo.thresholds");
        SqlDataSource2.SelectCommand = "SELECT DISTINCT [trainType] FROM  [thresholds]";
        DropDownList1.Items.Add(trainTypeTxt.Text);
        DropDownList1.SelectedValue = trainTypeTxt.Text;
        var log = PUBS.GetLogContect(',', "增加车型阈值配置，车型为：",
              trainTypeTxt.Text);
        PUBS.Log(Request.UserHostAddress, PUBS.GetCurrentUser(), 25, log);
        GetBind(-1);
    }

    protected void DeleteTrainBtn_OnClick(object sender, EventArgs e)
    {
        PUBS.sqlQuery(string.Format("delete from dbo.thresholds where trainType='{0}'", DropDownList1.Text));
        DropDownList1.SelectedValue = "default";
        SqlDataSource2.SelectCommand = "SELECT DISTINCT [trainType] FROM  [thresholds]";
        DropDownList1.Items.Remove(trainTypeTxt.Text);
        var log = PUBS.GetLogContect(',', "删除车型阈值配置，车型为：",
              trainTypeTxt.Text);
        PUBS.Log(Request.UserHostAddress, PUBS.GetCurrentUser(), 26, log);
        GetBind(-1);
    }
    protected void NewTrainPowerType_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(DropDownList1.Text))
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "alert", "alert('" + "请先选择需要操作的车型" + "');", true);
            return;
        } 
        var defaultThresholds = PUBS.sqlQuery(string.Format("select * from dbo.thresholds where trainType='{0}'", DropDownList1.Text));
        foreach (DataRow row in defaultThresholds.Rows)
        {
            row["powerType"] = 0;
        }
        PUBS.BatchInsertIntoDataBase(defaultThresholds, "dbo.thresholds");
        SqlDataSource2.SelectCommand = "SELECT DISTINCT [trainType] FROM  [thresholds]";
        DropDownList1.Items.Add(trainTypeTxt.Text);
        DropDownList1.SelectedValue = trainTypeTxt.Text;
        var log = PUBS.GetLogContect(',', "新增车型阈值配置，车型为：",
              trainTypeTxt.Text);
        PUBS.Log(Request.UserHostAddress, PUBS.GetCurrentUser(), 25, log);
        GetBind(-1);
    }
    protected void DeleteTrainPowerType_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(DropDownList1.Text))
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "alert", "alert('" + "请先选择需要操作的车型" + "');", true);
            return;
        }
        var defaultThresholds = PUBS.sqlQuery(string.Format("select * from dbo.thresholds where trainType='{0}' and powerType=1", DropDownList1.Text));
        PUBS.sqlQuery(string.Format("delete from dbo.thresholds where trainType='{0}'", DropDownList1.Text));
        PUBS.BatchInsertIntoDataBase(defaultThresholds, "dbo.thresholds");
        SqlDataSource2.SelectCommand = "SELECT DISTINCT [trainType] FROM  [thresholds]";
        DropDownList1.Items.Add(trainTypeTxt.Text);
        DropDownList1.SelectedValue = trainTypeTxt.Text;
        var log = PUBS.GetLogContect(',', "删除车型阈值拖车配置，车型为：",
              trainTypeTxt.Text);
        PUBS.Log(Request.UserHostAddress, PUBS.GetCurrentUser(), 25, log);
        GetBind(-1);
    }
    protected void bt_back_Click(object sender, EventArgs e)
    {
        Response.Redirect("DetectList.aspx");
    }
}
