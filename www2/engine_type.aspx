<%@ Page Language="C#" AutoEventWireup="true" CodeFile="engine_type.aspx.cs" Inherits="engine_engine" Theme="theme" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>本所车组号</title>
<link href="css/tycho/tycho.css" type="text/css" rel="stylesheet"/>
</head>
<body>
    <form id="form1" runat="server">
    <%=PUBS.OutputHead("") %>
        <div class="cmd">
            <asp:LoginName ID="LoginName2" runat="server" SkinID="LoginName1" />
            <asp:LoginStatus ID="LoginStatus2" runat="server"  LogoutAction="RedirectToLoginPage" 
                SkinID="LoginStatus1" onloggedout="LoginStatus2_LoggedOut" />
        <asp:Button ID="bt_back" runat="server" Text="返回" onclick="bt_back_Click" />
        </div>
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:SqlDataSource ID="SqlDataSource_engineType" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tychoConnectionString %>" 
            DeleteCommand="DELETE FROM [Train] WHERE [id] = @id" 
            InsertCommand="INSERT INTO [Train] ([id]) VALUES (@id)" 
            SelectCommand="SELECT * FROM [Train]" 
            >
            <DeleteParameters>
                <asp:Parameter Name="id" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="id" Type="String" />
            </InsertParameters>
        </asp:SqlDataSource>
    
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
            <div class="title" ><span class="title">
                <asp:Label ID="lb_title" runat="server" Text="车组配置"></asp:Label></span>
            </div>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            DataKeyNames="id" DataSourceID="SqlDataSource_engineType" AllowPaging="True" 
                    AllowSorting="True" HorizontalAlign="Center" 
                    onrowdeleted="GridView1_RowDeleted" onrowupdated="GridView1_RowUpdated">
                    <Columns>
                        <asp:TemplateField ShowHeader="False">
                            <FooterTemplate>
                                <asp:Button ID="bt_insert" runat="server" onclick="bt_insert_Click1" 
                                    Text="增加" />
                            </FooterTemplate>
                            <ItemTemplate>

                                <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" 
                                    CommandName="Delete" Text="删除" OnClientClick="return confirm('确认要删除此机车种类吗？')"></asp:LinkButton>
                            </ItemTemplate>
                            <ItemStyle BackColor="#FF9900" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="序号" SortExpression="id"　>
                            <ItemTemplate>
                                <%# Container.DataItemIndex+1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="本所车组号" SortExpression="id"　>
                            <FooterTemplate>
                                <asp:TextBox ID="tb_id" runat="server" Width="220px"></asp:TextBox>
                            </FooterTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("id") %>' Width="220px"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>
                    <HeaderStyle BackColor="#FF9900" ForeColor="White" />
                </asp:GridView>
                <asp:Button ID="bt_add" runat="server" onclick="bt_add_Click" Text="新  增" 
                    Width="63px" />
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <%=PUBS.OutputFoot("") %>
    </form>
</body>
</html>