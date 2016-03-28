using System;
using System.Data;
using System.Configuration;
using System.Drawing;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Runtime.InteropServices;
using System.Text;
using System.IO;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Management;
using System.Runtime;

public static class PUBS
{
    //public static string TYPE = "客车";
    public static string TYPE = "动车";
    //public static string TYPE = "地铁";
    public static string VERSION = "V4.2.6.4";
    public static string HomePage = "/login.aspx";
    public static Dictionary<string, string> dic = new Dictionary<string, string>();
    public static string dataDisk = "D:\\";
    public static string[] LWXH = new string[9] { "", "①", "②", "③", "④", "⑤", "⑥", "⑦", "⑧" };
    public static string[] sLevel = new string[5] { "正常", "超限", "预警", "跟踪", "未检" };
    //是否显示三级报警的时间点切换时间点
    //在GetTrain和用GetCar中也有用到相应的时间
    public static DateTime DT_SP;
    /// <summary>
    /// 取到升级时间
    /// </summary>
    public static void GetUpgradeTime()
    {
        DataTable dt = sqlQuery("select dbo.GetUpgradeTime()");
        DT_SP = Convert.ToDateTime(dt.Rows[0][0].ToString());
    }

    /// <summary>
    /// 获取用户显示名
    /// </summary>
    /// <returns></returns>
    public static DataSet GetRoles()
    {
        using (
               var conn =
                   new SqlConnection(
                       System.Configuration.ConfigurationManager.ConnectionStrings["aspnetConnectionString"]
                           .ConnectionString))
        {
            SqlCommand cmd = new SqlCommand() { Connection = conn };
            conn.Open();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select distinct RoleName from dbo.aspnet_Roles ";
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            var set = new DataSet();
            adapter.Fill(set);
            return set;
        }
    }

    /// <summary>
    /// 获取用户权限级别
    /// </summary>
    /// <returns></returns>
    public static string GetRoleLevel(string roleName)
    {
        using (
               var conn =
                   new SqlConnection(
                       System.Configuration.ConfigurationManager.ConnectionStrings["aspnetConnectionString"]
                           .ConnectionString))
        {
            SqlCommand cmd = new SqlCommand() { Connection = conn };
            conn.Open();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = string.Format("select RoleLevel from aspnet_Roles where RoleName='{0}'", roleName);
            var reader = cmd.ExecuteReader();
            reader.Read();
            if (!reader.HasRows)
            {
                return "5级";
            }
            var roleLevel = reader[0].ToString();
            return roleLevel ;
        }
    } 
    /// <summary>
    /// 获取用户描述
    /// </summary>
    /// <returns></returns>
    public static string GetRoleDesc(string roleName)
    {
        using (
               var conn =
                   new SqlConnection(
                       System.Configuration.ConfigurationManager.ConnectionStrings["aspnetConnectionString"]
                           .ConnectionString))
        {
            SqlCommand cmd = new SqlCommand() { Connection = conn };
            conn.Open();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = string.Format("select Description from aspnet_Roles where RoleName='{0}'", roleName);
            var reader = cmd.ExecuteReader();
            reader.Read();
            if (!reader.HasRows)
            {
                return "";
            }
            var desc = reader[0].ToString();
            return desc ;
        }
    } 

