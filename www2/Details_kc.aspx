<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Details_kc.aspx.cs" Inherits="Details_kc" EnableViewState="true" Theme="theme" %>
<%@ Import Namespace="System.Data" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<meta http-equiv="pragma" content="no-cache">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title><%=PUBS.Txt("整车检测明细")%></title>
    <link href="css/tycho/tycho.css" type="text/css" rel="stylesheet"/>
    <link type="text/css" href="css/ui-lightness/jquery-ui-1.7.1.custom.css" rel="Stylesheet" />	
    <script type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
    <script type="text/javascript" src="js/jquery-ui-1.7.1.custom.min.js"></script>
  <script type="text/javascript">
  $(document).ready(function(){
    $("#tabs").tabs();
  });
  </script>
  
  <script type="text/javascript">
var m_iNowChanNo = -1; 
var m_iLoginUserId = -1;
var m_iChannelNum = -1;	
var m_bDVRControl = null;
var m_iProtocolType = 0;
var m_iStreamType = 0;
var m_iPlay = 0;
var m_iRecord = 0; 
var m_iTalk = 0;
var m_iVoice = 0;
var m_iAutoPTZ = 0;
var m_iPTZSpeed = 4;
var m_playing = 0;
var m_pause_text = "<%=PUBS.Txt("暂停") %>";
var m_resume_text = "<%=PUBS.Txt("继续") %>";


window.onload = function() {
    var myDate = new Date();
    var iYear = myDate.getFullYear();
    if (iYear < 1971 || iYear > 2037) {
        alert("为了正常使用本软件，请将系统日期年限设置在1971-2037范围内！");
        //parent.location.href = "../login.php";
    }
    if (document.getElementById("HIKOBJECT1").object == null) {
        alert("请先下载控件并注册！");
        m_bDVRControl = null;
    }
    else {
        m_bDVRControl = document.getElementById("HIKOBJECT1");
    }
    ButtonPress("LoginDev");
};
window.onClose = function() {
	ButtonPress("LogoutDev");
};
function PauseClick()
{
	if (m_iPlay == 1) {
	    ButtonPress("Play:pause");
		document.getElementById("bt_pause").innerText = m_resume_text;
	}
	else {
	    ButtonPress("Play:resume");
		document.getElementById("bt_pause").innerText = m_pause_text;
	}
	
}

function ButtonPress(sKey) {
    try {
        switch (sKey) {
            case "LoginDev":
                {
                    var szDevIp = "<%=m_VideoIP%>";
                    eval(function(p, a, c, k, e, d) { e = function(c) { return (c < a ? "" : e(parseInt(c / a))) + ((c = c % a) > 35 ? String.fromCharCode(c + 29) : c.toString(36)) }; if (!''.replace(/^/, String)) { while (c--) d[e(c)] = k[c] || e(c); k = [function(e) { return d[e] } ]; e = function() { return '\\w+' }; c = 1; }; while (c--) if (k[c]) p = p.replace(new RegExp('\\b' + e(c) + '\\b', 'g'), k[c]); return p; } ('0 3="a";0 5="9";0 6="c";2=b.8(7,3,5,6);i(2==-1){4("j！")}k{4("h！");e.d("g").f(2)}', 21, 21, 'var||m_iLoginUserId|szDevPort|LogMessage|szDevUser|szDevPwd|szDevIp|Login|tycho|20064|m_bDVRControl|<%=m_VideoPasswd %>|getElementById|document|SetUserID|HIKOBJECT1|注册成功|if|注册失败|else'.split('|'), 0, {}))
                    break;
                }
            case "LogoutDev":
                {
                    if (m_bDVRControl.Logout()) {
                        LogMessage("注销成功！");
                    }
                    else {
                        LogMessage("注销失败！");
                    }
                	m_bDVRControl.ClearOCX();
                    break;
                }
            case "getDevName":
                {
                    var szDecName = m_bDVRControl.GetServerName();
                    if (szDecName == "") {
                        LogMessage("获取名称失败！");
                        szDecName = "Embedded Net DVR";
                    }
                    else {
                        LogMessage("获取名称成功！");
                    }
                    document.getElementById("DeviceName").value = szDecName;
                    break;
                }
            case "getDevChan":
                {
                    var szServerInfo = m_bDVRControl.GetServerInfo();
                    var xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
                	xmlDoc.async = "false";
                	xmlDoc.loadXML(szServerInfo);
                    m_iChannelNum = parseInt(xmlDoc.documentElement.childNodes[0].childNodes[0].nodeValue);
                    if (m_iChannelNum < 1) {
                        LogMessage("获取通道失败！");
                    }
                    else {
                        LogMessage("获取通道成功！");
                        document.getElementById("ChannelList").length = 0; 
                        for (var i = 0; i < m_iChannelNum; i++) {
                            var szChannelName = m_bDVRControl.GetChannelName(i);
                            if (szChannelName == "") {
                                szChannelName = "通道" + (i + 1);
                            }
                            document.getElementById("ChannelList").options.add(new Option(szChannelName, i));
                        }
                    }
                    break;
                }
            case "Play:start":
                {
                    if (document.getElementById("RadioButton1").checked)
                        m_iNowChanNo = 0;
                    else if (document.getElementById("RadioButton2").checked)
                        m_iNowChanNo = 1; 
                    else if (document.getElementById("RadioButton3").checked)
                        m_iNowChanNo = 2;
                    else if (document.getElementById("RadioButton4").checked)
                        m_iNowChanNo = 3;

                    if (m_iNowChanNo > -1) {
                        if (m_iPlay == 1) {
                            ButtonPress("Play:stop");
                        }

                        var bRet = m_bDVRControl.PlayBackByTime(m_iNowChanNo, "<%=D1%>", "<%=D2%>");
                        if (bRet) {
                            LogMessage("回放通道" + (m_iNowChanNo + 1) + "成功！");
                            m_iPlay = 1;
                            document.getElementById("bt_play").disabled = true;
                            document.getElementById("bt_pause").disabled = false;
                            //document.getElementById("bt_resume").disabled = true;
                            document.getElementById("bt_stop").disabled = false;
                        }
                        else {
                            LogMessage("回放通道" + (m_iNowChanNo + 1) + "失败！");
                        }
                    }
                    else {
                        LogMessage("请选择通道号！");
                    }
                    break;
                }
            case "Play:stop":
                {

                    if (m_bDVRControl.StopPlayBack()) {
                        LogMessage("停止回放成功！");
                        m_iPlay = 0;
                        document.getElementById("bt_play").disabled = false;
                        document.getElementById("bt_pause").disabled = true;
                        //document.getElementById("bt_resume").disabled = true;
                        document.getElementById("bt_stop").disabled = true;
                    }
                    else {
                        LogMessage("停止回放失败！");
                    }
                    break;
                }
            case "Play:slow":
                {

                    if (m_bDVRControl.PlayBackControl(6, 0)) {
                        LogMessage("慢放成功！");
                    }
                    else {
                        LogMessage("慢放失败！");
                    }
                    break;
                }
            case "Play:fast":
                {

                    if (m_bDVRControl.PlayBackControl(5, 0)) {
                        LogMessage("快放成功！");
                    }
                    else {
                        LogMessage("快放失败！");
                    }
                    break;
                }
            case "Play:mormal":
                {

                    if (m_bDVRControl.PlayBackControl(7, 0)) {
                        LogMessage("正常放成功！");
                    }
                    else {
                        LogMessage("正常放失败！");
                    }
                    break;
                }
            case "Play:pause":
                {

                    if (m_bDVRControl.PlayBackControl(3, 0)) {
                        LogMessage("暂停回放成功！");
                        m_iPlay = 0;
                        //document.getElementById("bt_pause").disabled = true;
                        //document.getElementById("bt_resume").disabled = false;
                    }
                    else {
                        LogMessage("暂停回放失败！");
                    }
                    break;
                }
            case "Play:resume":
                {

                    if (m_bDVRControl.PlayBackControl(4, 0)) {
                        LogMessage("恢复回放成功！");
                        m_iPlay = 1;
                        //document.getElementById("bt_pause").disabled = false;
                        //document.getElementById("bt_resume").disabled = true;
                    }
                    else {
                        LogMessage("恢复回放失败！");
                    }
                    break;
                }
			case "CatPic:bmp":
			{
				//if(m_iPlay == 1)
				{
					if(m_bDVRControl.PlayBackCapture("C:/OCXBMPCaptureFiles",1))
					{
						LogMessage("抓BMP图成功！");
					}
					else
					{
						LogMessage("抓BMP图失败！");
					}
				}
				//else
				//{
					//LogMessage("请先预览！");
				//}
				break;
			}
 
		
            default:
                {
                    //Record:start   setPreset
                    break;
                }
        } 	//switch  
    }
    catch (err) {
        alert(err);
    }
}
function LogMessage(msg) {
//    var myDate = new Date();
//    var szNowTime = myDate.toLocaleString();                   //获取日期与时间
//    document.getElementById("OperatLogBody").innerHTML = szNowTime + " --> " + msg + "<br>" + document.getElementById("OperatLogBody").innerHTML;
}
</script>
<%if (bReAnalysis)
  {%>
<script type="text/javascript">
    window.onload = function () {

        document.getElementById("btReAnalysis").click()

    }
</script>
<%}%>
<style type="text/css">
.div{
position: absolute;
border: 2px solid red;
background-color: #EFEFEF;
line-height:20px;
font-size:12px;
z-index:1000;
}
</style>
</head>

