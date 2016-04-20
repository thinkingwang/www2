<%@ Page Language="C#" AutoEventWireup="true" CodeFile="adjustCar.aspx.cs" Inherits="Verify" Theme="theme" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>车型配置</title>
<link href="css/tycho/tycho.css" type="text/css" rel="stylesheet"/>
<link href="css/tycho/tycho2.css" type="text/css" rel="stylesheet"/>


</head>
    <script type="text/javascript">
        function checkTxt() {
            var text = document.getElementById("NewTrainBtn").value;
            if (text === "开始增加") {
                return true;
            }
            var textFrom = document.getElementById("trainNoFromTxt").value;
            var textTo = document.getElementById("trainNoToTxt").value;
            if (textFrom !== "" && textTo!=="") {
                return true;
            }
            alert("“车号开始数字”和“车号结束数字”不能为空！");
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

        //选中所有行
        function SelectAll(chkAll) {
            var gridview = document.getElementById("GridView1");
            if (gridview) {
                //获取到GridView1中的所有input标签
                var inputs = gridview.getElementsByTagName("input");
                for (var i = 0; i < inputs.length; i++) {
                    if (inputs[i].type == "checkbox") {
                        //设置所有checkbox的选中状态与chkAll一致
                        inputs[i].checked = chkAll.checked;
                    }
                }
            }
        }

        //给选中行换背景色
        function checkRow(chkRow) {
            var row = chkRow.parentNode.parentNode;
            if (row) {
                if (chkRow.checked)
                    row.style.backgroundColor = "#7799CC";
                else
                    row.style.backgroundColor = "#FFFFFF";
            }
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

            <asp:Button ID="bt_back" runat="server" Text="返回" CausesValidation="False" onclientclick="javascript:history.go(-1);return false;"/>
        </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:tychoConnectionString %>" 
        ProviderName="<%$ ConnectionStrings:tychoConnectionString.ProviderName %>" SelectCommand="select * from [TrainType]" UpdateCommand="delete from [trainType] where trainNoFrom=@OldTrainNoFrom and trainNoTo=@OldTrainNoTo 
insert into [trainType] (trainType,trainNoFrom,trainNoTo,format) values(@TrainType,@TrainNoFrom,@TrainNoTo,@Format) " InsertCommand="insert into [trainType] (trainType,trainNoFrom,trainNoTo,format) values(@TrainType,@TrainNoFrom,@TrainNoTo,@Format) ">
        <InsertParameters>
            <asp:SessionParameter Name="TrainType" SessionField="TrainType" />
            <asp:SessionParameter Name="TrainNoFrom" SessionField="TrainNoFrom" />
            <asp:SessionParameter Name="TrainNoTo" SessionField="TrainNoTo" />
            <asp:SessionParameter Name="Format" SessionField="Format" />
        </InsertParameters>
        <UpdateParameters>
            <asp:SessionParameter Name="OldTrainNoFrom" SessionField="OldTrainNoFrom" />
            <asp:SessionParameter Name="OldTrainNoTo" SessionField="OldTrainNoTo" />
            <asp:SessionParameter DefaultValue="" Name="TrainNoFrom" SessionField="TrainNoFrom" />
            <asp:SessionParameter DefaultValue="" Name="TrainNoTo" SessionField="TrainNoTo" />
            <asp:SessionParameter DefaultValue="" Name="TrainType" SessionField="TrainType" />
            <asp:SessionParameter DefaultValue="" Name="Format" SessionField="Format" />
        </UpdateParameters>
        </asp:SqlDataSource>
        <br />

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">

    <ContentTemplate>
        <div class="content">        

            <div class="title" ><span class="title">
                <asp:Label ID="lb_title" runat="server" Text="车型配置"></asp:Label></span>
            </div>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4"
                    Width="976px" onrowcancelingedit="GridView1_RowCancelingEdit" 
                    onrowupdating="GridView1_RowUpdating" 
                     AlternatingRowStyle-VerticalAlign="NotSet" BackColor="#CCFFFF" DataSourceID="SqlDataSource1" OnRowDeleting="GridView1_RowDeleting" AllowSorting="True" HorizontalAlign="Center" OnRowEditing="GridView1_RowEditing" OnRowCommand="GridView1_RowCommand">
                    <Columns>
                        <asp:TemplateField HeaderText="序号">
                            <ItemTemplate>
                                <%# Container.DataItemIndex + 1%>
                            </ItemTemplate>
                            <ItemStyle BorderColor="#507CD1" HorizontalAlign="Center" BorderWidth="1px" ForeColor="Black" />
                        </asp:TemplateField>
                     <asp:TemplateField HeaderText="车型" SortExpression="trainType">
                    <ItemTemplate>
                        <asp:Label ID="trainTypeLbl" Runat="Server" Text='<%# Bind("trainType") %>'><%# Eval("trainType")%></asp:Label>
                    </ItemTemplate>
                     <EditItemTemplate>
                        <asp:TextBox ID="trainTypeEdit" runat="server" Text='<%# Bind("trainType") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="trainTypeTxt" Runat="server"></asp:TextBox>
                    </FooterTemplate>                        
                        <ItemStyle ForeColor="Black" />
                         </asp:TemplateField>
                        <asp:TemplateField HeaderText="车号开始数字" SortExpression="trainNoFrom">
                    <ItemTemplate>
                        <asp:Label ID="trainNoFromLbl" Runat="Server" Text='<%# Bind("trainNoFrom") %>'><%# Eval("trainNoFrom")%></asp:Label>
                    </ItemTemplate>
                   <EditItemTemplate>
                        <asp:TextBox ID="trainNoFromEdit" runat="server" Text='<%# Bind("trainNoFrom") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="trainNoFromTxt" Runat="server"></asp:TextBox>
                    </FooterTemplate>                        
                        <ItemStyle ForeColor="Black" />
                </asp:TemplateField>
                        <asp:TemplateField HeaderText="车号结束数字" SortExpression="trainNoTo">
                    <ItemTemplate>
                        <asp:Label ID="trainNoToLbl" Runat="Server" Text='<%# Bind("trainNoTo") %>'><%# Eval("trainNoTo")%></asp:Label>
                    </ItemTemplate>
                   <EditItemTemplate>
                        <asp:TextBox ID="trainNoToEdit" runat="server" Text='<%# Bind("trainNoTo") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="trainNoToTxt" Runat="server"></asp:TextBox>
                    </FooterTemplate>                        
                        <ItemStyle ForeColor="Black" />
                </asp:TemplateField>
                        <asp:TemplateField HeaderText="车型显示格式" SortExpression="format">
                    <ItemTemplate>
                        <asp:Label ID="formatLbl" Runat="Server" Text='<%# Bind("format") %>'><%# Eval("format")%></asp:Label>
                    </ItemTemplate>
                   <EditItemTemplate>
                        <asp:TextBox ID="formatEdit" runat="server" Text='<%# Bind("format") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="formatTxt" Runat="server"></asp:TextBox> 
                    </FooterTemplate>                        
                        <ItemStyle ForeColor="Black" />
                </asp:TemplateField>
                    <asp:CommandField HeaderText="编辑 " ShowEditButton="True" EditText="编缉" 
                    CancelText="取消" UpdateText="更新" ItemStyle-ForeColor="#33CCFF" ShowDeleteButton="True" DeleteText="删除"
                    ControlStyle-ForeColor="#33CCFF" >
                        <ControlStyle ForeColor="#33CCFF" />
                        <ItemStyle ForeColor="#33CCFF" />
                        </asp:CommandField> 
                         <asp:TemplateField HeaderText="详细" ShowHeader="False" >
                            <ItemTemplate>
                                <asp:Button ID="checkBtn"  Text="查询" runat="server" CommandName="check" CommandArgument='<%# Eval("trainType")+","+Eval("trainNoFrom")+","+Eval("trainNoTo") %>' />
                            </ItemTemplate>
                        <ControlStyle ForeColor="#33CCFF" />
                        <ItemStyle ForeColor="#33CCFF" />
                        </asp:TemplateField>
                    </Columns>
                    <HeaderStyle ForeColor="White" />
                    <PagerStyle ForeColor="Black" HorizontalAlign="Center" VerticalAlign="Bottom" />
                    <SortedAscendingCellStyle ForeColor="Black" />
                    <SortedAscendingHeaderStyle ForeColor="White" />
                    <SortedDescendingHeaderStyle ForeColor="White" />
                    </asp:GridView>              
            <asp:Button ID="NewTrainBtn" runat="server" Text="增加"  AutoPostBack="True" OnClick="NewTrainType_Click" Width="70px" />
            <asp:Button ID="CancelBtn" runat="server" Text="取消"  AutoPostBack="True"  OnClick="Cancel_Click" Width="70px" />


        </div>
                            </ContentTemplate>
    </asp:UpdatePanel>
    <%=PUBS.OutputFoot("") %>
    </form>
</body>
</html>