    /// <summary>
    /// 获取用户权限
    /// </summary>
    /// <returns></returns>
    public static Tuple<List<string>,List<string>> GetRolePowerElements(string roleName)
    {
        using (
               var conn =
                   new SqlConnection(
                       System.Configuration.ConfigurationManager.ConnectionStrings["aspnetConnectionString"]
                           .ConnectionString))
        {
            Tuple<List<string>,List<string>> lists = new Tuple<List<string>, List<string>>(new List<string>(),new List<string>() );
            SqlCommand cmd = new SqlCommand() { Connection = conn };
            conn.Open();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = string.Format("select ElementId from aspnet_PageElementControl as A left join aspnet_RoleAndPageControl As B on A.Id = B.Id where B.RoleName='{0}' ", roleName);
            var reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                lists.Item1.Add(reader[0].ToString());
            }
            reader.Close();
            reader.Dispose();
            cmd.CommandText = string.Format("select ElementId from aspnet_PageElementControl where Id not in (select Id from aspnet_RoleAndPageControl where RoleName='{0}' ) ", roleName);
            reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                lists.Item2.Add(reader[0].ToString());
            }
            return lists ;
        }
    }

    /// <summary>
    /// 角色设置
    /// </summary>
    /// <returns></returns>
    public static void SetRole(string roleNameOld,string roleNameNew,string desc,string roleLevel,List<Tuple<string,bool>> userPowers )
    {
        using (
               var conn =
                   new SqlConnection(
                       System.Configuration.ConfigurationManager.ConnectionStrings["aspnetConnectionString"]
                           .ConnectionString))
        {
            SqlCommand cmd = new SqlCommand() { Connection = conn };
            conn.Open();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = string.Format("update aspnet_Roles set RoleName='{0}' ,Description='{1}',RoleLevel='{2}'  where RoleName='{3}'", roleNameNew, desc, roleLevel,roleNameOld);
            cmd.ExecuteNonQuery();
            foreach (var item in userPowers)
            {
                if (item.Item2)
                {
                    cmd.CommandText =
                        string.Format(
                            "declare @id nvarchar(50) select @id = Id from aspnet_PageElementControl where Name='{0}'" +
                            " if(not exists(select * from aspnet_RoleAndPageControl  where RoleName='{1}' and Id=@id )) " +
                            "insert into aspnet_RoleAndPageControl (RoleName,Id) values('{1}',@id)",
                            item.Item1, roleNameNew);
                    cmd.ExecuteNonQuery();
                    continue;
                }
                cmd.CommandText =
                    string.Format(
                        "declare @id nvarchar(50) select @id = Id from aspnet_PageElementControl where Name='{0}'" +
                        " if(exists(select * from aspnet_RoleAndPageControl  where RoleName='{1}' and Id=@id )) " +
                        "delete from aspnet_RoleAndPageControl where RoleName='{1}' and Id=@id",
                        item.Item1, roleNameNew);
                cmd.ExecuteNonQuery();
            }
        }
    }
    /// <summary>
    /// 获取用户显示名
    /// </summary>
    /// <returns></returns>
    public static DataSet GetUsers()
    {
        using (
               var conn =
                   new SqlConnection(
                       System.Configuration.ConfigurationManager.ConnectionStrings["aspnetConnectionString"]
                           .ConnectionString))
        {
            SqlCommand cmd = new SqlCommand() { Connection = conn };
            conn.Open();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select UserName from aspnet_users";
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            var set = new DataSet();
            adapter.Fill(set);
            return set;
        }
    }

    /// <summary>
    /// 获取用户显示名
    /// </summary>
    /// <param name="userName"></param>
    /// <returns></returns>
    public static string GetUserDisplayName(string userName)
    {
        using (
            SqlConnection sqlConnection =
                new SqlConnection(ConfigurationManager.ConnectionStrings["aspnetConnectionString"].ConnectionString))
        {
            sqlConnection.Open();
            SqlCommand sqlCommand = new SqlCommand();
            sqlCommand.CommandType = System.Data.CommandType.Text;
            sqlCommand.Connection = sqlConnection;
            sqlCommand.CommandText = string.Format("select DisplayName from dbo.aspnet_Users where UserName='{0}'",
                userName);
            var reader = sqlCommand.ExecuteReader();
            reader.Read();
            if (!reader.HasRows)
            {
                return userName;
            }
            var displayName = reader[0].ToString();
            sqlCommand.Dispose();
            sqlConnection.Close();
            sqlConnection.Dispose();
            if (string.IsNullOrEmpty(displayName))
            {
                return userName;
            }
            return displayName;
        }
    }

    /// <summary>
    /// 更改用户显示名
    /// </summary>
    /// <param name="userName"></param>
    /// <param name="displayName"></param>
    public static void ChangeUserDisplay(string userName,string displayName)
    {
        using (
          SqlConnection sqlConnection =
              new SqlConnection(ConfigurationManager.ConnectionStrings["aspnetConnectionString"].ConnectionString))
        {
            sqlConnection.Open();
            SqlCommand sqlCommand = new SqlCommand
            {
                CommandType = System.Data.CommandType.Text,
                Connection = sqlConnection,
                CommandText = string.Format("update dbo.aspnet_Users set DisplayName='{0}' where UserName='{1}'",
                    displayName, userName)
            };
            sqlCommand.ExecuteNonQuery();
            sqlCommand.Dispose();
            sqlConnection.Close();
            sqlConnection.Dispose();
        }
    }
    public static void LogVersion()
    {
        try
        {
            sqlRun(string.Format("exec SetVersion '客户端Web', '{0}'", GetVersionStr()));
            sqlRun("declare @s varchar(50);select @s = dbo.GetdatabaseVersion();exec SetVersion '数据库', @s;");
        }
        catch { } //某些地方数据库没有升级
    }

    /// <summary>
    /// 取版本号字串
    /// </summary>
    /// <returns></returns>
    public static string GetVersionStr()
    {
        var temp = System.Web.HttpContext.Current.Application["DELAYMINUTE"] ?? 0;
        int DELAYMINUTE = int.Parse(temp.ToString());
        string dv;
        if (DELAYMINUTE == 0)
            dv = "";
        else
            dv = " D" + DELAYMINUTE.ToString();

        return VERSION + dv + " " + TYPE;
    }
    public static string OutputFoot(string sPath)
    {
        string ret;//, S;
        //if (PUBS.HomePage.Contains("?"))
        //    S = "&";
        //else
        //    S = "?";

        ret = "<div class=\"logo\"><img  alt=\"Tycho\" src=\"" + sPath + "image/tycho.jpg\" /><span>" + Txt("南京拓控信息科技有限公司") + " " + GetVersionStr() + "   <a href=\"/font.htm\" class=\"whitelink\">" + Txt("相关下载") + "</a></span></div>";
        //ret = "<div class=\"logo\"><img  alt=\"Tycho\" src=\"" + sPath + "image/tycho.jpg\" /><span>" + Txt("南京宝聚信息技术有限公司") + " V1.0 " + TYPE + "   <a href=\"/font.htm\" class=\"whitelink\">" + Txt("相关下载") + "</a></span></div>";
        //ret = "<div class=\"logo\"><img  alt=\"Tycho\" src=\"" + sPath + "image/tycho.jpg\" /><span>" + Txt("南京拓控信息科技有限公司") + " V1.0 " + TYPE + "   <a href=\"/font.htm\" class=\"whitelink\">" + Txt("相关下载") + "</a></span></div>";
        return ret;

    }
    /// <summary>
    /// 有延时倒计时的头部
    /// </summary>
    /// <param name="sPath"></param>
    /// <param name="testdatetime"></param>
    /// <returns></returns>
    public static string OutputHead(string sPath, DateTime testdatetime)
    {
        int v = GetRemainSecond(testdatetime);
        if ((v == 0) || !isTychoAdmin())//已过期或者不是TychoAdmin
            return OutputHead(sPath);

        string ret = "<div class=\"banner1\">";
        ret += "<img src=\"" + sPath + "image/title.jpg\" />";
        ret += string.Format("<span id=\"second\" class=\"title3\">{0}</span>", v);
        ret += "</div>\r\n";

        return ret;
    }
    /// <summary>
    /// 普通头部
    /// </summary>
    /// <param name="sPath"></param>
    /// <returns></returns>
    public static string OutputHead(string sPath)
    {
        string ret = "<div class=\"banner1\">" +
            "<img src=\"" + sPath + "image/title.jpg\" /></div>";
        ret += "\r\n";

        return ret;
    }
    /// <summary>
    /// 取当前登录用户级别
    /// 共有管理员 操作员 游客 三个级别 0 1 2
    /// 上级包含下级，不重叠
    /// </summary>
    /// <returns></returns>
    public static int GetUserLevel()
    {
        string[] sl = Roles.GetRolesForUser();
        try
        {
            if (sl[0] == "管理员")
                return 0;
            else if (sl[0] == "操作员")
                return 1;
        }
        catch
        { }

        return 2;
    }
    /// 是否是ＴＹＣＨＯ内部管理员帐号
    /// </summary>
    /// <returns>true=是</returns>
    public static bool isTychoAdmin()
    {
        return (Membership.GetUser().UserName.ToLower() == "njtycho");
    }
    /// <summary>
    /// 获取剩余延时时间　秒数
    /// </summary>
    /// <param name="dt">检测时间</param>
    /// <returns>剩余秒数</returns>
    public static int GetRemainSecond(DateTime dt)
    {
        int ret = 0;
        var temp = System.Web.HttpContext.Current.Application["DELAYMINUTE"] ?? 0;
        int iDelay = int.Parse(temp.ToString());
        DateTime dtEnd = dt.AddMinutes(iDelay);
        DateTime dtNow = DateTime.Now;
        if (dtEnd > dtNow)
        {
            TimeSpan ts1 = new TimeSpan(dtEnd.Ticks);
            TimeSpan ts2 = new TimeSpan(dtNow.Ticks);
            TimeSpan ts = ts1.Subtract(ts2).Duration();
            ret = (int)ts.TotalSeconds;
        }
        return ret;
    }
    /// <summary>
    /// 初始化数据源
    /// </summary>
    public static string IniListDataSource(bool isAll)
    {
        //延时显示结果
        string ret;
        var temp = System.Web.HttpContext.Current.Application["DELAYMINUTE"] ?? 0;
        int iDelay = int.Parse(temp.ToString());

        temp = System.Web.HttpContext.Current.Application["BZH_Start"] ?? "";
        string sStart = temp.ToString();

        temp = System.Web.HttpContext.Current.Application["MinAxleNum"] ?? "1";
        int iMinAxleNum = 1;
        int.TryParse(temp.ToString(), out iMinAxleNum);

        string sAll = "";

        if (!isAll)
        {
            //可以有多个，如　CRH;CJ
            string[] ss = sStart.Split(';');
            foreach (string s in ss)
            {
                if (s.Trim() != "")
                {
                    if (sAll != "")
                        sAll += "or ";
                    sAll += string.Format("engNum like '{0}%' ", s);
                }
            }

            if (sAll != "")
                sAll = "and (" + sAll + ")";

            sAll = " and axleNum > " + iMinAxleNum.ToString();
        }
        if ((iDelay > 0) && (!PUBS.isTychoAdmin()))
        {

            //1.时间符合　2.强制放行　3.单轮对　4.全部正常
            ret = string.Format("SELECT * FROM [V_Detect_kc] where ((testdatetime <dateadd(minute, -{0}, getdate())) or (isShow=1) or (AxleNum=1) or (s_level_ts='正常' and s_level_cs='正常' and s_level_M_LJ='正常' and s_level_M_TmMh='正常' and s_level_M_LyHd='正常' and s_level_M_LwHd='正常' and s_level_M_Ncj='正常')) {1} ORDER BY [testDateTime] DESC", iDelay, sAll);

        }
        else
        {
            ret = string.Format("SELECT * FROM [V_Detect_kc] where 1=1 {0} ORDER BY [testDateTime] DESC", sAll);
        }
        return ret;
    }
    /// <summary>
    /// 通过字典，进行文字转换，如果字典中没有返回原文字
    /// </summary>
    /// <param name="str">源字串</param>
    /// <returns>转换结果</returns>
    public static string Txt(string str)
    {
        if (dic.ContainsKey(str))
            return dic[str];
        else
            return str;
    }
    public static void Log(string sIP, string sName, int iOP, string sData)
    {
        try
        {
            sqlRun(string.Format("insert into log values('{0}', '{1}', '{2}', {3}, '{4}')", DateTime.Now.ToShortDateString() + " " + DateTime.Now.ToLongTimeString(), sName, sIP, iOP, sData));
        }
        catch
        { }
    }
    public static void sqlRun(string sqlCmd)
    {
        SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["tychoConnectionString"].ConnectionString);
        sqlConnection.Open();
        SqlCommand sqlCommand = new SqlCommand();
        sqlCommand.CommandType = System.Data.CommandType.Text;
        sqlCommand.Connection = sqlConnection;
        sqlCommand.CommandText = sqlCmd;
        sqlCommand.ExecuteNonQuery();
        sqlCommand.Dispose();
        sqlConnection.Close();
        sqlConnection.Dispose();
    }
    //public static　DataTable sqlGetDataProc(string sqlCmd, string p1)
    //{
    //    DataTable dt;
    //    SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["tychoConnectionString"].ConnectionString);
    //    sqlConnection.Open();
    //    SqlCommand sqlCommand = new SqlCommand();
    //    sqlCommand.CommandType = System.Data.CommandType.StoredProcedure;
    //    sqlCommand.Connection = sqlConnection;
    //    sqlCommand.CommandText = sqlCmd;
    //    sqlCommand.Parameters.Add("@carNo", SqlDbType.VarChar).Value = p1;
    //    SqlDataReader rd = sqlCommand.ExecuteReader();
    //    dt = ConvertDataReaderToDataTable(rd);
    //    sqlCommand.Dispose();
    //    sqlConnection.Close();
    //    sqlConnection.Dispose();
    //    return dt;
    //}
    public static DataTable sqlQuery(string strSql)
    {
        try
        {
            SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["tychoConnectionString"].ConnectionString);
            SqlDataAdapter sqlCmd = new SqlDataAdapter(strSql, sqlConnection);
            DataTable myDt = new DataTable();
            myDt.TableName = "result";
            sqlCmd.Fill(myDt);
            sqlCmd.Dispose();
            sqlConnection.Close();
            sqlConnection.Dispose();
            return myDt;
        }
        catch
        {
            return null;
        }

    }

    public static void BatchInsertIntoDataBase(DataTable table,string dataBase)
    {
        SqlBulkCopy sqlbulkcopy =
            new SqlBulkCopy(ConfigurationManager.ConnectionStrings["tychoConnectionString"].ConnectionString,
                SqlBulkCopyOptions.UseInternalTransaction) { DestinationTableName = dataBase };

        //数据库中的表名

        sqlbulkcopy.WriteToServer(table);
        sqlbulkcopy.Close();
    }

    public static DataTable ConvertDataReaderToDataTable(SqlDataReader dataReader)
    {
        DataTable datatable = new DataTable("DataTable");
        DataTable schemaTable = dataReader.GetSchemaTable();
        //动态添加列
        try
        {

            foreach (DataRow myRow in schemaTable.Rows)
            {
                DataColumn myDataColumn = new DataColumn();
                myDataColumn.DataType = myRow["DataTypeName"].GetType();
                myDataColumn.ColumnName = myRow[0].ToString();
                datatable.Columns.Add(myDataColumn);
            }
            //添加数据
            while (dataReader.Read())
            {
                DataRow myDataRow = datatable.NewRow();
                for (int i = 0; i < schemaTable.Rows.Count; i++)
                {
                    myDataRow[i] = dataReader[i].ToString();
                }
                datatable.Rows.Add(myDataRow);
                myDataRow = null;
            }
            schemaTable = null;
            dataReader.Close();
            return datatable;
        }
        catch (Exception ex)
        {
            //Error.Log(ex.ToString());
            throw new Exception("转换出错!", ex);
        }

    }
    public static bool ColorBug(ref TableCell cell)
    {
        bool ret = false;
        string s = cell.Text.Trim();
        if (s == "1")
        {
            //cell.BackColor = Color.Red;
            cell.ForeColor = Color.Red;
            cell.Text = Txt("I");
            cell.Font.Bold = true;
            ret = true;
        }
        else if (s == "2")
        {
            //cell.BackColor = Color.Yellow;
            cell.ForeColor = Color.Gold;//.Yellow;
            cell.Text = Txt("II");
            cell.Font.Bold = true;
            ret = true;
        }
        else if (s == "3")
        {
            //2015.05 开始三级不再报警

            //cell.BackColor = Color.Blue;
            //cell.ForeColor = Color.White;
            cell.ForeColor = Color.MediumSeaGreen;
            cell.Text = Txt("III");
            //cell.Font.Bold = true;
            //ret = true;
        }
        else if (s == "4")
        {
            //cell.BackColor = Color.LightGoldenrodYellow;
            //cell.ForeColor = Color.Black;//.White;
            cell.ForeColor = Color.MediumSeaGreen;
            cell.Text = Txt("正常");
        }
        else if (s == "正常")
        {
            //cell.BackColor = Color.MediumSeaGreen;
            cell.ForeColor = Color.MediumSeaGreen;
            cell.Text = Txt("正常");
        }
        else if (s == "正常*")
        {
            //cell.BackColor = Color.MediumSeaGreen;
            cell.ForeColor = Color.MediumSeaGreen;
            cell.Text = Txt("正常*");
        }
        else if (s == "无效")
        {
            //cell.BackColor = Color.DarkGray;
            cell.Text = Txt("无效");
        }
        else if (s == "停车")
        {
            //cell.BackColor = Color.DarkGray;
            cell.Text = Txt("停车");
        }
        else if  (s == "缺数")
        {
            //cell.BackColor = Color.DarkGray;
            cell.Text = Txt("缺数");
        }
        return ret;
    }
    /// <summary>
    /// 为显示以前的三级报警数据，保留旧版
    /// </summary>
    /// <param name="cell"></param>
    /// <returns></returns>
    public static bool ColorBug_OldVersion(ref TableCell cell)
    {
        bool ret = false;
        string s = cell.Text.Trim();
        if (s == "1")
        {
            //cell.BackColor = Color.Red;
            cell.ForeColor = Color.Red;
            cell.Text = Txt("I");
            cell.Font.Bold = true;
            ret = true;
        }
        else if (s == "2")
        {
            //cell.BackColor = Color.Yellow;
            cell.ForeColor = Color.Gold;//.Yellow;
            cell.Text = Txt("II");
            cell.Font.Bold = true;
            ret = true;
        }
        else if (s == "3")
        {
            //cell.BackColor = Color.Blue;
            //cell.ForeColor = Color.White;
            cell.ForeColor = Color.Blue;
            cell.Text = Txt("III");
            cell.Font.Bold = true;
            ret = true;
        }
        else if (s == "4")
        {
            //cell.BackColor = Color.LightGoldenrodYellow;
            //cell.ForeColor = Color.Black;//.White;
            cell.ForeColor = Color.MediumSeaGreen;
            cell.Text = Txt("正常");
        }
        else if (s == "正常")
        {
            //cell.BackColor = Color.MediumSeaGreen;
            cell.ForeColor = Color.MediumSeaGreen;
            cell.Text = Txt("正常");
        }
        else if (s == "正常*")
        {
            //cell.BackColor = Color.MediumSeaGreen;
            cell.ForeColor = Color.MediumSeaGreen;
            cell.Text = Txt("正常*");
        }
        else if (s == "无效")
        {
            //cell.BackColor = Color.DarkGray;
            cell.Text = Txt("无效");
        }
        else if (s == "停车")
        {
            //cell.BackColor = Color.DarkGray;
            cell.Text = Txt("停车");
        }
        else if (s == "缺数")
        {
            //cell.BackColor = Color.DarkGray;
            cell.Text = Txt("缺数");
        }
        return ret;
    }

    public static void ColorBug(ref TableCell cell, Color color)
    {
        string s = cell.Text.Trim();

        if (s == "正常")
        { cell.BackColor = Color.MediumSeaGreen; }
        else if (s == "无效")
        { cell.BackColor = Color.DarkGray; }
        else
        {
            cell.BackColor = color;
        }
    }
    public static string GetTrainInfo(string strTestDateTime)
    {
        DataTable dt = PUBS.sqlQuery(string.Format("select bzh from v_detect_kc where testDateTime='{0}'", strTestDateTime));
        if (dt.Rows.Count > 0)
            return (dt.Rows[0]["bzh"].ToString());
        else
            return "";

    }
    public static string GetCarInfo(string datetimestr, int axleNo)
    {
        DataTable dt = PUBS.sqlQuery(string.Format("select * from carlist where testDateTime='{0}' and posno ={1}", datetimestr, axleNo / 4));
        if (dt.Rows.Count > 0)
            return (dt.Rows[0]["carNo"].ToString());
        else
            return "";

    }
    public static void GetProfileStatus(string trainType, string name, string strValue, out int updown, out string desc)
    {
        //默认动车厢
        GetProfileStatus(trainType, 1, name, strValue, out updown, out desc);
    }

    public static void GetProfileStatus(string trainType, int powerType, string name, string strValue, out int updown,  out string desc)
    {
        DataTable dt = PUBS.sqlQuery(string.Format("select * from thresholds where  trainType='{1}' and  name='{0}' and powerType={2}", name, trainType, powerType));
        if (dt.Rows.Count == 0)
        {
            GetProfileStatus("default", name, strValue, out updown, out desc);//default 一定是有的
            return;
        }
        desc = dt.Rows[0]["desc"].ToString();
        if (strValue == "-")
        {
            updown = 0;
            return;
        }
        double value = double.Parse(strValue);

        if (value > double.Parse(dt.Rows[0]["up_level1"].ToString()))
        {
            updown = 1;
        }
        else if (value > double.Parse(dt.Rows[0]["up_level2"].ToString()))
        {
            updown = 1;
        }
        else if (value < double.Parse(dt.Rows[0]["low_level1"].ToString()))
        {
            updown = -1;
        }
        else if (value < double.Parse(dt.Rows[0]["low_level2"].ToString()))
        {
            updown = -1;
        }

        else
        {
            updown = 0;
        }
    }

    //public static void GetProfileStatus(string name, string  strValue, out int updown, out int level, out string desc)
    //{
    //    DataTable dt = PUBS.sqlQuery(string.Format("select * from thresholds where name='{0}'", name));
    //    desc = dt.Rows[0]["desc"].ToString();
    //    if (strValue == "-")
    //    {
    //        updown = 0;
    //        level = 4;
    //        return;
    //    }
    //    double value = double.Parse(strValue);

    //    if (value > double.Parse(dt.Rows[0]["up_level1"].ToString()))
    //    {
    //        updown = 1;
    //        level = 1;
    //    }
    //    else if (value > double.Parse(dt.Rows[0]["up_level2"].ToString()))
    //    {
    //        updown = 1;
    //        level = 2;
    //    }
    //    //else if (value > double.Parse(drs[0]["up_level3"].ToString()))
    //    //{
    //    //    updown = 1;
    //    //    level = 3;
    //    //}
    //    else if (value < double.Parse(dt.Rows[0]["low_level1"].ToString()))
    //    {
    //        updown = -1;
    //        level = 1;
    //    }
    //    else if (value < double.Parse(dt.Rows[0]["low_level2"].ToString()))
    //    {
    //        updown = -1;
    //        level = 2;
    //    }
    //    //else if (value < double.Parse(drs[0]["low_level3"].ToString()))
    //    //{
    //    //    updown = -1;
    //    //    level = 3;
    //    //}
    //    else
    //    {
    //        updown = 0;
    //        level = 0;
    //    }
    //}

    [DllImport("kernel32.dll")]
    public static extern bool GetDiskFreeSpaceEx(
    string lpDirectoryName,
    out UInt64 lpFreeBytesAvailable,
    out UInt64 lpTotalNumberOfBytes,
    out UInt64 lpTotalNumberOfFreeBytes);

    static ulong freeBytesAvailable = 0;
    static ulong totalNumberOfBytes = 0;
    static ulong totalNumberOfFreeBytes = 0;
    public static string GetDiskStatus(string data_Disk, ref int level)
    {
        string ret = "";
        GetDiskFreeSpaceEx(data_Disk, out freeBytesAvailable, out totalNumberOfBytes, out totalNumberOfFreeBytes);

        double freeG = freeBytesAvailable / 1024.0 / 1024 / 1024;
        //ret = string.Format("{0:F1} GB Free ({1:F2}%)", freeG, 100.0 * freeBytesAvailable / totalNumberOfBytes);
        ret = string.Format("{0:F1} GB", freeG);

        if (freeG > 5 ) //5G
            level = 3;
        else if (freeBytesAvailable > 1) //5G
            level = 2;
        else
            level = 1;

        return ret;
    }
    public static double GetDiskStatus(string data_Disk)
    {
        GetDiskFreeSpaceEx(data_Disk, out freeBytesAvailable, out totalNumberOfBytes, out totalNumberOfFreeBytes);

        double freeG = freeBytesAvailable / 1024.0 / 1024 / 1024;

        return freeG;
    }
}
/// <summary>
/// 存放打印单探头报告的数据
/// </summary>
public class PRN_DETECTOR
{
    public DateTime testDateTime;
    public string engName;
    public string engNo;
    public double inSpeed;                   //进线速度
    public double outSpeed;                  //离线速度
    public double waterTemp;                 //水温
    public double temperature;               //气温
    public double WheelSize;               //轮径

