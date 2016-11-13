<%@ Page Title="Cobranza" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Cobranza.aspx.cs" Inherits="SISGRES.Cobranza" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <dx:ASPxGridView ID="grdCobranza" runat="server" AutoGenerateColumns="False" 
        DataSourceID="CobranzaDatos" EnableTheming="True" KeyFieldName="NUM_FACTURA" 
        Theme="Moderno" Width="100%" OnDetailRowExpandedChanged="grdCobranza_DetailRowExpandedChanged" ClientInstanceName="grdCobranza">
        <TotalSummary>
            <dx:ASPxSummaryItem DisplayFormat="c2" FieldName="TOTAL" ShowInColumn="TOTAL" ShowInGroupFooterColumn="TOTAL" SummaryType="Sum" ValueDisplayFormat="c2" />
            <dx:ASPxSummaryItem DisplayFormat="c2" FieldName="COBROS" ShowInColumn="COBROS" ShowInGroupFooterColumn="COBROS" SummaryType="Sum" ValueDisplayFormat="c2" />
            <dx:ASPxSummaryItem DisplayFormat="c2" FieldName="SALDO" ShowInColumn="SALDO" ShowInGroupFooterColumn="SALDO" SummaryType="Sum" ValueDisplayFormat="c2" />
        </TotalSummary>
        <Columns>
            <dx:GridViewDataTextColumn FieldName="ID_PRODUCCION" ReadOnly="True" 
                VisibleIndex="0" Visible="False">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="FECHA" VisibleIndex="1" Caption="FECHA">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="NOMBRE" VisibleIndex="12" Caption="VENDEDOR">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CLIENTE" VisibleIndex="3" Caption="CLIENTE">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="SUBTOTAL" ReadOnly="True" 
                VisibleIndex="6" Caption="SUBTOTAL">
                <PropertiesTextEdit DisplayFormatString="c2">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="IVA" ReadOnly="True" VisibleIndex="7" Caption="IVA">
                <PropertiesTextEdit DisplayFormatString="c2">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="TOTAL" ReadOnly="True" VisibleIndex="8">
                <PropertiesTextEdit DisplayFormatString="c2">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ABONADO" ReadOnly="True" 
                VisibleIndex="9" Caption="COBROS">
                <PropertiesTextEdit DisplayFormatString="c2">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="RESTANTE" ReadOnly="True" VisibleIndex="10" Caption="SALDO">
                <PropertiesTextEdit DisplayFormatString="c2">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="NUMERO DE DOCUMENTO" FieldName="NUM_FACTURA" ReadOnly="True" VisibleIndex="2">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataCheckColumn FieldName="FACTURA" ReadOnly="True" Visible="False" VisibleIndex="11">
            </dx:GridViewDataCheckColumn>
            <dx:GridViewDataTextColumn Caption="TIPO DE CONCRETO" FieldName="CONCATENADO" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="CANTIDAD" FieldName="CANTIDAD" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" />
        <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowFooter="True" />
        <SettingsDetail AllowOnlyOneMasterRowExpanded="True" ExportMode="All" ShowDetailRow="True" />
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
                <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="Cobranza" EnableTheming="True" KeyFieldName="ID_ABONO" Theme="Moderno" Width="100%">
                    <ClientSideEvents EndCallback="function(s, e) {
	grdCobranza.Refresh();
}" />
                    <Columns>
                        <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
                        </dx:GridViewCommandColumn>
                        <dx:GridViewDataTextColumn FieldName="ID_ABONO" ReadOnly="True" Visible="False" VisibleIndex="1">
                            <EditFormSettings Visible="False" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="FACTURA" VisibleIndex="2" Caption="FACTURA">
                            <EditFormSettings Visible="False" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="ABONO" VisibleIndex="3" Caption="COBRO">
                            <PropertiesTextEdit DisplayFormatInEditMode="True" DisplayFormatString="c2">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataDateColumn FieldName="FECHA" VisibleIndex="4" Caption="FECHA">
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataTextColumn FieldName="FOLIO" VisibleIndex="6">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataComboBoxColumn FieldName="DOCUMENTO" VisibleIndex="5">
                            <PropertiesComboBox IncrementalFilteringMode="Contains">
                                <Items>
                                    <dx:ListEditItem Text="CHEQUE" Value="1" />
                                    <dx:ListEditItem Text="DEPOSITO" Value="4" />
                                    <dx:ListEditItem Text="TRANSFERENCIA" Value="2" />
                                    <dx:ListEditItem Text="RECIBO" Value="3" />
                                </Items>
                            </PropertiesComboBox>
                        </dx:GridViewDataComboBoxColumn>
                    </Columns>
                    <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" ConfirmDelete="True" />
                    <Settings ShowFilterRow="True" ShowGroupPanel="True" />
                    <Styles>
                        <Header HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
                        </Header>
                        <Cell HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
                        </Cell>
                    </Styles>
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="Cobranza" runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>" DeleteCommand="ABONOS_ELIMINAR" DeleteCommandType="StoredProcedure" InsertCommand="ABONOS_INSERTAR" InsertCommandType="StoredProcedure" SelectCommand="ABONOS_CONSULTAR" SelectCommandType="StoredProcedure" UpdateCommand="ABONOS_MODIFICAR" UpdateCommandType="StoredProcedure">
                    <DeleteParameters>
                        <asp:Parameter Name="ID_ABONO" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:SessionParameter Name="NUM_FACTURA" SessionField="NUM_FACTURA" Type="String" />
                        <asp:Parameter Name="FECHA" Type="DateTime" />
                        <asp:Parameter Name="ABONO" Type="Decimal" />
                        <asp:Parameter Name="DOCUMENTO" Type="Int32" />
                        <asp:Parameter Name="FOLIO" Type="String" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:SessionParameter Name="NUM_FACTURA" SessionField="NUM_FACTURA" Type="String" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="ID_ABONO" Type="Int32" />
                        <asp:SessionParameter Name="FACTURA" SessionField="NUM_FACTURA" Type="String" />
                        <asp:Parameter Name="FECHA" Type="DateTime" />
                        <asp:Parameter Name="ABONO" Type="Decimal" />
                        <asp:Parameter Name="DOCUMENTO" Type="Int32" />
                        <asp:Parameter Name="FOLIO" Type="String" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </DetailRow>
        </Templates>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="CobranzaDatos" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
        SelectCommand="COBRANZA_CONSULTAR" SelectCommandType="StoredProcedure">
    </asp:SqlDataSource>
</asp:Content>
