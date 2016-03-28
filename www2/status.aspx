<%@ Page Language="C#" AutoEventWireup="true" CodeFile="status.aspx.cs" Inherits="status" Theme="theme" %>

<%@ Import Namespace="System.Collections.Generic" %>
<%@ Register Assembly="calendarDropDown" Namespace="Meta.Web.Controls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >

<head runat="server">
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="refresh" content="60" />
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
        .style4
        {
            width: 131px;
        }
        .style5
        {
            width: 66px;
        }
        .style6
        {
            width: 139px;
        }
        .style7
        {
            width: 59px;
        }
        .style8
        {
            width: 123px;
        }
        .style10
        {
            width: 90px;
        }
        .style11
        {
            width: 144px;
        }
    </style>
    </head>
<body>
<form id="form1" runat="server">


<div>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:tychoConnectionString %>"
            SelectCommand="SELECT * FROM [V_Detect_kc_outline]"></asp:SqlDataSource>
    
</div>
<asp:ScriptManager ID="ScriptManager1" runat="server">
</asp:ScriptManager>

<div style="margin:auto;">
<%=PUBS.OutputHead("") %>
</div>
<%
    System.Data.DataTable dtDsp =  PUBS.sqlQuery("select * from ProcData where needproc=2");
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
        <div class="title"><span class="title"><%=PUBS.Txt("检测数据列表")%></span>
        </div>
        <div>
            <asp:GridView ID="GridView1"  runat="server" 
            DataSourceID="SqlDataSource1"  
                AllowSorting="True" PageSize="20" Width="875px" 
                AutoGenerateColumns="False"  
                ondatabound="GridView1_DataBound" onrowcommand="GridView1_RowCommand" 
                BackColor="White" BorderColor="#999999" BorderStyle ="None" BorderWidth="1px" 
                CellPadding="3" GridLines="Vertical" AllowPaging="True" >
                <AlternatingRowStyle BackColor="#DCDCDC" />
            <Columns>
                <asp:HyperLinkField DataNavigateUrlFields="testDateTime" DataNavigateUrlFormatString="Details_kc.aspx?field={0:yyyy-MM-dd HH_mm_ss}"
                    DataTextField="testDateTime" HeaderText="检测时间" 
                    SortExpression="testDateTime" 
                    DataTextFormatString="{0:yyyy-MM-dd HH:mm:ss}" ItemStyle-Width="150" 
                    Target="_top">
<ItemStyle Width="150px"></ItemStyle>
                </asp:HyperLinkField>
                <asp:BoundField DataField="bzh" HeaderText="车组号" SortExpression="bzh" 
                    ItemStyle-Width="130">
<ItemStyle Width="130px"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="AxleNum" HeaderText="轴数" 
                    SortExpression="AxleNum"  ItemStyle-Width="50">
<ItemStyle Width="50px"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="s_level_ts" HeaderText="探伤" 
                    SortExpression="s_level_ts" />
                <asp:BoundField DataField="s_level_cs" HeaderText="擦伤" 
                    SortExpression="s_level_cs" />
                <asp:BoundField DataField="s_level_M" HeaderText="外形尺寸" 
                    SortExpression="s_level_M" ItemStyle-Width="45">