    public int detectorNo;                  //探头编号
    public string detectorType;              //探头类别
    public string bugPos;                    //缺陷位置
    public double bugDeep;                     //深度

    public string result;               

    public string imageFile;
    public string wheelFile;

}
/// <summary>
/// 存放打印轮缘的数据
/// </summary>
public class PRN_RIM
{
    public DateTime testDateTime;
    public string engName;
    public string engNo;
    public double mh_left;                  //左轮磨耗
    public double mh_right;                 //右轮磨耗
    public double hd_left;                  //左轮厚度
    public double hd_right;                 //右轮厚度
    public double inside_len;               //内侧距

    public DataTable dt_wheel_info;
    public string result;
    public string imageFile_left;
    public string wheelFile_right;

    public PRN_RIM()
    {
        dt_wheel_info = new DataTable();

        DataColumn info = new DataColumn();
        info.DataType = System.Type.GetType("System.String");
        info.ColumnName = "info";
        dt_wheel_info.Columns.Add(info);

    }
}
/// <summary>
/// 存放打印单轮报告的数据
/// </summary>
public class PRN_WHEEL
{
    public DateTime testDateTime;
    public string engName;
    public string engNo;
    public double inSpeed;                  //进线速度
    public double outSpeed;                 //离线速度
    public double waterTemp;                //水温
    public double temperature;              //气温
    public double WheelSize;                //轮径
    public string bugPos;                    //缺陷位置

