using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Drawing;
using System.Globalization;
using System.IO;
using System.Data.SqlClient;


public partial class Details_kc : System.Web.UI.Page
{
    protected int m_iAxleNum;
    public DateTime m_dt;               //检测日期时间


    public string carNo;
    public int pageIndex;
    protected void Page_PreInit(object sender, EventArgs e)
    {
        if (Session["login"] == null)
            Response.Redirect(PUBS.HomePage);

        carNo = Request.QueryString["carNo"];
        if (carNo == null)
            Response.Redirect("blank.htm");

        string sPage = Request.QueryString["page"];
        if (sPage == null)
            pageIndex = 0;
        else
            pageIndex = int.Parse(sPage);

        m_iAxleNum = 4;


        bt_SelectTrain.Text = PUBS.Txt("选择列车");

        LoginStatus1.LogoutText = PUBS.Txt("注销");
    } 

    protected void Page_Load(object sender, EventArgs e)
    {
        var name = PUBS.GetUserDisplayName(Context.User.Identity.Name);
        LoginName1.FormatString = name;
    }

    protected void LoginStatus1_LoggedOut(object sender, EventArgs e)
    {
        Session.Remove("login");
        PUBS.Log(Request.UserHostAddress, Membership.GetUser().UserName, 0, this.GetType().FullName);
    }



    public string GetProfileFlag(string trainType, int powerType, string name, string sValue, int level)
    {
        string ret = "";
        if (sValue == "-")
            return ret;
        double value = double.Parse(sValue);
        int updown;
        string desc;
        PUBS.GetProfileStatus(trainType, powerType, name, sValue, out updown, out desc);

        if (level > 0)
        {
            string strColor = "";
            switch (level)
            {
                case 1:
                    strColor = "red";
                    break;
                case 2:
                    strColor = "yellow";
                    break;
                case 3:
                    strColor = "blue";
                    break;
            }
            string flag = "";
            switch (updown)
            {
                case 1: flag = "↑";
                    break;
                case -1: flag = "↓";
                    break;
                case 0: flag = "";
                    break;
            }
            ret = string.Format("<span style=\"color: {0}; font-weight: bold; font-size: medium;\">{1}</span>", strColor, flag);
        }
        return ret;
    }
    public string GetCarNo(string datetimestr, int index)
    {
        string ret = "";
        DataTable dt = PUBS.sqlQuery(string.Format("select * from carlist where testdatetime='{0}' and posNo={1}", datetimestr, index));
        if (dt.Rows.Count > 0)
            ret = dt.Rows[0]["CarNo"].ToString();
        return ret;
    }

    public void GetSwStatus(object d, out int imgId, out string tip)
    {
        byte status;
        tip = "";
        string s = d.ToString();
        if (s == "")//缺失　灰色
        {
            imgId = 3;
            tip = PUBS.Txt("数据缺失");
        }
        else
        {
            status = byte.Parse(s);
            if (status == 0)//正常　绿色
            {
                imgId = 0;
                tip = PUBS.Txt("正常");
            }
            else
            {
                if ((status & 0x02) != 0)       //无效　红色
                    imgId = 2;
                else if ((status & 0x10) != 0)//停车　桔色
                    imgId = 4;
                else//其它　黄色
                    imgId = 1;
                if ((status & 0x01) != 0)
                    tip += PUBS.Txt("速度异常")+";";
                if ((status & 0x02) != 0)
                    tip += PUBS.Txt("数据无效")+";";
                if ((status & 0x04) != 0)
                    tip += PUBS.Txt("脉冲不全")+";";
                if ((status & 0x08) != 0)
                    tip += PUBS.Txt("开关异常")+";";
                if ((status & 0x10) != 0)
                    tip += PUBS.Txt("异常停车")+";";
                if ((status & 0x20) != 0)
                    tip += PUBS.Txt("两轮在线") + ";";
            }
        }        
    }
    public string GetBzh(string datetimestr)
    {
        string ret = "";
        DataTable dt = PUBS.sqlQuery(string.Format("select bzh from V_Detect_kc where testdatetime='{0}'", datetimestr));
        if (dt.Rows.Count > 0)
            ret = dt.Rows[0][0].ToString();
        return ret;
    }
    public void GetCwStatus(object d, out int imgId, out string tip)
    {
        byte status;
        string s = d.ToString();
        if (s == "")//缺失　灰色
        {
            imgId = 3;
            tip = PUBS.Txt("数据缺失");
        }
        else
        {
            status = byte.Parse(s);
            if (status == 1)//正常　绿色
            {
                imgId = 0;
                tip = PUBS.Txt("正常");
            }
            else if (status == 0)
            {
                imgId = 2;
                tip = PUBS.Txt("异常");
            }
            else
            {
                imgId = 4;
                tip = PUBS.Txt("未知");
            }
        }
    }
}
