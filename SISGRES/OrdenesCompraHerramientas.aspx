<%@ Page Title="Ordenes de compra de Herramientas" Language="C#" MasterPageFile="~/Principal.Master"
    AutoEventWireup="true" CodeBehind="OrdenesCompraHerramientas.aspx.cs" Inherits="SISGRES.OrdenesCompraHerramientas" %>

<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <dx:ASPxGridView ID="grdAprobaciones" runat="server" AutoGenerateColumns="False"
        DataSourceID="AprobacionesRequisicionesHerramientasDatos" EnableTheming="True"
        KeyFieldName="ID_REQUISICION" Theme="BlackGlass" Width="100%" Caption="ORDENES DE COMPRA DE HERRAMIENTAS"
        AccessibilityCompliant="True" ClientInstanceName="grdAprobaciones" 
        EnableCallbackAnimation="True" EnablePagingCallbackAnimation="True">
        <Columns>
            <dx:GridViewCommandColumn SelectAllCheckboxMode="Page" ShowSelectCheckbox="True"
                VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn Caption="FOLIO" FieldName="ID_REQUISICION" ReadOnly="True"
                VisibleIndex="1">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="NOMBRE DEL SOLICITANTE" FieldName="NOMBRE" ReadOnly="True"
                VisibleIndex="2">
                <Settings AutoFilterCondition="Contains" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="CORREO ELECTRÓNICO" FieldName="CORREO_ELECTRONICO"
                VisibleIndex="3">
                <Settings AutoFilterCondition="Contains" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn Caption="FECHA DE SOLICITUD" FieldName="FECHA" VisibleIndex="4">
                <PropertiesDateEdit DisplayFormatString="" EditFormat="DateTime">
                </PropertiesDateEdit>
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn Caption="COMPAÑIA" FieldName="COMPAÑIA" VisibleIndex="5">
                <Settings AutoFilterCondition="Contains" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="JUSTIFICACIÓN" FieldName="JUSTIFICACION" VisibleIndex="6">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn VisibleIndex="7">
                <DataItemTemplate>
                    <asp:LinkButton ID="lnkDetalle" runat="server" OnClick="lnkDetalle_Click">Detalle</asp:LinkButton>
                </DataItemTemplate>
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" />
        <SettingsPager Position="TopAndBottom" ShowSeparators="True">
        </SettingsPager>
        <Settings ShowFilterRow="True" ShowGroupPanel="True" />
        <Styles>
            <Cell HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </Cell>
            <Header HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </Header>
        </Styles>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="AprobacionesRequisicionesHerramientasDatos" runat="server"
        ConnectionString="<%$ ConnectionStrings:SIFICA %>" SelectCommand="ORDENES_COMPRA_HERRAMIENTAS"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="ID_COMPAÑIA" SessionField="Compañia" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <dx:ASPxPopupControl ID="popupDetalle" runat="server" ClientInstanceName="popupReporte"
        HeaderText="" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="TopSides"
        Theme="BlackGlass" Width="1200px" AllowDragging="True" AllowResize="True" Modal="True"
        ShowPageScrollbarWhenModal="True" ShowPinButton="True" ShowRefreshButton="True"
        CloseAction="CloseButton">
        <ContentStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
        </ContentStyle>
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <table style="width: 100%;">
                    <tr>
                        <td>
                            &nbsp;</td>
                        <td colspan="4">
                            <dx:ASPxButton ID="ASPxButton4" runat="server" AutoPostBack="False" 
                                EnableTheming="True" HorizontalAlign="Center" OnClick="ASPxButton4_Click" 
                                Text="Procesar Orden de Compra" Theme="BlackGlass" UseSubmitBehavior="False" 
                                ValidationGroup="OrdenCompra" VerticalAlign="Middle">
                                <ClientSideEvents Click="function(s, e) {
	grdAprobaciones.Refresh();
}" />
                            </dx:ASPxButton>
                        </td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td align="center" valign="top">
                            <dx:ASPxLabel ID="ASPxLabel8" runat="server" Text="FOLIO">
                            </dx:ASPxLabel>
                            <dx:ASPxComboBox ID="cboFolio" runat="server" EnableTheming="True" 
                                Theme="BlackGlass">
                                <Items>
                                    <dx:ListEditItem Text="A" Value="A" />
                                    <dx:ListEditItem Text="B" Value="B" />
                                </Items>
                                <ValidationSettings ErrorTextPosition="Bottom" SetFocusOnError="True" 
                                    ValidationGroup="OrdenCompra">
                                    <RequiredField IsRequired="True" />
                                </ValidationSettings>
                            </dx:ASPxComboBox>
                        </td>
                        <td align="center" valign="top">
                            <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="MONEDA">
                            </dx:ASPxLabel>
                            <dx:ASPxComboBox ID="cboMoneda" runat="server" HorizontalAlign="Center" 
                                IncrementalFilteringMode="Contains" Theme="BlackGlass">
                                <Items>
                                    <dx:ListEditItem Text="USD" Value="USD" />
                                    <dx:ListEditItem Text="MXN" Value="MXN" />
                                </Items>
                                <ValidationSettings ErrorTextPosition="Bottom" SetFocusOnError="True" 
                                    ValidationGroup="OrdenCompra">
                                    <RequiredField IsRequired="True" />
                                </ValidationSettings>
                            </dx:ASPxComboBox>
                        </td>
                        <td align="center" valign="top">
                            <dx:ASPxLabel ID="ASPxLabel6" runat="server" Text="CONDICIONES DE PAGO">
                            </dx:ASPxLabel>
                            <dx:ASPxMemo ID="txtConidicionesPago" runat="server" Height="71px" 
                                HorizontalAlign="Justify" Theme="BlackGlass" Width="90%">
                                <ValidationSettings ErrorTextPosition="Bottom" SetFocusOnError="True" 
                                    ValidationGroup="OrdenCompra">
                                    <RequiredField IsRequired="True" />
                                </ValidationSettings>
                            </dx:ASPxMemo>
                        </td>
                        <td align="center" valign="top">
                            <dx:ASPxLabel ID="ASPxLabel5" runat="server" Text="CONDICIONES DE ENTREGA">
                            </dx:ASPxLabel>
                            <dx:ASPxMemo ID="txtConditionesEntrega" runat="server" Height="71px" 
                                Theme="BlackGlass" Width="90%">
                                <ValidationSettings ErrorTextPosition="Bottom" SetFocusOnError="True" 
                                    ValidationGroup="OrdenCompra">
                                    <RequiredField IsRequired="True" />
                                </ValidationSettings>
                            </dx:ASPxMemo>
                        </td>
                        <td align="center" valign="top">
                            <dx:ASPxLabel ID="ASPxLabel7" runat="server" Text="TIEMPO DE ENTREGA">
                            </dx:ASPxLabel>
                            <dx:ASPxMemo ID="txtTimeEntrega" runat="server" Height="71px" 
                                Theme="BlackGlass" Width="90%">
                                <ValidationSettings ErrorTextPosition="Bottom" SetFocusOnError="True" 
                                    ValidationGroup="OrdenCompra">
                                    <RequiredField IsRequired="True" />
                                </ValidationSettings>
                            </dx:ASPxMemo>
                        </td>
                        <td align="center" valign="top">
                            <dx:ASPxLabel ID="ASPxLabel9" runat="server" Text="NUMERO DE COTIZACIÓN">
                            </dx:ASPxLabel>
                            <dx:ASPxTextBox ID="txtCotizacion" runat="server" Width="170px">
                                <ValidationSettings ErrorTextPosition="Bottom" SetFocusOnError="True" 
                                    ValidationGroup="OrdenCompra">
                                    <RequiredField IsRequired="True" />
                                </ValidationSettings>
                            </dx:ASPxTextBox>
                            <dx:ASPxLabel ID="ASPxLabel10" runat="server" Text="APLICA IVA:">
                            </dx:ASPxLabel>
                            <dx:ASPxComboBox ID="cboAplicaIVA" runat="server" HorizontalAlign="Center" 
                                IncrementalFilteringMode="Contains" Theme="BlackGlass">
                                <Items>
                                    <dx:ListEditItem Text="SI" Value="0.16" />
                                    <dx:ListEditItem Text="NO" Value="0" />
                                </Items>
                                <ValidationSettings ErrorTextPosition="Bottom" SetFocusOnError="True" 
                                    ValidationGroup="OrdenCompra">
                                    <RequiredField IsRequired="True" />
                                </ValidationSettings>
                            </dx:ASPxComboBox>
                        </td>
                    </tr>
                </table>
                <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                    <ProgressTemplate>
                        <asp:Image ID="Image1" runat="server" ImageUrl="~/Logos/22.gif" />
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <dx:ASPxGridView ID="grdDetallesOrdenes" runat="server" AutoGenerateColumns="False"
                            ClientInstanceName="grdDetallesOrdenes" DataSourceID="DetallesOrdenesCompras"
                            EnableTheming="True" KeyFieldName="ID_DETALLE_REQUISICION" Theme="BlackGlass"
                            Width="100%">
                            <ClientSideEvents EndCallback="function(s, e) {
	grdProvedoresCotizaciones.Refresh();
}" />
                            <totalsummary>
                                <dx:ASPxSummaryItem FieldName="IMPORTE" ShowInColumn="IMPORTE" 
                                    ShowInGroupFooterColumn="IMPORTE" SummaryType="Sum" />
                            </totalsummary>
                            <Columns>
                                <dx:GridViewCommandColumn ShowClearFilterButton="True" ShowEditButton="True" VisibleIndex="0">
                                </dx:GridViewCommandColumn>
                                <dx:GridViewDataTextColumn Caption="PARTIDA" FieldName="PARTIDA" ReadOnly="True"
                                    VisibleIndex="1">
                                    <EditFormSettings Visible="False" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="ID_DETALLE_REQUISICION" ReadOnly="True" Visible="False"
                                    VisibleIndex="2">
                                    <EditFormSettings Visible="False" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="CANTIDAD" VisibleIndex="3">
                                    <EditFormSettings Visible="False" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="UNIDAD" VisibleIndex="4">
                                    <EditFormSettings Visible="False" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="HERRAMIENTA" VisibleIndex="5" 
                                    Caption="HERRAMIENTA">
                                    <EditFormSettings Visible="False" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="PRECIO UNITARIO" FieldName="PRECIO_UNITARIO"
                                    VisibleIndex="6">
                                    <propertiestextedit displayformatstring="c2">
                                        <validationsettings errortext="Ingrese el Precio Unitario" 
                                            errortextposition="Bottom" setfocusonerror="True">
                                            <requiredfield errortext="Ingrese el Precio Unitario" isrequired="True" />
                                        </validationsettings>
                                    </propertiestextedit>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="IMPORTE" ReadOnly="True" VisibleIndex="8">
                                    <propertiestextedit displayformatstring="c2">
                                    </propertiestextedit>
                                    <EditFormSettings Visible="False" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataComboBoxColumn Caption="PROVEEDOR" FieldName="ID_PROOVEDOR" 
                                    VisibleIndex="9">
                                    <PropertiesComboBox DataSourceID="Proveedores" DisplayFormatInEditMode="True" IncrementalFilteringMode="Contains"
                                        TextField="PROOVEDOR" ValueField="ID_PROOVEDOR">
                                        <validationsettings errortext="Seleccione el Proveedor" 
                                            errortextposition="Bottom" setfocusonerror="True">
                                            <requiredfield errortext="Seleccione el Proveedor" isrequired="True" />
                                        </validationsettings>
                                    </PropertiesComboBox>
                                </dx:GridViewDataComboBoxColumn>
                                <dx:GridViewDataTextColumn Caption="% DE DESCUENTO" FieldName="DESCUENTO" 
                                    VisibleIndex="7">
                                    <propertiestextedit>
                                        <masksettings mask="&lt;0..100&gt;" />
                                    </propertiestextedit>
                                </dx:GridViewDataTextColumn>
                            </Columns>
                            <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" />
                            <Settings ShowFilterRow="True" ShowFooter="True" />
                            <Styles>
                                <Cell HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
                                </Cell>
                                <Header HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
                                </Header>
                            </Styles>
                        </dx:ASPxGridView>
                        <asp:SqlDataSource ID="DetallesOrdenesCompras" runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>"
                            SelectCommand="ORDEN_DE_COMPRA_A_DETALLE_HERRAMIENTAS" SelectCommandType="StoredProcedure"
                            UpdateCommand="ORDEN_DE_COMPRA_HERRAMIENTAS_ACTUALIZAR_PRECIOS_UNITARIOS" 
                            UpdateCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:SessionParameter Name="ID_REQUISICION" SessionField="ID_REQUISICION" Type="Int32" />
                            </SelectParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="ID_DETALLE_REQUISICION" Type="Int32" />
                                <asp:Parameter Name="PRECIO_UNITARIO" Type="Decimal" />
                                <asp:Parameter Name="ID_PROOVEDOR" Type="Int32" />
                                <asp:Parameter Name="DESCUENTO" Type="Decimal" />
                            </UpdateParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="Proveedores" runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>"
                            SelectCommand="PROOVEDORES_MOSTRAR_TODOS" SelectCommandType="StoredProcedure">
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="OrigenDatos" runat="server"></asp:SqlDataSource>
                        <dx:ASPxGridView ID="grdProvedoresCotizaciones" runat="server" AutoGenerateColumns="False"
                            ClientInstanceName="grdProvedoresCotizaciones" DataSourceID="DocumentosCotizacionesProvedoresMateriales"
                            EnableTheming="True" KeyFieldName="ID_REQUISICION" Theme="BlackGlass" Width="100%">
                            <Columns>
                                <dx:GridViewCommandColumn
                                    VisibleIndex="0">
                                </dx:GridViewCommandColumn>
                                <dx:GridViewDataTextColumn FieldName="ID_REQUISICION" Visible="False" VisibleIndex="1">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn VisibleIndex="6">
                                    <DataItemTemplate>
                                        <dx:ASPxHyperLink ID="ASPxHyperLink1" runat="server" Text="Cargar Cotizacion">
                                            <ClientSideEvents Click="function(s, e) {
	popupCarga.Show();
}" />
                                        </dx:ASPxHyperLink>
                                    </DataItemTemplate>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataComboBoxColumn Caption="PROVEEDOR" FieldName="ID_PROOVEDOR" VisibleIndex="3">
                                    <PropertiesComboBox DataSourceID="Proveedores" IncrementalFilteringMode="Contains"
                                        TextField="PROOVEDOR" ValueField="ID_PROOVEDOR">
                                    </PropertiesComboBox>
                                    <Settings AutoFilterCondition="Contains" />
                                </dx:GridViewDataComboBoxColumn>
                                <dx:GridViewDataHyperLinkColumn Caption="DOCUMENTO" FieldName="DOCUMENTO" VisibleIndex="5">
                                </dx:GridViewDataHyperLinkColumn>
                            </Columns>
                            <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" />
                            <SettingsDataSecurity AllowDelete="False" AllowEdit="False" 
                                AllowInsert="False" />
                            <Styles>
                                <Cell HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
                                </Cell>
                                <Header HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
                                </Header>
                            </Styles>
                        </dx:ASPxGridView>
                        <asp:SqlDataSource ID="DocumentosCotizacionesProvedoresMateriales" runat="server"
                            ConnectionString="<%$ ConnectionStrings:SIFICA %>" SelectCommand="PROOVEDORES_MOSTRAR_ORDEN_COMPRA_HERRAMIENTAS"
                            SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:SessionParameter Name="ID_REQUISICION" SessionField="ID_REQUISICION" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <dx:ASPxPopupControl ID="popupCarga" runat="server" ClientInstanceName="popupCarga"
                            HeaderText="" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter"
                            Width="300px">
                            <ContentCollection>
                                <dx:PopupControlContentControl runat="server">
                                    <dx:ASPxUploadControl ID="Subir" runat="server" ClientInstanceName="Subir" FileUploadMode="OnPageLoad"
                                        OnFileUploadComplete="Subir_FileUploadComplete" ShowProgressPanel="True" ShowUploadButton="True"
                                        UploadMode="Auto" Width="280px">
                                        <clientsideevents fileuploadcomplete="function(s, e) {
	grdProvedoresCotizaciones.Refresh();
}" />
                                    </dx:ASPxUploadControl>
                                </dx:PopupControlContentControl>
                            </ContentCollection>
                        </dx:ASPxPopupControl>
                        <dx:ASPxPopupControl ID="popupEnvioAprobacion" runat="server" 
                            ClientInstanceName="popupEnvioAprobacion" HeaderText="Escriba un Comentario" 
                            Modal="True" PopupHorizontalAlign="WindowCenter" 
                            PopupVerticalAlign="WindowCenter" Width="300px">
                            <contentcollection>
                                <dx:PopupControlContentControl runat="server">
                                    <table style="width:100%;">
                                        <tr>
                                            <td colspan="3">
                                                <dx:ASPxMemo ID="txtComentario" runat="server" Height="71px" Theme="Metropolis" 
                                                    Width="100%">
                                                </dx:ASPxMemo>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                &nbsp;</td>
                                            <td>
                                                <dx:ASPxButton ID="btnEnviarAprobacion" runat="server" 
                                                    OnClick="ASPxButton2_Click1" Text="Enviar a Aprobación" Theme="BlackGlass">
                                                </dx:ASPxButton>
                                            </td>
                                            <td>
                                                &nbsp;</td>
                                        </tr>
                                    </table>
                                </dx:PopupControlContentControl>
                            </contentcollection>
                        </dx:ASPxPopupControl>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>
</asp:Content>