    public DataTable dt_wheel_info;
    public string result;           
    public string imageFile;
    public string wheelFile;

    public PRN_WHEEL()
    {
        dt_wheel_info = new DataTable();

        DataColumn info = new DataColumn();
        info.DataType = System.Type.GetType("System.String");
        info.ColumnName = "info";
        dt_wheel_info.Columns.Add(info);

    }
}
public class PRN_WHEEL_DETAIL
{
    public string info;                 //缺陷信息
}
/// <summary>
/// 存放打印整车报告的数据
/// </summary>
public class PRN_ALL
{
    public DateTime testDateTime;
    public string engName;
    public string engNo;
    public double inSpeed;                  //进线速度
    public double outSpeed;                 //离线速度
    public double waterTemp;                //水温
    public double temperature;              //气温
    public double WheelSize;                //轮径

    public DataTable dt_wheel_info;
    //public string[] L_info;                 //左轮信息
    //public string[] R_info;                 //右轮信息
    public string Result_info;            //右轮信息

    public PRN_ALL()
    {
        dt_wheel_info = new DataTable();

        DataColumn Type_AlexNo = new DataColumn();
        Type_AlexNo.DataType = System.Type.GetType("System.Int32");
        Type_AlexNo.Unique = true;
        Type_AlexNo.ColumnName = "AlexNo";
        //idColumn.AutoIncrement = true;
        dt_wheel_info.Columns.Add(Type_AlexNo);

        DataColumn Type_L_info = new DataColumn();
        Type_L_info.DataType = System.Type.GetType("System.String");
        Type_L_info.ColumnName = "L_info";
        dt_wheel_info.Columns.Add(Type_L_info);

        DataColumn Type_R_info = new DataColumn();
        Type_R_info.DataType = System.Type.GetType("System.String");
        Type_R_info.ColumnName = "R_info";
        dt_wheel_info.Columns.Add(Type_R_info);

        DataColumn[] keys = new DataColumn[1];
        keys[0] = Type_AlexNo;
        dt_wheel_info.PrimaryKey = keys;

    }
}
public class PRN_ALL_DETAIL
{
    public int  AlexNo;

