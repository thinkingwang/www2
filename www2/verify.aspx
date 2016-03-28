<%@ Page Language="C#" AutoEventWireup="true" CodeFile="verify.aspx.cs" Inherits="Verify" Theme="theme" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>车轮在线检测装置  校验管理</title>
<link href="css/tycho/tycho.css" type="text/css" rel="stylesheet"/>
<script language="javascript" type="text/javascript" src="My97DatePicker/WdatePicker.js"></script>
    <style type="text/css">
        .style1
        {
            width: 50%;
        }
        .style2
        {
            width: 50%;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
<div>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:tychoConnectionString %>"
            SelectCommand="SELECT * FROM Verify order by verifydate desc"></asp:SqlDataSource>
    
</div>

    <%=PUBS.OutputHead("") %>
        <div class="cmd">
            <asp:LoginName ID="LoginName2" runat="server" SkinID="LoginName1" />
            <asp:LoginStatus ID="LoginStatus2" runat="server"  LogoutAction="RedirectToLoginPage" 
                SkinID="LoginStatus1" onloggedout="LoginStatus2_LoggedOut" />
            <asp:Button ID="btAdd" runat="server" Text="增加校验记录" onclick="btAdd_Click" 
                visible="false" CausesValidation="False"/>
            <asp:Button ID="bt_back" runat="server" Text="返回" onclick="bt_back_Click" 
                CausesValidation="False" />
        </div>
        <div class="content">
            <div class="title"><span class="title">
                <asp:Label ID="lb_title" runat="server" Text="增加新的校验记录"></asp:Label></span>
            </div>
            <table width="600" style="padding: 1px; text-align:left;">
            <tr>
                <td class="style1">
            校验完成日期： <asp:TextBox ID="DropDownCalendar1" runat="server" Width="100"  ControlToValidate="DropDownCalendar1" /><asp:Image  id="img_from"  runat="server"  onclick="WdatePicker({el:'DropDownCalendar1'})" src="My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle" />
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ErrorMessage="请填写校验日期" ControlToValidate="DropDownCalendar1"></asp:RequiredFieldValidator>
                </td>
                <td class="style2">
            校验人： <asp:TextBox ID="tb_name" runat="server"></asp:TextBox> 
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                        ErrorMessage="请填写校验人员" ControlToValidate="tb_name"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="style1">
            校验内容及结果描述： <br />
                </td>
                <td class="style2">
                </td>
            </tr>
            <tr>
            <td colspan = "2" >
            <asp:TextBox ID="tb_desc" runat="server" Wrap="True" TextMode="MultiLine" Rows="10" Width="520"></asp:TextBox>
                <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                        ErrorMessage="请填写校验内容及结果描述" ControlToValidate="tb_desc"></asp:RequiredFieldValidator>
            </td>
            </tr>
            </table>
        <div class="cmd"><asp:Button ID="btCommit" runat="server" Text="提交校验记录" 
                onclick="btCommit_Click" />
                
                </div>
        </div>


        <div class="content">
            <div class="title"><span class="title">设备校验记录</span>
            </div>

            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
                AutoGenerateColumns="False" DataKeyNames="VerifyDate" 
                DataSourceID="SqlDataSource1" BackColor="LightGoldenrodYellow" 
                BorderColor="Tan" BorderWidth="1px" CellPadding="2" ForeColor="Black" 
                Width="873px" >
                <AlternatingRowStyle BackColor="PaleGoldenrod" />
                <Columns>
                    <asp:HyperLinkField DataNavigateUrlFields="VerifyDate" HeaderText="校验日期" 
                        SortExpression="VerifyDate" DataNavigateUrlFormatString="verify.aspx?field={0:yyyy-MM-dd}"
                    DataTextField="VerifyDate" DataTextFormatString="{0:yyyy-MM-dd}" >
                    <ItemStyle Width="100px" />
                    </asp:HyperLinkField>
                    <asp:BoundField DataField="name" HeaderText="校验人" SortExpression="name" >
                    <ItemStyle Width="60px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="CommitTime" HeaderText="提交时间" 
                        SortExpression="CommitTime" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" >
                    <ItemStyle Width="160px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="desc" HeaderText="检验内容及结果描述" SortExpression="desc" >
                    <ItemStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                </Columns>
                <FooterStyle BackColor="Tan" />
                <HeaderStyle BackColor="Tan" Font-Bold="True" />
                <PagerStyle BackColor="PaleGoldenrod" ForeColor="DarkSlateBlue" 
                    HorizontalAlign="Center" />
                <SelectedRowStyle BackColor="DarkSlateBlue" ForeColor="GhostWhite" />
                <SortedAscendingCellStyle BackColor="#FAFAE7" />
                <SortedAscendingHeaderStyle BackColor="#DAC09E" />
                <SortedDescendingCellStyle BackColor="#E1DB9C" />
                <SortedDescendingHeaderStyle BackColor="#C2A47B" />
            </asp:GridView>


        </div>


        <%=PUBS.OutputFoot("") %>

    </form>
</body>
</html>
