<%@ Page Language="C#" AutoEventWireup="true" CodeFile="userinfo.aspx.cs" Inherits="userinfo" Theme="theme" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>机车车轮在线检测装置  用户信息</title>
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
        <div class="user_manage">
            <div class="title"><span class="title">用户信息</span>
            </div>
            <div>
                <table style="width: 100%;">
                    <tr>
                        <td>
                            用户名
                        </td>
                        <td>
                            <%=username %>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            创建日期
                        </td>
                        <td>
                            <%=mu.CreationDate %>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            所属类别
                        </td>
                        <td>
                            <%=js %>
                        </td>
                    </tr>
                </table>    
            </div>
        </div> 
        <div class="user_manage">
            <div class="title"><span class="title">更改密码</span>
            </div>
            <div class="user_manage">
            
                <asp:ChangePassword ID="ChangePassword1" runat="server" 
                    CancelDestinationPageUrl="~/DetectList.aspx" 
                    ChangePasswordFailureText="密码错误或新密码无效。新密码的最短长度为 {0}" ChangePasswordTitleText="" 
                    ContinueDestinationPageUrl="~/userinfo.aspx" 
                    onchangedpassword="ChangePassword1_ChangedPassword" DisplayUserName="True">
                </asp:ChangePassword>
            
            </div>          
        </div>          
    <%=PUBS.OutputFoot("") %>
    </form>
</body>
</html>
