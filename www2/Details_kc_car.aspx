<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Details_kc_car.aspx.cs" Inherits="Details_kc" EnableViewState="true" Theme="theme" %>
<%@ Import Namespace="System.Data" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<meta http-equiv="pragma" content="no-cache">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title><%=PUBS.Txt("单车厢历史检测记录")%></title>
    <link href="css/tycho/tycho.css" type="text/css" rel="stylesheet"/>
    <link type="text/css" href="css/ui-lightness/jquery-ui-1.7.1.custom.css" rel="Stylesheet" />	
    <script type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
    <script type="text/javascript" src="js/jquery-ui-1.7.1.custom.min.js"></script>
  <script type="text/javascript">
  $(document).ready(function(){
    $("#tabs").tabs();
  });
  </script>
  

<style>
<!--
.div{
position: absolute;
border: 2px solid red;
background-color: #EFEFEF;
line-height:20px;
font-size:12px;
z-index:1000;
}
-->
</style>
</head>

<body>
<form id="form1" runat="server">
            <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>

<%=PUBS.OutputHead("") %>
<div class="cmd">
    <table cellpadding="0" cellspacing="0" >
    <tr>
        <td>
    <asp:LoginName ID="LoginName1" runat="server" SkinID="LoginName1" />&nbsp;
    </td>
    <td>
    <asp:LoginStatus ID="LoginStatus1" runat="server"  LogoutAction="RedirectToLoginPage"
                        OnLoggedOut="LoginStatus1_LoggedOut" 
        SkinID="LoginStatus1" />&nbsp;
    </td>
    <%if (PUBS.GetUserLevel() <= 1)
      {%>
      <td>
       </td>
       <td></td>
       <td></td>
    <%} %>
    <td>
    &nbsp;<asp:Button ID="bt_SelectTrain" runat="server"  Text="选择列车" 
        onclientclick="javascript:history.go(-1);return false;" /></td>

    </tr>
    </table>
</div>
<%
    DataTable d0 = PUBS.sqlQuery(string.Format("select testDateTime, posNo from carlist where carNo='{0}' and not exists(select * from Detect where Detect.testDateTime=CarList.testDateTime and AxleNum=0) order by testDatetime desc", carNo));
    int index = -1;
    int perPage = 20;
    int count = d0.Rows.Count;
    int pageNum =  count / perPage + 1;    
    
     %>
