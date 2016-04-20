<%@ Page Language="C#" AutoEventWireup="true" CodeFile="check.aspx.cs" Inherits="Verify" Theme="theme" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>车轮在线检测装置  车轮复核</title>
<link href="css/tycho/tycho.css" type="text/css" rel="stylesheet"/>

<script language="javascript" type="text/javascript" src="My97DatePicker/WdatePicker.js"></script>
    <style type="text/css">
        .style4
        {
            height: 20px;
            width: 71px;
            background-color: #20487C
        }
        .style8
        {
            height: 20px;
            width: 310px;
            background-color: #20487C
        }
        .style9
        {
            width: 310px;
        }
        .style12
        {
            height: 20px;
            background-color: #20487C
        }
        .style13
        {
            width: 89px;

        }
        .style14
        {
            width: 106px;

        }
        .style16
        {
            width: 47px;
        }
        .style17
        {
            width: 66px;
        }
        .style18
        {
            height: 20px;
            width: 114px;
            background-color: #20487C
        }
        .style19
        {
            width: 114px;
        }
        .style20
        {
            height: 20px;
            width: 131px;
            background-color: #20487C
        }
        .style21
        {
            width: 131px;
        }
        .style22
        {
            width: 71px;
        }
    </style>
</head>

<body>

    <form id="form1" runat="server">
