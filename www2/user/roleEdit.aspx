<%@ Page Language="C#" AutoEventWireup="true" CodeFile="roleEdit.aspx.cs" Inherits="user_userList" Theme="theme" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>机车车轮在线检测装置  用户创建</title>
<link href="../css/tycho/tycho.css" type="text/css" rel="stylesheet"/>
</head>
    <script>
        // 点击复选框时触发事件
        function postBackByObject() {
            var o = window.event.srcElement;
            if (o.tagName === "INPUT" && o.type === "checkbox") {
                __doPostBack("", "");
            }

        }

    </script>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:aspnetConnectionString %>" ProviderName="<%$ ConnectionStrings:aspnetConnectionString.ProviderName %>" SelectCommand="select Name,C.Description,case when isnull(B.Id,0)=0 then 0 else 1 end as isAllowed from aspnet_PageElementControl as A left join aspnet_RoleAndPageControl as B on A.Id = B.Id and B.RoleName=@roleName left join aspnet_Roles as C on B.RoleName=C.RoleName" UpdateCommand="Update dbo.aspnet_Users set DisplayName=@DisplayName ,Department=@Department where UserName=@UserName">
            <SelectParameters>
                <asp:QueryStringParameter Name="roleName" QueryStringField="roleName" />
            </SelectParameters>
            <UpdateParameters>
                <asp:SessionParameter Name="DisplayName" SessionField="DisplayName" />
                <asp:SessionParameter Name="UserName" SessionField="UserName" />
                <asp:SessionParameter Name="Department" SessionField="Department" />
            </UpdateParameters>
        </asp:SqlDataSource>
    <div class="cmd">
        <asp:LoginName ID="LoginName2" runat="server" SkinID="LoginName1" />
        <asp:LoginStatus ID="LoginStatus2" runat="server"  LogoutAction="RedirectToLoginPage" 
            SkinID="LoginStatus1" onloggedout="LoginStatus2_LoggedOut" />
        <asp:Button ID="bt_back" runat="server" Text="返回" OnClientClick="javascript:history.go(-1);return false;" />
    </div>
    <div class ="user_manage">
        <div class="title" ><span class="title">
                <asp:Label ID="lb_checkTitle" runat="server" Text="修改角色"></asp:Label></span>
            </div>
            <asp:Panel runat="server" HorizontalAlign="Left">
                <asp:Label ID="lb_RoleName" runat="server">角色名称:</asp:Label>
                <asp:TextBox ID="tb_RoleName" runat="server"></asp:TextBox>
                <br/>
                <asp:Label ID="lb_RoleLevel" runat="server">角色级别:</asp:Label>
                <asp:DropDownList ID="ddl_RoleLevel" runat="server" DataTextField="RoleLevel">
                    <asp:ListItem>1级</asp:ListItem>
                    <asp:ListItem>2级</asp:ListItem>
                    <asp:ListItem>3级</asp:ListItem>
                    <asp:ListItem>4级</asp:ListItem>
                    <asp:ListItem>5级</asp:ListItem>
                    <asp:ListItem>6级</asp:ListItem>
                    <asp:ListItem>7级</asp:ListItem>
                    <asp:ListItem>8级</asp:ListItem>
                    <asp:ListItem>9级</asp:ListItem>
                    <asp:ListItem>10级</asp:ListItem>
                </asp:DropDownList>
                <asp:XmlDataSource ID="XmlDataSource1" runat="server"></asp:XmlDataSource>
                <br/>
                <asp:Label ID="lb_desc" runat="server">描述:</asp:Label>
                <asp:TextBox ID="txt_desc" runat="server"></asp:TextBox>
            </asp:Panel>
        <div class="title"><span class="title">拥有权限</span></div>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                  <asp:Panel runat="server" HorizontalAlign="Left">    
                      <asp:TreeView ID="TreeView1" runat="server" ForeColor="#CCFFFF" OnTreeNodeCheckChanged="TreeView1_TreeNodeCheckChanged">
                          <Nodes>
                              <asp:TreeNode  Text="权限" Value="权限">
                                  <asp:TreeNode  Text="权限管理" Value="bt_user"></asp:TreeNode>
                                  <asp:TreeNode  Text="综合配置" Value="Menu2">
                                      <asp:TreeNode  Text="门限配置" Value="manageThreshold"></asp:TreeNode>
                                      <asp:TreeNode  Text="车组配置" Value="manageTrain"></asp:TreeNode>
                                      <asp:TreeNode  Text="车型配置" Value="manageCar"></asp:TreeNode>
                                  </asp:TreeNode>
                                  <asp:TreeNode  Text="查询" Value="Menu1">
                                      <asp:TreeNode  Text="综合查询" Value="zongheCheck"></asp:TreeNode>
                                      <asp:TreeNode  Text="历史查询" Value="checkHistory"></asp:TreeNode>
                                      <asp:TreeNode  Text="超限查询" Value="CheckAlarm"></asp:TreeNode>
                                  </asp:TreeNode>
                                  <asp:TreeNode  Text="校验管理" Value="bt_Verify"></asp:TreeNode>
                                  <asp:TreeNode  Text="探伤开关" Value="btSwitch"></asp:TreeNode>
                                  <asp:TreeNode  Text="数据下载" Value="btSaveExcel"></asp:TreeNode>
                                  <asp:TreeNode  Text="轮径维护" Value="btEditEngine"></asp:TreeNode>
                                  <asp:TreeNode  Text="数据刷新" Value="btRefresh"></asp:TreeNode>
                                  <asp:TreeNode Text="操作日志" Value="bt_log"></asp:TreeNode>
                              </asp:TreeNode>
                          </Nodes>
                      </asp:TreeView>
                </div>
              </asp:Panel>
            </ContentTemplate>
            </asp:UpdatePanel>
                </div>
        <asp:Button ID="submit_btn" runat="server" Text="提交" OnClick="submit_btn_Click"/>
        <asp:Button ID="cancel_btn" runat="server" Text="取消"  OnClientClick="javascript:history.go(-1);return false;"/>
            <%=PUBS.OutputFoot("../") %>
    </form>
</body>
</html>
