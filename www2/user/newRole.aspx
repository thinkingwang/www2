<%@ Page Language="C#" AutoEventWireup="true" CodeFile="newRole.aspx.cs" Inherits="newuser" Theme="theme" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>机车车轮在线检测装置  角色管理</title>
<link href="../css/tycho/tycho.css" type="text/css" rel="stylesheet"/>
</head>
<body>
    <form id="form1" runat="server">
    <%=PUBS.OutputHead("../") %>
        <div class="cmd">
            <asp:LoginName ID="LoginName2" runat="server" SkinID="LoginName1" />
            <asp:LoginStatus ID="LoginStatus2" runat="server"  LogoutAction="RedirectToLoginPage" 
                SkinID="LoginStatus1" onloggedout="LoginStatus2_LoggedOut" />
        <asp:Button ID="bt_back" runat="server" Text="返回" OnClientClick="javascript:history.go(-1);return false;" />
        </div>
        <div class="user_manage">
            <div class="title"><span class="title">管理角色</span>
            </div>
            <div>
                角色列表:
                <asp:DropDownList ID="lstRoles" runat="server">
                </asp:DropDownList>
                
                &nbsp;<br />
                新角色名:
                <asp:TextBox ID="txtrolename" runat="server"></asp:TextBox>
                <br />
                <asp:Button ID="roleCreateBtn" OnClick="roleCreateBtn_OnClick" Text="增加" runat="server"/>
                <asp:Button ID="roleDeleteBtn" OnClick="roleDeleteBtn_OnClick" Text="删除" runat="server"/>
                <asp:Button ID="roleEditBtn" OnClick="roleEditBtn_OnClick" Text="修改" runat="server"/>
                <br />
                <asp:Label ID="Label1" runat="server" ></asp:Label>
            </div>
        </div>
        <%=PUBS.OutputFoot("../") %>

    </form>
</body>
</html>
