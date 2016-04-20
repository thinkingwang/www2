<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DetectList.aspx.cs" Inherits="DetectList" Theme="theme" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<%@ Import Namespace="System.Collections.Generic" %>
<%@ Register Assembly="calendarDropDown" Namespace="Meta.Web.Controls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<meta http-equiv="pragma" content="no-cache">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title><%=PUBS.Txt("检测数据列表")%></title>
    <link href="css/tycho/tycho.css" type="text/css" rel="stylesheet"/>
    <link type="text/css" href="css/ui-lightness/jquery-ui-1.7.1.custom.css" rel="Stylesheet" />	
    <script type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
    <script type="text/javascript" src="js/jquery-ui-1.7.1.custom.min.js"></script>
    <script language="javascript" type="text/javascript" src="My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript">
	$.ui.dialog.defaults.bgiframe = true;
	$(function() {
		$("#dialog").dialog({ autoOpen: false });
	});
	</script>
    <style type="text/css">
        .style1
        {
            width: 100px;
        }
        .style3
        {
            width: 120px;
        }
    </style>
    </head>
<body>
<form id="form1" runat="server">

<!-- 浮动代码开始 -->

<div id="ShowAD" style="position:absolute; z-index: 100; display:none">
<div style="width:235px;height:18px;font-size:14px;font-weight:bold;text-align:left;CURSOR: hand;float:right" onClick="closead();"><font color=ff0000>关闭</font></div>
        <div class="content3">
        <div class="title"><span class="title"><%=PUBS.Txt("数据筛选")%></span></div>
                <table style="width: 100%;text-align:left">
                    <tr>
                        <td>
                            <table style="width: 100%">

                                <tr>
                                    <td style="width: 100px"><%=PUBS.Txt("检测时间")%>：</td>
                                    <td class="style1">
                                        <asp:DropDownList ID="dl_date" runat="server" 
                                             Width="100px">
                                            <asp:ListItem Selected="True" Value="All">全部</asp:ListItem>
                                            <asp:ListItem>指定</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                 </tr>
                            </table>
                            <table width="100%">
                                <tr>
                                    <td >
                                    <asp:Label ID="lb_from" runat="server" Text="从" Visible="true" Width="12px"></asp:Label>
                                    </td>
                                    <td style="width: 125px">
                                        <asp:TextBox ID="DropDownCalendar1" runat="server" Width="100" Visible="true" /><asp:Image  id="img_from"  runat="server"  onclick="WdatePicker({el:'DropDownCalendar1'})" src="My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle" Visible="true" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    <asp:Label ID="lb_to" runat="server" Text="至" Visible="true" Width="12"></asp:Label>
                                    </td>
                                    <td style="width: 125px">
                                        <asp:TextBox ID="DropDownCalendar2" runat="server" Width="100" Visible="true" /><asp:Image  id="img_to"  runat="server"  onclick="WdatePicker({el:'DropDownCalendar2'})" src="My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle" Visible="true" />
                                   </td>
                                </tr>
                            </table>
                            <table  style="width: 100%;text-align:left">
                                 <tr>
                                    <td>
                                        <%=PUBS.Txt("最少轴数")%>：
                                    </td>
                                    <td>

                                        <asp:DropDownList ID="dl_axle" runat="server" 
                                            Width="50px">
                                            <asp:ListItem Selected="True" Value=">">></asp:ListItem>
                                            <asp:ListItem  Value="=">=</asp:ListItem>
                                            <asp:ListItem  Value="<"><</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="tb_AxleNum" runat="server" Width="50px">1</asp:TextBox>
                                    </td>
                                 </tr>
                                <tr>
                                    <td style="width: 100px"><%=PUBS.Txt("车组号")%>：</td>
                                    <td colspan=2>
                                        <asp:TextBox ID="tb_bzh" runat="server" Width="100px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td  style="width: 100px">
                                       <%=PUBS.Txt("车厢号")%>:
                                    </td>
                                    <td colspan=2>
                                       <asp:TextBox ID="tb_cxh" runat="server" Width="100px"></asp:TextBox>
                                    </td>

                                </tr>
                                <tr>
                                    <td  style="width: 100px">
                                       <%=PUBS.Txt("复核锁定")%>:
                                    </td>
                                    <td colspan=2>
                                        <asp:DropDownList ID="dl_lock" runat="server" Width="100px">
                                            <asp:ListItem Value="All">全部</asp:ListItem>
                                            <asp:ListItem Value="1">已复核锁定</asp:ListItem>
                                            <asp:ListItem Value="0">未锁定</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>

                                </tr>
                                <tr>
                                    <td  style="width: 100px">
                                       <%=PUBS.Txt("检测结果")%>:
                                    </td>
                                    <td colspan=2>
                                        <asp:DropDownList ID="dl_all" runat="server" Width="100px">
                                            <asp:ListItem Value="All">全部</asp:ListItem>
                                            <asp:ListItem Value="True">有报警</asp:ListItem>
                                            <asp:ListItem style="background-color:mediumseagreen" Value="False">无报警</asp:ListItem>
                                            <asp:ListItem style="background-color:red" Value="1">&nbsp;I&nbsp;级报警</asp:ListItem>
                                            <asp:ListItem style="background-color:yellow" Value="2">II&nbsp;级报警</asp:ListItem>
                                            <asp:ListItem style="color:white;background-color:blue" Value="3">III级报警</asp:ListItem>
                                        </asp:DropDownList>

                                    </td>

                                </tr>
