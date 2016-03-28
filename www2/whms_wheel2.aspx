<%@ Page Language="C#" AutoEventWireup="true" CodeFile="whms_wheel2.aspx.cs" Inherits="whms_wheel" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>轮对外形尺寸</title>
<link href="css/tycho/tycho.css" type="text/css" rel="stylesheet"/>
</head>
<body>
    <form id="form1" runat="server">
        <asp:SqlDataSource ID="SqlDataSource_L" runat="server" ConnectionString="<%$ ConnectionStrings:tychoConnectionString %>">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource_R" runat="server" ConnectionString="<%$ ConnectionStrings:tychoConnectionString %>">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:tychoConnectionString %>">
        </asp:SqlDataSource>

    <%=PUBS.OutputHead("") %>
    <div class="cmd">
        <asp:LoginName ID="LoginName2" runat="server" SkinID="LoginName1" />
        <asp:LoginStatus ID="LoginStatus2" runat="server"  LogoutAction="RedirectToLoginPage" 
            SkinID="LoginStatus1" onloggedout="LoginStatus2_LoggedOut" />
        <asp:Button ID="bt_back" runat="server" Text="返回" onclientclick="javascript:history.go(-1);return false;" />
    </div>
    <table width="700" border="1" bordercolor="gray" cellspacing="0" 
       cellpadding="0">
        <tr><td colspan="2">第<%=carNo %>车厢 第<%=axleNoInCar%>轴</td></tr>

        <tr>
            <td>
                <asp:Panel ID="PanelL" runat="server">
                    
                <asp:DetailsView ID="DetailsView1" runat="server" Height="50px" Width="225px" 
                    AutoGenerateRows="False" DataKeyNames="testDateTime,axleNo,wheelNo" 
                    DataSourceID="SqlDataSource_L" style="margin-left: 0px">
                    <Fields>
                        <asp:BoundField DataField="testDateTime" HeaderText="检测时间" 
                            ReadOnly="True" SortExpression="testDateTime" />
                        <asp:BoundField DataField="axleNo" HeaderText="绝对轴号" ReadOnly="True" 
                            SortExpression="axleNo" />
                        <asp:BoundField DataField="wheelNo_s" HeaderText="轮位" ReadOnly="True" 
                            SortExpression="wheelNo" />
                        <asp:BoundField DataField="Lj" HeaderText="车轮直径" SortExpression="Lj" />
                        <asp:BoundField DataField="TmMh" HeaderText="踏面磨耗" SortExpression="TmMh" />
                        <asp:BoundField DataField="LyHd" HeaderText="轮缘厚度" SortExpression="LyHd" />
                        <asp:BoundField DataField="LwHd" HeaderText="轮辋宽度" SortExpression="LwHd" />
                        <asp:BoundField DataField="Ncj" HeaderText="内侧距" SortExpression="Ncj" />
                    </Fields>
                </asp:DetailsView>
                    
                    <div>
                        <asp:Chart ID="Chart1" runat="server" Height="343px" Width="675px">
                            <Series>
                                <asp:Series Name="Series1" ChartType="FastPoint" Color="Black">
                                </asp:Series>
                                <asp:Series BorderWidth="3" ChartArea="ChartArea1" ChartType="Point" 
                                    Color="Red" Name="Series2">
                                </asp:Series>
                            </Series>
                            <ChartAreas>
                                <asp:ChartArea Name="ChartArea1">
                                    <AxisX>
                                        <MinorGrid Enabled="True" Interval="4" LineColor="Silver" />
                                    </AxisX>
                                    <AxisY>
                                        <MinorGrid Enabled="True" Interval="4" LineColor="Silver" />
                                    </AxisY>
                                </asp:ChartArea>
                            </ChartAreas>
                        </asp:Chart>
                    
                    </div>
                 </asp:Panel>
            </td>
            <td>
                <asp:Panel ID="PanelR" runat="server">
                    
                    
                <asp:DetailsView ID="DetailsView2" runat="server" Height="50px" Width="225px" 
                    AutoGenerateRows="False" DataKeyNames="testDateTime,axleNo,wheelNo" 
                    DataSourceID="SqlDataSource_R">
                    <Fields>
                        <asp:BoundField DataField="testDateTime" HeaderText="检测时间" 
                            ReadOnly="True" SortExpression="testDateTime" />
                        <asp:BoundField DataField="axleNo" HeaderText="绝对轴号" ReadOnly="True" 
                            SortExpression="axleNo" />
                        <asp:BoundField DataField="wheelNo_s" HeaderText="轮位" ReadOnly="True" 
                            SortExpression="wheelNo" />
                        <asp:BoundField DataField="Lj" HeaderText="车轮直径" SortExpression="Lj" />
                        <asp:BoundField DataField="TmMh" HeaderText="踏面磨耗" SortExpression="TmMh" />
                        <asp:BoundField DataField="LyHd" HeaderText="轮缘厚度" SortExpression="LyHd" />
                        <asp:BoundField DataField="LwHd" HeaderText="轮辋宽度" SortExpression="LwHd" />
                        <asp:BoundField DataField="Ncj" HeaderText="内侧距" SortExpression="Ncj" />
                    </Fields>
                </asp:DetailsView>
                    
                    <div>
                        <asp:Chart ID="Chart2" runat="server" Height="343px" Width="675px">
                            <Series>
                                <asp:Series Name="Series1" ChartType="FastPoint" Color="Black">
                                </asp:Series>
                                <asp:Series BorderWidth="3" ChartArea="ChartArea1" ChartType="Point" 
                                    Color="Red" Name="Series2">
                                </asp:Series>
                            </Series>
                            <ChartAreas>
                                <asp:ChartArea Name="ChartArea1">
                                    <AxisX>
                                        <MinorGrid Enabled="True" Interval="4" LineColor="Silver" />
                                    </AxisX>
                                    <AxisY>
                                        <MinorGrid Enabled="True" Interval="4" LineColor="Silver" />
                                    </AxisY>
                                </asp:ChartArea>
                            </ChartAreas>
                        </asp:Chart>
                    
                    </div>
                </asp:Panel>
       
            </td>
        </tr>
    </table>

    <%=PUBS.OutputFoot("") %>
    </form>
</body>
</html>
