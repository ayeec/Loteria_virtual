<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Frases.aspx.cs" Inherits="Admin_Frases" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1 id="h1Title" runat="server">h1Title</h1>
    <asp:SqlDataSource ID="SqlDSFrases" runat="server" ConnectionString="<%$ ConnectionStrings:SQLServer_loteria %>" 
        DeleteCommand="DELETE FROM [Frases] WHERE [INTIDFRASE] = @INTIDFRASE" 
        InsertCommand="INSERT INTO [Frases] ([INTCVECARTA], [VCHARFRASE]) VALUES (@INTCVECARTA, @VCHARFRASE)" 
        SelectCommand="SELECT f.INTCVECARTA, f.INTIDFRASE, f.VCHARFRASE, CONCAT(c.INTCVECARTA, ' - ', c.VCHNOMBRE) as nameCarta 
FROM [Frases] f JOIN Cartas c ON c.INTCVECARTA = f.INTCVECARTA
WHERE (c.INTCVECARTA = CASE WHEN  @INTCVECARTA > 0 THEN @INTCVECARTA ELSE c.[INTCVECARTA] END) "
        UpdateCommand="UPDATE [Frases] SET [INTCVECARTA] = @INTCVECARTA, [VCHARFRASE] = @VCHARFRASE WHERE [INTIDFRASE] = @INTIDFRASE">
        <DeleteParameters>
            <asp:Parameter Name="INTIDFRASE" Type="Int32" />
        </DeleteParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="0" Name="INTCVECARTA" QueryStringField="idCarta" Type="Int32" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="INTCVECARTA" Type="Int32" />
            <asp:Parameter Name="VCHARFRASE" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="INTCVECARTA" Type="Int32" />
            <asp:Parameter Name="VCHARFRASE" Type="String" />
            <asp:Parameter Name="INTIDFRASE" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDSIDCartas" runat="server" ConnectionString="<%$ ConnectionStrings:SQLServer_loteria %>" SelectCommand="SELECT INTCVECARTA, CONCAT(INTCVECARTA, ' - ', VCHNOMBRE) as nameCarta FROM cartas"></asp:SqlDataSource>
    
    <asp:ListView ID="lvFrases" runat="server" DataKeyNames="INTIDFRASE" DataSourceID="SqlDSFrases" InsertItemPosition="LastItem">
        <EditItemTemplate>
            <tr class="itemRowAlt">
                <td>
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Actualizar" CssClass="btn btn-success" OnClick="UpdateButton_Click"/>
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancelar" CssClass="btn btn-outline-danger"/>
                </td>
                <td>
                    <asp:Label ID="INTIDFRASELabel1" runat="server" Text='<%# Eval("INTIDFRASE") %>' />
                </td>
                <td>
                    <asp:DropDownList ID="ddlCartas" runat="server" DataSourceID="SqlDSIDCartas" DataTextField="nameCarta" DataValueField="INTCVECARTA" OnPreRender="ddlCartas_PreRender">
                    </asp:DropDownList>
                    <asp:TextBox ID="INTCVECARTATextBox" runat="server" Text='<%# Bind("INTCVECARTA") %>' Visible="false"/>
                </td>
                <td>
                    <asp:TextBox ID="VCHARFRASETextBox" runat="server" Text='<%# Bind("VCHARFRASE") %>' MaxLength="50" />
                </td>
            </tr>
        </EditItemTemplate>
        <EmptyDataTemplate>
            <table runat="server" class="table table-bordered table-striped table-responsive">
                <tr>
                    <td>No hay Frases a mostrar.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <InsertItemTemplate>
            <tr style="">
                <td>
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insertar" CssClass="btn btn-success" OnClick="InsertButton_Click"/>
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Limpiar" CssClass="btn btn-outline-warning"/>
                </td>
                <td>
                    
                </td>
                <td>
                    <asp:DropDownList ID="ddlCartas" runat="server" DataSourceID="SqlDSIDCartas" DataTextField="nameCarta" DataValueField="INTCVECARTA" OnDataBound="ddlCartas_DataBound">
                    </asp:DropDownList>
                    <asp:TextBox ID="INTCVECARTATextBox" runat="server" Text='<%# Bind("INTCVECARTA") %>' Visible="false" />
                </td>
                <td>
                    <asp:TextBox ID="VCHARFRASETextBox" runat="server" Text='<%# Bind("VCHARFRASE") %>' MaxLength="50" />
                </td>
            </tr>
        </InsertItemTemplate>
        <ItemTemplate>
            <tr style="">
                <td>
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Editar" CssClass="btn btn-primary"/>
                    <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="Borrar" CssClass="btn btn-danger" OnClientClick="if(!confirm('Desea borrarlo?')) return false"/>
                </td>
                <td>
                    <asp:Label ID="INTIDFRASELabel" runat="server" Text='<%# Eval("INTIDFRASE") %>' />
                </td>
                <td>
                    <asp:Label ID="INTCVECARTALabel" runat="server" Text='<%# Eval("nameCarta") %>' />
                </td>
                <td>
                    <asp:Label ID="VCHARFRASELabel" runat="server" Text='<%# Eval("VCHARFRASE") %>' />
                </td>
            </tr>
        </ItemTemplate>
        <LayoutTemplate>
            <table runat="server">
                <tr runat="server">
                    <td runat="server">
                        <table id="itemPlaceholderContainer" runat="server" class="table table-bordered table-striped table-responsive">
                            <tr runat="server" style="">
                                <th runat="server"></th>
                                <th runat="server">ID Frase</th>
                                <th runat="server">Carta</th>
                                <th runat="server">Frase</th>
                            </tr>
                            <tr id="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr runat="server">
                    <td runat="server" style="">
                        <asp:DataPager ID="DataPager1" runat="server">
                            <Fields>
                                <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowLastPageButton="True" />
                            </Fields>
                        </asp:DataPager>
                    </td>
                </tr>
            </table>
        </LayoutTemplate>
        <SelectedItemTemplate>
            <tr style="">
                <td>
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" CssClass="btn btn-primary"/>
                    <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="Delete" CssClass="btn btn-danger"/>
                </td>
                <td>
                    <asp:Label ID="INTIDFRASELabel" runat="server" Text='<%# Eval("INTIDFRASE") %>' />
                </td>
                <td>
                    <asp:Label ID="INTCVECARTALabel" runat="server" Text='<%# Eval("INTCVECARTA") %>' />
                </td>
                <td>
                    <asp:Label ID="VCHARFRASELabel" runat="server" Text='<%# Eval("VCHARFRASE") %>' />
                </td>
            </tr>
        </SelectedItemTemplate>
    </asp:ListView>
</asp:Content>