<%if ((bool)Session["SYS_TS"])
  {
 %>
                                <tr style="background-color:Olive">
                                <td  colspan=3 >
                                    探伤
                                </td>
                                </tr>
                                <tr>
                                    <td  style="width: 100px">
                                       <%=PUBS.Txt("缺陷级别")%>:
                                    </td>
                                    <td colspan=2>
                                        <asp:DropDownList ID="dl_level" runat="server" Width="100px">
                                            <asp:ListItem Value="All">全部</asp:ListItem>
                                            <asp:ListItem Value="True">有报警</asp:ListItem>
                                            <asp:ListItem style="background-color:mediumseagreen" Value="False">无报警</asp:ListItem>
                                            <asp:ListItem style="background-color:red" Value="1">&nbsp;I&nbsp;级报警</asp:ListItem>
                                            <asp:ListItem style="background-color:yellow" Value="2">II&nbsp;级报警</asp:ListItem>
                                            <asp:ListItem style="color:white;background-color:blue" Value="3">III级报警</asp:ListItem>
                                            <asp:ListItem Value="Stop">停车</asp:ListItem>
                                            <asp:ListItem style="background-color:darkgray" Value="QueShu">缺数</asp:ListItem>
                                        </asp:DropDownList>
                                     </td>
                                </tr>
<%}
    if ((bool)Session["SYS_CS"])
    {
 %>
                                <tr style="background-color:Olive">
                                <td  colspan=3 >
                                    擦伤
                                </td>
                                </tr>
                                <tr>
                                    <td  style="width: 100px">
                                       <%=PUBS.Txt("缺陷级别")%>:
                                    </td>
                                    <td colspan=2>
                                        <asp:DropDownList ID="dl_level_cs" runat="server" Width="100px">
                                            <asp:ListItem Value="All">全部</asp:ListItem>
                                            <asp:ListItem Value="True">有报警</asp:ListItem>
                                            <asp:ListItem style="background-color:mediumseagreen" Value="False">无报警</asp:ListItem>
                                            <asp:ListItem style="background-color:red" Value="1">&nbsp;I&nbsp;级报警</asp:ListItem>
                                            <asp:ListItem style="background-color:yellow" Value="2">II&nbsp;级报警</asp:ListItem>
                                            <asp:ListItem style="color:white;background-color:blue" Value="3">III级报警</asp:ListItem>
                                        </asp:DropDownList>
                                     </td>
                                </tr>
                                <%}
                                    if ((bool)Session["SYS_WX"])
                                    { %>
                                <tr style="background-color:Olive">
                                <td  colspan=3 >
                                    外形尺寸
                                </td>
                                </tr>
                                <tr>
                                    <td  style="width: 100px">
                                       轮径:
                                    </td>
                                    <td colspan=2>
                                        <asp:DropDownList ID="dl_level_wx_lj" runat="server" Width="100px">
                                            <asp:ListItem Value="All">全部</asp:ListItem>
                                            <asp:ListItem Value="True">有报警</asp:ListItem>
                                            <asp:ListItem style="background-color:mediumseagreen" Value="False">无报警</asp:ListItem>
                                            <asp:ListItem style="background-color:red" Value="1">&nbsp;I&nbsp;级报警</asp:ListItem>
                                            <asp:ListItem style="background-color:yellow" Value="2">II&nbsp;级报警</asp:ListItem>
                                            <asp:ListItem style="color:white;background-color:blue" Value="3">III级报警</asp:ListItem>
                                        </asp:DropDownList>
                                     </td>
                                </tr>                            
                                <tr>
                                    <td  style="width: 100px">
                                       踏面磨耗:
                                    </td>
                                    <td colspan=2>
                                        <asp:DropDownList ID="dl_level_wx_tmmh" runat="server" Width="100px">
                                            <asp:ListItem Value="All">全部</asp:ListItem>
                                            <asp:ListItem Value="True">有报警</asp:ListItem>
                                            <asp:ListItem style="background-color:mediumseagreen" Value="False">无报警</asp:ListItem>
                                            <asp:ListItem style="background-color:red" Value="1">&nbsp;I&nbsp;级报警</asp:ListItem>
                                            <asp:ListItem style="background-color:yellow" Value="2">II&nbsp;级报警</asp:ListItem>
                                            <asp:ListItem style="color:white;background-color:blue" Value="3">III级报警</asp:ListItem>
                                        </asp:DropDownList>
                                     </td>
                                </tr>  
                                <tr>
                                    <td  style="width: 100px">
                                       轮缘厚度:
                                    </td>
                                    <td colspan=2>
                                        <asp:DropDownList ID="dl_level_wx_lyhd" runat="server" Width="100px">
                                            <asp:ListItem Value="All">全部</asp:ListItem>
                                            <asp:ListItem Value="True">有报警</asp:ListItem>
                                            <asp:ListItem style="background-color:mediumseagreen" Value="False">无报警</asp:ListItem>
                                            <asp:ListItem style="background-color:red" Value="1">&nbsp;I&nbsp;级报警</asp:ListItem>
                                            <asp:ListItem style="background-color:yellow" Value="2">II&nbsp;级报警</asp:ListItem>
                                            <asp:ListItem style="color:white;background-color:blue" Value="3">III级报警</asp:ListItem>
                                        </asp:DropDownList>
                                     </td>
                                </tr>                                  
                                <tr>
                                    <td  style="width: 100px">
                                       轮缘高度:
                                    </td>
                                    <td colspan=2>
                                        <asp:DropDownList ID="dl_level_wx_lygd" runat="server" Width="100px">
                                            <asp:ListItem Value="All">全部</asp:ListItem>
                                            <asp:ListItem Value="True">有报警</asp:ListItem>
                                            <asp:ListItem style="background-color:mediumseagreen" Value="False">无报警</asp:ListItem>
                                            <asp:ListItem style="background-color:red" Value="1">&nbsp;I&nbsp;级报警</asp:ListItem>
                                            <asp:ListItem style="background-color:yellow" Value="2">II&nbsp;级报警</asp:ListItem>
                                            <asp:ListItem style="color:white;background-color:blue" Value="3">III级报警</asp:ListItem>
                                        </asp:DropDownList>
                                     </td>
                                </tr>                                  
                                <tr>
                                    <td  style="width: 100px">
                                       轮辋宽度:
                                    </td>
                                    <td colspan=2>
                                        <asp:DropDownList ID="dl_level_wx_lwhd" runat="server" Width="100px">
                                            <asp:ListItem Value="All">全部</asp:ListItem>
                                            <asp:ListItem Value="True">有报警</asp:ListItem>
                                            <asp:ListItem style="background-color:mediumseagreen" Value="False">无报警</asp:ListItem>
                                            <asp:ListItem style="background-color:red" Value="1">&nbsp;I&nbsp;级报警</asp:ListItem>
                                            <asp:ListItem style="background-color:yellow" Value="2">II&nbsp;级报警</asp:ListItem>
                                            <asp:ListItem style="color:white;background-color:blue" Value="3">III级报警</asp:ListItem>
                                        </asp:DropDownList>
                                     </td>
                                </tr>                                  
                                <tr>
                                    <td  style="width: 100px">
                                       QR值:
                                    </td>
                                    <td colspan=2>
                                        <asp:DropDownList ID="dl_level_wx_qr" runat="server" Width="100px">
                                            <asp:ListItem Value="All">全部</asp:ListItem>
                                            <asp:ListItem Value="True">有报警</asp:ListItem>
                                            <asp:ListItem style="background-color:mediumseagreen" Value="False">无报警</asp:ListItem>
                                            <asp:ListItem style="background-color:red" Value="1">&nbsp;I&nbsp;级报警</asp:ListItem>
                                            <asp:ListItem style="background-color:yellow" Value="2">II&nbsp;级报警</asp:ListItem>
                                            <asp:ListItem style="color:white;background-color:blue" Value="3">III级报警</asp:ListItem>
                                        </asp:DropDownList>
                                     </td>
                                </tr>                                  
                                <tr>
                                    <td  style="width: 100px">
                                       内侧距:
                                    </td>
                                    <td colspan=2>
                                        <asp:DropDownList ID="dl_level_wx_ncj" runat="server" Width="100px">
                                            <asp:ListItem Value="All">全部</asp:ListItem>
                                            <asp:ListItem Value="True">有报警</asp:ListItem>
                                            <asp:ListItem style="background-color:mediumseagreen" Value="False">无报警</asp:ListItem>
                                            <asp:ListItem style="background-color:red" Value="1">&nbsp;I&nbsp;级报警</asp:ListItem>
                                            <asp:ListItem style="background-color:yellow" Value="2">II&nbsp;级报警</asp:ListItem>
                                            <asp:ListItem style="color:white;background-color:blue" Value="3">III级报警</asp:ListItem>
                                        </asp:DropDownList>
                                     </td>
                                </tr>  
                                  <%} %>                              
                            </table>
                            <table>
                                <tr>
                                    <td>
                                        <asp:Button ID="bt_filter" runat="server" OnClick="btFilterClick" Text="确定" />
                                    </td>
                                    <td>
                                        <asp:Button ID="bt_all" runat="server" OnClick="bt_all_Click" Text="还原" />
                                    </td>
                                </tr>
                            </table>
                            <table style="width: 100%">

                                <tr>
                                    <td colspan=2 style="width: 100px; color: #FF6600;"><%=PUBS.Txt("指定车厢")%></td>
                                 </tr>
                                <tr>
                                    <td style="width: 100px"><%=PUBS.Txt("车厢号")%>:</td>
                                    <td class="style1">
                                        <asp:TextBox ID="tb_car" runat="server"  Width="100px"></asp:TextBox>
                                    </td>
                                 </tr> 
                                 <tr>
                                 <td>
                                        <asp:Button ID="bt_car" runat="server" Text="确定" onclick="bt_car_Click" />
                                 </td>
                                 </tr>                           
                           </table> 
                        </td>
                    </tr>
                    <tr>
                    <td>


                    </td>
                    </tr>
                </table>
        </div>
