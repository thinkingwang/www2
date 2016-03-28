<%@ Page Language="C#" AutoEventWireup="true" CodeFile="adjustThresholds.aspx.cs" Inherits="Verify" Theme="theme" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>门限配置</title>
<link href="css/tycho/tycho.css" type="text/css" rel="stylesheet"/>
<link href="css/tycho/tycho2.css" type="text/css" rel="stylesheet"/>


</head>
    <script type="text/javascript">
        function checkTxt() {
            var text = document.getElementById("trainTypeTxt").value;
            if (text !== "") {
                return true;
            }
            alert("新增车型文本框不能为空！");
            return false;
        }
        function deleteConfirm() {
            var text = document.getElementById("DropDownList1").value;
            if (text === "default") {
                alert("默认车型不能删除！");
                return false;
            }
            return true;
        }
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

            <asp:Button ID="bt_back" runat="server" Text="返回" CausesValidation="False" onclick="bt_back_Click" onclientclick="javascript:history.go(-1);return false;"/>
        </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:tychoConnectionString %>" 
        ProviderName="<%$ ConnectionStrings:tychoConnectionString.ProviderName %>"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
        ConnectionString="<%$ ConnectionStrings:tychoConnectionString %>" 
        ProviderName="<%$ ConnectionStrings:tychoConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT [trainType]
