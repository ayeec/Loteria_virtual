<%@ Page Title="Ver Usuarios" Language="C#"  MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Usuarios.aspx.cs" Inherits="Admin_Usuarios" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:SqlDataSource ID="SQLDSUsuarios" runat="server" ConnectionString="<%$ ConnectionStrings:SQLServer_loteria %>" SelectCommand="SELECT * FROM [usuario]" ConflictDetection="CompareAllValues" DeleteCommand="DELETE FROM [usuario] WHERE [INTCVEUSUARIO] = @original_INTCVEUSUARIO AND [VCHUSUARIO] = @original_VCHUSUARIO AND [VCHPASSWORD] = @original_VCHPASSWORD AND [CHRTIPOUSUARIO] = @original_CHRTIPOUSUARIO" InsertCommand="INSERT INTO [usuario] ([VCHUSUARIO], [VCHPASSWORD], [CHRTIPOUSUARIO]) VALUES (@VCHUSUARIO, @VCHPASSWORD, @CHRTIPOUSUARIO)" OldValuesParameterFormatString="original_{0}" UpdateCommand="UPDATE [usuario] SET [VCHUSUARIO] = @VCHUSUARIO, [VCHPASSWORD] = @VCHPASSWORD, [CHRTIPOUSUARIO] = @CHRTIPOUSUARIO WHERE [INTCVEUSUARIO] = @original_INTCVEUSUARIO AND [VCHUSUARIO] = @original_VCHUSUARIO AND [VCHPASSWORD] = @original_VCHPASSWORD AND [CHRTIPOUSUARIO] = @original_CHRTIPOUSUARIO">
        <DeleteParameters>
            <asp:Parameter Name="original_INTCVEUSUARIO" Type="Int32" />
            <asp:Parameter Name="original_VCHUSUARIO" Type="String" />
            <asp:Parameter Name="original_VCHPASSWORD" Type="String" />
            <asp:Parameter Name="original_CHRTIPOUSUARIO" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="VCHUSUARIO" Type="String" />
            <asp:Parameter Name="VCHPASSWORD" Type="String" />
            <asp:Parameter Name="CHRTIPOUSUARIO" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="VCHUSUARIO" Type="String" />
            <asp:Parameter Name="VCHPASSWORD" Type="String" />
            <asp:Parameter Name="CHRTIPOUSUARIO" Type="String" />
            <asp:Parameter Name="original_INTCVEUSUARIO" Type="Int32" />
            <asp:Parameter Name="original_VCHUSUARIO" Type="String" />
            <asp:Parameter Name="original_VCHPASSWORD" Type="String" />
            <asp:Parameter Name="original_CHRTIPOUSUARIO" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
     <asp:ListView ID="lvUsuarios" runat="server" DataSourceID="SQLDSUsuarios" InsertItemPosition="LastItem" DataKeyNames="INTCVEUSUARIO">
         <AlternatingItemTemplate>
             <tr style="background-color:#FFF8DC;">
                 <td>
                     <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="Delete" />
                     <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                 </td>
                 <td>
                     <asp:Label ID="INTCVEUSUARIOLabel" runat="server" Text='<%# Eval("INTCVEUSUARIO") %>' />
                 </td>
                 <td>
                     <asp:Label ID="VCHUSUARIOLabel" runat="server" Text='<%# Eval("VCHUSUARIO") %>' />
                 </td>
                 <td>
                     <asp:Label ID="VCHPASSWORDLabel" runat="server" Text='<%# Eval("VCHPASSWORD") %>' />
                 </td>
                 <td>
                     <asp:Label ID="CHRTIPOUSUARIOLabel" runat="server" Text='<%# Eval("CHRTIPOUSUARIO") %>' />
                 </td>
             </tr>
         </AlternatingItemTemplate>
         <EditItemTemplate>
             <tr style="background-color:#008A8C;color: #FFFFFF;">
                 <td>
                     <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                     <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                 </td>
                 <td>
                     <asp:Label ID="INTCVEUSUARIOLabel1" runat="server" Text='<%# Eval("INTCVEUSUARIO") %>' />
                 </td>
                 <td>
                     <asp:TextBox ID="VCHUSUARIOTextBox" runat="server" Text='<%# Bind("VCHUSUARIO") %>' />
                 </td>
                 <td>
                     <asp:TextBox ID="VCHPASSWORDTextBox" runat="server" Text='<%# Bind("VCHPASSWORD") %>' />
                 </td>
                 <td>
                     <asp:TextBox ID="CHRTIPOUSUARIOTextBox" runat="server" Text='<%# Bind("CHRTIPOUSUARIO") %>' />
                 </td>
             </tr>
         </EditItemTemplate>
         <EmptyDataTemplate>
             <table runat="server" style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                 <tr>
                     <td>No data was returned.</td>
                 </tr>
             </table>
         </EmptyDataTemplate>
         <InsertItemTemplate>
             <tr style="">
                 <td>
                     <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" />
                     <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />
                 </td>
                 <td>
                     &nbsp;</td>
                 <td>
                     <asp:TextBox ID="VCHUSUARIOTextBox" runat="server" Text='<%# Bind("VCHUSUARIO") %>' />
                 </td>
                 <td>
                     <asp:TextBox ID="VCHPASSWORDTextBox" runat="server" Text='<%# Bind("VCHPASSWORD") %>' />

                 </td>
                 <td>
                     <asp:TextBox ID="CHRTIPOUSUARIOTextBox" runat="server" Text='<%# Bind("CHRTIPOUSUARIO") %>' />
                 </td>
             </tr>
         </InsertItemTemplate>
         <ItemTemplate>
             <tr style="background-color:#DCDCDC;color: #000000;">
                 <td>
                     <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="Delete" />
                     <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                 </td>
                 <td>
                     <asp:Label ID="INTCVEUSUARIOLabel" runat="server" Text='<%# Eval("INTCVEUSUARIO") %>' />
                 </td>
                 <td>                         
                     <asp:Label ID="VCHUSUARIOLabel" runat="server" Text='<%# Eval("VCHUSUARIO") %>' />
                 </td>
                 <td>
                     <asp:Label ID="VCHPASSWORDLabel" runat="server" Text='<%# Eval("VCHPASSWORD") %>' />
                     
                 </td>
                 <td>
                     <asp:Label ID="CHRTIPOUSUARIOLabel" runat="server" Text='<%# Eval("CHRTIPOUSUARIO") %>' />
                 </td>
             </tr>
         </ItemTemplate>
         <LayoutTemplate>
             <table runat="server">
                 <tr runat="server">
                     <td runat="server">
                         <table id="itemPlaceholderContainer" runat="server" border="1" style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                             <tr runat="server" style="background-color:#DCDCDC;color: #000000;">
                                 <th runat="server"></th>
                                 <th runat="server">INTCVEUSUARIO</th>
                                 <th runat="server">VCHUSUARIO</th>
                                 <th runat="server">VCHPASSWORD</th>
                                 <th runat="server">CHRTIPOUSUARIO</th>
                             </tr>
                             <tr id="itemPlaceholder" runat="server">
                             </tr>
                         </table>
                     </td>
                 </tr>
                 <tr runat="server">
                     <td runat="server" style="text-align: center;background-color: #CCCCCC;font-family: Verdana, Arial, Helvetica, sans-serif;color: #000000;">
                         <asp:DataPager ID="DataPager1" runat="server">
                             <Fields>
                                 <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" />
                                 <asp:NumericPagerField />
                                 <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" />
                             </Fields>
                         </asp:DataPager>
                     </td>
                 </tr>
             </table>
         </LayoutTemplate>
         <SelectedItemTemplate>
             <tr style="background-color:#008A8C;font-weight: bold;color: #FFFFFF;">
                 <td>
                     <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="Delete" />
                     <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                 </td>
                 <td>
                     <asp:Label ID="INTCVEUSUARIOLabel" runat="server" Text='<%# Eval("INTCVEUSUARIO") %>' />
                 </td>
                 <td>
                     <asp:Label ID="VCHUSUARIOLabel" runat="server" Text='<%# Eval("VCHUSUARIO") %>' />
                 </td>
                 <td>
                     <asp:Label ID="VCHPASSWORDLabel" runat="server" Text='<%# Eval("VCHPASSWORD") %>' />
                 </td>
                 <td>
                     <asp:Label ID="CHRTIPOUSUARIOLabel" runat="server" Text='<%# Eval("CHRTIPOUSUARIO") %>' />
                 </td>
             </tr>
         </SelectedItemTemplate>
    </asp:ListView>
     </asp:Content>