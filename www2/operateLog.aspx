<%@ Page Language="C#" AutoEventWireup="true" CodeFile="operateLog.aspx.cs" Inherits="Verify" Theme="theme" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>操作日志</title>
<link href="css/tycho/tycho.css" type="text/css" rel="stylesheet"/>
<link href="css/tycho/tycho2.css" type="text/css" rel="stylesheet"/>


</head>
    <script type="text/javascript">
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
        <br />

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">

    <ContentTemplate>
        <div class="content">        

            <div class="title" ><span class="title">
                <asp:Label ID="lb_title" runat="server" Text="操作日志"></asp:Label></span>
            </div>
                <asp:GridView ID="GridView1" runat="server"  CellPadding="4"
                    Width="976px" ackColor="#CCFFFF"  AllowSorting="True" HorizontalAlign="Center" AllowPaging="True" PageSize="20" OnPageIndexChanging="GridView1_PageIndexChanging" >
                    <HeaderStyle ForeColor="White" />
                    <PagerStyle ForeColor="Black" HorizontalAlign="Center" VerticalAlign="Bottom" />
                    <SortedAscendingCellStyle ForeColor="Black" />
                    <SortedAscendingHeaderStyle ForeColor="White" />
                    <SortedDescendingHeaderStyle ForeColor="White" />
                    </asp:GridView>              


        </div>
                            </ContentTemplate>
    </asp:UpdatePanel>
    <%=PUBS.OutputFoot("") %>
    </form>
</body>
</html>
