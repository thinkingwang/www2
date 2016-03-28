<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AlarmCheck.aspx.cs" Inherits="Verify" Theme="theme" EnableEventValidation = "false"  %>
<%@ Register TagPrefix="ajaxToolkit" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit, Version=4.1.7.1213, Culture=neutral, PublicKeyToken=28f01b0e84b6d53e" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>超限查询</title>
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
    <ajaxToolkit:ToolkitScriptManager ID="ScriptManager1" runat="server"/>
    <%=PUBS.OutputHead("") %>
        <div class="cmd">
            <asp:LoginName ID="LoginName2" runat="server" SkinID="LoginName1" />
            <asp:LoginStatus ID="LoginStatus2" runat="server"  LogoutAction="RedirectToLoginPage" 
                SkinID="LoginStatus1" onloggedout="LoginStatus2_LoggedOut" />

            <asp:Button ID="bt_back" runat="server" Text="返回" CausesValidation="False" onclientclick="javascript:history.go(-1);return false;"/>
        </div>
    
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:tychoConnectionString %>" 
        ProviderName="<%$ ConnectionStrings:tychoConnectionString.ProviderName %>" SelectCommand="exec dbo.GetOneTrainAlarms @datetimestr" UpdateCommand="exec [dbo].[SetRecheck] @testDatetime,@carNo,@wheelPos,@checkItem,@checkValue,@recheckValue,@level,@recheckPerson,@recheckDesc,@operator,@description" >
        
        <SelectParameters>
            <asp:QueryStringParameter Name="datetimestr" QueryStringField="datetimestr" />
        </SelectParameters>
        <UpdateParameters>
            <asp:SessionParameter Name="testDatetime" SessionField="testDatetime" />
            <asp:SessionParameter Name="carNo" SessionField="carNo" />
            <asp:SessionParameter DefaultValue="" Name="wheelPos" SessionField="wheelPos" />
            <asp:SessionParameter DefaultValue="" Name="checkItem" SessionField="checkItem" />
            <asp:SessionParameter DefaultValue="" Name="checkValue" SessionField="checkValue" />
            <asp:SessionParameter DefaultValue="" Name="recheckValue" SessionField="recheckValue" />
            <asp:SessionParameter DefaultValue="" Name="level" SessionField="level" />
            <asp:SessionParameter DefaultValue="" Name="recheckPerson" SessionField="recheckPerson" />
            <asp:SessionParameter DefaultValue="" Name="recheckDesc" SessionField="recheckDesc" />
            <asp:SessionParameter DefaultValue="" Name="operator" SessionField="operator" />
            <asp:SessionParameter DefaultValue="" Name="description" SessionField="description" />
        </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:tychoConnectionString %>" ProviderName="<%$ ConnectionStrings:tychoConnectionString.ProviderName %>" SelectCommand="select *  from train"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:aspnetConnectionString %>" ProviderName="<%$ ConnectionStrings:aspnetConnectionString.ProviderName %>" SelectCommand="select DisplayName from dbo.aspnet_Users  where DisplayName!='' order by DisplayName"></asp:SqlDataSource>
        <br />
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
                        <asp:Label ID="lb_alarmState" runat="server" Text="报警级别："></asp:Label>
                        <asp:DropDownList ID="DropDownList4" runat="server" DataTextField="carNo">
                            <asp:ListItem Value="All">全部</asp:ListItem>
                            <asp:ListItem Value="3">一级报警</asp:ListItem>
                            <asp:ListItem Value="2">二级报警</asp:ListItem>
                            <asp:ListItem Value="1">三级报警</asp:ListItem>
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
                
                <span>开始日期：<asp:TextBox type="text" CssClass="ui_timepicker" id="datepickerStart" runat="server"/></span> <span>结束日期：<asp:TextBox type="text" CssClass="ui_timepicker" id="datepickerEnd" runat="server"/></span>
                
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
                            <asp:ListItem Value="Lygd">轮缘高度</asp:ListItem>
                            <asp:ListItem Value="Lwhd">轮辋宽度</asp:ListItem>
                            <asp:ListItem Value="Qr">QR值</asp:ListItem>
                            <asp:ListItem Value="Lj">轮径</asp:ListItem>
                            <asp:ListItem Value="Ncj">内侧距</asp:ListItem>
                            <asp:ListItem Value="LjCha_Zhou">同轴轮径差</asp:ListItem>
                            <asp:ListItem Value="LjCha_ZXJ">同转向架轮径差</asp:ListItem>
                            <asp:ListItem Value="LjCha_Che">同车轮径差</asp:ListItem>
                            <asp:ListItem Value="LjCha_Bz">整车差</asp:ListItem>
                        </asp:CheckBoxList>
                    </div>
                    <div style="width: 19%; height: 30px; float: left;">
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
                <asp:Label ID="Label1" runat="server" Text="查询结果"></asp:Label></span>
            </div>
            
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <Triggers>  
                    <asp:PostBackTrigger ControlID="DownloadBtn" />  
               </Triggers>  
             <ContentTemplate>
                  <asp:Panel ID="Panel1" runat="server">
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4"
                    Width="976px" onrowcancelingedit="GridView1_RowCancelingEdit" 
                    onrowupdating="GridView1_RowUpdating" 
                     AlternatingRowStyle-VerticalAlign="NotSet" BackColor="#CCFFFF"  AllowSorting="True" HorizontalAlign="Center" OnRowEditing="GridView1_RowEditing" OnRowDataBound="GridView1_RowDataBound">
                    <Columns>
                        <asp:BoundField DataField="序号" HeaderText="序号" ReadOnly="True" >
                        <ItemStyle ForeColor="Black" />
                        </asp:BoundField>
                        <asp:BoundField DataField="检测时间" HeaderText="检测时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" ReadOnly="True" >
                        <ItemStyle ForeColor="Black" />
                        </asp:BoundField>
                        <asp:BoundField DataField="车组号" HeaderText="车组号" ReadOnly="True" >
                        <ItemStyle ForeColor="Black" />
                        </asp:BoundField>
                        <asp:BoundField DataField="车厢号" HeaderText="车厢号" ReadOnly="True" >
                        <ItemStyle ForeColor="Black" />
                        </asp:BoundField>
                        <asp:BoundField DataField="轮位" HeaderText="轮位" ReadOnly="True" >
                        <ItemStyle ForeColor="Black" />
                        </asp:BoundField>
                        <asp:BoundField DataField="检测项" HeaderText="检测项" ReadOnly="True" >
                        <ItemStyle ForeColor="Black" />
                        </asp:BoundField>
                        <asp:BoundField DataField="检测值" HeaderText="检测值" ReadOnly="True" >
                        <ItemStyle ForeColor="Black" />
                        </asp:BoundField>
                        <asp:BoundField DataField="复核值" HeaderText="复核值" >
                        <ItemStyle ForeColor="Black" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="报警级别"  SortExpression="报警级别">
                            <ItemTemplate>
                                <asp:Label ID="trainNoFromLbl" Runat="Server" Text='<%# PUBS.GetLevelTxt(Eval("报警级别")) %>'></asp:Label>
                            </ItemTemplate>                    
                                <ItemStyle ForeColor="Black" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="复核人" SortExpression="复核人">
                            <ItemTemplate>
                                <asp:Label ID="trainNoFromLbl" Runat="Server" Text='<%# Bind("复核人") %>'></asp:Label>
                            </ItemTemplate>
                           <EditItemTemplate>
                               <ajaxToolkit:ComboBox ID="cb_recheckPerson" DataSourceID="SqlDataSource3" DropDownStyle="DropDown" DataTextField="DisplayName" MaxLength="30" style="top:10px" Width="100%" runat="server"></ajaxToolkit:ComboBox>
                           </EditItemTemplate>                       
                                <ItemStyle ForeColor="Black" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="处理意见" HeaderText="处理意见" >
                        <ItemStyle ForeColor="Black" />
                        </asp:BoundField>
                        <asp:BoundField DataField="处理人" HeaderText="处理人"  ReadOnly="True">
                        <ItemStyle ForeColor="Black" />
                        </asp:BoundField>
                        <asp:BoundField DataField="备注" HeaderText="备注" >
                        <ItemStyle ForeColor="Black" />
                        </asp:BoundField>
                        <asp:CommandField HeaderText="编辑 " ShowEditButton="True" EditText="编缉" 
                        CancelText="取消" UpdateText="更新" ItemStyle-ForeColor="#33CCFF" 
                        ControlStyle-ForeColor="#33CCFF" >
                            </asp:CommandField> 
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