    public string L_info;                 //左轮信息
    public string R_info;                 //右轮信息

}
public class PRN_image
{
    public byte[] imageData;
    public byte[] wheelData;

}

public class rptTest
{
    public static DataTable ImageTable(string ImageFile, string WheelFile)
    {
        DataTable data = new DataTable();
        DataRow row;
        data.TableName = "Images";
        data.Columns.Add("imageData", System.Type.GetType("System.Byte[]"));
        data.Columns.Add("wheelData", System.Type.GetType("System.Byte[]"));
        FileStream fs = new FileStream(ImageFile, FileMode.Open);
        BinaryReader br = new BinaryReader(fs);
        FileStream fs2 = new FileStream(WheelFile, FileMode.Open);
        BinaryReader br2 = new BinaryReader(fs2);
        row = data.NewRow();
        row["imageData"] = br.ReadBytes((int)br.BaseStream.Length);
        row["wheelData"] = br2.ReadBytes((int)br2.BaseStream.Length);
        data.Rows.Add(row);
        br = null;
        fs.Close();
        fs = null;
        br2 = null;
        fs2.Close();
        fs2 = null;
        return data;
    }
}
/// <summary>
/// Create a New INI file to store or load data
/// </summary>
public class IniFile
{
    public string path;
    [DllImport("kernel32")]
    private static extern long WritePrivateProfileString(string section,
        string key, string val, string filePath);
    [DllImport("kernel32")]
    private static extern int GetPrivateProfileString(string section,
                string key, string def, StringBuilder retVal,
                int size, string filePath);