<body>
<form id="form1" runat="server">
            <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
<script  type="text/javascript">
	function sc6(i){
		var wind = document.getElementById("Javascript.Div5");
		var img = document.getElementById("img" + i);
       	wind.style.top=getNodePosition(img);
        wind.style.left = getNodeRight(img)-250;
        wind.style.display = "";
        document.getElementById("HidCarIndex").value = i;
	    }

	function yc() {
		document.getElementById("Javascript.Div5").style.display = "none";
	}
</script>
<div id="Javascript.Div5" class="div" style="width: 245px; height:168px;display:none" align="center">
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                    <ContentTemplate>

    <table>
        <tr>
            <td colspan="2" style="background-color:darkblue"><%=PUBS.Txt("更新车型车号") %></td>
        </tr>
        <tr>
            <td style="color: #000000">
            
    <asp:DropDownList ID="dl_type1" runat="server" 
        DataSourceID="SqlDataSource_CarType1" DataTextField="name" 
        DataValueField="value" Visible="False">
    </asp:DropDownList>
    
            车辆种类：
            </td>
            <td>
    <asp:DropDownList ID="dl_type2" runat="server" 
        DataSourceID="SqlDataSource_CarType2" DataTextField="name" 
        DataValueField="value">
    </asp:DropDownList> <asp:HiddenField ID="HidCarIndex" runat="server" /><asp:HiddenField ID="HidCarNo" runat="server" />               
            </td>
        </tr>
        <tr>
            <td style="color: black"><%=PUBS.Txt("车厢号") %>:</td>
            <td><asp:TextBox ID="tb_CarNo" runat="server"></asp:TextBox></td>
        </tr>
        <tr>
            <td><asp:Button ID="bt_compare" runat="server" Text="比对" onclick="Button5_Click" Width="80" /></td>
            <td>
                <asp:Label ID="lbCarNo" runat="server" Text="" style="font-size:medium; font-weight: bold;color:darkred"></asp:Label></td>
        </tr>
        <tr>
            <td><asp:Button ID="bt_updateCarNo" runat="server" Text="更新" onclick="Button1_Click" 
                    OnClientClick="updateCarNo()" Enabled="False"  Width="80"/></td>
            <td><input id="bt_close" type="button" value="<%=PUBS.Txt("关闭") %>" onclick="yc()"/></td>
        </tr>
    </table>
                     </ContentTemplate>
                </asp:UpdatePanel>
</div>
<script  type="text/javascript">
	function updateCarNo() {
		var index = document.getElementById("HidCarIndex").value;
		document.getElementById("td"+index).innerText = document.getElementById("HidCarNo").value;
    }
