<%@ Page Language="C#" AutoEventWireup="true" CodeFile="userList.aspx.cs" Inherits="user_userList" Theme="theme" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>机车车轮在线检测装置  用户创建</title>
<link href="../css/tycho/tycho.css" type="text/css" rel="stylesheet"/>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:aspnetConnectionString %>" ProviderName="<%$ ConnectionStrings:aspnetConnectionString.ProviderName %>" SelectCommand="select UserName,DisplayName,c.RoleName as RoleName ,Department from dbo.aspnet_Users as a inner join dbo.aspnet_UsersInRoles as b on a.UserId=b.UserId inner join dbo.aspnet_Roles as c on b.RoleId=c.RoleId
 order by a.UserName" UpdateCommand="Update dbo.aspnet_Users set DisplayName=@DisplayName ,Department=@Department where UserName=@UserName">
            <UpdateParameters>
                <asp:SessionParameter Name="DisplayName" SessionField="DisplayName" />
                <asp:SessionParameter Name="UserName" SessionField="UserName" />
                <asp:SessionParameter Name="Department" SessionField="Department" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:aspnetConnectionString %>" ProviderName="<%$ ConnectionStrings:aspnetConnectionString.ProviderName %>" SelectCommand="select distinct RoleName from dbo.aspnet_Roles"></asp:SqlDataSource>
    <%=PUBS.OutputHead("../") %>
    <div class="cmd">
        <asp:LoginName ID="LoginName2" runat="server" SkinID="LoginName1" />
        <asp:LoginStatus ID="LoginStatus2" runat="server"  LogoutAction="RedirectToLoginPage" 
            SkinID="LoginStatus1" onloggedout="LoginStatus2_LoggedOut" />
        <asp:Button ID="bt_need" runat="server" Text="创建用户" onclick="bt_need_Click" />
        <asp:Button ID="createRoleBtn" runat="server" Text="角色管理" onclick="createRole_Click" />
        <asp:Button ID="bt_back" runat="server" Text="返回" OnClientClick="javascript:history.go(-1);return false;" />
    </div>
    <div class ="user_manage">
        <div class="title"><span class="title">用户列表</span></div>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>      
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" OnRowCommand="GridView1_RowCommand" OnRowDeleting="GridView1_RowDeleting" OnRowUpdating="GridView1_RowUpdating" OnRowDataBound="GridView1_RowDataBound">
                        <Columns>
                            <asp:TemplateField HeaderText="序号">
                            <ItemTemplate>
                                <%# Container.DataItemIndex + 1%>
                            </ItemTemplate>
                        </asp:TemplateField>
                            <asp:BoundField DataField="UserName" HeaderText="用户名" ReadOnly="True" SortExpression="UserName" />
                            <asp:BoundField DataField="DisplayName" HeaderText="显示名" SortExpression="DisplayName" />
                            <asp:TemplateField HeaderText="角色">
                                <ItemTemplate>
                                    <asp:label runat="server" ID="RoleName" ></asp:label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:DropDownList ID="dl_roles" runat="server" DataSourceID="SqlDataSource2" DataTextField="RoleName">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="所属单位">
                                <ItemTemplate>
                                    <asp:label runat="server" ID="Department" ></asp:label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DepartList" runat="server">
                                     <asp:ListItem>深圳北动车所</asp:ListItem>
                                     <asp:ListItem>惠州北动车所</asp:ListItem>
                                     <asp:ListItem>南京拓控</asp:ListItem>
                                     <asp:ListItem>其他</asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:CommandField HeaderText="编辑 " ShowEditButton="True" EditText="编缉" 
                            CancelText="取消" UpdateText="更新" ItemStyle-ForeColor="#33CCFF" 
                            ControlStyle-ForeColor="#33CCFF" >
                                </asp:CommandField> 
                            <asp:CommandField ShowDeleteButton="True" DeleteText="删除" />
                            <asp:ButtonField CommandName="changePassword" Text="修改密码" />
                        </Columns>
                    </asp:GridView>
                </div>
            </ContentTemplate>
            </asp:UpdatePanel>
                </div>
            <%=PUBS.OutputFoot("../") %>
    </form>
</body>
</html>
