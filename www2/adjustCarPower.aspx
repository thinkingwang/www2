<%@ Page Language="C#" AutoEventWireup="true" CodeFile="adjustCarPower.aspx.cs" Inherits="Verify" Theme="theme" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>车厢类型配置</title>
<link href="css/tycho/tycho.css" type="text/css" rel="stylesheet"/>
<link href="css/tycho/tycho2.css" type="text/css" rel="stylesheet"/>


</head>
    <script type="text/javascript">
        function checkTxt() {
            var text = document.getElementById("txt_trainType").value;
            var carNum = document.getElementById("txt_carNum").value;
            if (text !== ""&&carNum!=="") {
                return true;
            }
            alert("新增车型和车厢节数文本框不能为空！");
            return false;
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
        <br />

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">

    <ContentTemplate>
        <div class="content">        

            <div class="title" ><span class="title">
                <asp:Label ID="lb_title" runat="server" Text="车厢类型配置"></asp:Label></span>
            </div>
            <span style="color: #FF3300">车型名称:</span>
            <asp:TextBox ID="txt_trainType" runat="server" ToolTip="请输入新增车型的名称"></asp:TextBox>
            <span style="color: #FF3300">车厢节数:</span>
            <asp:TextBox ID="txt_carNum" runat="server" onkeyup="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')" ToolTip="请输入新增车厢节数"></asp:TextBox>
            <asp:Button ID="NewTrainBtn" runat="server" Text="增加车型"  AutoPostBack="True" OnClientClick="return checkTxt()" OnClick="NewTrainType_Click" />
            <asp:Button ID="DeleteTrainBtn" runat="server" Text="删除当前车型"  AutoPostBack="True" OnClick="DeleteTrainBtn_OnClick" />
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                    Width="976px" onrowcancelingedit="GridView1_RowCancelingEdit" 
                    onrowediting="GridView1_RowEditing" 
                    onrowupdating="GridView1_RowUpdating" 
                    onrowdatabound="GridView1_RowDataBound" AlternatingRowStyle-VerticalAlign="NotSet" BackColor="#CCFFFF" OnDataBound="GridView1_DataBound">
                    <Columns>
                       <%-- <asp:BoundField DataField="up_level3" HeaderText="上限三级" 
                            SortExpression="up_level3" />--%>    
                        <asp:BoundField DataField="trainType" HeaderText="车型" 
                            SortExpression="trainType" ReadOnly="True" >
                        <ItemStyle ForeColor="Black" />
                        </asp:BoundField>
                        <asp:BoundField DataField="carPos" HeaderText="车厢序号" SortExpression="name" 
                            ReadOnly="True" >
                        <ItemStyle ForeColor="Black" />
                        </asp:BoundField>
                        <asp:BoundField DataField="carNo" HeaderText="车厢编号">
                        <ItemStyle ForeColor="Black" />
                        </asp:BoundField>
                        <asp:BoundField DataField="axleType" HeaderText="轴类型" ItemStyle-Width="50" >
                        <ItemStyle ForeColor="Black" />
                        </asp:BoundField>
                        <asp:CheckBoxField DataField="dir" HeaderText="方向" />
                        <asp:TemplateField HeaderText="车厢类型">
                            <ItemTemplate>
                                <asp:Label runat="server" Text='<%# Bind("powerType") %>' ID="lb_powerType"></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                            <asp:DropDownList ID="ddl_powerType" runat="server">
                                <asp:ListItem Value="1" Text="动车" ></asp:ListItem>
                                <asp:ListItem Value="0" Text="拖车" ></asp:ListItem>
                            </asp:DropDownList>
                            </EditItemTemplate>                         
                        <ItemStyle ForeColor="Black" />
                        </asp:TemplateField>
                        <asp:CommandField HeaderText="编辑 " ShowEditButton="True" EditText="编缉" 
                            CancelText="取消" UpdateText="更新" ItemStyle-ForeColor="#33CCFF" 
                            ControlStyle-ForeColor="#33CCFF" > 
                        <ControlStyle ForeColor="#33CCFF" />
                        <ItemStyle ForeColor="#33CCFF" />
                        </asp:CommandField>
                    </Columns>
                    <EditRowStyle Width="100%" />
                    </asp:GridView>
              


        </div>
                            </ContentTemplate>
    </asp:UpdatePanel>
    <%=PUBS.OutputFoot("") %>
    </form>
</body>
</html>