    /// <summary>
    /// INIFile Constructor.
    /// </summary>
    /// <PARAM name="INIPath"></PARAM>
    public IniFile(string INIPath)
    {
        path = INIPath;
    }
    /// <summary>
    /// Write Data to the INI File
    /// </summary>
    /// <PARAM name="Section"></PARAM>
    /// Section name
    /// <PARAM name="Key"></PARAM>
    /// Key Name
    /// <PARAM name="Value"></PARAM>
    /// Value Name
    public void IniWriteValue(string Section, string Key, string Value)
    {
        WritePrivateProfileString(Section, Key, Value, this.path);
    }

    /// <summary>
    /// Read Data Value From the Ini File
    /// </summary>
    /// <PARAM name="Section"></PARAM>
    /// <PARAM name="Key"></PARAM>
    /// <PARAM name="Path"></PARAM>
    /// <returns></returns>
    public string IniReadValue(string Section, string Key, string DefaultVal)
    {
        StringBuilder temp = new StringBuilder(255);
        int i = GetPrivateProfileString(Section, Key, DefaultVal, temp, 255, this.path);
        return temp.ToString();
    }

}

public class PrnWhmsWheel
{
    public string testDateTime;
    public string trainInfo;
    public int powerType;
    public string carInfo;
    public string carIndex;
    public string axleIndex;
    public string pos;
    public string v_wheelSize;
    public string v_LJC_Z;
    public string v_LJC_J;
    public string v_LJC_C;
    public string v_LJC_B;
    public string v_tmmh;
    public string v_lyhd;
    public string v_lygd;
    public string v_lwhd;
    public string v_qr;
    public string v_ncj;
    public string image;
    public int l_wheelSize;
    public int l_LJC_Z;
    public int l_LJC_J;
    public int l_LJC_C;
    public int l_LJC_B;
    public int l_tmmh;
    public int l_lyhd;
    public int l_lygd;
    public int l_lwhd;
    public int l_qr;
    public int l_ncj;


}

