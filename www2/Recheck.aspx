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
        ProviderName="<%$ ConnectionStrings:tychoConnectionString.ProviderName %>" SelectCommand="exec dbo.GetOneTrainAlarmsForWaiXing @datetimestr" UpdateCommand="exec [dbo].[SetRecheck] @testDatetime,@carNo,@wheelPos,@checkItem,@checkValue,@recheckValue,@level,@recheckPerson,@recheckDesc,@operator,@description" >
        
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
            <asp:Panel ID="Panel1" runat="server">
            <div class="title" ><span class="title">
                <asp:Label ID="lb_title" runat="server" Text="外形报警复核"></asp:Label></span>
            </div>
                <asp:GridView ID="GridView1" runat="server" CellPadding="3"
                    Width="976px" onrowcancelingedit="GridView1_RowCancelingEdit" 
                    onrowupdating="GridView1_RowUpdating" 
                     AlternatingRowStyle-VerticalAlign="NotSet" BackColor="#CCFFFF" AllowSorting="True" HorizontalAlign="Center"  ForeColor="Black" OnRowEditing="GridView1_RowEditing" OnRowDataBound="GridView1_RowDataBound" BorderWidth="1px" OnRowCommand="GridView1_RowCommand" AutoGenerateColumns="False">
                    <Columns>
                        <asp:ButtonField  Text="编辑" runat="server" CommandName="recheck"
                                     />
                    </Columns>
                    <HeaderStyle ForeColor="White" />
                    <PagerStyle ForeColor="Black" HorizontalAlign="Center" />
                    <SortedAscendingCellStyle ForeColor="Black" />
                    <SortedAscendingHeaderStyle ForeColor="White" />
                    <SortedDescendingHeaderStyle ForeColor="White" />
                    </asp:GridView>              
                </asp:Panel>
        </div>
        <div class="content">        
            
            <asp:Panel ID="Panel2" runat="server">
            <div class="title" ><span class="title">
                <asp:Label ID="Label1" runat="server" Text="探伤报警复核"></asp:Label></span>
            </div>
                <asp:GridView ID="GridView2" runat="server" CellPadding="3"
                    Width="976px" onrowcancelingedit="GridView1_RowCancelingEdit" 
                    onrowupdating="GridView1_RowUpdating" 
                     AlternatingRowStyle-VerticalAlign="NotSet" BackColor="#CCFFFF" AllowSorting="True" HorizontalAlign="Center"  BorderWidth="1px" OnRowCommand="GridView2_RowCommand" ForeColor="Black" AutoGenerateColumns="False" >
                    <Columns>
                        <asp:ButtonField  Text="编辑" runat="server" CommandName="recheck"
                                     />
                    </Columns>
                    <HeaderStyle ForeColor="White" />
                    <PagerStyle ForeColor="Black" HorizontalAlign="Center" />
                    <SortedAscendingCellStyle ForeColor="Black" />
                    <SortedAscendingHeaderStyle ForeColor="White" />
                    <SortedDescendingHeaderStyle ForeColor="White" />
                    </asp:GridView>              
            <ajaxToolkit:ComboBox ID="ComboBox1"  Visible="False" runat="server"></ajaxToolkit:ComboBox>
                           
                </asp:Panel>
        </div>
        
        <div class="content">        
            
            <asp:Panel ID="Panel3" runat="server">
            <div class="title" ><span class="title">
                <asp:Label ID="Label2" runat="server" Text="擦伤报警复核"></asp:Label></span>
            </div>
                <asp:GridView ID="GridView3" runat="server" CellPadding="3"
                    Width="976px" 
                     AlternatingRowStyle-VerticalAlign="NotSet" BackColor="#CCFFFF" AllowSorting="True" HorizontalAlign="Center"  BorderWidth="1px" OnRowCommand="GridView3_RowCommand" ForeColor="Black" AutoGenerateColumns="False" >
                    <Columns>
                        <asp:ButtonField  Text="编辑" runat="server" CommandName="recheck"
                                     />
                    </Columns>
                    <HeaderStyle ForeColor="White" />
                    <PagerStyle ForeColor="Black" HorizontalAlign="Center" />
                    <SortedAscendingCellStyle ForeColor="Black" />
                    <SortedAscendingHeaderStyle ForeColor="White" />
                    <SortedDescendingHeaderStyle ForeColor="White" />
                    </asp:GridView>              
            <ajaxToolkit:ComboBox ID="ComboBox2"  Visible="False" runat="server"></ajaxToolkit:ComboBox>
                           
                </asp:Panel>
        </div>
                            </ContentTemplate>
    </asp:UpdatePanel>
    <%=PUBS.OutputFoot("") %>
    </form>
</body>
</html>
