<%@ Page Language="C#" AutoEventWireup="true" CodeFile="HistoryCheck.aspx.cs" Inherits="Verify" Theme="theme" EnableEventValidation = "false"  %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>历史查询</title>
<link href="css/tycho/tycho.css" type="text/css" rel="stylesheet"/>
<link href="css/tycho/tycho2.css" type="text/css" rel="stylesheet"/>	
    <link type="text/css" href="css/jquery-ui-timepicker-addon.css" rel="Stylesheet" />	
    <link type="text/css" href="css/jquery-ui-1.8.17.custom.css" rel="Stylesheet" />	
<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.8.17.custom.min.js"></script>
<script type="text/javascript" src="js/jquery-ui-timepicker-addon.js"></script>
<script type="text/javascript" src="js/jquery-ui-timepicker-zh-CN.js"></script>
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
    <script type="text/javascript">
        
        function reload () {
            $("#datepickerStart").datetimepicker({
                showSecond: true,
                timeFormat: 'hh:mm:ss',
                stepHour: 1,
                stepMinute: 1,
                stepSecond: 1
            });
            $("#datepickerEnd").datetimepicker({
                showSecond: true,
                timeFormat: 'hh:mm:ss',
                stepHour: 1,
                stepMinute: 1,
                stepSecond: 1
            });
        };
      
    </script>
<body>

    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
        <%=PUBS.OutputHead("") %>
        <div class="cmd">
            <asp:LoginName ID="LoginName2" runat="server" SkinID="LoginName1" />
            <asp:LoginStatus ID="LoginStatus2" runat="server"  LogoutAction="RedirectToLoginPage" 
                SkinID="LoginStatus1" onloggedout="LoginStatus2_LoggedOut" />

            <asp:Button ID="bt_back" runat="server" Text="返回" CausesValidation="False" onclientclick="javascript:history.go(-1);return false;"/>
        </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:tychoConnectionString %>" 
        ProviderName="<%$ ConnectionStrings:tychoConnectionString.ProviderName %>" SelectCommand="select * from [Thresholds]" UpdateCommand="delete from [trainType] where trainNoFrom=@OldTrainNoFrom and trainNoTo=@OldTrainNoTo 
