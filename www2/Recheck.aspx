<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Recheck.aspx.cs" Inherits="Verify" Theme="theme" %>
<%@ Register
    Assembly="AjaxControlToolkit"
    Namespace="AjaxControlToolkit"
    TagPrefix="ajaxToolkit" %>
<%@ Register TagPrefix="ajaxToolkit" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit, Version=4.1.7.1213, Culture=neutral, PublicKeyToken=28f01b0e84b6d53e" %>
<meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>超限复核</title>
<link href="css/tycho/tycho.css" type="text/css" rel="stylesheet"/>
<link href="css/tycho/tycho2.css" type="text/css" rel="stylesheet"/>
 

</head>
<body>

    <form id="form1" runat="server">
    <ajaxToolkit:ToolkitScriptManager ID="ScriptManager1" runat="server">
    </ajaxToolkit:ToolkitScriptManager>
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
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:aspnetConnectionString %>" ProviderName="<%$ ConnectionStrings:aspnetConnectionString.ProviderName %>" SelectCommand="select DisplayName from dbo.aspnet_Users  where DisplayName!='' order by DisplayName"></asp:SqlDataSource>
        <br />

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">

    <ContentTemplate>
        <div class="content">        

            <div class="title" ><span class="title">
                <asp:Label ID="lb_title" runat="server" Text="报警复核"></asp:Label></span>
            </div>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="3"
                    Width="976px" onrowcancelingedit="GridView1_RowCancelingEdit" 
                    onrowupdating="GridView1_RowUpdating" 
                     AlternatingRowStyle-VerticalAlign="NotSet" BackColor="#CCFFFF" DataSourceID="SqlDataSource1" AllowSorting="True" HorizontalAlign="Center" OnRowEditing="GridView1_RowEditing" OnRowDataBound="GridView1_RowDataBound" BorderWidth="1px">
                    <Columns>
                        <asp:BoundField DataField="序号" HeaderText="序号" ReadOnly="True" >
                        <HeaderStyle Width="40px" />
                        <ItemStyle ForeColor="Black" />
                        </asp:BoundField>
                        <asp:BoundField DataField="检测时间" HeaderText="检测时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" ReadOnly="True" >
                        <HeaderStyle Width="100px" />
                        <ItemStyle ForeColor="Black" />
                        </asp:BoundField>
                        <asp:BoundField DataField="车组号" HeaderText="车组号"  ReadOnly="True" >
                        <ItemStyle ForeColor="Black" HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="车厢号" HeaderText="车厢号" ReadOnly="True" >
                        <HeaderStyle Width="100px" />
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
                                <asp:Label ID="trainNoFromLbl" Runat="Server" Text='<%# Bind("复核人") %>'><%# Eval("复核人")%></asp:Label>
                            </ItemTemplate>
                           <EditItemTemplate>
                               <ajaxToolkit:ComboBox ID="cb_recheckPerson" DataSourceID="SqlDataSource2" DropDownStyle="DropDown" DataTextField="DisplayName" MaxLength="30" style="top:10px" Width="100%" runat="server"></ajaxToolkit:ComboBox>
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
                    <PagerStyle ForeColor="Black" HorizontalAlign="Center" />
                    <SortedAscendingCellStyle ForeColor="Black" />
                    <SortedAscendingHeaderStyle ForeColor="White" />
                    <SortedDescendingHeaderStyle ForeColor="White" />
                    </asp:GridView>              
            <ajaxToolkit:ComboBox ID="cb_recheckPerson1"  Visible="False" runat="server"></ajaxToolkit:ComboBox>

        </div>
                            </ContentTemplate>
    </asp:UpdatePanel>
    <%=PUBS.OutputFoot("") %>
    </form>
</body>
</html>