<ItemStyle Width="45px"></ItemStyle>
                </asp:BoundField>
                <asp:TemplateField ShowHeader="False"  ItemStyle-Width="30" Visible=false>
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
            </Columns>
                <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
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

        <div class="content">
        <div class="title"><span class="title"><%=PUBS.Txt("仪器综合数据")%></span></div>
        <div>
        采样时间:<asp:Label ID="lb_time" runat="server" Text=""></asp:Label><br />
        <table>
        <tr>
        <td class="style4">系统状态:
        </td>
        <td class="style5">
        <asp:Label ID="lb_SysStatus" runat="server" Text=""></asp:Label>
        </td>
        <td class="style6">检测模式:
        </td>
        <td class="style7">
            <asp:Label ID="lb_Mode" runat="server" Text=""></asp:Label>
        </td>
        <td class="style8">车辆状态:
        </td>
        <td class="style7">
        <asp:Label ID="lb_IsOnline" runat="server" Text=""></asp:Label>
        </td>
        <td class="style11">在线时长:
        </td>
        <td class="style10">
        <asp:Label ID="lb_OnlineTimes" runat="server" Text=""></asp:Label>s
        </td>
        </tr>

        <tr>
        <td class="style4">车辆方向:
        </td>
        <td class="style5">
        <asp:Label ID="lb_direction" runat="server" Text=""></asp:Label>
        </td>
        <td class="style6">进入轮对:
        </td>
        <td class="style7">
        <asp:Label ID="lb_wheelIn" runat="server" Text=""></asp:Label>
        </td>
        <td class="style8">通过轮对:
        </td>
        <td class="style7">
        <asp:Label ID="lb_wheelPass" runat="server" Text=""></asp:Label>
        </td>
        <td class="style11">进线速度:
        </td>
        <td class="style10">
        <asp:Label ID="lb_speedIn" runat="server" Text=""></asp:Label>km/h
        </td>
        </tr>

        <tr>
        <td class="style4">离线速度:
        </td>
        <td class="style5">
        <asp:Label ID="lb_speedOut" runat="server" Text=""></asp:Label>km/h
        </td>
        <td class="style6">通讯标志:
        </td>
        <td class="style7">
        <asp:Label ID="lb_comWord" runat="server" Text=""></asp:Label>
        </td>
        <td class="style8">水泵状态:
        </td>
        <td class="style7">
        <asp:Label ID="lb_pump" runat="server" Text="■" Font-Size="X-Large"></asp:Label>
        </td>
        <td class="style11">下次校验:
        </td>
        <td class="style10">
        <asp:Label ID="lb_verify" runat="server" Text="-" Font-Size="Large"></asp:Label>
        </td>
        </tr>

        <tr>
        <td class="style4">IR1:
        </td>
        <td class="style5">
        <asp:Label ID="lb_IR1" runat="server" Text="■" Font-Size="X-Large"></asp:Label>
        </td>
        <td class="style6">IR2:
        </td>
        <td class="style7">
        <asp:Label ID="lb_IR2" runat="server" Text="■" Font-Size="X-Large"></asp:Label>
        </td>
        <td class="style8">IR3:
        </td>
        <td class="style7">
        <asp:Label ID="lb_IR3" runat="server" Text="■" Font-Size="X-Large"></asp:Label>
        </td>
        <td class="style11">IR4:
        </td>
        <td class="style10">
        <asp:Label ID="lb_IR4" runat="server" Text="■" Font-Size="X-Large"></asp:Label>
        </td>
        </tr>        <tr>
        <td class="style4">SP1:
        </td>
        <td class="style5">
        <asp:Label ID="lb_SP1" runat="server" Text="■" Font-Size="X-Large"></asp:Label>
        </td>
        <td class="style6">SP2:
        </td>
        <td class="style7">
        <asp:Label ID="lb_SP2" runat="server" Text="■" Font-Size="X-Large"></asp:Label>
        </td>
        <td class="style8">SP3:
        </td>
        <td class="style7">
        <asp:Label ID="lb_SP3" runat="server" Text="■" Font-Size="X-Large"></asp:Label>
        </td>
        <td class="style11">SP4:
        </td>
        <td class="style10">
        <asp:Label ID="lb_SP4" runat="server" Text="■" Font-Size="X-Large"></asp:Label>
        </td>
        </tr>

        <tr>
        <td class="style4">环温:
        </td>
        <td class="style5">
        <asp:Label ID="lb_temp" runat="server" Text=""></asp:Label>℃
        </td>
        <td class="style6">水温:
        </td>
        <td class="style7">
        <asp:Label ID="lb_waterTemp" runat="server" Text=""></asp:Label>℃
        </td>
        <td class="style8">A温度:
        </td>
        <td class="style7">
        <asp:Label ID="lb_ATemp" runat="server" Text=""></asp:Label>℃
        </td>
        <td class="style11">B温度:
        </td>
        <td class="style10">
        <asp:Label ID="lb_BTemp" runat="server" Text=""></asp:Label>℃
        </td>
        </tr>

        <tr>
            <td class="style4">液位:
            </td>
            <td class="style5">
            <asp:Label ID="lb_waterLevel" runat="server" Text=""></asp:Label>mm
            </td>

            <td class="style6">机柜风扇:
            </td>
            <td class="style7">
            <asp:Label ID="lb_fan" runat="server" Text="■" Font-Size="X-Large"></asp:Label>
            </td>

            <td class="style8">阵列加温:
            </td>
            <td class="style7">
            <asp:Label ID="lb_hot" runat="server" Text="■" Font-Size="X-Large"></asp:Label>
            </td>

            <td class="style11">磁盘空间
            </td>
            <td class="style10">
            <asp:Label ID="lb_disk" runat="server" Text="-" Font-Size="Large"></asp:Label>
            </td>
        </tr>

        <tr>
        <td class="style4">采集1:
        </td>
        <td class="style5">
        <asp:Label ID="lb_ut1" runat="server" Text=""></asp:Label>
        </td>
        <td class="style6">采集2:
        </td>
        <td class="style7">
        <asp:Label ID="lb_ut2" runat="server" Text=""></asp:Label>
        </td>
        <td class="style8">采集3:
        </td>
        <td class="style7">
        <asp:Label ID="lb_ut3" runat="server" Text=""></asp:Label>
        </td>
        <td class="style11">采集4:
        </td>
        <td class="style10">
        <asp:Label ID="lb_ut4" runat="server" Text=""></asp:Label>
        </td>
        </tr>

        <tr>
        <td class="style4">采集5:
        </td>
        <td class="style5">
        <asp:Label ID="lb_ut5" runat="server" Text=""></asp:Label>
        </td>
        <td class="style6">采集6:
        </td>
        <td class="style7">
        <asp:Label ID="lb_ut6" runat="server" Text=""></asp:Label>
        </td>
        <td class="style8">采集7:
        </td>
        <td class="style7">
        <asp:Label ID="lb_ut7" runat="server" Text=""></asp:Label>
        </td>
        <td class="style11">采集8:
        </td>
        <td class="style10">
        <asp:Label ID="lb_ut8" runat="server" Text=""></asp:Label>
        </td>
        </tr>
