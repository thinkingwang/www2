<%@ Page Language="C#" AutoEventWireup="true" CodeFile="whms_history.aspx.cs" Inherits="whms_wheel" Theme="theme"%>

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

    <%=PUBS.OutputHead("") %>
    <div class="cmd">
        <asp:LoginName ID="LoginName2" runat="server" SkinID="LoginName1" />
        <asp:LoginStatus ID="LoginStatus2" runat="server"  LogoutAction="RedirectToLoginPage" 
            SkinID="LoginStatus1" onloggedout="LoginStatus2_LoggedOut" />
        <asp:Button ID="bt_back" runat="server" Text="返回" onclientclick="javascript:history.go(-1);return false;" />
    </div>
    <table id="tableMain" border="1" bordercolor="gray" cellspacing="0" 
       cellpadding="0"  width="<%=tableWidth %>">
        <tr><td colspan="2" >车轮外形尺寸历史检测数据统计分析　　　车型:<span 
                style="font-size: 32px; font-weight: bold;"><%=trainType%></span>  车厢号:<span 
                style="font-size: 32px; font-weight: bold;"><%=strCarNo%></span>  轮位:<span 
                style="font-size: 32px; font-weight: bold;"><%=PUBS.LWXH[wheelPos] %></span>
         </td>
        </tr>

        <tr>
        <td >
            轮径</td>
        <td class="style1" rowspan="2">                    
            <div>
                        <asp:Chart ID="Chart_lj" runat="server" Width="1400px" BackColor="DimGray">
                            <Series>
                                <asp:Series Name="Series1" BorderWidth="2" ChartType="FastLine" Color="Lime" 
                                    Legend="Legend1" LegendText="检测数据">
                                </asp:Series>
                            </Series>
                            <ChartAreas>
                                <asp:ChartArea Name="ChartArea1" BackColor="64, 64, 64" BorderColor="DimGray">
                                    <AxisY Maximum="1100" Minimum="800">
                                    </AxisY>
                                    <InnerPlotPosition Height="85" Width="94" X="5" Y="3" />
                                </asp:ChartArea>
                            </ChartAreas>
                            <Legends>
                                <asp:Legend Docking="Top" Name="Legend1">
                                </asp:Legend>
                            </Legends>
                        </asp:Chart>
                    按照目前的车辆使用频度，估算剩余使用寿命为：<%=sShengYu %>
            </div>
        </td>
       </tr>
       <tr>
               <td class="style4">
            <img alt="" src="image/whms_lj.jpg" style="height: 172px; width: 166px" /></td>
       </tr>

        <tr>
        <td >
            同轴轮径差</td>
        <td class="style1" rowspan="2">                    
            <div>
                        <asp:Chart ID="Chart_ljc_Z" runat="server" Width="1400px" BackColor="DimGray">
                            <Series>
                                <asp:Series Name="Series1" BorderWidth="2" ChartType="FastLine" Color="Lime" 
                                    Legend="Legend1" LegendText="检测数据">
                                </asp:Series>
                            </Series>
                            <ChartAreas>
                                <asp:ChartArea Name="ChartArea1" BackColor="64, 64, 64" BorderColor="DimGray">
                                    <AxisY Maximum="1100" Minimum="800">
                                    </AxisY>
                                    <InnerPlotPosition Height="85" Width="94" X="5" Y="3" />
                                </asp:ChartArea>
                            </ChartAreas>
                            <Legends>
                                <asp:Legend Docking="Top" Name="Legend1">
                                </asp:Legend>
                            </Legends>
                        </asp:Chart>
                    
                    </div>
                    </td>
       </tr>
       <tr>
               <td class="style4">
            </td>
       </tr>

        <tr>
        <td >
            同转向架轮径差</td>
        <td class="style1" rowspan="2">                    
            <div>
                        <asp:Chart ID="Chart_ljc_J" runat="server" Width="1400px" BackColor="DimGray">
                            <Series>
                                <asp:Series Name="Series1" BorderWidth="2" ChartType="FastLine" Color="Lime" 
                                    Legend="Legend1" LegendText="检测数据">
                                </asp:Series>
                            </Series>
                            <ChartAreas>
                                <asp:ChartArea Name="ChartArea1" BackColor="64, 64, 64" BorderColor="DimGray">
                                    <AxisY Maximum="1100" Minimum="800">
                                    </AxisY>
                                    <InnerPlotPosition Height="85" Width="94" X="5" Y="3" />
                                </asp:ChartArea>
                            </ChartAreas>
                            <Legends>
                                <asp:Legend Docking="Top" Name="Legend1">
                                </asp:Legend>
                            </Legends>
                        </asp:Chart>
                    
                    </div>
                    </td>
       </tr>
       <tr>
               <td class="style4">
            </td>
       </tr>

        <tr>
        <td >
            同车厢轮径差</td>
        <td class="style1" rowspan="2">                    
            <div>
                        <asp:Chart ID="Chart_ljc_C" runat="server" Width="1400px" BackColor="DimGray">
                            <Series>
                                <asp:Series Name="Series1" BorderWidth="2" ChartType="FastLine" Color="Lime" 
                                    Legend="Legend1" LegendText="检测数据">
                                </asp:Series>
                            </Series>
                            <ChartAreas>
                                <asp:ChartArea Name="ChartArea1" BackColor="64, 64, 64" BorderColor="DimGray">
                                    <AxisY Maximum="1100" Minimum="800">
                                    </AxisY>
                                    <InnerPlotPosition Height="85" Width="94" X="5" Y="3" />
                                </asp:ChartArea>
                            </ChartAreas>
                            <Legends>
                                <asp:Legend Docking="Top" Name="Legend1">
                                </asp:Legend>
                            </Legends>
                        </asp:Chart>
                    
                    </div>
                    </td>
       </tr>
       <tr>
               <td class="style4">
            </td>
       </tr>

        <tr>
        <td >
            同车组轮径差</td>
        <td class="style1" rowspan="2">                    
            <div>
                        <asp:Chart ID="Chart_ljc_B" runat="server" Width="1400px" BackColor="DimGray">
                            <Series>
                                <asp:Series Name="Series1" BorderWidth="2" ChartType="FastLine" Color="Lime" 
                                    Legend="Legend1" LegendText="检测数据">
                                </asp:Series>
                            </Series>
                            <ChartAreas>
                                <asp:ChartArea Name="ChartArea1" BackColor="64, 64, 64" BorderColor="DimGray">
                                    <AxisY Maximum="1100" Minimum="800">
                                    </AxisY>
                                    <InnerPlotPosition Height="85" Width="94" X="5" Y="3" />
                                </asp:ChartArea>
                            </ChartAreas>
                            <Legends>
                                <asp:Legend Docking="Top" Name="Legend1">
                                </asp:Legend>
                            </Legends>
                        </asp:Chart>
                    
                    </div>
                    </td>
       </tr>
       <tr>
               <td class="style4">
            </td>
       </tr>

        <tr>
        <td>
            踏面磨耗</td>
        <td class="style1"  rowspan="2">                    
            <div>
                    
                    <asp:Chart ID="Chart_tmmh" runat="server" Width="1400px" BackColor="DimGray">
                        <Series>
                            <asp:Series Name="Series1" BorderWidth="2" ChartType="FastLine" Color="Lime" 
                                Legend="Legend1" LegendText="检测数据">
                            </asp:Series>
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1" BackColor="64, 64, 64" 
                                ShadowColor="64, 64, 64">
                                <InnerPlotPosition Height="85" Width="94" X="5" Y="3" />
                            </asp:ChartArea>
                        </ChartAreas>
                        <Legends>
                            <asp:Legend Docking="Top" Name="Legend1">
                            </asp:Legend>
                        </Legends>
                    </asp:Chart>
                    
                    </div>
                    </td>
       </tr>
        <tr>
        <td class="style4">
            <img alt="" src="image/whms_tmmh.jpg" style="height: 135px; width: 166px" /></td>
        </tr>


        <tr>
        <td>
            轮缘厚度</td>
        <td class="style1"  rowspan="2">                    
            <div>
                    
                    <asp:Chart ID="Chart_lyhd" runat="server" Width="1400px" BackColor="DimGray">
                        <Series>
                            <asp:Series Name="Series1" BorderWidth="2" ChartType="FastLine" Color="Lime" 
                                LegendText="检测数据" Legend="Legend1">
                            </asp:Series>
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1" BackColor="64, 64, 64">
                                <InnerPlotPosition Height="85" Width="94" X="5" Y="3" />
                            </asp:ChartArea>
                        </ChartAreas>
                        <Legends>
                            <asp:Legend Docking="Top" Name="Legend1">
                            </asp:Legend>
                        </Legends>
                    </asp:Chart>
                    
                    </div>
                    </td>
        </tr>
        <tr>
        <td class="style4" >
            <img alt="" src="image/whms_lyhd.jpg" style="height: 144px; width: 166px" /></td>
        </tr>

        <tr>
        <td>
            轮缘高度</td>
        <td class="style1"  rowspan="2">                    
            <div>
                    
                    <asp:Chart ID="Chart_lygd" runat="server" Width="1400px" BackColor="DimGray">
                        <Series>
                            <asp:Series Name="Series1" BorderWidth="2" ChartType="FastLine" Color="Lime" 
                                Legend="Legend1">
                            </asp:Series>
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1" BackColor="64, 64, 64">
                                <InnerPlotPosition Height="85" Width="94" X="5" Y="3" />
                            </asp:ChartArea>
                        </ChartAreas>
                        <Legends>
                            <asp:Legend Docking="Top" Name="Legend1">
                            </asp:Legend>
                        </Legends>
                    </asp:Chart>
                    
                    </div>
                    </td>
        </tr>
        <tr>
        <td class="style4" >
            <img alt="" src="image/whms_lygd.jpg" style="height: 144px; width: 166px" /></td>
        </tr>

        <tr>
        <td>
            轮辋宽度</td>
        <td class="style1"  rowspan="2">                    
            <div>
                    
                    <asp:Chart ID="Chart_lwhd" runat="server" Width="1400px" BackColor="DimGray">
                        <Series>
                            <asp:Series Name="Series1" BorderWidth="2" ChartType="FastLine" Color="Lime" 
                                Legend="Legend1">
                            </asp:Series>
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1" BackColor="64, 64, 64">
                                <InnerPlotPosition Height="85" Width="94" X="5" Y="3" />
                            </asp:ChartArea>
                        </ChartAreas>
                        <Legends>
                            <asp:Legend Docking="Top" Name="Legend1">
                            </asp:Legend>
                        </Legends>
                    </asp:Chart>
                    
                    </div>
                    </td>
       </tr>
        <tr>
        <td class="style4">
            <img alt="" src="image/whms_lwhd.jpg" style="height: 135px; width: 166px" /></td>
        </tr>

        <tr>
        <td>
            QR值</td>
        <td class="style1"  rowspan="2">                    
            <div>
                    
                    <asp:Chart ID="Chart_qr" runat="server" Width="1400px" BackColor="DimGray">
                        <Series>
                            <asp:Series Name="Series1" BorderWidth="2" ChartType="FastLine" Color="Lime" 
                                Legend="Legend1">
                            </asp:Series>
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1" BackColor="64, 64, 64">
                                <InnerPlotPosition Height="85" Width="94" X="5" Y="3" />
                            </asp:ChartArea>
                        </ChartAreas>
                        <Legends>
                            <asp:Legend Docking="Top" Name="Legend1">
                            </asp:Legend>
                        </Legends>
                    </asp:Chart>
                    
                    </div>
                    </td>
        </tr>
        <tr>
        <td class="style4" >
            <img alt="" src="image/whms_qr.jpg" style="height: 144px; width: 166px" /></td>
        </tr>


        <tr>
        <td>
            内侧距</td>
        <td class="style1"  rowspan="2">                    
            <div>
                    
                    <asp:Chart ID="Chart_ncj" runat="server" Width="1400px" BackColor="DimGray">
                        <Series>
                            <asp:Series Name="Series1" BorderWidth="2" ChartType="FastLine" Color="Lime" 
                                Legend="Legend1">
                            </asp:Series>
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1" BackColor="64, 64, 64">
                                <InnerPlotPosition Height="85" Width="94" X="5" Y="3" />
                            </asp:ChartArea>
                        </ChartAreas>
                        <Legends>
                            <asp:Legend Docking="Top" Name="Legend1">
                            </asp:Legend>
                        </Legends>
                    </asp:Chart>
                    
                    </div>
                    </td>
       </tr>
        <tr>
        <td class="style4" >
            <img alt="" src="image/whms_ncj.jpg" style="height: 103px; width: 166px" /></td>
        </tr>
    </table>

    <%=PUBS.OutputFoot("") %>
    </form>
</body>
</html>
