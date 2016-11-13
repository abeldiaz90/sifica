<%@ Page Title="INGRESOS" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Ingresos.aspx.cs" Inherits="SISGRES.Ingresos" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .style3
        {
            width: 155px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table style="width:100%;">
                <tr>
                    <td class="style3" align="justify" valign="top">
                        <dx:ASPxLabel ID="lblFechaOperacion" runat="server" Text="FECHA DE OPERACIÓN:" 
                            Theme="BlackGlass">
                        </dx:ASPxLabel>
                    </td>
                    <td align="justify" valign="top">
                        <dx:ASPxDateEdit ID="fechaOperacion" runat="server" EditFormat="Custom" 
                            EditFormatString="d" EnableTheming="True" HorizontalAlign="Justify" 
                            NullText="Seleccione la Fecha de Operacion" Theme="Youthful">
                            <focusedstyle horizontalalign="Justify" wrap="True">
                            </focusedstyle>
                        </dx:ASPxDateEdit>
                    </td>
                </tr>
                <tr>
                    <td class="style3" align="justify" valign="top">
                        <dx:ASPxLabel ID="ASPxLabel4" runat="server" Text="ORIGEN DEL INGRESO:" 
                            Theme="BlackGlass">
                        </dx:ASPxLabel>
                    </td>
                    <td align="justify" valign="top">
                        <dx:ASPxComboBox ID="cboOrigen" runat="server" AutoPostBack="True" 
                            AutoResizeWithContainer="True" EnableTheming="True" HorizontalAlign="Justify" 
                            NullText="Seleccione el Origen" 
                            onselectedindexchanged="cboOrigen_SelectedIndexChanged" Theme="Youthful">
                            <Items>
                                <dx:ListEditItem Text="Prestamo" Value="1" />
                                <dx:ListEditItem Text="Venta Contado" Value="2" />
                                <dx:ListEditItem Text="Venta Credito" Value="3" />
                            </Items>
                            <focusedstyle horizontalalign="Justify" wrap="True">
                            </focusedstyle>
                        </dx:ASPxComboBox>
                    </td>
                </tr>
                <tr>
                    <td class="style3" align="justify" valign="top">
                        <dx:ASPxLabel ID="lblCliente" runat="server" Text="CLIENTE:" Theme="BlackGlass" 
                            Visible="False">
                        </dx:ASPxLabel>
                        <br />
                        <dx:ASPxLabel ID="lblAcreedor" runat="server" Text="ACREEDOR:" Visible="False">
                        </dx:ASPxLabel>
                    </td>
                    <td align="justify" valign="top">
                        <dx:ASPxComboBox ID="cboCliente" runat="server" DataSourceID="DatosCliente" 
                            EnableTheming="True" HorizontalAlign="Justify" NullText="Seleccione el Cliente" 
                            TextField="CLIENTE" Theme="Youthful" ValueField="ID_CLIENTE" Visible="False" 
                            Width="100%" IncrementalFilteringMode="Contains">
                            <focusedstyle horizontalalign="Justify" wrap="True">
                            </focusedstyle>
                        </dx:ASPxComboBox>
                        <asp:SqlDataSource ID="DatosCliente" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
                            SelectCommand="CLIENTES_CONSULTAR" SelectCommandType="StoredProcedure">
                        </asp:SqlDataSource>
                        <dx:ASPxComboBox ID="cboAcreedor" runat="server" HorizontalAlign="Justify" 
                            NullText="Seleccione el Acreedor" Theme="Youthful" 
                            Visible="False" Width="100%" IncrementalFilteringMode="Contains" 
                            DataSourceID="Acreedores" TextField="ACREEDOR" ValueField="ID_ACREEDOR">
                            <focusedstyle horizontalalign="Justify" wrap="True">
                            </focusedstyle>
                        </dx:ASPxComboBox>
                        <asp:SqlDataSource ID="Acreedores" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
                            SelectCommand="SELECT [ID_ACREEDOR], [ACREEDOR] FROM [ACREEDORES] ORDER BY [ACREEDOR]">
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td class="style3" align="justify" valign="top">
                        <dx:ASPxLabel ID="ASPxLabel5" runat="server" Text="DOCUMENTO DE INGRESO:" 
                            Theme="BlackGlass">
                        </dx:ASPxLabel>
                    </td>
                    <td align="justify" valign="top">
                        <dx:ASPxComboBox ID="cboDocumento" runat="server" 
                            AutoResizeWithContainer="True" EnableTheming="True" HorizontalAlign="Justify" 
                            NullText="Seleccione el Documento" Theme="Youthful" 
                            IncrementalFilteringMode="Contains">
                            <Items>
                                <dx:ListEditItem Text="Factura" Value="1" />
                                <dx:ListEditItem Text="Transferencia" Value="2" />
                                <dx:ListEditItem Text="Recibo" Value="3" />
                                <dx:ListEditItem Text="Cheque" Value="4" />
                            </Items>
                            <focusedstyle horizontalalign="Justify" wrap="True">
                            </focusedstyle>
                        </dx:ASPxComboBox>
                    </td>
                </tr>
                <tr>
                    <td class="style3" align="justify" valign="top">
                        <dx:ASPxLabel ID="ASPxLabel6" runat="server" Text="IMPORTE:" Theme="BlackGlass">
                        </dx:ASPxLabel>
                    </td>
                    <td align="justify" valign="top">
                        <dx:ASPxTextBox ID="txtImporte" runat="server" HorizontalAlign="Justify" 
                            NullText="Ingrese el Importe" Theme="Youthful" Width="170px">
                    <MaskSettings IncludeLiterals="DecimalSymbol" 
                        Mask="$&lt;0..999999999g&gt;.&lt;00..99&gt;" />
                            <focusedstyle horizontalalign="Justify" wrap="True">
                            </focusedstyle>
                        </dx:ASPxTextBox>
                    </td>
                </tr>
                <tr>
                    <td class="style3" align="justify" valign="top">
                        <dx:ASPxLabel ID="ASPxLabel12" runat="server" Text="MONEDA:">
                        </dx:ASPxLabel>
                    </td>
                    <td align="justify" valign="top">
                        <dx:ASPxComboBox ID="cbomoneda" runat="server" EnableTheming="True" 
                            HorizontalAlign="Justify" NullText="Seleccione la Moneda" Theme="Youthful">
                            <Items>
                                <dx:ListEditItem Text="MXN" Value="MXN" />
                                <dx:ListEditItem Text="USD" Value="USD" />
                            </Items>
                        </dx:ASPxComboBox>
                    </td>
                </tr>
                <tr>
                    <td class="style3" align="justify" valign="top">
                        <dx:ASPxLabel ID="ASPxLabel11" runat="server" Text="FOLIO DEL DOCUMENTO:" 
                            Theme="BlackGlass">
                        </dx:ASPxLabel>
                    </td>
                    <td align="justify" valign="top">
                        <dx:ASPxTextBox ID="txtFolio" runat="server" HorizontalAlign="Justify" 
                            NullText="Ingrese el Folio del Documento" Theme="Youthful" Width="170px">
                        </dx:ASPxTextBox>
                    </td>
                </tr>
                <tr>
                    <td class="style3" align="justify" valign="top">
                        <dx:ASPxLabel ID="ASPxLabel13" runat="server" Text="CONCEPTO:" 
                            Theme="BlackGlass">
                        </dx:ASPxLabel>
                    </td>
                    <td align="justify" valign="top">
                        <dx:ASPxComboBox ID="cboConcepto" runat="server" DataSourceID="ConceptoDatos" 
                            EnableTheming="True" HorizontalAlign="Center" 
                            IncrementalFilteringMode="Contains" NullText="Seleccione un Contrato" 
                            TextField="CONCEPTO" Theme="Youthful" ValueField="ID_CONCEPTO">
                        </dx:ASPxComboBox>
                        <asp:SqlDataSource ID="ConceptoDatos" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
                            SelectCommand="CONCEPTOS_CONSULTAR" SelectCommandType="StoredProcedure">
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td align="justify" class="style3" valign="top">
                        <dx:ASPxLabel ID="ASPxLabel7" runat="server" Text="OBSERVACIONES:" 
                            Theme="BlackGlass">
                        </dx:ASPxLabel>
                    </td>
                    <td align="justify" valign="top">
                        <dx:ASPxMemo ID="txtObservaciones" runat="server" Height="71px" 
                            HorizontalAlign="Justify" Theme="Youthful" Width="100%">
                            <focusedstyle horizontalalign="Justify" wrap="True">
                            </focusedstyle>
                        </dx:ASPxMemo>
                    </td>
                </tr>
                <tr>
                    <td class="style3" align="justify" valign="top">
                        <dx:ASPxLabel ID="ASPxLabel10" runat="server" Text="CUENTA BANCARIA:" 
                            Theme="BlackGlass">
                        </dx:ASPxLabel>
                    </td>
                    <td align="justify" valign="top">
                        <dx:ASPxComboBox ID="cboCuentaBancaria" runat="server" AnimationType="Fade" 
                            AutoResizeWithContainer="True" DataSourceID="CuentasBancarias" 
                            EnableTheming="True" HorizontalAlign="Justify" 
                            IncrementalFilteringMode="Contains" NullText="Seleccione la cuenta bancaria" 
                            TextField="CUENTA" TextFormatString="{0}" Theme="Youthful" 
                            ValueField="ID_CUENTA">
                            <Columns>
                                <dx:ListBoxColumn Caption="CUENTA" FieldName="CUENTA" />
                                <dx:ListBoxColumn Caption="BANCO" FieldName="BANCO" />
                                <dx:ListBoxColumn Caption="MONEDA" FieldName="MONEDA" />
                            </Columns>
                            <focusedstyle horizontalalign="Justify" wrap="True">
                            </focusedstyle>
                        </dx:ASPxComboBox>
                        <asp:SqlDataSource ID="CuentasBancarias" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
                            SelectCommand="CUENTAS_BANCARIAS_CONSULTAR" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:SessionParameter Name="ID_COMPAÑIA" SessionField="Compañia" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td class="style3" align="justify" valign="top">
                        &nbsp;</td>
                    <td align="justify" valign="top">
                        <dx:ASPxButton ID="btnGuardar" runat="server" HorizontalAlign="Center" 
                            onclick="btnGuardar_Click" Text="Guardar" Theme="Youthful">
                        </dx:ASPxButton>
                    </td>
                </tr>
                <tr>
                    <td class="style3" align="justify" valign="top">
                        &nbsp;</td>
                    <td align="justify" valign="top">
                        <asp:UpdateProgress ID="UpdateProgress1" runat="server" 
                            AssociatedUpdatePanelID="UpdatePanel1">
                            <progresstemplate>
                                <asp:Image ID="Image2" runat="server" ImageUrl="~/Logos/22.gif" />
                            </progresstemplate>
                        </asp:UpdateProgress>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
    <br />
</asp:Content>