<asp:ScriptManager ID="ScriptManager1" runat="server">
</asp:ScriptManager>
    <%=PUBS.OutputHead("") %>
        <div class="cmd">
            <asp:LoginName ID="LoginName2" runat="server" SkinID="LoginName1" />
            <asp:LoginStatus ID="LoginStatus2" runat="server"  LogoutAction="RedirectToLoginPage" 
                SkinID="LoginStatus1" onloggedout="LoginStatus2_LoggedOut" />

            <asp:Button ID="bt_back" runat="server" Text="返回" CausesValidation="False" onclick="bt_back_Click" onclientclick="javascript:history.go(-1);return false;"/>
        </div>
        <div class="content">
        <span style="color: #FF3300">检测时间:</span>
             <asp:Label ID="lb_datetime" runat="server" Text="Label" style="font-size: 16px; font-weight: bold;"></asp:Label>
        <span style="color: #FF3300">车组号:</span>
            <asp:Label ID="lb_bzh" runat="server" Text="Label" style="font-size: 20px; font-weight: bold;"></asp:Label>
        <span style="color: #FF3300">车厢号:</span>
            <asp:Label ID="lb_carNo" runat="server" Text="Label" style="font-size: 20px; font-weight: bold;"></asp:Label>
        <span style="color: #FF3300">轮位:</span>
            <asp:Label ID="lb_wheelPos" runat="server" Text="Label" style="font-size: 32px; font-weight: bold;"></asp:Label>
        </div>
        <br />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">

    <ContentTemplate>
        <div class="content">

            <div class="title"><span class="title">
                <asp:Label ID="lb_title" runat="server" Text="车轮复核情况"></asp:Label></span>
            </div>
            <table width="980" border="1" cellspacing="0" cellpadding="0">
            <tr >
                <td id="MYID" class="style12" colspan="2"></td>
                <td class="style4">检测值</td>
                <td class="style8">复核情况</td>
                <td class="style18">复核人</td>
                <td class="style18">处理人</td>
                <td class="style20">复核日期</td>
            </tr>
            <tr>
                <td class="style13" colspan="2">探伤</td>
                <td class="style22">
                <asp:Label ID="lb_ts" runat="server" Text="Label" width="50"></asp:Label>
                </td>
                <td class="style9">
                    <asp:TextBox ID="tb_ts_desc" runat="server" Height="80px" TextMode="MultiLine" 
                        Width="360px"></asp:TextBox>
                </td>
                <td class="style19">
                       <div>
                         <asp:DropDownList ID="dl_ts_who" 
                            Width="90px"  runat="server" AutoPostBack="True" 
                               onselectedindexchanged="dl_ts_who_SelectedIndexChanged" style="position:relative; top:12px" Font-Size="Large">
                            </asp:DropDownList>
                        &nbsp;
                        <asp:TextBox id="tb_ts_who"  runat="server"  
                               style="width:68px; position:relative;  left:-12px;top:-16px" Font-Size="Large" ></asp:TextBox>
                         </div>
                    </td>
                <td class="style19">
                       <div>
                        <asp:Label id="lb_ts_operator"  runat="server"  
                               style="width:68px; position:relative;  left:-12px;top:-16px" Font-Size="Large" ></asp:Label>
                         </div>
                    </td>
                <td class="style21">
                    <asp:TextBox ID="DropDownCalendar_ts" runat="server" Width="100" Visible="true" Font-Size="Large" /><asp:Image  id="img_from"  runat="server"  onclick="WdatePicker({el:'DropDownCalendar_ts'})" src="My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle" Visible="true" />
                </td>
            </tr>
            <tr>
                <td class="style13" colspan="2">擦伤</td>
                <td class="style22" >
                <asp:Label ID="lb_cs" runat="server" Text="Label" width="50"></asp:Label>
                </td>
                <td class="style9" >
                    <asp:TextBox ID="tb_cs_desc" runat="server" Height="80px" TextMode="MultiLine" 
                        Width="360px"></asp:TextBox>
                </td>
                <td class="style19">
                    <div>
                         <asp:DropDownList ID="dl_cs_who" 
                            Width="90px"  runat="server" AutoPostBack="True" 
                            onselectedindexchanged="dl_cs_who_SelectedIndexChanged" style="position:relative; top:12px" Font-Size="Large"
                               >
                            </asp:DropDownList>
                        &nbsp;
                        <asp:TextBox id="tb_cs_who"  runat="server"  
                               style="width:68px; position:relative;  left:-12px;top:-16px" Font-Size="Large" ></asp:TextBox>
                    </div>
                </td>
                <td class="style19">
                       <div>
                        <asp:Label id="lb_cs_operator"  runat="server"  
                               style="width:68px; position:relative;  left:-12px;top:-16px" Font-Size="Large" ></asp:Label>
                         </div>
                    </td>
                <td class="style21">
                    <asp:TextBox ID="DropDownCalendar_cs" runat="server" Width="100" Visible="true" Font-Size="Large" /><asp:Image  id="Image1"  runat="server"  onclick="WdatePicker({el:'DropDownCalendar_cs'})" src="My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle" Visible="true" />
                </td>
            </tr>
            <tr>
                <td class="style16" rowspan="10">外形</td>
                <td class="style17">直径(mm)</td>
                <td class="style22">
                <asp:Label ID="lb_wx_lj" runat="server" Text="Label" width="50"></asp:Label>
                </td>
                <td class="style9">
                    <asp:TextBox ID="tb_wx_lj" runat="server" Height="20px"
                        Width="100px" AutoPostBack="True" ontextchanged="tb_wx_lj_TextChanged" ControlToValidate="tb_wx_lj"></asp:TextBox><asp:RegularExpressionValidator
                            ID="RegularExpressionValidator1" runat="server" 
                        ErrorMessage="格式错误" 
                        ValidationExpression="^[0-9]+(.[0-9]{1})?$" ControlToValidate="tb_wx_lj"></asp:RegularExpressionValidator>
                </td>
                <td class="style19" rowspan="10">
                    <div>
                         <asp:DropDownList ID="dl_wx_who" 
                            Width="90px"  runat="server" AutoPostBack="True" 
                            onselectedindexchanged="dl_wx_who_SelectedIndexChanged" style="position:relative; top:12px" Font-Size="Large"
                               >
                            </asp:DropDownList>
                        &nbsp;
                        <asp:TextBox id="tb_wx_who"  runat="server"  
                               style="width:68px; position:relative;  left:-12px;top:-16px" Font-Size="Large" ></asp:TextBox>
                    </div>
                </td>
                <td class="style19" rowspan="10">
                       <div>
                        <asp:Label id="lb_wx_operator"  runat="server"  
                               style="width:68px; position:relative;  left:-12px;top:-16px" Font-Size="Large" ></asp:Label>
                         </div>
                    </td>
                <td class="style21" rowspan="10">
                    <asp:TextBox ID="DropDownCalendar_wx" runat="server" Width="100" Visible="true" Font-Size="Large" /><asp:Image  id="Image2"  runat="server"  onclick="WdatePicker({el:'DropDownCalendar_wx'})" src="My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle" Visible="true" />
                </td>
            </tr>
             <tr>
                <td class="style17">同轴差(mm)</td>
                 <td class="style22">
                <asp:Label ID="lb_wx_ljc_z" runat="server" Text="Label" width="50"></asp:Label>
                </td>
                <td class="style9">
                    <asp:TextBox ID="tb_wx_ljc_z" runat="server" Height="20px"
                        Width="100px" ReadOnly="true" BackColor="#999999"></asp:TextBox>
                </td>
            </tr>   
             <tr>
                <td class="style17">同架差(mm)</td>
                 <td class="style22">
                <asp:Label ID="lb_wx_ljc_j" runat="server" Text="Label" width="50"></asp:Label>
                </td>
                <td class="style9">
                    <asp:TextBox ID="tb_wx_ljc_j" runat="server" Height="20px"
                        Width="100px" ReadOnly="true" BackColor="#999999"></asp:TextBox>
                </td>
            </tr>   
             <tr>
                <td class="style17">同车差(mm)</td>
                 <td class="style22">
                <asp:Label ID="lb_wx_ljc_c" runat="server" Text="Label" width="50"></asp:Label>
                </td>
                <td class="style9">
                    <asp:TextBox ID="tb_wx_ljc_c" runat="server" Height="20px"
                        Width="100px" ReadOnly="true" BackColor="#999999"></asp:TextBox>
                </td>
            </tr>   
            <tr>
                <td class="style17">轮缘厚度(mm)</td>
                 <td class="style22">
                <asp:Label ID="lb_wx_lyhd" runat="server" Text="Label" width="50"></asp:Label>
                </td>
                <td class="style9">
                    <asp:TextBox ID="tb_wx_lyhd" runat="server" Height="20px"
                        Width="100px"></asp:TextBox><asp:RegularExpressionValidator
                            ID="RegularExpressionValidator3" runat="server" 
                        ErrorMessage="格式错误" 
                        ValidationExpression="^[0-9]+(.[0-9]{1})?$" ControlToValidate="tb_wx_lyhd"></asp:RegularExpressionValidator>
                </td>
            </tr>
             <tr>
                <td class="style17">轮缘高度(mm)</td>
                 <td class="style22">
                <asp:Label ID="lb_wx_lygd" runat="server" Text="Label" width="50"></asp:Label>
                </td>
                <td class="style9">
                    <asp:TextBox ID="tb_wx_lygd" runat="server" Height="20px"
                        Width="100px" AutoPostBack="True" ontextchanged="tb_wx_lygd_TextChanged"></asp:TextBox><asp:RegularExpressionValidator
                            ID="RegularExpressionValidator4" runat="server" 
                        ErrorMessage="格式错误" 
                        ValidationExpression="^[0-9]+(.[0-9]{1})?$" ControlToValidate="tb_wx_lygd"></asp:RegularExpressionValidator>
                </td>
            </tr>       
             <tr>
                <td class="style17">踏面磨耗(mm)</td>
                 <td class="style22">
                <asp:Label ID="lb_wx_tmmh" runat="server" Text="Label" width="50"></asp:Label>
                </td>
                <td class="style9">
                    <asp:TextBox ID="tb_wx_tmmh" runat="server" Height="20px"
                        Width="100px" ReadOnly="true" BackColor="#999999"></asp:TextBox>
                </td>
            </tr>   
            <tr>
                <td class="style17">轮辋宽度(mm)</td>
                 <td class="style22">
                <asp:Label ID="lb_wx_lwhd" runat="server" Text="Label" width="50"></asp:Label>
                </td>
                <td class="style9">
                    <asp:TextBox ID="tb_wx_lwhd" runat="server" Height="20px"
                        Width="100px"></asp:TextBox><asp:RegularExpressionValidator
                            ID="RegularExpressionValidator5" runat="server" 
                        ErrorMessage="格式错误" 
                        ValidationExpression="^[0-9]+(.[0-9]{1})?$" ControlToValidate="tb_wx_lwhd"></asp:RegularExpressionValidator>
                </td>
            </tr>            
             <tr>
                <td class="style17">QR值(mm)</td>
                 <td class="style22">
                <asp:Label ID="lb_wx_qr" runat="server" Text="Label" width="50"></asp:Label>
                </td>
                <td class="style9">
                    <asp:TextBox ID="tb_wx_qr" runat="server" Height="20px"
                        Width="100px"></asp:TextBox><asp:RegularExpressionValidator
                            ID="RegularExpressionValidator6" runat="server" 
                        ErrorMessage="格式错误" 
                        ValidationExpression="^[0-9]+(.[0-9]{1})?$" ControlToValidate="tb_wx_qr"></asp:RegularExpressionValidator>
                </td>
            </tr>                 <tr>
                <td class="style17">内侧距(mm)</td>
                 <td class="style22">
                 <asp:Label ID="lb_wx_ncj" runat="server" Text="Label" width="50"></asp:Label>
                </td>

                <td class="style9">
                    <asp:TextBox ID="tb_wx_ncj" runat="server" Height="20px"
                        Width="100px"></asp:TextBox><asp:RegularExpressionValidator
                            ID="RegularExpressionValidator2" runat="server" 
                        ErrorMessage="格式错误" 
                        ValidationExpression="^[0-9]+(.[0-9]{1})?$" ControlToValidate="tb_wx_ncj"></asp:RegularExpressionValidator>
                </td>
            </tr>                 
            </table>


                


        </div>
                            </ContentTemplate>
    </asp:UpdatePanel>
        <div class="cmd"><asp:Button ID="btCommit" runat="server" Text="提交复核数据" 
                onclick="btCommit_Click" />
        </div>
    <%=PUBS.OutputFoot("") %>

    </form>
</body>
</html>