public class ZhParam
{
    private byte[] _datas;
    private string _strKL = "开路";
    private string _strDL = "短路";
    public int scDeep = 0;
    public byte[] datas
    {
        get
        {
            return _datas;
        }
    }
    /// <summary>
    /// 系统状态
    /// </summary>
    public string SysStatus
    {
        get
        {
            switch (_datas[0])
            {
                case 0x55:
                    return "系统上电";
                case 0x5a:
                    return "超时";
                case 0xaa:
                    return "检测";
                default:
                    return "未知";
            }
        }
    }
    /// <summary>
    /// 检测模式
    /// </summary>
    public string Mode
    {
        get
        {
            if (_datas[1] == 1)
                return "单轮";
            else
                return "列车";
        }
    }
    /// <summary>
    /// 在线状态
    /// </summary>
    public string IsOnLine
    {
        get
        {
            if (_datas == null)
                return "通讯错";
            else if (_datas[2] == 1)
                return "在线";
            else
                return "离线";
        }

    }
    /// <summary>
    /// 在线时长
    /// </summary>
    public UInt16 OnlineTimes
    {
        get
        {
            return BitConverter.ToUInt16(_datas, 3);
        }
    }
    /// <summary>
    /// 进线方向
    /// </summary>
    public string Direction
    {
        get
        {
            if (_datas[8] == 1)
                return "正向";
            else
                return "反向";
        }
    }
    /// <summary>
    /// 进入轮对数
    /// </summary>
    public UInt16 WheelNum_in
    {
        get
        {
            return BitConverter.ToUInt16(_datas, 9);
        }
    }