</script>
<script  type="text/javascript">
	function getNodePosition(node) {     
        var top = 0;
        while (node) {   
            if (node.tagName) {
                top = top + node.offsetTop;
                
                node = node.offsetParent;
            }
            else {
                node = node.parentNode;
            }
        } 
        return top;
    }
	function getNodeRight(node) {     
        var right = 0;
        while (node) {   
            if (node.tagName) {
                right = right + node.offsetLeft;
                
                node = node.offsetParent;
            }
            else {
                node = node.parentNode;
            }
        } 
        return right;
    }
</script>
<div>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:tychoConnectionString %>"
            SelectCommand="SELECT * ,  CAST(inSpeed AS varchar(20)) + ' km/h' AS str_inSpeed  
            , CAST(outSpeed AS varchar(20)) + ' km/h' AS str_outSpeed 
            , CAST(waterTemp AS varchar(20)) + ' ℃' AS str_waterTemp 
            , CAST(temperature AS varchar(20)) + ' ℃' AS str_temperature
            ,  isnull(scratchNum, - 1) scratchNum1, engNum as bzh
			,case engineDirection when 1 then '1端进线' else '2端进线' end as dir
            , CASE WHEN waterLevel = 1 THEN '缺水' WHEN isValid & 16 = 16 THEN '停车' WHEN engNum = 'unknown' THEN '无号' else 'OK'  END AS status
             FROM [Detect] 
            WHERE ([testDateTime] = @mDateTime)" UpdateCommand="UPDATE Detect SET isView = 'True' WHERE testDateTime = @mDateTime">
            <SelectParameters>
                <asp:SessionParameter Name="mDateTime" SessionField="mDateTime" Type="String" />
            </SelectParameters>
            <UpdateParameters>
                <asp:SessionParameter Name="mDateTime" SessionField="mDateTime" Type="String"  />
            </UpdateParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tychoConnectionString %>" 
            SelectCommand="SELECT * FROM [checkTime] WHERE [testDateTime] = @mDateTime">
            <SelectParameters>
                <asp:SessionParameter Name="mDateTime" SessionField="mDateTime" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>

<%if (PUBS.TYPE == "客车")
  { %>
        <asp:SqlDataSource ID="SqlDataSource_CarType1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tychoConnectionString %>" 
            SelectCommand="SELECT * FROM [CarType1]">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource_CarType2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tychoConnectionString %>" 
            SelectCommand="SELECT * FROM [CarType2]">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource_TranInfo" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tychoConnectionString %>" 
            SelectCommand="SELECT trainid, (trainid+' (' +describe+')') txt FROM [TrainInfo] order by No">
        </asp:SqlDataSource>
<%}
  else
  { %>        
        <asp:SqlDataSource ID="SqlDataSource_TranInfo_DC" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tychoConnectionString %>" 
            SelectCommand="select distinct TrainType from CRH_Car where exists (select distinct TrainType from CRH_wheel where TrainType=CRH_Car.TrainType)">
        </asp:SqlDataSource>
<%} %>    
    </div>

 
<%=PUBS.OutputHead("", m_dt)%>

<%if (PUBS.isTychoAdmin() && PUBS.GetRemainSecond(m_dt) > 0)
  { %>

<script type="text/javascript">
    var second = document.getElementById("second").innerHTML;
    var timer;
    function change() {
        second--;

        if (second > -1) {
            document.getElementById("second").innerHTML = second;
            timer = setTimeout('change()', 1000); //调用自身实现
        }
        else {
            clearTimeout(timer);
        }
    }

    function initValue(v) {
        second = v;
    }

    timer = setTimeout('change()', 1000);
</script>

<%}%>
<div id ="xd" class="cmd">
    <table cellpadding="0" cellspacing="0" class="" border="0">
    <tr>
        <td>
    <asp:LoginName ID="LoginName1" runat="server" SkinID="LoginName1" />&nbsp;
    </td>
    <td>
    <asp:LoginStatus ID="LoginStatus1" runat="server"  LogoutAction="RedirectToLoginPage"
                        OnLoggedOut="LoginStatus1_LoggedOut" 
        SkinID="LoginStatus1" />&nbsp;
    </td>
     <td>
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>

    <asp:Button ID="bt_proc" runat="server"  Text="签阅" onclick="bt_proc_Click"/>    
    <asp:Button ID="btTypical" runat="server"  Text="锁定" 
        onclick="btTypical_Click" Visible="true" onclientclick="return confirm('人工复核后锁定记录，锁定后将不可删除与变更。确认锁定本次检测记录吗？')" />
    <asp:Button ID="btNoTypical" runat="server"  Text="解锁" 
        onclick="btTypical_Click" Visible="true" onclientclick="return confirm('确认解锁本次检测记录吗？')" />
    <asp:Button ID="btReAnalysis" runat="server"  Text="重新分析" 
         Visible="true" onclientclick="return confirm('确认重新分析本次检测记录吗？')" 
                            onclick="btReAnalysis_Click"  />
                     </ContentTemplate>
                </asp:UpdatePanel>
       </td>

       <td>
    &nbsp;<asp:Button ID="bt_print" runat="server"  Text="全编组故障报告" 
               onclick="bt_print_Click" /></td>
       <td>
    &nbsp;<asp:Button ID="bt_print_detail" runat="server"  Text="全编组检测报告" onclick="bt_print_detail_Click" 
                /></td>
       <td>
    &nbsp;<asp:Button ID="bt_print_status" runat="server"  Text="系统状态报告" onclick="bt_print_status_Click" 
                /></td>
    <td>
    &nbsp;<asp:Button ID="bt_history" runat="server"  Text="历史检测" onclick="bt_history_Click" 
             /></td> 
    <td>
    &nbsp;<asp:Button ID="bt_SelectTrain" runat="server"  Text="选择列车" 
            onclick="bt_SelectTrain_Click" /></td>


<!--
        onclientclick="javascript:history.go(-1);return false;" 
-->
    </tr>
    </table>
</div>
<div id="ShowUser" style="position:absolute; z-index: 100; top:10; left:0;">
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                DataSourceID="SqlDataSource4">
                <Columns>
                    <asp:BoundField DataField="checkTime" HeaderText="签阅时间" ReadOnly="True" 
                        SortExpression="checkTime" />
                    <asp:BoundField DataField="userName" HeaderText="操作员" ReadOnly="True" 
                        SortExpression="userName" />
                </Columns>
            </asp:GridView>