</div>

<script>
    var bodyfrm = (document.compatMode.toLowerCase() == "css1compat") ? document.documentElement : document.body;
    var adst = document.getElementById("ShowAD").style;
    adst.top = (bodyfrm.clientHeight - 630 - 22) + "px";
    adst.left = (bodyfrm.clientWidth - 235) + "px";
    function moveR() {
        adst.top = (bodyfrm.scrollTop + bodyfrm.clientHeight - 630 - 22) + "px";
        adst.left = (bodyfrm.scrollLeft + bodyfrm.clientWidth - 235) + "px";
    }
    setInterval("moveR();", 80);

    function closead() {
        adst.display = 'none';
    }
    function openad() {
        if (adst.display === 'none')
            adst.display = 'table';
        else
            adst.display = 'none';

    }
    $(function () {
        $.post('WebHandler.ashx', { method: 1 }, function(data, statu) {
            if (statu === 'success') {
                if (data === "false") {
                    alert("请登录后再进行此操作");
                } else {

                }
            }
        });
    });
</script>

<!-- 浮动代码结束 -->

<div>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:tychoConnectionString %>"
            SelectCommand="SELECT * FROM [V_Detect_kc] ORDER BY [testDateTime] DESC" 
            ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    
</div>
<asp:ScriptManager ID="ScriptManager1" runat="server">
</asp:ScriptManager>

