<%@ Page Title="Facturación" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Facturacion.aspx.cs" Inherits="SISGRES.Facturacion" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <table style="width:100%;">
        <tr>
            <td align="center">
                <div>
                    <br />
                    <dx:ASPxGridView ID="lstFacturacion" runat="server" AutoGenerateColumns="False" DataSourceID="CobranzaDatos" EnableTheming="True" KeyFieldName="ID_PRODUCCION" Theme="MetropolisBlue" Width="100%">
                        <Columns>
                            <dx:GridViewCommandColumn SelectAllCheckboxMode="Page" ShowClearFilterButton="True" ShowSelectCheckbox="True" VisibleIndex="0">
                            </dx:GridViewCommandColumn>
                            <dx:GridViewDataTextColumn FieldName="ID_PRODUCCION" ReadOnly="True" Visible="False" VisibleIndex="1">
                                <EditFormSettings Visible="False" />
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="FECHA" ReadOnly="True" VisibleIndex="2">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn Caption="VENDEDOR" FieldName="NOMBRE" VisibleIndex="10">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn Caption="CLIENTE" FieldName="CLIENTE" VisibleIndex="4">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn Caption="IMPORTE" FieldName="SUBTOTAL" ReadOnly="True" VisibleIndex="8">
                                <PropertiesTextEdit DisplayFormatString="c2">
                                </PropertiesTextEdit>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="IVA" ReadOnly="True" Visible="False" VisibleIndex="12">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn Caption="PRECIO DE VENTA FINAL" FieldName="TOTAL" ReadOnly="True" Visible="False" VisibleIndex="9">
                                <PropertiesTextEdit DisplayFormatString="c2">
                                </PropertiesTextEdit>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn Caption="REQUIERE FACTURA" FieldName="FACTURA" ReadOnly="True" VisibleIndex="11">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn Caption="REMISIÓN" FieldName="REMISION" VisibleIndex="3">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="ID_TIPO" Visible="False" VisibleIndex="13">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="CANTIDAD" VisibleIndex="6">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn Caption="TIPO DE CONCRETO" FieldName="CONCATENADO" ReadOnly="True" VisibleIndex="5">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="FACTURA" ReadOnly="True" Visible="False" VisibleIndex="14">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn Caption="PRECIO DE VENTA FINAL" FieldName="PRECIO_VENTA_FINAL" VisibleIndex="7">
                                <PropertiesTextEdit DisplayFormatString="C2">
                                </PropertiesTextEdit>
                            </dx:GridViewDataTextColumn>
                        </Columns>
                        <Settings ShowFilterRow="True" />
                        <Styles>
                            <Header HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
                            </Header>
                            <Cell HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
                            </Cell>
                        </Styles>
                    </dx:ASPxGridView>
                </div>
                <table style="width:100%;">
                    <tr>
                        <td align="center" valign="top">
                            <dx:ASPxLabel ID="lblTipoDocumento" runat="server" Text="TIPO DE DOCUMENTO" Theme="Moderno">
                            </dx:ASPxLabel>
                            <dx:ASPxComboBox ID="cboTipoDocumento" runat="server" EnableTheming="True" Theme="Moderno">
                                <Items>
                                    <dx:ListEditItem Text="FACTURA" Value="1" />
                                    <dx:ListEditItem Text="RECIBO" Value="2" />
                                </Items>
                                <ValidationSettings ErrorTextPosition="Bottom" SetFocusOnError="True" ValidationGroup="Facturacion">
                                    <RequiredField IsRequired="True" />
                                </ValidationSettings>
                            </dx:ASPxComboBox>
                        </td>
                        <td align="center" valign="top">
                            <dx:ASPxLabel ID="ASPxLabel3" runat="server" AssociatedControlID="txtNumeroFactura" Text="NUMERO DE DOCUMENTO" Theme="Moderno">
                            </dx:ASPxLabel>
                            <dx:ASPxTextBox ID="txtNumeroFactura" runat="server" HorizontalAlign="Center" Theme="Moderno" Width="170px">
                                <ValidationSettings ErrorTextPosition="Bottom" SetFocusOnError="True" ValidationGroup="Facturacion">
                                    <RequiredField IsRequired="True" />
                                </ValidationSettings>
                            </dx:ASPxTextBox>
                        </td>
                        <td align="center" valign="top">
                            <dx:ASPxLabel ID="ASPxLabel4" runat="server" AssociatedControlID="txtNumeroFactura" Text="FECHA DE DOCUMENTO" Theme="Moderno">
                            </dx:ASPxLabel>
                            <dx:ASPxDateEdit ID="FechaFacturacion" runat="server" Theme="Moderno">
                                <ValidationSettings ErrorTextPosition="Bottom" SetFocusOnError="True" ValidationGroup="Facturacion">
                                    <RequiredField IsRequired="True" />
                                </ValidationSettings>
                            </dx:ASPxDateEdit>
                        </td>
                    </tr>
                </table>
                <dx:ASPxButton ID="ASPxButton2" runat="server" EnableTheming="True" OnClick="ASPxButton2_Click" Text="AGREGAR" Theme="Moderno" ValidationGroup="Facturacion">
                    <ClientSideEvents Click="function(s, e) {
	this.grdFacturas.Refresh();
}" />
                </dx:ASPxButton>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="CobranzaDatos" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
        SelectCommand="FACTURACION_CONSULTAR" SelectCommandType="StoredProcedure" 
        UpdateCommand="FACTURACION_MODIFICAR" UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter Name="ID_PRODUCCION" Type="Int32" />
            <asp:Parameter Name="NUM_FACTURA" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <dx:ASPxGridView ID="grdFacturas" runat="server" AutoGenerateColumns="False" ClientInstanceName="grdFacturas" DataSourceID="FacturacionDatos" EnableTheming="True" Theme="Moderno" Width="100%" KeyFieldName="NUM_FACTURA" OnDetailRowExpandedChanged="grdFacturas_DetailRowExpandedChanged">
        <TotalSummary>
            <dx:ASPxSummaryItem DisplayFormat="C2" FieldName="TOTAL" ShowInColumn="TOTAL" ShowInGroupFooterColumn="TOTAL" SummaryType="Sum" ValueDisplayFormat="C2" />
        </TotalSummary>
        <Columns>
            <dx:GridViewDataTextColumn Caption="NUMERO DEL DOCUMENTO" FieldName="NUM_FACTURA" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn Caption="FECHA DEL DOCUMENTO" FieldName="FECHA_FACTURA" VisibleIndex="0">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn Caption="VENDEDOR" FieldName="NOMBRE" VisibleIndex="8">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="CLIENTE" FieldName="CLIENTE" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="SUBTOTAL" ReadOnly="True" VisibleIndex="5">
                <PropertiesTextEdit DisplayFormatString="c2">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="IVA" ReadOnly="True" VisibleIndex="6">
                <PropertiesTextEdit DisplayFormatString="c2">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="TOTAL" ReadOnly="True" VisibleIndex="7">
                <PropertiesTextEdit DisplayFormatString="c2">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="CANTIDAD" FieldName="CANTIDAD" ReadOnly="True" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="TIPO DE CONCRETO" FieldName="CONCATENADO" ReadOnly="True" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" />
        <Settings ShowFooter="True" ShowGroupPanel="True" />
        <SettingsDetail AllowOnlyOneMasterRowExpanded="True" ExportMode="Expanded" ShowDetailRow="True" />
        <Styles>
            <Header HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </Header>
            <DetailRow BackColor="#CCFF33" HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </DetailRow>
            <Cell HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </Cell>
        </Styles>
        <Templates>
            <DetailRow>
                <dx:ASPxGridView ID="grdRemisiones" runat="server" AutoGenerateColumns="False" DataSourceID="FACTURACION_DATALLE" EnableTheming="True" KeyFieldName="ID_PRODUCCION" Theme="Moderno" KeyboardSupport="True">
                    <TotalSummary>
                        <dx:ASPxSummaryItem DisplayFormat="c2" FieldName="TOTAL" ShowInColumn="TOTAL" ShowInGroupFooterColumn="TOTAL" SummaryType="Sum" Tag="TOTAL" ValueDisplayFormat="c2" />
                    </TotalSummary>
                    <Columns>
                        <dx:GridViewCommandColumn ShowDeleteButton="True" VisibleIndex="0">
                        </dx:GridViewCommandColumn>
                        <dx:GridViewDataTextColumn FieldName="ID_PRODUCCION" ReadOnly="True" Visible="False" VisibleIndex="1">
                            <EditFormSettings Visible="False" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="FECHA DE REMISION" FieldName="FECHA" ReadOnly="True" VisibleIndex="2">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="VENDEDOR" FieldName="NOMBRE" VisibleIndex="4">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="CLIENTE" FieldName="CLIENTE" VisibleIndex="5">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="SUBTOTAL" ReadOnly="True" VisibleIndex="8">
                            <PropertiesTextEdit DisplayFormatString="c2">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="IVA" ReadOnly="True" VisibleIndex="9">
                            <PropertiesTextEdit DisplayFormatString="c2">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="TOTAL" ReadOnly="True" VisibleIndex="10">
                            <PropertiesTextEdit DisplayFormatString="c2">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="NUMERO DE FACTURA" FieldName="NUM_FACTURA" ReadOnly="True" Visible="False" VisibleIndex="11">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="NOTA DE REMISIÓN" FieldName="REMISION" VisibleIndex="3">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="TIPO DE CONCRETO" FieldName="ID_TIPO" Visible="False" VisibleIndex="12">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="CANTIDAD" FieldName="CANTIDAD" VisibleIndex="7">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="TIPO DE CONCRETO" FieldName="CONCATENADO" ReadOnly="True" VisibleIndex="6">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" />
                    <Settings ShowFooter="True" ShowGroupFooter="VisibleAlways" ShowTitlePanel="True" />
                    <Styles>
                        <Cell HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
                        </Cell>
                    </Styles>
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="FACTURACION_DATALLE" runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>" DeleteCommand="FACTURACION_CONSULTAR_ELIMINAR" DeleteCommandType="StoredProcedure" SelectCommand="FACTURACION_CONSULTAR_DETALLE" SelectCommandType="StoredProcedure">
                    <DeleteParameters>
                         <asp:Parameter Name="ID_PRODUCCION" Type="String" />
                    </DeleteParameters>
                    <SelectParameters>
                        <asp:SessionParameter Name="NUM_FACTURA" SessionField="NUM_FACTURA" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </DetailRow>
        </Templates>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="FacturacionDatos" runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>" SelectCommand="FACTURACION_CONSULTAR_AGRUPADO" SelectCommandType="StoredProcedure"></asp:SqlDataSource>

</asp:Content>
