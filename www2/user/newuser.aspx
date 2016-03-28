<%@ Page Language="C#" AutoEventWireup="true" CodeFile="newuser.aspx.cs" Inherits="newuser" Theme="theme" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>机车车轮在线检测装置  用户创建</title>
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
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:aspnetConnectionString %>" SelectCommand="SELECT DISTINCT [RoleName] FROM [vw_aspnet_Roles]"></asp:SqlDataSource>
        </div>
        <div class="user_manage">
            <div class="title"><span class="title">创建新用户</span>
            </div>
            <div>
                <br />
                注册新账户的种类
                <br />
                <asp:DropDownList ID="dl_roles" runat="server" DataSourceID="SqlDataSource1" DataTextField="RoleName">
                </asp:DropDownList>
                <br />
                <br />
            
                <asp:CreateUserWizard ID="CreateUserWizard1" runat="server" 
                    ContinueDestinationPageUrl="~/user/newuser.aspx" LoginCreatedUser="False" 
                    oncreateduser="CreateUserWizard1_CreatedUser" RequireEmail="False" 
                    oncreateusererror="CreateUserWizard1_CreateUserError" 
                    oncreatinguser="CreateUserWizard1_CreatingUser">
                    <WizardSteps>
                        <asp:CreateUserWizardStep runat="server">
                 <ContentTemplate>
                     <table border="0">
                         <tr>
                             <td align="center" colspan="2">
                                 注册新帐户</td>
                         </tr>
                         <tr>
                             <td align="right">
                                 <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">登录账号:</asp:Label></td>
                             <td>
                                 <asp:TextBox ID="UserName" runat="server"></asp:TextBox>
                                 <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName"
                                     ErrorMessage="必须填写“登录账号”。" ToolTip="必须填写“登录账号”。" ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                             </td>
                         </tr>
                         <tr>
                             <td align="right">
                                 <asp:Label ID="DisplayNameLabel" runat="server" AssociatedControlID="DisplayName">显示名:</asp:Label></td>
                             <td>
                                 <asp:TextBox ID="DisplayName" runat="server"></asp:TextBox>
                                 <asp:RequiredFieldValidator ID="DisplayNameRequired" runat="server" ControlToValidate="DisplayName"
                                     ErrorMessage="必须填写“显示名”。" ToolTip="必须填写“显示名”。" ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                             </td>
                         </tr>
                         <tr>
                             <td align="right">
                                 <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">密码:</asp:Label></td>
                             <td>
                                 <asp:TextBox ID="Password" runat="server" TextMode="Password"></asp:TextBox>
                                 <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password"
                                     ErrorMessage="必须填写“密码”。" ToolTip="必须填写“密码”。" ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                             </td>
                         </tr>
                         <tr>
                             <td align="right">
                                 <asp:Label ID="ConfirmPasswordLabel" runat="server" AssociatedControlID="ConfirmPassword">确认密码:</asp:Label></td>
                             <td>
                                 <asp:TextBox ID="ConfirmPassword" runat="server" TextMode="Password"></asp:TextBox>
                                 <asp:RequiredFieldValidator ID="ConfirmPasswordRequired" runat="server" ControlToValidate="ConfirmPassword"
                                     ErrorMessage="必须填写“确认密码”。" ToolTip="必须填写“确认密码”。" ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                             </td>
                         </tr>
                     </table>
                 </ContentTemplate>
             </asp:CreateUserWizardStep>
              <asp:CompleteWizardStep runat="server" Title="">
             </asp:CompleteWizardStep>
                    </WizardSteps>
                </asp:CreateUserWizard>
        
                <asp:Label ID="Label1" runat="server" ForeColor="Red" 
                    Text="用户名长度不能超过10个汉字或20字符" Visible="False"></asp:Label>
        
            </div>
        </div>
        <%=PUBS.OutputFoot("../") %>

    </form>
</body>
</html>