<div style="margin:auto;">
<%=PUBS.OutputHead("") %>
<div class="cmd">
    <span style ="float:left">
    <a href="userinfo.aspx">
    <asp:LoginName ID="LoginName2" runat="server" SkinID="LoginName1" /></a>
    <asp:LoginStatus ID="LoginStatus2" runat="server"  LogoutAction="RedirectToLoginPage"
                        OnLoggedOut="LoginStatus1_LoggedOut" 
        SkinID="LoginStatus1" />

    </span>

    <%if (PUBS.isTychoAdmin())
      { %>
            <span style ="margin-right:5pt; float:right">
            <asp:TextBox ID="tbDelay" runat="server" BackColor="White" Width="40" CausesValidation="True" ></asp:TextBox>分钟
            </span>
            <span style ="margin-right:5pt; margin-left:25pt;float:right">
            <asp:Button ID="btSetDelay" runat="server" Text="设置延时" 
        onclick="btSetDelay_Click" onclientclick="return confirm('确认重新设置延时时间?')"/>
            
            </span>

    <%} %>
    
    <span style ="margin-right:5pt; float:right">
    <asp:Button ID="bt_log" runat="server" Text="操作日志" 
onclick="bt_log_Click" />
    </span>
    <span style ="margin-right:5pt; float:right">
    <asp:Button ID="bt_user" runat="server" Text="权限管理" 