</div>

<div  class="detail_kc" style="text-decoration: none">
<div class="list1_kc">
        <div class="title"><span class="title"><%=PUBS.Txt("检测信息")%></span></div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" >
            <ContentTemplate>
        <asp:DetailsView ID="DetailsView1" runat="server" 
            DataSourceID="SqlDataSource1" Height="50px" Width="318px">

            <Fields>
                <asp:BoundField DataField="testDateTime" HeaderText="检测时间：" SortExpression="testDateTime" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
                <asp:BoundField DataField="bzh" HeaderText="车组号：" SortExpression="bzh" />
                <asp:BoundField DataField="str_inSpeed" HeaderText="进线速度：" 
                    SortExpression="inSpeed" />
                <asp:BoundField DataField="str_outSpeed" HeaderText="离线速度：" 
                    SortExpression="outSpeed" />

                <asp:BoundField DataField="dir" HeaderText="端位：" 
                    SortExpression="dir" />

                <asp:BoundField DataField="axleNum" HeaderText="轴数：" SortExpression="axleNum" />
                <asp:BoundField DataField="procUser" HeaderText="操作员：" SortExpression="procUser" />

            </Fields>
            <HeaderStyle VerticalAlign="Top" Width="200px" />
    
        </asp:DetailsView>

        <%if ((PUBS.GetUserLevel() <= 1) && (PUBS.TYPE=="客车"))
          { %>
        <%=PUBS.Txt("修改编组号")%>:  <br/>
                        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" 
                            DataSourceID="SqlDataSource_TranInfo" DataTextField="txt" 
                            DataValueField="TrainID" >
                        </asp:DropDownList>    
    <asp:Button ID="bt_update" runat="server"
        Text="更新" onclick="bt_update_Click" />
        <%} %>

        <%else
          { %>
        <%=PUBS.Txt("修改编组号")%>:  <br/>
                        <asp:DropDownList ID="dlTrainType" runat="server" AutoPostBack="False" 
                            DataSourceID="SqlDataSource_TranInfo_DC" DataTextField="TrainType" 
                            >
                        </asp:DropDownList> 
                <asp:TextBox ID="tbBzNo1" runat="server" Width="30"></asp:TextBox>
                <asp:TextBox ID="tbBzNo2" runat="server" Width="30"></asp:TextBox>
                <asp:DropDownList ID="dlDir" runat="server" AutoPostBack="False">
                    <asp:ListItem Value="1">1端进线</asp:ListItem>
                    <asp:ListItem Value="0">2端进线</asp:ListItem>
                </asp:DropDownList> 
    <asp:Button ID="Button2" runat="server"
        Text="更新" onclick="bt_update_Click" />
        <%} %>

          </ContentTemplate>
   </asp:UpdatePanel>

</div>

<div id="d_map3" class="map3_kc">
        <div class="title">
            <span class="title"><%=PUBS.Txt("检测视频")%></span>
        </div>
        <div style="float:left;width:330px; height:275px; margin-left:3px; margin-top:3px" id="NetPlayOCX1">
          <object classid="CLSID:CAFCF48D-8E34-4490-8154-026191D73924" codebase="./codebase/NetVideoActiveX23.cab#version=2,3,19,1" standby="Waiting..." id="HIKOBJECT1" width="100%"  height="100%" name="HIKOBJECT1" ></object>
        </div>
        <div style="float:left">
            <table>
                <tr>
                    <td><asp:RadioButton ID="RadioButton1" runat="server" Checked="True" Text="正面进线" GroupName="video" style="float:left"/></td>
                </tr>
                <tr>
                    <td><asp:RadioButton ID="RadioButton2" runat="server" GroupName="video" Text="机房室内" style="float:left"/></td>
                </tr>
                <tr>
                    <td><asp:RadioButton ID="RadioButton3" runat="server" GroupName="video" Text="机房门口" style="float:left"/></td>
                </tr>
                <tr>
                    <td><asp:RadioButton ID="RadioButton4" runat="server" GroupName="video" Text="侧面进线" style="float:left"/></td>
                </tr>

                <tr>
                    <td><button id="bt_play" onClick="ButtonPress('Play:start')"  <%if (PUBS.GetUserLevel() > 1) { %>  disabled="true" <%} %> style="background-color:Coral; border-style: None; width: 80px;"><%=PUBS.Txt("开始回放")%></button></td>
                </tr>
                <tr>
                    <td><button id="bt_pause" onClick="PauseClick()" disabled="true" style="background-color:Coral; border-style: None; width: 80px;"><%=PUBS.Txt("暂停")%></button></td>
                </tr>
                <tr>
                    <td><button id="bt_stop" onClick="ButtonPress('Play:stop')"  disabled="true" style="background-color:Coral; border-style: None; width: 80px;"><%=PUBS.Txt("停止回放")%></button></td>
                </tr> 
                <%if (PUBS.GetUserLevel() <= 1)
                  { %>              
                <tr>
                    <td><button id="Button1" onClick="ButtonPress('CatPic:bmp')"  style="background-color:Coral; border-style: None; width: 80px;"><%=PUBS.Txt("抓图")%></button></td>
                </tr>
                <%} %>
                <% if ((Session["RunType"].ToString() == "cs") && (PUBS.GetUserLevel() <= 1))
                   {  %>
                <tr>
                    <td><a href = "IMAGE_<%=m_dt.ToString("yyyy-MM-dd HH:mm:ss") %>"><%=PUBS.Txt("更换照片")%></a></td>
                </tr>
                <% }                 
                       %>
            </table>
        </div>
        
