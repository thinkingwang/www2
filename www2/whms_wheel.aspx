<%@ Page Language="C#" AutoEventWireup="true" CodeFile="whms_wheel.aspx.cs" Inherits="whms_wheel" Theme="theme"%>

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
        <asp:Button ID="bt_prn_car" runat="server" Text="单车厢外形报告"　 visible ="false"
            onclick="bt_prn_car_Click" />

        <asp:Button ID="bt_back" runat="server" Text="返回" onclientclick="javascript:history.go(-1);return false;" />
    </div>
    <table width="700" border="1" bordercolor="gray" cellspacing="0" 
       cellpadding="0">
        <tr><td colspan="2">  
        <% if (carInfo != "")
           {%>
            车厢号:<span style="font-size: 32px; font-weight: bold;"><%=carInfo%></span>
                  
         <% }%>
         </td>
        </tr>

        <tr>
            <td>
                <asp:Panel ID="PanelL" runat="server">
                <div class="cmd">
                    <asp:Button ID="bt_prn" runat="server" Text="单轮外形报告"　 onclick="bt_prn_Click"/>
                    <asp:Button ID="bt_history" runat="server" Text="历史数据"　 
                        onclick="bt_history_Click" />
                    <asp:Button ID="bt_analyse" runat="server" Text="趋势分析"　 
                        onclick="bt_analyse_Click" />
                    轮位:<span　style="font-size: 32px; font-weight: bold;"><%=PUBS.LWXH[wheelPos_L]%></span>
                </div>
                <table>
                <tr>
                <td>
                <asp:DetailsView ID="DetailsView1" runat="server" Height="50px" Width="225px" 
                    AutoGenerateRows="False" DataKeyNames="testDateTime,axleNo,wheelNo" 
                    DataSourceID="SqlDataSource_L" style="margin-left: 0px">
                    <Fields>
                        <asp:BoundField DataField="testDateTime" HeaderText="检测时间" 
                            ReadOnly="True" SortExpression="testDateTime" />
                        <asp:BoundField DataField="axlePos" HeaderText="轴号" ReadOnly="True" 
                            SortExpression="axlePos" />
<%--                        <asp:BoundField DataField="wheelPos" HeaderText="轮位" ReadOnly="True" 
                            SortExpression="wheelPos" />
--%>                        <asp:BoundField DataField="str_Lj" HeaderText="车轮直径" SortExpression="Lj" />
                        <asp:BoundField DataField="LjCha_Zhou" HeaderText="同轴差" SortExpression="LjCha_Zhou" />
                        <asp:BoundField DataField="LjCha_ZXJ" HeaderText="同架差" SortExpression="LjCha_ZXJ" />
                        <asp:BoundField DataField="LjCha_Che" HeaderText="同车差" SortExpression="LjCha_Che" />
                        <asp:BoundField DataField="LjCha_Bz" HeaderText="同车组差" SortExpression="LjCha_Bz" />
                        <asp:BoundField DataField="str_TmMh" HeaderText="踏面磨耗" SortExpression="TmMh" />
                        <asp:BoundField DataField="str_LyHd" HeaderText="轮缘厚度" SortExpression="LyHd" />
                        <asp:BoundField DataField="str_LyGd" HeaderText="轮缘高度" SortExpression="LyGd" />
                        <asp:BoundField DataField="str_LwHd" HeaderText="轮辋宽度" SortExpression="LwHd" />
                        <asp:BoundField DataField="str_Qr" HeaderText="QR值" SortExpression="Qr" />
                        <asp:BoundField DataField="str_Ncj" HeaderText="内侧距" SortExpression="Ncj" />
                    </Fields>
                    <HeaderStyle BackColor="#20487C" ForeColor="White" />
                </asp:DetailsView>
                </td>
                <td>
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
                                    <AxisX Maximum="100" Minimum="-100">
                                        <MinorGrid Enabled="True" Interval="4" LineColor="Silver" />
                                    </AxisX>
                                    <AxisY Maximum="60" Minimum="-40">
                                        <MinorGrid Enabled="True" Interval="4" LineColor="Silver" />
                                    </AxisY>
                                </asp:ChartArea>
                            </ChartAreas>
                        </asp:Chart>
                    
                    </div>
                </td>
                 </tr>
                </table>
                 </asp:Panel>
            </td>
            <td>
                <asp:Panel ID="PanelR" runat="server">
                <div class="cmd">
                    <asp:Button ID="bt_prn_R" runat="server" Text="单轮外形报告" 
                        onclick="bt_prn_R_Click"/>
                    <asp:Button ID="bt_history_R" runat="server" Text="历史数据"　 onclick="bt_history_R_Click" 
                         />
                    <asp:Button ID="bt_analyse_R" runat="server" Text="趋势分析"　 onclick="bt_analyse_R_Click" 
                         />
                    轮位:<span　style="font-size: 32px; font-weight: bold;"><%=PUBS.LWXH[wheelPos_R]%></span>
                </div>
                <table>
                <tr>
                <td>
                <asp:DetailsView ID="DetailsView2" runat="server" Height="50px" Width="225px" 
                    AutoGenerateRows="False" DataKeyNames="testDateTime,axleNo,wheelNo" 
                    DataSourceID="SqlDataSource_R">
                    <Fields>
                        <asp:BoundField DataField="testDateTime" HeaderText="检测时间" 
                            ReadOnly="True" SortExpression="testDateTime" />
                        <asp:BoundField DataField="axlePos" HeaderText="轴号" ReadOnly="True" 
                            SortExpression="axlePos" />