onclick="bt_user_Click" />
    </span>
     <%--       <span style ="float:right">
            <asp:Button ID="bt_engine" runat="server" Text="车组管理" 
        onclick="bt_engine_Click" Visible="True" />
            </span>--%>
            
        

          <%--  <span style ="margin-right:5pt; float:right">
            <asp:Button ID="Button2" runat="server" Text="门限管理" 
        onclick="bt_threshold_Click" />
            </span>--%>
    
            <span style ="margin-right:5pt; float:right">
                <asp:Menu ID="Menu2" runat="server" BackColor="Coral" ForeColor="Black" StaticSubMenuIndent="16px" OnMenuItemClick="Menu2_MenuItemClick" Font-Size="12pt">
                            <Items>
                                <asp:MenuItem Text="综合配置" Value="查询">
                                    <asp:MenuItem Text="门限配置" Value="manageThreshold"></asp:MenuItem>
                                    <asp:MenuItem Text="车组配置" Value="manageTrain"></asp:MenuItem>
                                    <asp:MenuItem Text="车型配置" Value="manageCar"></asp:MenuItem>
                                </asp:MenuItem>
                            </Items>
                            <LevelMenuItemStyles>
                                <asp:MenuItemStyle BackColor="Coral" Font-Underline="False" ForeColor="Black" />
                                <asp:MenuItemStyle BackColor="Coral" Font-Underline="False" ForeColor="Black" />
                                <asp:MenuItemStyle BackColor="Coral" Font-Underline="False" ForeColor="Black" />
                            </LevelMenuItemStyles>
                            <StaticHoverStyle BackColor="White" ForeColor="Black" />
                            <StaticMenuItemStyle Font-Size="11pt" />
                            <StaticSelectedStyle Font-Size="12pt" BackColor="White" ForeColor="Black" />
                </asp:Menu>
            </span>

            <span style ="margin-right:5pt; float:right">
            <asp:Button ID="bt_Verify" runat="server" Text="校验管理" onclick="bt_Verify_Click" 
         />
            </span>
            <span style ="margin-right:5pt; float:right">
                <asp:Menu ID="Menu1" runat="server" BackColor="Coral" ForeColor="Black" StaticSubMenuIndent="16px" Font-Size="12pt" OnMenuItemClick="Menu1_MenuItemClick">
                            <Items>
                                <asp:MenuItem Text="查询" Value="查询">
                                    <asp:MenuItem Text="综合查询" Value="zongheCheck"></asp:MenuItem>
                                    <asp:MenuItem Text="历史查询" Value="checkHistory"></asp:MenuItem>
                                    <asp:MenuItem Text="超限查询" Value="CheckAlarm"></asp:MenuItem>
                                </asp:MenuItem>
                            </Items>
                            <LevelMenuItemStyles>
                                <asp:MenuItemStyle BackColor="Coral" Font-Underline="False" ForeColor="Black" />
                                <asp:MenuItemStyle BackColor="Coral" Font-Underline="False" ForeColor="Black" />
                                <asp:MenuItemStyle BackColor="Coral" Font-Underline="False" ForeColor="Black" />
                            </LevelMenuItemStyles>
                            <StaticHoverStyle BackColor="White" ForeColor="Black" />
                            <StaticMenuItemStyle Font-Size="11pt" />
                            <StaticSelectedStyle BackColor="White" ForeColor="Black" />
                </asp:Menu>
            </span>
            
            <span style ="margin-right:5pt; float:right">
               <asp:Button ID="btSwitch" runat="server" Text="探伤开关" Visible="True" 
        onclick="btSwitch_Click" />
            </span>    
    
            <span style ="margin-right:5pt; float:right">
               <asp:Button ID="btSaveExcel" runat="server" Text="数据下载" onclick="btSaveExcel_Click"/>
            </span>
            <span style ="margin-right:5pt; float:right">
               <asp:Button ID="btEditEngine" runat="server" Text="轮径维护" Visible="False" />
            </span>
         <%--   <span style ="float:right">
            <input id="Button1"  type="button" value="综合查询" onclick="openad()"  />
            </span>--%>

            <span style ="margin-right:5pt; float:right">
               <asp:Button ID="btRefresh" runat="server" Text="数据刷新" 
        onclick="btRefresh_Click"  />
            </span>
    
