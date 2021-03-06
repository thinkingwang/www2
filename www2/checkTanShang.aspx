﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="checkTanShang.aspx.cs" Inherits="Verify" Theme="theme" %>
<%@ Register TagPrefix="ajaxToolkit" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit, Version=4.1.7.1213, Culture=neutral, PublicKeyToken=28f01b0e84b6d53e" %>

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
        .auto-style2 {
            width: 164px;
        }
        .auto-style3 {
            width: 225px;
        }
    </style>
</head>

<body>

    <form id="form1" runat="server">
<ajaxToolkit:ToolkitScriptManager ID="ScriptManager1" runat="server">
</ajaxToolkit:ToolkitScriptManager>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:tychoConnectionString %>" ProviderName="<%$ ConnectionStrings:tychoConnectionString.ProviderName %>" SelectCommand="exec [dbo].[GetWheelDataTanShangByAxleNoAndWheelNo] @testDateTime,@axleNo,@wheelNo">
           
            <SelectParameters>
                <asp:QueryStringParameter Name="testDateTime" QueryStringField="testDateTime" />
                <asp:QueryStringParameter Name="axleNo" QueryStringField="axleNo" />
                <asp:QueryStringParameter Name="wheelNo" QueryStringField="wheelNo" />
            </SelectParameters>
        </asp:SqlDataSource>
         <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:aspnetConnectionString %>" ProviderName="<%$ ConnectionStrings:aspnetConnectionString.ProviderName %>" SelectCommand="select DisplayName from dbo.aspnet_Users  where DisplayName!='' order by DisplayName"></asp:SqlDataSource>
        <div class="cmd">
            <asp:LoginName ID="LoginName2" runat="server" SkinID="LoginName1" />
            <asp:LoginStatus ID="LoginStatus2" runat="server"  LogoutAction="RedirectToLoginPage" 
                SkinID="LoginStatus1" onloggedout="LoginStatus2_LoggedOut" />

            <asp:Button ID="bt_back" runat="server" Text="返回" CausesValidation="False" onclick="bt_back_Click" onclientclick="javascript:history.go(-1);return false;"/>
        
        </div>
        <br />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <div class="content">
            <asp:Panel ID="panel" runat="server" HorizontalAlign="Left">
                
            <div class="title"><span class="title">
                <asp:Label ID="lb_title" runat="server" Text="探伤车轮复核情况"></asp:Label></span>
            </div>
                <asp:GridView ID="GridView1" runat="server" Width="100%" DataSourceID="SqlDataSource1" >
                </asp:GridView>
            </asp:Panel>
        </div>

        <div class="content">
            <asp:Panel runat="server" ID="panel2" HorizontalAlign="Left">
            
           
            <table width="50%">
                <tr>
                    <td class="auto-style3"><asp:Label ID="lb_advice" runat="server"  Text="处理意见:"></asp:Label></td>
                    <td><ajaxToolkit:ComboBox ID="cb_advice"  runat="server"    OnPreRender="cb_advice_PreRender" DataTextField="content">
                        
                    </ajaxToolkit:ComboBox></td>
                </tr>
                <tr>
                    <td class="auto-style3"><asp:Label ID="lb_desc" runat="server"  Text="处理结论:"></asp:Label></td>
                    <td><asp:TextBox ID="txt_desc"  TextMode="MultiLine"  Height="80px" runat="server" Width="100%" ></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="auto-style3"><asp:Label ID="lb_recheckPerson" runat="server" Text="复核人:"></asp:Label></td>
                    <td><ajaxToolkit:ComboBox ID="cb_recheckPerson" DataSourceID="SqlDataSource2" DropDownStyle="DropDown" DataTextField="DisplayName" MaxLength="30"  runat="server"  OnPreRender="cb_recheckPerson_PreRender">
                    
                </ajaxToolkit:ComboBox></td>
                </tr>
                <tr>
                    <td class="auto-style3"><asp:Label ID="lb_recheckOperator" runat="server" Text="处理人:"></asp:Label></td>
                    <td> <%= Request["recheckOperator"]%></td>
                </tr>
            </table>
            <div class="cmd">
                    <asp:Button ID="btCommit" runat="server" onclick="btCommit_Click" Text="提交复核数据" />
            </div>
            <br/>
            </asp:Panel>
        </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <%=PUBS.OutputFoot("") %>

    </form>
</body>
</html>