<%--                        <asp:BoundField DataField="wheelPos" HeaderText="轮位" ReadOnly="True" 
                            SortExpression="wheelPos" />
--%>                        <asp:BoundField DataField="str_Lj" HeaderText="车轮直径" SortExpression="Lj" />
                        <asp:BoundField DataField="LjCha_Zhou" HeaderText="同轴差" SortExpression="LjCha_Zhou" />
                        <asp:BoundField DataField="LjCha_ZXJ" HeaderText="同架差" SortExpression="LjCha_ZXJ" />
                        <asp:BoundField DataField="LjCha_Che" HeaderText="同车差" SortExpression="LjCha_Che" />
                        <asp:BoundField DataField="LjCha_Bz" HeaderText="同车组差" SortExpression="LjCha_Bz" />
                        <asp:BoundField DataField="str_TmMh" HeaderText="踏面磨耗" SortExpression="TmMh" />
                        <asp:BoundField DataField="str_LyHd" HeaderText="轮缘厚度" SortExpression="LyHd" />
                        <asp:BoundField DataField="str_LyGd" HeaderText="轮缘高度" SortExpression="LyGd" />
                        <asp:BoundField DataField="str_LwHd" HeaderText="轮辋宽度" SortExpression="LwHd" />
                        <asp:BoundField DataField="str_Qr" HeaderText="QR值" SortExpression="Qr" />
                        <asp:BoundField DataField="str_Ncj" HeaderText="内侧距" SortExpression="Ncj" />
                    </Fields>
                    <HeaderStyle BackColor="#20487C" ForeColor="White" />
                </asp:DetailsView>
                </td>
                <td>
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
                                    <AxisX Maximum="100" Minimum="-100">
                                        <MinorGrid Enabled="True" Interval="4" LineColor="Silver" />
                                    </AxisX>
                                    <AxisY Maximum="60" Minimum="-40">
                                        <MinorGrid Enabled="True" Interval="4" LineColor="Silver" />
                                    </AxisY>
                                </asp:ChartArea>
                            </ChartAreas>
                        </asp:Chart>
                    
                    </div>
                </td>
                 </tr>
                </table>
                </asp:Panel>
       
            </td>
        </tr>
    </table>

    <%=PUBS.OutputFoot("") %>
    </form>
</body>
</html>
