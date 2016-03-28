<%@ Page Language="C#" AutoEventWireup="true" CodeFile="whms_history_wheelData.aspx.cs" Inherits="whms_wheel" Theme="theme"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<meta http-equiv="pragma" content="no-cache">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>轮对外形尺寸历史数据</title>
<link href="css/tycho/tycho.css" type="text/css" rel="stylesheet"/>
    <style type="text/css">
        .style1
        {
            height: 168px;
        }
        .style3
        {
            height: 168px;
            width: 50px;
        }
        .style4
        {
            height: 168px;
            width: 118px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tychoConnectionString %>" >
        </asp:SqlDataSource>

    <%=PUBS.OutputHead("") %>
    <div class="cmd">
        <asp:LoginName ID="LoginName2" runat="server" SkinID="LoginName1" />
        <asp:LoginStatus ID="LoginStatus2" runat="server"  LogoutAction="RedirectToLoginPage" 
            SkinID="LoginStatus1" onloggedout="LoginStatus2_LoggedOut" />
        <asp:Button ID="bt_back" runat="server" Text="返回" onclientclick="javascript:history.go(-1);return false;" />
    </div>
    <table border="0" bordercolor="gray" cellspacing="0" 
       cellpadding="0" style="width: 1280px">
        <tr>
            <td>车轮外形尺寸历史检测数据统计分析(单位:mm)　　　车厢号:<span 
                style="font-size: 32px; font-weight: bold;"><%=strCarNo%></span>  轮位:<span 
                style="font-size: 32px; font-weight: bold;"><%=PUBS.LWXH[wheelPos] %></span>
            </td>
        </tr>

        <tr>
            <td>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                    DataKeyNames="testDateTime,axleNo,wheelNo" DataSourceID="SqlDataSource1"
                                    AllowSorting="True" PageSize="20" Width="875px" 
                BackColor="White" BorderColor="#999999" BorderStyle ="None" BorderWidth="1px" 
                CellPadding="3" GridLines="Vertical" AllowPaging="True" ForeColor="#003399" 
                >
                <AlternatingRowStyle BackColor="#A5C0DE" />
                    <Columns>
                        <asp:BoundField DataField="testDateTime" HeaderText="检测时间" 
                            ReadOnly="True" SortExpression="testDateTime" />
                        <asp:BoundField DataField="Lj" HeaderText="直径" 
                            SortExpression="Lj" />
                        <asp:BoundField DataField="LjCha_Zhou" HeaderText="同轴差" 
                            SortExpression="LjCha_Zhou" />
                        <asp:BoundField DataField="LjCha_ZXJ" HeaderText="同架差" 
                            SortExpression="LjCha_ZXJ" />
                        <asp:BoundField DataField="LjCha_Che" HeaderText="同车差" 
                            SortExpression="LjCha_Che" />
                        <asp:BoundField DataField="LjCha_Bz" HeaderText="同车组差" 
                            SortExpression="LjCha_Bz" />
                        <asp:BoundField DataField="TmMh" HeaderText="踏面磨耗" SortExpression="TmMh" />
                        <asp:BoundField DataField="LyHd" HeaderText="轮缘厚度" SortExpression="LyHd" />
                        <asp:BoundField DataField="LyGd" HeaderText="轮缘高度" SortExpression="LyGd" />
                        <asp:BoundField DataField="LwHd" HeaderText="轮辋宽度" SortExpression="LwHd" />
                        <asp:BoundField DataField="QR" HeaderText="QR值" SortExpression="QR" />
                        <asp:BoundField DataField="Ncj" HeaderText="内侧距" SortExpression="Ncj" />
                    </Columns>
                    <HeaderStyle BackColor="#20487C" ForeColor="White" />
                </asp:GridView>
            </td>   
        </tr>
    </table>

    <%=PUBS.OutputFoot("") %>
    </form>
</body>
</html>