    /// <summary>
    /// 经过轮对数
    /// </summary>
    public UInt16 WheelNum_pass
    {
        get
        {
            return BitConverter.ToUInt16(_datas, 11);
        }
    }
    /// <summary>
    /// 进线速度
    /// </summary>
    public UInt16 SpeedIn
    {
        get
        {
            return BitConverter.ToUInt16(_datas, 15);
        }
    }
    /// <summary>
    /// 离线速度
    /// </summary>
    public UInt16 SpeedOut
    {
        get
        {
            return BitConverter.ToUInt16(_datas, 17);
        }
    }
    /// <summary>
    /// 通讯状态
    /// </summary>
    public byte ComWord
    {
        get
        {
            return _datas[19];
        }
    }
    /// <summary>
    /// 水泵开关
    /// </summary>
    public bool PumpOn
    {
        get
        {
            return (_datas[20] == 1);
        }
    }
    /// <summary>
    /// 端口状态
    /// </summary>
    public byte PortStatus
    {
        get
        {
            return _datas[24];
        }
    }
    private string TemperatureBinToStr(int v)
    {
        if (v == 0x6C6B)
            return _strKL;
        if (v == 0x6C64)
            return _strDL;
        return (v * 0.5).ToString();
    }
    private string ValueBinToStr(int v)
    {
        if (v == 0x6C6B)
            return _strKL;
        if (v == 0x6C64)
            return _strDL;
        return v.ToString();
    }
    /// <summary>
    /// 环温
    /// </summary>
    public string Temperature
    {
        get
        {
            int v = BitConverter.ToInt16(_datas, 25);
            return TemperatureBinToStr(v);
        }
    }
    /// <summary>
    /// 液温
    /// </summary>
    public string WaterTemperature
    {
        get
        {
            int v = BitConverter.ToInt16(_datas, 27);
            return TemperatureBinToStr(v);
        }
    }
    /// <summary>
    /// A温
    /// </summary>
    public string ATemperature
    {
        get
        {
            int v = BitConverter.ToInt16(_datas, 29);
            return TemperatureBinToStr(v);
        }
    }
    /// <summary>
    /// B温
    /// </summary>
    public string BTemperature
    {
        get
        {
            int v = BitConverter.ToInt16(_datas, 31);
            return TemperatureBinToStr(v);
        }
    }
    /// <summary>
    /// 水位
    /// </summary>
    public string WaterLevel
    {
        get
        {
            int v = BitConverter.ToUInt16(_datas, 33);
            if (v == 0x6C6B)
                return _strKL;
            if (v == 0x6C64)
                return _strDL;
            return ValueBinToStr(Math.Abs(scDeep - v)); 
        }
    }
    /// <summary>
    /// 机柜风扇是否打开
    /// </summary>
    public bool FanOn
    {
        get
        {
            return (_datas[37] == 1);
        }
    }
    /// <summary>
    /// 阵列加温开关
    /// </summary>
    public bool HotOn
    {
        get
        {
            return (_datas[40] == 1);
        }
    }
    /// <summary>
    /// 综控数据
    /// </summary>
    /// <param name="datas">综控数据</param>
    public ZhParam(byte[] datas)
    {
        this._datas = datas;
    }
}