<%            if (Application["SYS_MODE"].ToString() == "12UT")
              {
 %>
         <tr>
        <td class="style4">采集9:
        </td>
        <td class="style5">
        <asp:Label ID="lb_ut9" runat="server" Text=""></asp:Label>
        </td>
        <td class="style6">采集10:
        </td>
        <td class="style7">
        <asp:Label ID="lb_ut10" runat="server" Text=""></asp:Label>
        </td>
        <td class="style8">采集11:
        </td>
        <td class="style7">
        <asp:Label ID="lb_ut11" runat="server" Text=""></asp:Label>
        </td>
        <td class="style11">采集12:
        </td>
        <td class="style10">
        <asp:Label ID="lb_ut12" runat="server" Text=""></asp:Label>
        </td>
        </tr>

 <%} %>
        <tr>
        <td class="style4">控制1:
        </td>
        <td class="style5">
        <asp:Label ID="lb_cy1" runat="server" Text=""></asp:Label>
        </td>
        <td class="style6">控制2:
        </td>
        <td class="style7">
        <asp:Label ID="lb_cy2" runat="server" Text=""></asp:Label>
        </td>
        <td class="style8">控制3:
        </td>
        <td class="style7">
        <asp:Label ID="lb_cy3" runat="server" Text=""></asp:Label>
        </td>
        <td class="style11">控制4:
        </td>
        <td class="style10">
        <asp:Label ID="lb_cy4" runat="server" Text=""></asp:Label>
        </td>
        </tr>

        <tr>
        <td class="style4">控制5:
        </td>
        <td class="style5">
        <asp:Label ID="lb_cy5" runat="server" Text=""></asp:Label>
        </td>
        <td class="style6">控制6:
        </td>
        <td class="style7">
        <asp:Label ID="lb_cy6" runat="server" Text=""></asp:Label>
        </td>
        <td class="style8">控制7:
        </td>
        <td class="style7">
        <asp:Label ID="lb_cy7" runat="server" Text=""></asp:Label>
        </td>
        <td class="style11">控制8:
        </td>
        <td class="style10">
        <asp:Label ID="lb_cy8" runat="server" Text=""></asp:Label>
        </td>
        </tr>
<%            if (Application["SYS_MODE"].ToString() == "12UT")
              {
 %>
         <tr>
        <td class="style4">控制9:
        </td>
        <td class="style5">
        <asp:Label ID="lb_cy9" runat="server" Text=""></asp:Label>
        </td>
        <td class="style6">控制10:
        </td>
        <td class="style7">
        <asp:Label ID="lb_cy10" runat="server" Text=""></asp:Label>
        </td>
        <td class="style8">控制11:
        </td>
        <td class="style7">
        <asp:Label ID="lb_cy11" runat="server" Text=""></asp:Label>
        </td>
        <td class="style11">控制12:
        </td>
        <td class="style10">
        <asp:Label ID="lb_cy12" runat="server" Text=""></asp:Label>
        </td>
        </tr>
        <%} %>
        <tr>
        <td>
        </td>
        <td><asp:Label ID="lb_diskFree" runat="server" Text="" ></asp:Label>
        </td>
        </tr>
        </table>
        
        
        
        


        </div>  

       
</div>
</div>



<%=PUBS.OutputFoot("") %>

</form>
</body>
</html>