</div>
</div>
<%
    System.Data.DataTable dtDsp =  PUBS.sqlQuery("select * from ProcData where needproc=2");
    if (dtDsp != null)
    if (dtDsp.Rows.Count > 0)
    {
        string dspInfo = string.Format("{0:yyyy-MM-dd HH:mm:ss} {1}", dtDsp.Rows[0]["testDateTime"], dtDsp.Rows[0]["info"]);
        %>
<div>
<span>正在运算中: <%=dspInfo%></span>
</div>
        <%
    }
%>



<div>
        <div class="content">
        <div class="title"><span class="title"><%=PUBS.Txt("检测数据列表")%></span></div>
        <div>
            <asp:GridView ID="GridView1"  runat="server" 
            DataSourceID="SqlDataSource1"  
                AllowSorting="True" PageSize="20" Width="975px" 
                AutoGenerateColumns="False"  
                ondatabound="GridView1_DataBound" onrowcommand="GridView1_RowCommand" 
                BackColor="White" BorderColor="#999999" BorderStyle ="None" BorderWidth="1px" 
                CellPadding="3" GridLines="Vertical" AllowPaging="True" 
                onrowcreated="GridView1_RowCreated" PagerSettings-FirstPageText="首页" PagerSettings-LastPageText="末页" PagerSettings-NextPageText="后" PagerSettings-PreviousPageText="前页">
                <AlternatingRowStyle BackColor="#DCDCDC" />
            <Columns>
                <asp:TemplateField HeaderText="序号">
                            <ItemTemplate>
                                <asp:Label ID="number" runat="server" Text="<%# Container.DataItemIndex + 1%>"></asp:Label>
                            </ItemTemplate>
                    <ItemStyle Width="25px"/>
                </asp:TemplateField>
                <asp:HyperLinkField DataNavigateUrlFields="testDateTime" DataNavigateUrlFormatString="Details_kc.aspx?field={0:yyyy-MM-dd HH_mm_ss}"
                    DataTextField="testDateTime" HeaderText="检测时间" 
                    SortExpression="testDateTime" 
                    DataTextFormatString="{0:yyyy-MM-dd HH:mm:ss}" ItemStyle-Width="150">