insert into [trainType] (trainType,trainNoFrom,trainNoTo,format) values(@TrainType,@TrainNoFrom,@TrainNoTo,@Format) " InsertCommand="insert into [trainType] (trainType,trainNoFrom,trainNoTo,format) values(@TrainType,@TrainNoFrom,@TrainNoTo,@Format) ">
        <InsertParameters>
            <asp:SessionParameter Name="TrainType" SessionField="TrainType" />
            <asp:SessionParameter Name="TrainNoFrom" SessionField="TrainNoFrom" />
            <asp:SessionParameter Name="TrainNoTo" SessionField="TrainNoTo" />
            <asp:SessionParameter Name="Format" SessionField="Format" />
        </InsertParameters>
        <UpdateParameters>
            <asp:SessionParameter Name="OldTrainNoFrom" SessionField="OldTrainNoFrom" />
            <asp:SessionParameter Name="OldTrainNoTo" SessionField="OldTrainNoTo" />
            <asp:SessionParameter DefaultValue="" Name="TrainNoFrom" SessionField="TrainNoFrom" />
            <asp:SessionParameter DefaultValue="" Name="TrainNoTo" SessionField="TrainNoTo" />
            <asp:SessionParameter DefaultValue="" Name="TrainType" SessionField="TrainType" />
            <asp:SessionParameter DefaultValue="" Name="Format" SessionField="Format" />
        </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:tychoConnectionString %>" ProviderName="<%$ ConnectionStrings:tychoConnectionString.ProviderName %>" SelectCommand="select *  from train"></asp:SqlDataSource>
        <br />
        
        <div class="content"  style="text-decoration: none">
            <div class="title" ><span class="title">
                <asp:Label ID="lb_checkTitle" runat="server" Text="查询条件"></asp:Label></span>
            </div>
            
             <asp:UpdatePanel ID="UpdatePanel2" runat="server">

             <ContentTemplate>
            <asp:Panel ID="check_panel"  runat="server" HorizontalAlign="Left">
                 <div>
                    <asp:Label ID="lb_engNum" runat="server" Text="编组名称："></asp:Label>
                        <asp:DropDownList ID="DropDownList1" AutoPostBack="True" runat="server" DataSourceID="SqlDataSource2" DataTextField="id" OnPreRender="DropDownList1_PreRender" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                    
                        </asp:DropDownList>
                        <asp:Label ID="lb_wheelNo1" runat="server" Text="车厢号："></asp:Label>
                        <asp:DropDownList ID="DropDownList3" runat="server" DataTextField="carNo">
                        </asp:DropDownList>
                    <asp:Label ID="lb_wheelNo" runat="server" Text="轮位："></asp:Label>
                        <asp:DropDownList ID="DropDownList2" runat="server" >
                            <asp:ListItem Value="All">全部</asp:ListItem>
                            <asp:ListItem Value="1">1位</asp:ListItem>
                            <asp:ListItem Value="2">2位</asp:ListItem>
                            <asp:ListItem Value="3">3位</asp:ListItem>
                            <asp:ListItem Value="4">4位</asp:ListItem>
                            <asp:ListItem Value="5">5位</asp:ListItem>
                            <asp:ListItem Value="6">6位</asp:ListItem>
                            <asp:ListItem Value="7">7位</asp:ListItem>
                            <asp:ListItem Value="8">8位</asp:ListItem>
                        </asp:DropDownList>
                 </div>
                <br/>
                <%--<span>开始日期：<input type="text" id="datepickerStart"/></span> <span>结束日期：<input type="text" id="datepickerEnd"/></span>--%>
                
                <span>开始日期：<asp:TextBox type="text" id="datepickerStart" runat="server"/></span> <span>结束日期：<asp:TextBox type="text" id="datepickerEnd" runat="server"/></span>
                
                <br />
                <div style="height: 120px; width: 100%;position: relative;">
                    <div style="width: 19%; height: 30px; float: left;">
                        <asp:Button ID="SelectAllWhprBtn" runat="server" Text="全选" OnClick="SelectAllWhprBtn_Click" />
                        <asp:Button ID="UnSelectAllWhprBtn" runat="server" OnClick="UnSelectAllWhprBtn_Click" Text="全不选" />
                    </div>
                    
                    <div style="width: 80%; height: 30px;float: right">
                        <asp:CheckBoxList ID="CheckBoxList1" runat="server" RepeatDirection="Horizontal">
                            <asp:ListItem Value="Tmmh">踏面磨耗</asp:ListItem>
                            <asp:ListItem Value="Lyhd">轮缘厚度</asp:ListItem>
                            <asp:ListItem Value="Qr">QR值</asp:ListItem>
                            <asp:ListItem Value="Lj">轮径</asp:ListItem>
                            <asp:ListItem Value="Ncj">内侧距</asp:ListItem>
                            <asp:ListItem Value="LjCha_Zhou">同轴轮径差</asp:ListItem>
                            <asp:ListItem Value="LjCha_ZXJ">同转向架轮径差</asp:ListItem>
                            <asp:ListItem Value="LjCha_Che">同车轮径差</asp:ListItem>
                        </asp:CheckBoxList>
                    </div>
                    <div style="width: 19%; height: 30px; float: left; font-weight: 700;">
                        <asp:Button ID="SelectAllCsBtn" runat="server" Text="全选" OnClick="SelectAllCsBtn_Click" />
                        <asp:Button ID="UnSelectAllCsBtn" runat="server" OnClick="UnSelectAllCsBtn_Click" Text="全不选" />
                    </div>
                    
                    <div style="width: 80%; height: 30px;float: right">
                        <asp:CheckBoxList ID="CheckBoxList2" runat="server" RepeatDirection="Horizontal">
                            <asp:ListItem Value="scratch_depth">缺陷深度</asp:ListItem>
                            <asp:ListItem Value="scratch_length">缺陷长度</asp:ListItem>
                        </asp:CheckBoxList>
                    </div>
                    <div style="width: 19%; height: 30px; float: left;">
                        <asp:Button ID="SelectAllTsBtn" runat="server" Text="全选" OnClick="SelectAllTsBtn_Click" />
                        <asp:Button ID="UnSelectAllTsBtn" runat="server" OnClick="UnSelectAllTsBtn_Click" style="height: 21px" Text="全不选" />
                    </div>
                    
                    <div style="width: 80%; height: 30px;float: right">
                        <asp:CheckBoxList ID="CheckBoxList3" runat="server" RepeatDirection="Horizontal">
                            <asp:ListItem Value="tanShang">探伤</asp:ListItem>
                        </asp:CheckBoxList>
                    </div>
                    <div style="width: 100%; height: 30px; float: left;margin-left: 45%">
                        <asp:Button ID="CheckBtn" runat="server" Text="查询" OnClick="CheckBtn_OnClick" Width="70px" />
                        <asp:Button ID="DownloadBtn" runat="server" Text="数据下载" OnClick="DownloadBtn_OnClick" Width="70px" />
                    </div>
                    
                </div>
                <br/>
               
            </asp:Panel>
                 </ContentTemplate>
                 </asp:UpdatePanel>
            <br/>
            <br/>
            
            <div class="title" ><span class="title">
                <asp:Label ID="Label1" runat="server" Text="查询条件"></asp:Label></span>
            </div>
            
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <Triggers>  
                    <asp:PostBackTrigger ControlID="DownloadBtn" />  
               </Triggers>  
             <ContentTemplate>
                  <asp:Panel ID="Panel1" runat="server">
                    <asp:GridView ID="GridView1" runat="server" CellPadding="4"
                        Width="976px" 
                         AlternatingRowStyle-VerticalAlign="NotSet" BackColor="#CCFFFF"  AllowSorting="True" HorizontalAlign="Center"  ForeColor="Black" OnPageIndexChanging="GridView1_PageIndexChanging">
                        <Columns>
                        </Columns>
                        <HeaderStyle ForeColor="White" />
                        <PagerStyle ForeColor="Black" HorizontalAlign="Center" VerticalAlign="Bottom" />
                        <SortedAscendingCellStyle ForeColor="Black" />
                        <SortedAscendingHeaderStyle ForeColor="White" />
                        <SortedDescendingHeaderStyle ForeColor="White" />
                        </asp:GridView>    
                </asp:Panel>          
                            </ContentTemplate>
                </asp:UpdatePanel>
        </div>

   
    <%=PUBS.OutputFoot("") %>
    </form>
</body>
</html>
