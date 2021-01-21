<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="Web_Site.Index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Bubble tea Bonanza</title>
    <style>
        .float-left{
            float:left
        }
        .float-clear{
            clear:both;
        }
        .content-row{
            width:100%;
            padding:10px;
        }
        .content-row-div{
            width:33.33%
        }
        @media only screen and (max-device-width :393px) {

            .float-left {
                float:none;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="max-width:980px;margin-top:40px">
        <h1>Bubble Tea Bonanza!</h1> 
        <div class="content-row" style="text-align:right"><a href="#">Log In</a></div>
        <div class="content-row">
        <div class="content-row-div float-left">
            Base Tea :
            <asp:DropDownList ID="ddlBaseTea" runat="server" DataSourceID="SqlDataSource1" DataTextField="Name" DataValueField="Id">
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:BubbleTeaConnectionString %>" SelectCommand="SELECT * FROM [BaseTea]"></asp:SqlDataSource>
        </div>
        <div class="content-row-div float-left">
            Flavor :
            <asp:DropDownList ID="ddlFlavor" runat="server" DataSourceID="SqlDataSource2" DataTextField="Name" DataValueField="Id">
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:BubbleTeaConnectionString %>" SelectCommand="SELECT * FROM [Flavors]"></asp:SqlDataSource>
        </div>
        <div class="content-row-div float-left">
            Toppings :
            <asp:CheckBoxList ID="chkListToppings" runat="server" DataSourceID="SqlDataSource3" DataTextField="Name" DataValueField="Id"></asp:CheckBoxList>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:BubbleTeaConnectionString %>" SelectCommand="SELECT * FROM [Toppings]"></asp:SqlDataSource>
        </div>
        </div>
        <div class="content-row float-clear">
            Size:
            <asp:RadioButtonList ID="rdbSize" runat="server" onclick="GetRadioButtonListSelectedValue(this);">
                    <asp:ListItem Value="S">Small</asp:ListItem>
                    <asp:ListItem Value="M">Medium</asp:ListItem>
                    <asp:ListItem Value="L">Large</asp:ListItem>
            </asp:RadioButtonList>
        </div>
        <div class="content-row" style="text-align:center">
            Total: $<label ID="lblCost" runat="server" ></label>
            <asp:HiddenField ID="hddCost" runat="server" />
        </div>
        <div class="content-row" style="text-align:center;">
            <asp:Button ID="btnSend" runat="server" Text="Send" OnClick="btnSend_Click" ForeColor="#fff" />
        </div>
        <div class="content-row">
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSource4" OnRowDataBound="GridView1_RowDataBound">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" Visible="false" />
                    <asp:TemplateField HeaderText="Size" SortExpression="Size">
                        <EditItemTemplate>
                            <asp:DropDownList ID="DropDownList3" runat="server" SelectedValue='<%# Bind("Size") %>'>
                                <asp:ListItem Value="S">Small</asp:ListItem>
                                <asp:ListItem Value="M">Medium</asp:ListItem>
                                <asp:ListItem Value="L">Large</asp:ListItem>
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("Size") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Base" SortExpression="Base">
                        <EditItemTemplate>
                            <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSource1" DataTextField="Name" DataValueField="Name" SelectedValue='<%# Bind("Base") %>'>
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("Base") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Tea" SortExpression="Tea">
                        <EditItemTemplate>
                            <asp:DropDownList ID="DropDownList4" runat="server" DataSourceID="SqlDataSource5" DataTextField="Name" DataValueField="Name" SelectedValue='<%# Bind("Tea") %>'>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:BubbleTeaConnectionString %>" SelectCommand="SELECT * FROM [Flavors]"></asp:SqlDataSource>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("Tea") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Toppings" HeaderText="Toppings" SortExpression="Toppings" />
                    <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" />
                    <asp:BoundField DataField="CustomerId" HeaderText="CustomerId" SortExpression="CustomerId" Visible="false" />
                    <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                </Columns>
            </asp:GridView>
            <br />
            <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:BubbleTeaConnectionString %>" DeleteCommand="DELETE FROM [Orders] WHERE [Id] = @Id" InsertCommand="INSERT INTO [Orders] ([Size], [Base], [Tea], [Toppings], [Price], [CustomerId]) VALUES (@Size, @Base, @Tea, @Toppings, @Price, @CustomerId)" SelectCommand="SELECT * FROM [Orders]" UpdateCommand="UPDATE [Orders] SET [Size] = @Size, [Base] = @Base, [Tea] = @Tea, [Toppings] = @Toppings, [Price] = @Price, [CustomerId] = @CustomerId WHERE [Id] = @Id">
                <DeleteParameters>
                    <asp:Parameter Name="Id" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="Size" Type="String" />
                    <asp:Parameter Name="Base" Type="String" />
                    <asp:Parameter Name="Tea" Type="String" />
                    <asp:Parameter Name="Toppings" Type="String" />
                    <asp:Parameter Name="Price" Type="Decimal" />
                    <asp:Parameter Name="CustomerId" Type="Int32" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Size" Type="String" />
                    <asp:Parameter Name="Base" Type="String" />
                    <asp:Parameter Name="Tea" Type="String" />
                    <asp:Parameter Name="Toppings" Type="String" />
                    <asp:Parameter Name="Price" Type="Decimal" />
                    <asp:Parameter Name="CustomerId" Type="Int32" />
                    <asp:Parameter Name="Id" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </div>
            </div>
    </form>
</body>
     <script type='text/javascript'>

         function GetRadioButtonListSelectedValue(radioButtonList) {

             for (var i = 0; i < radioButtonList.rows.length; ++i) {

                 if (radioButtonList.rows[i].cells[0].firstChild.checked) {

                     switch (radioButtonList.rows[i].cells[0].firstChild.value) {
                         case "S":
                             document.getElementById('lblCost').innerHTML = "3.50";
                             document.getElementById('<%=hddCost.ClientID %>').value = "3.50";
                             break;
                         case "M":
                             document.getElementById('lblCost').innerHTML = "4.50";
                             document.getElementById('<%=hddCost.ClientID %>').value = "4.50";
                             break;
                         case "L":
                             document.getElementById('lblCost').innerHTML = "5.50";
                             document.getElementById('<%=hddCost.ClientID %>').value = "5.50";
                             break;
                         default:
                     }
                 }

             }

         }

     </script>
</html>