<ItemStyle Width="150px"></ItemStyle>
                </asp:HyperLinkField>
                <asp:BoundField DataField="bzh" HeaderText="车组号" SortExpression="bzh" 
                    ItemStyle-Width="130" ItemStyle-HorizontalAlign="Left" >
<ItemStyle HorizontalAlign="Left" Width="105px"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="AxleNum" HeaderText="轴数" 
                    SortExpression="AxleNum"  ItemStyle-Width="50">
<ItemStyle Width="50px"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="s_level_ts" HeaderText="探伤" 
                    SortExpression="s_level_ts" />
                <asp:BoundField DataField="s_level_cs" HeaderText="擦伤" 
                    SortExpression="s_level_cs" />
                <asp:BoundField DataField="s_level_M_Lj" HeaderText="轮径" 
                    SortExpression="s_level_M_Lj" ItemStyle-Width="45">
<ItemStyle Width="45px"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="s_level_M_TmMh" HeaderText="踏面磨耗" 
                    SortExpression="s_level_M_TmMh"  ItemStyle-Width="45">
<ItemStyle Width="45px"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="s_level_M_LyHd" HeaderText="轮缘厚度" 
                    SortExpression="s_level_M_LyHd"  ItemStyle-Width="45">
<ItemStyle Width="45px"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="s_level_M_LyGd" HeaderText="轮缘高度" 
                    SortExpression="s_level_M_LyGd"  ItemStyle-Width="45">
<ItemStyle Width="45px"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="s_level_M_LwHd" HeaderText="轮辋宽度" 
                    SortExpression="s_level_M_LwHd"  ItemStyle-Width="45">
<ItemStyle Width="45px"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="s_level_M_Qr" HeaderText="QR值" 
                    SortExpression="s_level_M_Qr"  ItemStyle-Width="45">
<ItemStyle Width="45px"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="s_level_M_Ncj" HeaderText="内侧距" 
                    SortExpression="s_level_M_Ncj"  ItemStyle-Width="45">
<ItemStyle Width="45px"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="isOur" HeaderText="所属" 
                    SortExpression="isOur"  ItemStyle-Width="45">
<ItemStyle Width="45px"></ItemStyle>
                </asp:BoundField>
                <asp:TemplateField ShowHeader="False"  ItemStyle-Width="30">
                    <ItemTemplate> 
                        <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False" 
                            CommandArgument='<%# Eval("testDateTime") %>' CommandName="tycho" 
                            Text='<%# Eval("testDateTime") %>' ImageUrl="~/image/printer.gif" 
                            ToolTip="全编组故障报告" />
                    </ItemTemplate>

<ItemStyle Width="30px"></ItemStyle>
                </asp:TemplateField>
                <asp:BoundField DataField="isView" ItemStyle-Width="1">

<ItemStyle Width="1px"></ItemStyle>

                </asp:BoundField>
                <asp:BoundField DataField="isTypical" ItemStyle-Width="1">

<ItemStyle Width="1px"></ItemStyle>

                </asp:BoundField>
                <asp:TemplateField ShowHeader="False" >
                    <ItemTemplate>
                        <asp:Button ID="btnrecheck" Enabled="False" Text="复核" runat="server" CommandName="recheck" CommandArgument='<%# Bind("testDateTime")%>' />
                    </ItemTemplate>
                  <ItemStyle Width="45px"></ItemStyle>
                </asp:TemplateField>

           </Columns>
                <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />

<PagerSettings FirstPageText="首页" LastPageText="末页" NextPageText="后" PreviousPageText="前页" 
                    Mode="NumericFirstLast"></PagerSettings>

                <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#0000A9" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#000065" />
            </asp:GridView>
        </div>
        <div class="GridFoot"><span><%=PUBS.Txt("第")+(GridView1.PageIndex+1).ToString()+ PUBS.Txt("页 共") + GridView1.PageCount.ToString()+PUBS.Txt("页,　本页") + GridView1.Rows.Count.ToString() + PUBS.Txt("条") %></span></div>
    </div>
       
</div>

<%=PUBS.OutputFoot("") %>

</form>
</body>
</html>