FROM      [thresholds]">
    </asp:SqlDataSource>
        <br />

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">

    <ContentTemplate>
        <div class="content">        

            <div class="title" ><span class="title">
                <asp:Label ID="lb_title" runat="server" Text="门限配置"></asp:Label></span>
            </div>
        <span style="color: #FF3300">车型:</span>
        <asp:DropDownList ID="DropDownList1" 
                runat="server" DataSourceID="SqlDataSource2" AutoPostBack="True" 
                DataTextField="trainType" DataValueField="trainType" 
                onselectedindexchanged="DropDownList1_SelectedIndexChanged">
        </asp:DropDownList>
        <span style="color: #FF3300">车厢类型:</span>
        <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True" 
                onselectedindexchanged="DropDownList2_SelectedIndexChanged">
                <asp:ListItem Value="1">动车</asp:ListItem>
                <asp:ListItem Value="0">拖车</asp:ListItem>
        </asp:DropDownList>
            <asp:TextBox ID="trainTypeTxt" runat="server" ToolTip="请输入新增车型的名称"></asp:TextBox>
            <asp:Button ID="NewTrainBtn" runat="server" Text="增加车型"  AutoPostBack="True" OnClientClick="return checkTxt()" OnClick="NewTrainType_Click" />
            <asp:Button ID="NewTrainPowerBtn" runat="server" Text="增加拖车配置"  AutoPostBack="True"  OnClick="NewTrainPowerType_Click" />
            <asp:Button ID="DeleteTrainPowerBtn" runat="server" Text="删除拖车配置"  AutoPostBack="True"  OnClick="DeleteTrainPowerType_Click" />
            <asp:Button ID="DeleteTrainBtn" runat="server" Text="删除当前车型"  AutoPostBack="True" OnClientClick="return deleteConfirm()" OnClick="DeleteTrainBtn_OnClick" />
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                    Width="976px" onrowcancelingedit="GridView1_RowCancelingEdit" 
                    onrowediting="GridView1_RowEditing" 
                    onrowupdating="GridView1_RowUpdating" 
                    onrowdatabound="GridView1_RowDataBound" AlternatingRowStyle-VerticalAlign="NotSet" BackColor="#CCFFFF">
                    <Columns>
                       <%-- <asp:BoundField DataField="up_level3" HeaderText="上限三级" 
                            SortExpression="up_level3" />--%>    
                        <asp:BoundField DataField="trainType" HeaderText="车型" 
                            SortExpression="trainType" ReadOnly="True" >
                        <ItemStyle ForeColor="Black" />
                        </asp:BoundField>
                        <asp:BoundField DataField="powerType" HeaderText="车厢类型" 
                            SortExpression="powerType" ReadOnly="True" >                           
                        <ItemStyle ForeColor="Black" />
                        </asp:BoundField>
                        <asp:BoundField DataField="name" HeaderText="配置项" SortExpression="name" 
                            ReadOnly="True" >
                        <ItemStyle ForeColor="Black" />
                        </asp:BoundField>
                        <asp:BoundField DataField="standard" HeaderText="标准值" 
                            SortExpression="standard">
                        <ControlStyle Width="100%" />
                        <ItemStyle BackColor="#339966" ForeColor="Black" />
                        </asp:BoundField>
                            <asp:TemplateField ItemStyle-Width="100px">
                            <HeaderTemplate><%=sL3%>&nbsp;级<br /> (上限)</HeaderTemplate>
                               <EditItemTemplate>
                                   <asp:TextBox ID="up3tbx" runat="server" Width="100%"></asp:TextBox>
                                   <asp:CheckBox ID="up3ck" AutoPostBack="true"  OnCheckedChanged="cb_CheckedChanged" runat="server" Text="无" />
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="up3Value" runat="server" Text="Label"></asp:Label>
                            </ItemTemplate>
                                <ItemStyle Width="100px" ForeColor="Blue" />
                        </asp:TemplateField>
                            <asp:TemplateField  ItemStyle-Width="100px">
                            <HeaderTemplate><%=sL3%>&nbsp;级<br /> (下限)</HeaderTemplate>
                               <EditItemTemplate>
                                   <asp:TextBox ID="low3tbx" runat="server" Width="100%"></asp:TextBox>
                                   <asp:CheckBox ID="low3ck" AutoPostBack="true"  OnCheckedChanged="cb_CheckedChanged" runat="server" Text="无" />
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="low3Value" runat="server" Text="Label"></asp:Label>
                            </ItemTemplate>
                                <ItemStyle Width="50px" ForeColor="Blue" />
                        </asp:TemplateField>
                            <asp:TemplateField ItemStyle-Width="100px">
                               <HeaderTemplate><%=sL2%>&nbsp;级<br /> (上限)</HeaderTemplate>
                               <EditItemTemplate>
                                   <asp:TextBox ID="up2tbx" runat="server" Width="100%"></asp:TextBox>
                                   <asp:CheckBox ID="up2ck" AutoPostBack="true"  OnCheckedChanged="cb_CheckedChanged" runat="server" Text="无" />
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="up2Value" runat="server" Text="Label"></asp:Label>
                            </ItemTemplate>
                                <ItemStyle Width="50px" ForeColor="#FFCC00" />
                        </asp:TemplateField>
                            <asp:TemplateField ItemStyle-Width="100px">
                            <HeaderTemplate><%=sL2%>&nbsp;级<br /> (下限)</HeaderTemplate>
                               <EditItemTemplate>
                                   <asp:TextBox ID="low2tbx" runat="server" Width="100%"></asp:TextBox>
                                   <asp:CheckBox ID="low2ck" AutoPostBack="true"  OnCheckedChanged="cb_CheckedChanged" runat="server" Text="无" />
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="low2Value" runat="server" Text="Label"></asp:Label>
                            </ItemTemplate>
                                <ItemStyle Width="50px" ForeColor="#FFCC00" />
                        </asp:TemplateField>
                            <asp:TemplateField ItemStyle-Width="100px">
                            <HeaderTemplate><%=sL1%>&nbsp;级<br />(上限)</HeaderTemplate>
                               <EditItemTemplate>
                                   <asp:TextBox ID="up1tbx" runat="server" Width="100%"></asp:TextBox>
                                   <asp:CheckBox ID="up1ck" AutoPostBack="true"  OnCheckedChanged="cb_CheckedChanged" runat="server" Text="无" />
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="up1Value" runat="server" Text="Label"></asp:Label>
                            </ItemTemplate>
                                <ItemStyle Width="50px" ForeColor="Red" />
                        </asp:TemplateField>  
                            <asp:TemplateField  ItemStyle-Width="100px">
                            <HeaderTemplate><%=sL1%>&nbsp;级<br /> (下限)</HeaderTemplate>
                               <EditItemTemplate>
                                   <asp:TextBox ID="low1tbx" runat="server" Width="100%"></asp:TextBox>
                                   <asp:CheckBox ID="low1ck" AutoPostBack="true"  OnCheckedChanged="cb_CheckedChanged" runat="server" Text="无" />
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="low1Value" runat="server" Text="Label"></asp:Label>
                            </ItemTemplate>
                                <ItemStyle Width="100px" ForeColor="Red" />
                        </asp:TemplateField>                             
                        <asp:BoundField DataField="precision" HeaderText="精度" 
                            SortExpression="precision" ItemStyle-Width="50" Visible="False" >
                        <ItemStyle Width="50px" ForeColor="Black" />
                        </asp:BoundField>
                        <asp:BoundField DataField="desc" HeaderText="描述" SortExpression="desc"  
                            ReadOnly="True">
                        <ItemStyle Width="200px" ForeColor="Black" />
                        </asp:BoundField>
                        <asp:CommandField HeaderText="编辑 " ShowEditButton="True" EditText="编缉" 
                            CancelText="取消" UpdateText="更新" ItemStyle-ForeColor="#33CCFF" 
                            ControlStyle-ForeColor="#33CCFF" > 
                        <ControlStyle ForeColor="#33CCFF" />
                        <ItemStyle ForeColor="#33CCFF" />
                        </asp:CommandField>
                    </Columns>
                    <EditRowStyle Width="100px" />
                    <EmptyDataRowStyle Width="100px" />
                    <HeaderStyle Width="100px" />
                    <RowStyle Width="100px" Wrap="True" />
                    <SelectedRowStyle Width="100px" />
                    </asp:GridView>
              


        </div>
                            </ContentTemplate>
    </asp:UpdatePanel>
    <%=PUBS.OutputFoot("") %>
    </form>
</body>
</html>