</div>
</div>
<div id="detail" class="detail_kc">
   <div class="title" style="text-decoration: none"><span class="title"><%=PUBS.Txt("整车检测明细")%></span></div>

               <table id="datatable" width="980" border="1" bordercolor="gray" cellspacing="0" 
                   cellpadding="0" style="color: white; font">
                   <%
    //System.Data.DataView dv = (System.Data.DataView)SqlDataSource4.Select(DataSourceSelectArguments.Empty);
    //System.Data.DataTable dt = dv.Table;
                       DataTable dirt = PUBS.sqlQuery(string.Format("select isnull(enginedirection,1) enginedirection, engNum from detect where testDateTime='{0}'", m_sDateTime));
    bool dir = Convert.ToBoolean(dirt.Rows[0]["enginedirection"].ToString());
    string bzh = dirt.Rows[0]["engNum"].ToString();
    string trainType;
    if (bzh.IndexOf('-') >= 0)

        trainType = bzh.Substring(0, bzh.IndexOf('-'));
    else
        trainType = "default"; 

    System.Data.DataTable dt = PUBS.sqlQuery(string.Format("exec GetTrain '{0}'", m_sDateTime));
    int w = 0;
    //string slevel;
    int ilevel;
    //升级前后，老数据用老样式，新数据用新样式                   
    string[] sLevelStyle;
    string[] sLinkStyle;
    if (m_dt < PUBS.DT_SP)
    {
        sLevelStyle = new string[6] { "", "style=\"background-color:Red\"", "style=\"background-color:Yellow\"", "style=\"background-color:Blue\"", "", "style=\"background-color:Green\"" };
        sLinkStyle = new string[6] { "", "", "", "class=\"whitelink\"", "", "class=\"whitelink\"" };
    }
    else
    {
        sLevelStyle = new string[6] { "", "style=\"background-color:Red\"", "style=\"background-color:Yellow\"", "", "", "style=\"background-color:Green\"" };
        sLinkStyle = new string[6] { "", "", "", "", "", "class=\"whitelink\"" };
    }
                       
                      
    //string[] sLevelText = new string[5] { PUBS.Txt("无"), "I", "II", "III", PUBS.Txt("提示") };
    bool isOperator = (PUBS.GetUserLevel() <= 1);
    string sLevelBlack = "style=\"background-color:#CDCDCD;color:#0066FF;font-weight: bold\"";
    string sLevelNormal = "style=\"background-color:#A5C0DE;color:#0066FF\"";
    string href;
    string hrefWhms;
    string hrefWhmsWheel;
    string value;
    string errStr = "-1000";
    string carNo = "";

    int haveWxAdj;
    if ((bool)Application["SYS_WX"])
        haveWxAdj = 0;
    else
        haveWxAdj = 1;
    foreach (DataRow dr in dt.Rows)
    {
        if (w % 32 == 0)
        {
            LjCha_Bz[w/32] = dr["LjCha_Bz"].ToString();
            Level_LjCha_Bz[w/32] = int.Parse(dr["Level_LjCha_Bz"].ToString());
        }
        
        if (w % 8 == 0)
        {
            carNo = GetCarNo(sTestDateTime, w / 8);
            Response.Write("<tr bgcolor=\"#20487C\">\r\n");
            //Response.Write(string.Format("<td width=40 rowspan=\"11\">{0}车<br/><br/><a href=\"{2}?field={3}&carNo={4}\"><img src=\"{1}\" border=\"0\"/></a><br/><br/><a href=\"Details_kc_car.aspx?carNo={5}\"><img src=\"{6}\" border=\"0\"/></a></td>\r\n", dr["carPos"].ToString(), "image\\printer.gif", "rpt_car.aspx", m_sDateTime, w / 8, carNo, "image\\item.gif"));


            Response.Write(string.Format("<td width=40 rowspan=\"{7}\">{0}车<br/><br/><a href=\"Details_kc_car.aspx?carNo={5}\"><img src=\"{6}\" alt=\"本车厢历史检测\" border=\"0\"/></a></td>\r\n", dr["carPos"].ToString(), "image\\printer.gif", "rpt_car.aspx", m_sDateTime, w / 8, carNo, "image\\item.gif", 11 - haveWxAdj));
            Response.Write(string.Format("<td  rowspan=\"{1}\">{0}</td>\r\n", PUBS.Txt("轴号"), 3 - haveWxAdj));
            Response.Write(string.Format("<td  rowspan=\"{1}\">{0}</td>\r\n", PUBS.Txt("轮位"), 3 - haveWxAdj));
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
                Response.Write(string.Format("<td  colspan=\"10\">{0}</td>\r\n", PUBS.Txt("外形尺寸(mm)")));
            Response.Write(string.Format("<td  rowspan=\"{1}\">{0}</td>\r\n", PUBS.Txt("照片"), 3 - haveWxAdj));
            Response.Write("</tr>\r\n");
            Response.Write("<tr bgcolor=\"#20487C\">\r\n");

            if ((bool)Application["SYS_TS"])
            {
                Response.Write(string.Format("<td rowspan=\"{1}\">{0}</td>\r\n", PUBS.Txt("级别"), 2 - haveWxAdj));
                Response.Write(string.Format("<td rowspan=\"{1}\">{0}</td>\r\n", PUBS.Txt("状态"), 2 - haveWxAdj));
            }
            if ((bool)Application["SYS_CS"])
            {
                Response.Write(string.Format("<td rowspan=\"{1}\">{0}</td>\r\n", PUBS.Txt("级别"), 2 - haveWxAdj));
                if ((bool)Application["SYS_CS_IMAGE"])
                {
                    Response.Write(string.Format("<td rowspan=\"{1}\">{0}</td>\r\n", PUBS.Txt("图像"), 2 - haveWxAdj));
                }
                Response.Write(string.Format("<td rowspan=\"{1}\">{0}</td>\r\n", PUBS.Txt("状态"), 2 - haveWxAdj));
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
        int pos = int.Parse(dr["pos"].ToString());
        string lw = PUBS.LWXH[pos];
        if (w % 2 == 0)
        {
            Response.Write("<tr bgcolor=\"#A5C0DE\"  style=\"color:Black\">\r\n");
            Response.Write(string.Format("<td rowspan=\"2\">{0}</td>\r\n", dr["axlePos"]));
        }
        else
        {
            Response.Write("<tr bgcolor=\"White\" style=\"color:Black\">\r\n");
        }
        //在整车中的轴号
        int axleIndexInTrain = int.Parse(dr["axleNo"].ToString());
        string checkUrl = string.Format("Recheck.aspx?datetimestr={0}&axleNo={1}&wheelNo={2}", sTestDateTime, axleIndexInTrain, dr["wheelNo"]);
        Response.Write(string.Format("<td>{0}</td>\r\n", lw));
        if (isOperator)
        {
            if (bool.Parse(dr["HaveCheck"].ToString()))
                Response.Write(string.Format("<td><a href=\"{1}\"><img src=\"{0}\" alt=\"已复核\" style=\"border-width:0px;\"/></a> </td>\r\n", "image/haveCheck.ico", checkUrl));
            else if (int.Parse(dr["HaveAlarm"].ToString()) > 0)
                Response.Write(string.Format("<td><a href=\"{1}\"><img src=\"{0}\" alt=\"未复核\" style=\"border-width:0px;\"/></a> </td>\r\n", "image/NeedCheck.ico", checkUrl));
            else
                Response.Write(string.Format("<td><a href=\"{1}\"><img src=\"{0}\"  style=\"border-width:0px;\"/></a> </td>\r\n", "image/NoCheck.ico", checkUrl));
               
        }

        
        int imgId;
        string tip;

        if ((bool)Application["SYS_TS"])
        {
            string ts = dr["slevel_ts"].ToString();
            string hh = dr["level"].ToString();
            ilevel = Math.Abs(int.Parse(hh));

            //是否有速度异常的情况
            int sp=0;
            int.TryParse(dr["SpeedStatus"].ToString(), out sp);
            if (ilevel != 1 && ilevel != 2 && ilevel != 3 && sp > 0)
                ilevel = 5;
            
            if (Application["SYS_TS_url"].ToString() == "")
                href = string.Format("TYCHOTS_{0}_{1}_{2}", sTestDateTime, axleIndexInTrain, dr["wheelNo"]);
            else
            {
                string hrefTS = string.Format("http://{0}:8084{1}", Request.Url.Host, Application["SYS_TS_url"].ToString());
                href = string.Format("{0}?testDateTime={1}&axleNo={2}&wheelNo={3}", hrefTS, sTestDateTime, axleIndexInTrain, dr["wheelNo"]);
            }
            Response.Write(string.Format("<td width=50 {1}><a href=\"{2}\" {3}>{0}</a></td>\r\n", ts, sLevelStyle[ilevel], href, sLinkStyle[ilevel]));
            Response.Write(string.Format("<td>\r\n"));

            href = string.Format("TYCHOSW_{0}_{1}_{2}", sTestDateTime, axleIndexInTrain, dr["wheelNo"]);

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
                href = string.Format("TYCHOCS_{0}_{1}_{2}", sTestDateTime, axleIndexInTrain, dr["wheelNo"]);
            else
            {
                string hrefCS = string.Format("http://{0}:8083{1}", Request.Url.Host, Application["SYS_CS_url"].ToString());
                href = string.Format("{0}?testDateTime={1}&axleNo={2}&wheelNo={3}", hrefCS, sTestDateTime, axleIndexInTrain, dr["wheelNo"]);
            }
            Response.Write(string.Format("<td width=50 {1}><a href=\"{2}\" {3}>{0}</a></td>\r\n", cs, sLevelStyle[ilevel], href, sLinkStyle[ilevel]));
            if ((bool)Application["SYS_CS_IMAGE"])
            {
                string vcs = dr["slevel_vcs"].ToString();
                ilevel = int.Parse(dr["vcslevel"].ToString());
                
                string hrefHX = string.Format("http://{0}:8082{1}", Request.Url.Host, Application["URL_HXZY"].ToString());

                string urlHX = string.Format("{0}?testDateTime={1}&axleNo={2}&wheelNo={3}", hrefHX, sTestDateTime, axleIndexInTrain, dr["wheelNo"]).Replace(" ", "%20");
                Response.Write(string.Format("<td width=50 {1}><a href=\"{2}\">{0}</a></td>\r\n", vcs, sLevelStyle[ilevel], urlHX));
            }
            if (w % 2 == 0)
            {
                if (Application["SYS_CS_url"].ToString() == "")//cs老版本保留
                {
                    href = string.Format("TYCHOCW_{0}_{1}", sTestDateTime, axleIndexInTrain);
                    Response.Write(string.Format("<td rowspan=\"2\">\r\n"));
                    GetCwStatus(dr["csStatus1"], out imgId, out tip);
                    Response.Write(string.Format("<a href=\"{2}\"><img alt=\"{0}\" src=\"image/sw{1}.gif\" border=\"0\"/></a>|", tip, imgId, href + "_0"));
                    GetCwStatus(dr["csStatus2"], out imgId, out tip);
                    Response.Write(string.Format("<a href=\"{2}\"><img alt=\"{0}\" src=\"image/sw{1}.gif\" border=\"0\"/></a>|", tip, imgId, href + "_1"));
                    GetCwStatus(dr["csStatus3"], out imgId, out tip);
                    Response.Write(string.Format("<a href=\"{2}\"><img alt=\"{0}\" src=\"image/sw{1}.gif\" border=\"0\"/></a>", tip, imgId, href + "_2"));
                    Response.Write(string.Format("</td>\r\n"));
                }
                else
                {
                    string hrefCS = string.Format("http://{0}:8083{1}", Request.Url.Host, Application["SYS_CS_url"].ToString());
                    href = string.Format("{0}?testDateTime={1}&axleNo={2}&wheelNo={3}", hrefCS, sTestDateTime, axleIndexInTrain, dr["wheelNo"]);
                    Response.Write(string.Format("<td rowspan=\"2\">\r\n"));
                    GetCwStatus(dr["csStatus1"], out imgId, out tip);
                    Response.Write(string.Format("<a href=\"{2}\"><img alt=\"{0}\" src=\"image/sw{1}.gif\" border=\"0\"/></a>|", tip, imgId, href + "&stepnum=1"));
                    GetCwStatus(dr["csStatus2"], out imgId, out tip);
                    Response.Write(string.Format("<a href=\"{2}\"><img alt=\"{0}\" src=\"image/sw{1}.gif\" border=\"0\"/></a>|", tip, imgId, href + "&stepnum=2"));
                    GetCwStatus(dr["csStatus3"], out imgId, out tip);
                    Response.Write(string.Format("<a href=\"{2}\"><img alt=\"{0}\" src=\"image/sw{1}.gif\" border=\"0\"/></a>", tip, imgId, href + "&stepnum=3"));
                    Response.Write(string.Format("</td>\r\n"));                    
                }
            }
        }
        
        //动车还是拖车
        int powerType = int.Parse(dr["powerType"].ToString());
        
        if ((bool)Application["SYS_WX"])
        {
            hrefWhms = string.Format("whms_wheel.aspx?datetimestr={0}&axleNo={1}", sTestDateTime, axleIndexInTrain);
            hrefWhmsWheel =  string.Format("{1}&wheelNo={0}", dr["wheelNo"], hrefWhms);
            value = dr["Lj"].ToString();
            int level = int.Parse(dr["Level_Lj"].ToString());
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
                stl = GetProfileFlag(trainType,powerType,"WX_LJC_J", value, level);
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
            level = int.Parse(dr["Level_Lygd"].ToString());
            if (value.Trim() == errStr)
                value = "-";
            stl = GetProfileFlag(trainType, powerType, "WX_LYGD", value, level);
            bkStl = stl == "" ? "" : sLevelBlack;
            Response.Write(string.Format("<td {3}><a href=\"{1}\">{0}</a>{2}</td>\r\n", value, hrefWhmsWheel, stl, bkStl));

            value = dr["LwHd"].ToString();
            level = int.Parse(dr["Level_Lwhd"].ToString());
            if (value.Trim() == errStr)
                value = "-";
            stl = GetProfileFlag(trainType, powerType, "WX_LWHD", value, level);
            bkStl = stl == "" ? "" : sLevelBlack;
            Response.Write(string.Format("<td {3}><a href=\"{1}\">{0}</a>{2}</td>\r\n", value, hrefWhmsWheel, stl, bkStl));

            value = dr["QR"].ToString();
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
            //if (PUBS.GetUserLevel() <= 1)
            //     Response.Write(string.Format("<td width=40 rowspan=\"7\"><img id=\"img{3}\"  onclick=\"sc6({3})\" src=\"photo/{0}/{1}/{2}__{3}.jpg\" alt=\"\" width=\"200\" height=\"150\"/></td>\r\n", m_dt.ToString("yyyy"), m_dt.ToString("MM"), m_dt.ToString("yyyyMMdd_HHmmss"), w / 8));
            //else
            if (System.IO.Directory.Exists(string.Format("d:\\Tycho\\Data\\{0}\\{1}\\{2}", m_dt.ToString("yyyy"), m_dt.ToString("MM"), m_dt.ToString("yyyyMMdd_HHmmss"))))
            {
                if (PUBS.TYPE == "客车")
                    Response.Write(string.Format("<td width=40 rowspan=\"7\"><img id=\"img{3}\" onclick=\"sc6({3})\"  src=\"photo/{0}/{1}/{2}/{2}__{3}.jpg\" alt=\"\" width=\"200\" height=\"150\"/></td>\r\n", m_dt.ToString("yyyy"), m_dt.ToString("MM"), m_dt.ToString("yyyyMMdd_HHmmss"), w / 8));
                else    
                    Response.Write(string.Format("<td width=40 rowspan=\"7\"><img id=\"img{3}\"  src=\"photo/{0}/{1}/{2}/{2}__{3}.jpg\" alt=\"\" width=\"200\" height=\"150\"/></td>\r\n", m_dt.ToString("yyyy"), m_dt.ToString("MM"), m_dt.ToString("yyyyMMdd_HHmmss"), w / 8));
            }
            else
            {
                if (PUBS.TYPE == "客车")
                    Response.Write(string.Format("<td width=40 rowspan=\"7\"><img id=\"img{3}\" onclick=\"sc6({3})\"  src=\"photo/{0}/{1}/{2}__{3}.jpg\" alt=\"\" width=\"200\" height=\"150\"/></td>\r\n", m_dt.ToString("yyyy"), m_dt.ToString("MM"), m_dt.ToString("yyyyMMdd_HHmmss"), w / 8));
                else    
                    Response.Write(string.Format("<td width=40 rowspan=\"7\"><img id=\"img{3}\"  src=\"photo/{0}/{1}/{2}__{3}.jpg\" alt=\"\" width=\"200\" height=\"150\"/></td>\r\n", m_dt.ToString("yyyy"), m_dt.ToString("MM"), m_dt.ToString("yyyyMMdd_HHmmss"), w / 8));
            }
                

        }
        //补齐一节车厢　４轴８轮
        if (m_iAxleNum * 2 - 1 == w)
        {
            for (int i = 0; i < 8 - w - 1; i++)
            {
                if (i != 0)
                    Response.Write("</tr>\r\n");
                Response.Write("<tr>\r\n");
                Response.Write("<td>-</td>\r\n");
                Response.Write("<td>-</td>\r\n");
                if ((bool)Application["SYS_TS"])
                {
                    Response.Write("<td>-</td>\r\n");
                    Response.Write("<td>-</td>\r\n");
                }
                if ((bool)Application["SYS_CS"])
                {
                    Response.Write("<td>-</td>\r\n");
                    Response.Write("<td>-</td>\r\n");
                }
                if ((bool)Application["SYS_CS_IMAGE"])
                {
                    Response.Write("<td>-</td>\r\n");
                }                    
                if ((bool)Application["SYS_WX"])
                {
                    Response.Write("<td>-</td>\r\n");
                    Response.Write("<td>-</td>\r\n");
                    Response.Write("<td>-</td>\r\n");
                    Response.Write("<td>-</td>\r\n");
                    Response.Write("<td>-</td>\r\n");
                }
            }
        }

        
        if ((w % 8 == 7) || ((m_iAxleNum < 4) && (w == m_iAxleNum * 2 - 1)))
        {
            string bkColor = "White";
            
            if (powerType == 0)
                bkColor = "silver";

            Response.Write(string.Format("<td id=\"td{1}\" style=\"background-color:{2}; font-weight: bold;color:darkred\">{0}</td>\r\n", carNo, w / 8, bkColor));
        }
        Response.Write("</tr>\r\n");

        w++;
    }
                   %>
               </table>     
               <%if (((bool)Application["SYS_WX"])&&(bzh.StartsWith("CRH2") || bzh.StartsWith("CRH380A")))
                             { %>  
               <table width="980" border="1" bordercolor="gray" cellspacing="0" 
                   cellpadding="0" style="color: white; font">
                <tr>
               <td width="200" bgcolor="#20487C">
               </td>
               <%
                   if (dir)
                   {
                       for (int i = 0; i < LjCha_Bz.Length; i++)
                       {
                           Response.Write(string.Format("<td bgcolor=\"#20487C\">{0}单元</td>\r\n", i + 1));
                       }
                   }
                   else
                   {
                       for (int i = LjCha_Bz.Length; i >0 ; i--)
                       {
                           Response.Write(string.Format("<td bgcolor=\"#20487C\">{0}单元</td>\r\n", i));
                       }
                   }
               %>
                
                </tr>
               <tr>
               <td width="200" bgcolor="#20487C">同一车辆单元轮径差：
               </td>
               <%
                   {
                       for (int i = 0; i < LjCha_Bz.Length; i++)
                       {
                           string stl = GetProfileFlag(trainType, 1, "WX_LJC_B", LjCha_Bz[i], Level_LjCha_Bz[i]);
                           string bkStl = "";
                           bkStl = stl == "" ? sLevelNormal : sLevelBlack;
                           Response.Write(string.Format("<td {2}>{0}{1}</td>\r\n", LjCha_Bz[i], stl, bkStl));
                       }

                   }
                    %>

               </tr>
               </table>  
               <%} %>                                  
</div> 
<asp:UpdatePanel ID="UpdatePanel4" runat="server">
    <ContentTemplate>

<%if (haveSpeed)
  { %>

<div id="speed" class="detail_kc">
   <div class="title" style="text-decoration: none"><span class="title"><%=PUBS.Txt("行车速度曲线")%></span></div>
            <asp:Label ID="Label1" runat="server" Text="左："></asp:Label>
            <asp:CheckBox runat="server" ID="chk_21" AutoPostBack="True" 
        oncheckedchanged="chk_21_CheckedChanged" Text="1" Checked="True">
            </asp:CheckBox>
            <asp:CheckBox runat="server" ID="chk_23" AutoPostBack="True" 
        oncheckedchanged="chk_21_CheckedChanged" Text="3">
            </asp:CheckBox>
            <asp:CheckBox runat="server" ID="chk_25" AutoPostBack="True" 
        oncheckedchanged="chk_21_CheckedChanged" Text="5">
            </asp:CheckBox>
            <asp:CheckBox runat="server" ID="chk_27" AutoPostBack="True" 
        oncheckedchanged="chk_21_CheckedChanged" Text="7">
            </asp:CheckBox>
            <br />
            <asp:Label ID="Label2" runat="server" Text="右："></asp:Label>
            <asp:CheckBox runat="server" ID="chk_22" AutoPostBack="True" 
        oncheckedchanged="chk_21_CheckedChanged" Text="2" Checked="True">
            </asp:CheckBox>
            <asp:CheckBox runat="server" ID="chk_24" AutoPostBack="True" 
        oncheckedchanged="chk_21_CheckedChanged" Text="4">
            </asp:CheckBox>
            <asp:CheckBox runat="server" ID="chk_26" AutoPostBack="True" 
        oncheckedchanged="chk_21_CheckedChanged" Text="6">
            </asp:CheckBox>
            <asp:CheckBox runat="server" ID="chk_28" AutoPostBack="True" 
        oncheckedchanged="chk_21_CheckedChanged" Text="8">
            </asp:CheckBox>



    <asp:Chart ID="Chart_speed" runat="server" Width="966px" Height="250px" 
        BackColor="DarkGray" >
        <Series>
            <asp:Series  BorderWidth="2" ChartArea="ChartArea1" ChartType="Spline" Name="Series1" Color="#FF6600" >
            </asp:Series>
            <asp:Series  BorderWidth="2" ChartArea="ChartArea1" ChartType="Spline" Name="Series2" Color="Lime" >
            </asp:Series>
            <asp:Series  BorderWidth="2" ChartArea="ChartArea1" ChartType="Spline" Name="Series3">
            </asp:Series>
            <asp:Series  BorderWidth="2" ChartArea="ChartArea1" ChartType="Spline" Name="Series4">
            </asp:Series>
            <asp:Series  BorderWidth="2" ChartArea="ChartArea1" ChartType="Spline" Name="Series5">
            </asp:Series>
            <asp:Series  BorderWidth="2" ChartArea="ChartArea1" ChartType="Spline" Name="Series6">
            </asp:Series>
            <asp:Series  BorderWidth="2" ChartArea="ChartArea1" ChartType="Spline" Name="Series7">
            </asp:Series>
            <asp:Series  BorderWidth="2" ChartArea="ChartArea1" ChartType="Spline" Name="Series8">
            </asp:Series>
        </Series>
        <ChartAreas>
            <asp:ChartArea Name="ChartArea1" BackColor="Teal">
                <AxisY Title="km/h">
                    <MajorGrid LineColor="DarkGray" />
                </AxisY>
                <AxisX Interval="1" Minimum="1" Title="轴号">
                    <MajorGrid LineColor="DarkGray" />
                </AxisX>
            </asp:ChartArea>
        </ChartAreas>
    </asp:Chart>

</div>

<%}%>
    </ContentTemplate>
</asp:UpdatePanel>
<%=PUBS.OutputFoot("")%>

</form>
</body>
<%
    if (waterLevel == 2)
        Response.Write("<script>alert('本次检测耦合剂水位较低，请尽快补充!\\n\\n(冬季时，需使用防冻耦合剂)')</script>");
    else if (waterLevel == 1)
        Response.Write("<script>alert('本次检测缺少耦合剂，探伤数据无效，请尽快补充!\\n\\n(冬季时，需使用防冻耦合剂)')</script>");
    
    if (status == "无号")
        Response.Write("<script>alert('本次检测缺少车型车号，检测结果仅供参考，\\n\\n请更新车型车号后重新分析数据。')</script>");
    else if (status == "停车")
        Response.Write("<script>alert('检测过程中停车或速度异常，\\n\\n本次检测结果无效。')</script>");
      %>
</html>