<div class="detail_kc">
   <div class="title" style="text-decoration: none"><span class="title"><%=string.Format("{0} {1} ({2})", carNo, PUBS.Txt("历史检测记录明细"), count)%></span></div>

               <table id="datatable" width="980" border="1" bordercolor="gray" cellspacing="0" 
                   cellpadding="0" style="color: white; font">
                   <%

                       int w = 0;
                       //string slevel;
                       int ilevel;
                       //string[] sLevelText = new string[5] { PUBS.Txt("无"), "I", "II", "III", PUBS.Txt("提示") };
                       //升级前后，老数据用老样式，新数据用新样式                   
                       string[] sLevelStyle;
                       string[] sLinkStyle;
                       bool isOperator = (PUBS.GetUserLevel() <= 1);
                       string sLevelBlack = "style=\"background-color:#CDCDCD;color:#0066FF\"";
                       string sLevelNormal = "style=\"background-color:#A5C0DE;color:#0066FF\"";
                       string href;
                       string hrefWhms;
                       string hrefWhmsWheel;
                       string value;
                       string errStr="-1000";
                       int level;
                       
                       int haveWxAdj;
                       if ((bool)Application["SYS_WX"])
                           haveWxAdj = 0;
                       else
                           haveWxAdj = 1;
                       
                       int iDelay = 0;
                       int.TryParse(Application["DelayMinute"].ToString(), out iDelay);
                        
                       foreach (DataRow dr0 in d0.Rows)
                       {
                           index++;
                           if ((index < pageIndex * perPage) || (index >= (pageIndex + 1) * perPage))
                               continue;
                           string stestDatetime = dr0["testDateTime"].ToString();
                           DateTime dtTest = Convert.ToDateTime(stestDatetime);
                               
                           m_dt = Convert.ToDateTime(stestDatetime);
                           //考虑延时的情况
                           if (!PUBS.isTychoAdmin() && (iDelay > 0))//不是内管员，且有延时
                           {
                               if (m_dt.AddMinutes(iDelay) > DateTime.Now)//时间没有过
                               {
                                   DataTable t = PUBS.sqlQuery(string.Format("select * from  [V_Detect_kc_outline] where testdatetime='{0}'", stestDatetime));
                                   if (t.Rows.Count > 0)
                                   {
                                       if (!Convert.ToBoolean(t.Rows[0]["isShow"].ToString()))//没有人工确认
                                       {
                                           if (int.Parse(t.Rows[0]["AxleNum"].ToString()) > 1)//不是单轮对
                                           {
                                               //非正常
                                               if ((t.Rows[0]["s_level_ts"].ToString() != "正常") || (t.Rows[0]["s_level_cs"].ToString() != "正常") || (t.Rows[0]["s_level_M"].ToString() != "正常"))
                                               {
                                                   continue;
                                               }
                                           }
                                       }
                                   }
                               }
                           }
                           
                           stestDatetime = m_dt.ToString("yyyy-MM-dd HH:mm:ss");
                           string sCarIndex = dr0["posNo"].ToString();
                           int iCarIndex = int.Parse(sCarIndex);
                           string s = string.Format("exec GetCar '{0}', {1}", stestDatetime, sCarIndex);

                           if (dtTest < PUBS.DT_SP)
                           {
                               sLevelStyle = new string[5] { "", "style=\"background-color:Red\"", "style=\"background-color:Yellow\"", "style=\"background-color:Blue\"", "" };
                               sLinkStyle = new string[5] { "", "", "", "class=\"whitelink\"", "" };
                           }
                           else
                           {
                               sLevelStyle = new string[5] { "", "style=\"background-color:Red\"", "style=\"background-color:Yellow\"", "", "" };
                               sLinkStyle = new string[5] { "", "", "", "", "" };
                           }
                           
                           
                       DataTable dt = PUBS.sqlQuery(s);
                       string bzh;
                       string trainType="";
                       int iAllCols = 18;
                       if (isOperator)
                           iAllCols = 19;
                       foreach (DataRow dr in dt.Rows)
                       {
                           if (w % 8 == 0)
                           {
                               Response.Write("<tr bgcolor=\"#20487C\">\r\n");
                               bzh = GetBzh(stestDatetime);
                               if (bzh.IndexOf('-') >= 0)

                                   trainType = bzh.Substring(0, bzh.IndexOf('-'));
                               else
                                   trainType = "default";

                               Response.Write(string.Format("<td Height=\"30\" colspan=\"{3}\" align=\"left\"><span class=\"title2\">检测时间</span>:<a href=\"Details_kc.aspx?field={2}\" class=\"whitelink\">{0}</a>    <span class=\"title2\">车组号</span>:{1}</td>\r\n", stestDatetime, bzh, stestDatetime, iAllCols));
                               Response.Write("</tr>\r\n");
                               Response.Write("<tr bgcolor=\"#20487C\">\r\n");
                               //Response.Write(string.Format("<td width=40 rowspan=\"11\">{0}车<br/><br/><a href=\"{2}?field={3}&carNo={4}\"><img src=\"{1}\" border=\"0\"/></a></td>\r\n", dr["carPos"].ToString(), "image\\printer.gif", "rpt_car.aspx", stestDatetime, sCarIndex));
                               Response.Write(string.Format("<td width=40 rowspan=\"{1}\">{0}车<br/><br/></td>\r\n", dr["carPos"].ToString(), 11-haveWxAdj));
                               Response.Write(string.Format("<td  rowspan=\"{1}\">{0}</td>\r\n", PUBS.Txt("轴号"),3-haveWxAdj));
                               Response.Write(string.Format("<td  rowspan=\"{1}\">{0}</td>\r\n", PUBS.Txt("轮位"),3-haveWxAdj));
                               if (isOperator)
                                   Response.Write(string.Format("<td  rowspan=\"{1}\">{0}</td>\r\n", PUBS.Txt("复核"), 3 - haveWxAdj));
                               if ((bool)Application["SYS_TS"])
                                   Response.Write(string.Format("<td  colspan=\"2\">{0}</td>\r\n", PUBS.Txt("探伤")));
                               if ((bool)Application["SYS_CS"])
                               {
                                   int cw = 2;
                                   if ((bool)Application["SYS_CS_IMAGE"])
                                       cw = 3;
                                   Response.Write(string.Format("<td  colspan=\"{1}\">{0}</td>\r\n", PUBS.Txt("擦伤"), cw));
                               }
                               if ((bool)Application["SYS_WX"])
                                   Response.Write(string.Format("<td  colspan=\"10\">{0}</td>\r\n", PUBS.Txt("外形尺寸")));
                               Response.Write(string.Format("<td  rowspan=\"{1}\">{0}</td>\r\n", PUBS.Txt("照片"),3-haveWxAdj));
                               Response.Write("</tr>\r\n");
                               Response.Write("<tr bgcolor=\"#20487C\">\r\n");
                               if ((bool)Application["SYS_TS"])
                               {
                                   Response.Write(string.Format("<td rowspan=\"{1}\">{0}</td>\r\n", PUBS.Txt("级别"),2-haveWxAdj));
                                   Response.Write(string.Format("<td rowspan=\"{1}\">{0}</td>\r\n", PUBS.Txt("状态"),2-haveWxAdj));
                               }
                               if ((bool)Application["SYS_CS"])
                               {
                                   Response.Write(string.Format("<td rowspan=\"{1}\">{0}</td>\r\n", PUBS.Txt("级别"),2-haveWxAdj));
                                   if ((bool)Application["SYS_CS_IMAGE"])
                                   {
                                       Response.Write(string.Format("<td rowspan=\"{1}\">{0}</td>\r\n", PUBS.Txt("图像"),2-haveWxAdj));
                                   }
                                   Response.Write(string.Format("<td rowspan=\"{1}\">{0}</td>\r\n", PUBS.Txt("状态"),2-haveWxAdj));
                               }
                               if ((bool)Application["SYS_WX"])
                               {
                                   Response.Write(string.Format("<td colspan=\"4\">{0}</td>\r\n", PUBS.Txt("轮径")));
                                   Response.Write(string.Format("<td rowspan=\"2\">{0}</td>\r\n", PUBS.Txt("踏面<br/>磨耗")));
                                   Response.Write(string.Format("<td rowspan=\"2\">{0}</td>\r\n", PUBS.Txt("轮缘<br/>厚度")));
                                   Response.Write(string.Format("<td rowspan=\"2\">{0}</td>\r\n", PUBS.Txt("轮缘<br/>高度")));
                                   Response.Write(string.Format("<td rowspan=\"2\">{0}</td>\r\n", PUBS.Txt("轮辋<br/>宽度")));
                                   Response.Write(string.Format("<td rowspan=\"2\">{0}</td>\r\n", PUBS.Txt("QR<br/>值")));
                                   Response.Write(string.Format("<td rowspan=\"2\">{0}</td>\r\n", PUBS.Txt("内侧距")));
                               }
                               Response.Write("</tr>\r\n");
                               
                               if ((bool)Application["SYS_WX"])
                               {
                                   Response.Write("<tr bgcolor=\"#20487C\">\r\n");
                                   Response.Write(string.Format("<td>{0}</td>\r\n", PUBS.Txt("直径")));
                                   Response.Write(string.Format("<td>{0}</td>\r\n", PUBS.Txt("同轴差")));
                                   Response.Write(string.Format("<td>{0}</td>\r\n", PUBS.Txt("同架差")));
                                   Response.Write(string.Format("<td>{0}</td>\r\n", PUBS.Txt("同车差")));
                                   Response.Write("</tr>\r\n");
                               }                              
                           }
                           string lw = PUBS.LWXH[int.Parse(dr["pos"].ToString())];
                           if (w % 2 == 0)
                           {
                               Response.Write("<tr bgcolor=\"#A5C0DE\"  style=\"color:Black\">\r\n");
                               Response.Write(string.Format("<td rowspan=\"2\">{0}</td>\r\n", w % 8 /2+1));
                               Response.Write(string.Format("<td>{0}</td>\r\n",lw));
                           }
                           else
                           {
                               Response.Write("<tr bgcolor=\"White\" style=\"color:Black\">\r\n");
                               Response.Write(string.Format("<td>{0}</td>\r\n", lw));
                           }

                           //Response.Write(string.Format("<td>{0}</td>\r\n", w%8+1));
                           
                           //在整车中的轴号
                           int axleIndexInTrain = iCarIndex * 4 + int.Parse(dr["axleNo"].ToString());

                           string checkUrl = string.Format("check.aspx?datetimestr={0}&axleNo={1}&wheelNo={2}", stestDatetime, axleIndexInTrain, dr["wheelNo"]);
                           if (isOperator)
                           {
                               if (bool.Parse(dr["HaveCheck"].ToString()))
                                   Response.Write(string.Format("<td><a href=\"{1}\"><img src=\"{0}\" alt=\"已复核\" style=\"border-width:0px;\"/></a> </td>\r\n", "image/haveCheck.ico", checkUrl));
                               else
                                   Response.Write(string.Format("<td><a href=\"{1}\"><img src=\"{0}\" alt=\"未复核\" style=\"border-width:0px;\"/></a> </td>\r\n", "image/NoCheck.ico", checkUrl));

                           }
                           
                           int imgId;
                           string tip;
                           if ((bool)Application["SYS_TS"])
                           {
                               //slevel = dr["level"].ToString();
                               //if (slevel != "无")
                               //    ilevel = int.Parse(slevel);
                               //else
                               //    ilevel = 0;

                               //if (Session["RunType"].ToString() == "cs")
                               //    href = string.Format("TYCHOTS_{0}_{1}_{2}", stestDatetime, axleIndexInTrain, dr["wheelNo"]);
                               //else
                               //    href = string.Format("ts/wheel.aspx?testDateTime={0}&axleNo={1}&wheelNo={2}", stestDatetime, axleIndexInTrain, dr["wheelNo"]);
                               string ts=dr["slevel_ts"].ToString();
                               string hh = dr["level"].ToString();
                               ilevel = int.Parse(hh);

                               if (Application["SYS_TS_url"].ToString() == "")
                                   href = string.Format("TYCHOTS_{0}_{1}_{2}", stestDatetime, axleIndexInTrain, dr["wheelNo"]);
                               else
                               {
                                   string hrefTS = string.Format("http://{0}:8084{1}", Request.Url.Host, Application["SYS_TS_url"].ToString());
                                   href = string.Format("{0}?testDateTime={1}&axleNo={2}&wheelNo={3}", hrefTS, stestDatetime, axleIndexInTrain, dr["wheelNo"]);
                               }

                               
                               //Response.Write(string.Format("<td width=50 {1}><a href=\"{2}\" {3}>{0}</a></td>\r\n", sLevelText[ilevel], sLevelStyle[ilevel], href, sLinkStyle[ilevel]));
                               Response.Write(string.Format("<td width=50 {1}><a href=\"{2}\" {3}>{0}</a></td>\r\n", ts, sLevelStyle[ilevel], href, sLinkStyle[ilevel]));

                               //Response.Write(string.Format("<td>{0} {1} {2} {3}</td>\r\n", dr["status1"], dr["status2"], dr["status3"], dr["status4"]));
                               Response.Write(string.Format("<td>\r\n"));

                               href = string.Format("TYCHOSW_{0}_{1}_{2}", stestDatetime, axleIndexInTrain, dr["wheelNo"]);
                               if (Application["SYS_MODE"].ToString() == "12UT")
                               {
                                   GetSwStatus(dr["status6"], out imgId, out tip);
                                   Response.Write(string.Format("<a href=\"{2}\"><img alt=\"{0}\" src=\"image/sw{1}.gif\" border=\"0\"/></a>|", tip, imgId, href + "_5"));
                                   GetSwStatus(dr["status5"], out imgId, out tip);
                                   Response.Write(string.Format("<a href=\"{2}\"><img alt=\"{0}\" src=\"image/sw{1}.gif\" border=\"0\"/></a>|", tip, imgId, href + "_4"));
                               }
                               GetSwStatus(dr["status4"], out imgId, out tip);
                               Response.Write(string.Format("<a href=\"{2}\"><img alt=\"{0}\" src=\"image/sw{1}.gif\" border=\"0\"/></a>|", tip, imgId, href + "_3"));
                               GetSwStatus(dr["status3"], out imgId, out tip);
                               Response.Write(string.Format("<a href=\"{2}\"><img alt=\"{0}\" src=\"image/sw{1}.gif\" border=\"0\"/></a>|", tip, imgId, href + "_2"));
                               GetSwStatus(dr["status2"], out imgId, out tip);
                               Response.Write(string.Format("<a href=\"{2}\"><img alt=\"{0}\" src=\"image/sw{1}.gif\" border=\"0\"/></a>|", tip, imgId, href + "_1"));
                               GetSwStatus(dr["status1"], out imgId, out tip);
                               Response.Write(string.Format("<a href=\"{2}\"><img alt=\"{0}\" src=\"image/sw{1}.gif\" border=\"0\"/></a>", tip, imgId, href + "_0"));
                               Response.Write(string.Format("</td>\r\n"));
                           }
                           if ((bool)Application["SYS_CS"])
                           {
                               string cs = dr["slevel_cs"].ToString();
                               ilevel = int.Parse(dr["cslevel"].ToString());

                               if (Application["SYS_CS_url"].ToString() == "")
                                   href = string.Format("TYCHOCS_{0}_{1}_{2}", stestDatetime, axleIndexInTrain, dr["wheelNo"]);
                               else
                               {
                                   string hrefCS = string.Format("http://{0}:8083{1}", Request.Url.Host, Application["SYS_CS_url"].ToString());
                                   href = string.Format("{0}?testDateTime={1}&axleNo={2}&wheelNo={3}", hrefCS, stestDatetime, axleIndexInTrain, dr["wheelNo"]);
                               }
                               Response.Write(string.Format("<td width=50 {1}><a href=\"{2}\">{0}</a></td>\r\n", cs, sLevelStyle[ilevel], href));
                               if ((bool)Application["SYS_CS_IMAGE"])
                               {
                                   string vcs = dr["slevel_vcs"].ToString();
                                   ilevel = int.Parse(dr["vcslevel"].ToString());
                                   string hrefHX = string.Format("http://{0}:8082{1}", Request.Url.Host, Application["URL_HXZY"].ToString());
                                   string urlHX = string.Format("{0}?testDateTime={1}&axleNo={2}&wheelNo={3}", hrefHX, stestDatetime, axleIndexInTrain, dr["wheelNo"]).Replace(" ", "%20");
                                   Response.Write(string.Format("<td width=50 {1}><a href=\"{2}\">{0}</a></td>\r\n", vcs, sLevelStyle[ilevel], urlHX));
                               }
                               if (w % 2 == 0)
                               {
                                   href = string.Format("TYCHOCW_{0}_{1}", stestDatetime, axleIndexInTrain);
                                   Response.Write(string.Format("<td rowspan=\"2\">\r\n"));
                                   GetCwStatus(dr["csStatus1"], out imgId, out tip);
                                   Response.Write(string.Format("<a href=\"{2}\"><img alt=\"{0}\" src=\"image/sw{1}.gif\" border=\"0\"/></a>|", tip, imgId, href + "_0"));
                                   GetCwStatus(dr["csStatus2"], out imgId, out tip);
                                   Response.Write(string.Format("<a href=\"{2}\"><img alt=\"{0}\" src=\"image/sw{1}.gif\" border=\"0\"/></a>|", tip, imgId, href + "_1"));
                                   GetCwStatus(dr["csStatus3"], out imgId, out tip);
                                   Response.Write(string.Format("<a href=\"{2}\"><img alt=\"{0}\" src=\"image/sw{1}.gif\" border=\"0\"/></a>", tip, imgId, href + "_2"));

                                   Response.Write(string.Format("</td>\r\n"));
                               }
                           }
                            //动车还是拖车
                            int powerType = int.Parse(dr["powerType"].ToString());
                           
                           if ((bool)Application["SYS_WX"])
                           {


                               hrefWhms = string.Format("whms_wheel.aspx?datetimestr={0}&axleNo={1}", stestDatetime, axleIndexInTrain);

                               hrefWhmsWheel = string.Format("{0}&wheelNo={1}", hrefWhms, dr["wheelNo"]);
                               
                               value = dr["Lj"].ToString();
                               level = int.Parse(dr["Level_Lj"].ToString());
                               if (value.Trim() == errStr)
                                   value = "-";
                               string stl = GetProfileFlag(trainType, powerType, "WX_LJ", value, level);
                               string bkStl = "";
                               bkStl = stl == "" ? "" : sLevelBlack;
                               Response.Write(string.Format("<td {3}><a href=\"{1}\">{0}</a>{2}</td>\r\n", value, hrefWhmsWheel, stl, bkStl));

                               if (w % 2 == 0)
                               {

                                   value = dr["LjCha_Zhou"].ToString();
                                   level = int.Parse(dr["Level_LjCha_Zhou"].ToString());
                                   if (value.Trim() == errStr)
                                       value = "-";
                                   stl = GetProfileFlag(trainType, powerType, "WX_LJC_Z", value, level);
                                   bkStl = "";
                                   bkStl = stl == "" ? "" : sLevelBlack;
                                   Response.Write(string.Format("<td rowspan=\"2\" {3}><a href=\"{1}\">{0}</a>{2}</td>\r\n", value, hrefWhms, stl, bkStl));
                               }

                               if (w % 4 == 0)
                               {
                                   value = dr["LjCha_ZXJ"].ToString();
                                   level = int.Parse(dr["Level_LjCha_ZXJ"].ToString());
                                   if (value.Trim() == errStr)
                                       value = "-";
                                   stl = GetProfileFlag(trainType, powerType, "WX_LJC_J", value, level);
                                   bkStl = "";
                                   bkStl = stl == "" ? sLevelNormal : sLevelBlack;
                                   Response.Write(string.Format("<td rowspan=\"4\" {3}>{0}{2}</td>\r\n", value, hrefWhmsWheel, stl, bkStl));
                               }
                               if (w % 8 == 0)
                               {
                                   value = dr["LjCha_Che"].ToString();
                                   level = int.Parse(dr["Level_LjCha_Che"].ToString());
                                   if (value.Trim() == errStr)
                                       value = "-";
                                   stl = GetProfileFlag(trainType, powerType, "WX_LJC_C", value, level);
                                   bkStl = "";
                                   bkStl = stl == "" ? sLevelNormal : sLevelBlack;
                                   Response.Write(string.Format("<td rowspan=\"8\" {3}>{0}{2}</td>\r\n", value, hrefWhmsWheel, stl, bkStl));
                               }                               
                               
                               value = dr["TmMh"].ToString();
                               level = int.Parse(dr["Level_tmmh"].ToString());
                               if (value.Trim() == errStr)
                                   value = "-";
                               stl = GetProfileFlag(trainType, powerType, "WX_TMMH", value, level);
                               bkStl = stl == "" ? "" : sLevelBlack;
                               Response.Write(string.Format("<td {3}><a href=\"{1}\">{0}</a>{2}</td>\r\n", value, hrefWhmsWheel, stl, bkStl));

                               value = dr["LyHd"].ToString();
                               level = int.Parse(dr["Level_lyhd"].ToString());
                               if (value.Trim() == errStr)
                                   value = "-";
                               stl = GetProfileFlag(trainType, powerType, "WX_LYHD", value, level);
                               bkStl = stl == "" ? "" : sLevelBlack;
                               Response.Write(string.Format("<td {3}><a href=\"{1}\">{0}</a>{2}</td>\r\n", value, hrefWhmsWheel, stl, bkStl));

                               value = dr["LyGd"].ToString();
                               level = int.Parse(dr["Level_lygd"].ToString());
                               if (value.Trim() == errStr)
                                   value = "-";
                               stl = GetProfileFlag(trainType, powerType, "WX_LYGD", value, level);
                               bkStl = stl == "" ? "" : sLevelBlack;
                               Response.Write(string.Format("<td {3}><a href=\"{1}\">{0}</a>{2}</td>\r\n", value, hrefWhmsWheel, stl, bkStl));

                               value = dr["LwHd"].ToString();
                               level = int.Parse(dr["Level_lwhd"].ToString());
                               if (value.Trim() == errStr)
                                   value = "-";
                               stl = GetProfileFlag(trainType, powerType, "WX_LWHD", value, level);
                               bkStl = stl == "" ? "" : sLevelBlack;
                               Response.Write(string.Format("<td {3}><a href=\"{1}\">{0}</a>{2}</td>\r\n", value, hrefWhmsWheel, stl, bkStl));

                               value = dr["Qr"].ToString();
                               level = int.Parse(dr["Level_qr"].ToString());
                               if (value.Trim() == errStr)
                                   value = "-";
                               stl = GetProfileFlag(trainType, powerType, "WX_QR", value, level);
                               bkStl = stl == "" ? "" : sLevelBlack;
                               Response.Write(string.Format("<td {3}><a href=\"{1}\">{0}</a>{2}</td>\r\n", value, hrefWhmsWheel, stl, bkStl));

                               if (w % 2 == 0)
                               {
                                   value = dr["Ncj"].ToString();
                                   level = int.Parse(dr["Level_ncj"].ToString());
                                   if (value.Trim() == errStr)
                                       value = "-";
                                   stl = GetProfileFlag(trainType, powerType, "WX_NCJ", value, level);
                                   bkStl = stl == "" ? "" : sLevelBlack;
                                   Response.Write(string.Format("<td rowspan=\"2\"  {3}><a href=\"{1}\">{0}</a>{2}</td>\r\n",
                                                                value, hrefWhms, stl, bkStl));
                               }
                           }
                           
                           //车厢照片
                           if (w % 8 == 0)
                           {
                               Response.Write(string.Format("<td width=40 rowspan=\"7\"><img id=\"img{3}\"  onclick=\"sc6({3})\" src=\"photo/{0}/{1}/{2}__{3}.jpg\" alt=\"\" width=\"200\" height=\"150\"/></td>\r\n", m_dt.ToString("yyyy"), m_dt.ToString("MM"), m_dt.ToString("yyyyMMdd_HHmmss"), sCarIndex));

                           }
                           //补齐一节车厢　４轴８轮
                           if (m_iAxleNum * 2 - 1 == w)
                           {
                               for (int i = 0; i < 8-w-1; i++)
                               {
                                   if (i!=0)
                                       Response.Write("</tr>\r\n");
                                   Response.Write("<tr>\r\n");
                                   Response.Write("<td>-</td>\r\n");
                                   Response.Write("<td>-</td>\r\n");
                                   Response.Write("<td>-</td>\r\n");
                                   Response.Write("<td>-</td>\r\n");
                                   Response.Write("<td>-</td>\r\n");
                                   Response.Write("<td>-</td>\r\n");
                                   Response.Write("<td>-</td>\r\n");
                                   Response.Write("<td>-</td>\r\n");
                                   Response.Write("<td>-</td>\r\n");
                                   Response.Write("<td>-</td>\r\n");
                                   Response.Write("<td>-</td>\r\n");
                               
                               }
                            }

                           if ((w % 8 == 7) || ((m_iAxleNum < 4) && (w == m_iAxleNum*2-1)))
                               {
                                   string bkColor = "White";

                                   if (powerType == 0)
                                       bkColor = "silver";
                               
                                   Response.Write(string.Format("<td id=\"td{1}\" style=\"background-color:{2}; font-weight: bold;color:darkred\">{0}</td>\r\n", carNo, w / 8, bkColor));
                               }
                               Response.Write("</tr>\r\n");
                          
                               w++;
                       }
                       }
                   %>
               </table> 
                   
               <%
                 Response.Write(string.Format("<a href=\"Details_kc_car.aspx?carNo={0}\">首页</a>", carNo));
                 Response.Write("&nbsp;&nbsp;&nbsp;&nbsp;");
                 if (pageIndex > 0)
                 {
                     Response.Write(string.Format("<a href=\"Details_kc_car.aspx?carNo={0}&page={1}\">上一页</a>", carNo, pageIndex - 1));
                     Response.Write("&nbsp;&nbsp;&nbsp;&nbsp;");
                 }

                 if (pageIndex < pageNum - 1)
                 {
                     Response.Write(string.Format("<a href=\"Details_kc_car.aspx?carNo={0}&page={1}\">下一页</a>", carNo, pageIndex + 1));
                     Response.Write("&nbsp;&nbsp;&nbsp;&nbsp;");
                 }
                 Response.Write(string.Format("<a href=\"Details_kc_car.aspx?carNo={0}&page={1}\">尾页</a>", carNo, pageNum - 1));
                 Response.Write("&nbsp;&nbsp;&nbsp;&nbsp;");  

                 Response.Write(string.Format("第{0}页　共{1}页", pageIndex + 1, pageNum));      
               %>                                        
</div> 


<%=PUBS.OutputFoot("") %>


</form>
</body>
</html>
