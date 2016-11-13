<%@ Page Title="Cuadro Comparativo Materiales" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="CuadroComparativo.aspx.cs" Inherits="SISGRES.CuadroComparativo" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
.dxgvControl_BlackGlass,
.dxgvDisabled_BlackGlass
{
	border: 1px solid #4E4F51;
	font: 12px Tahoma, Geneva, sans-serif;
	background-color: #E8EDF1;
	color: Black;
	cursor: default;
}
.dxgvTable_BlackGlass
{
	-webkit-tap-highlight-color: rgba(0,0,0,0);
}

.dxgvTable_BlackGlass
{
	background-color: #E8EDF1;
	border-width: 0;
	border-collapse: separate!important;
	overflow: hidden;
	color: Black;
}
.dxgvFilterRow_BlackGlass
{
	background-color: #E8EDF1;
}
.dxgvCommandColumn_BlackGlass
{
	padding: 2px;
}

.dxgvFocusedRow_BlackGlass
{
	background-color: #BDCAD5;
}

.dxgvEditFormDisplayRow_BlackGlass,
.dxgvDataRow_BlackGlass,
.dxgvSelectedRow_BlackGlass,
.dxgvFocusedRow_BlackGlass
{
	background-color: #FFFFFF;
}
.dxgvFocusedRow_BlackGlass
{
	background-color: #8D8D8D;
}

.dxgvInlineEditRow_BlackGlass,
.dxgvDataRow_BlackGlass
{
	background-color: White;
}
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
                        <dx:ASPxButton ID="btnComparativo" runat="server" HorizontalAlign="Center" 
                            onclick="btnComparativo_Click" Text="Ver Comparativo">
                        </dx:ASPxButton>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table style="width:100%;">
                <tr>
                    <td align="center">
                        <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="SELECCIONE LA REQUISICIÓN">
                        </dx:ASPxLabel>
                        <dx:ASPxComboBox ID="cboRequisicion" runat="server" AutoPostBack="True" 
                            AutoResizeWithContainer="True" 
                            DataSourceID="AprobacionesRequisicionesHerramientasDatos" 
                            DisplayFormatString="{0}" EnableTheming="True" HorizontalAlign="Center" 
                            IncrementalFilteringMode="Contains" 
                            onselectedindexchanged="cboRequisicion_SelectedIndexChanged" 
                            TextField="ID_REQUISICION" Theme="BlackGlass" ValueField="ID_REQUISICION" 
                            Width="300px" LoadDropDownOnDemand="True">
                            <Columns>
                                <dx:ListBoxColumn Caption="NUMERO DE REQUISICIÓN" FieldName="ID_REQUISICION" />
                                <dx:ListBoxColumn Caption="SOLICITANTE" FieldName="NOMBRE" />
                                <dx:ListBoxColumn Caption="COMPAÑIA" FieldName="COMPAÑIA" />
                                <dx:ListBoxColumn Caption="PROYECTO" FieldName="JUSTIFICACION" />
                            </Columns>
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True" />
                            <listboxstyle horizontalalign="Center" verticalalign="Middle">
                            </listboxstyle>
                        </dx:ASPxComboBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <dx:ASPxGridView ID="grdRequisicionesPartidas" runat="server" 
                            AutoGenerateColumns="False" ClientInstanceName="grdRequisicionesPartidas" 
                            DataSourceID="PartidasRequisicionesMateriales" EnableTheming="True" 
                            KeyFieldName="ID_DETALLE_REQUISICION" Theme="BlackGlass" Width="100%" 
                            ondetailrowexpandedchanged="grdRequisicionesPartidas_DetailRowExpandedChanged1">
                            <Columns>
                                <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" 
                                    ShowNewButtonInHeader="True" VisibleIndex="0">
                                </dx:GridViewCommandColumn>
                                <dx:GridViewDataTextColumn FieldName="ID_DETALLE_REQUISICION" ReadOnly="True" 
                                    Visible="False" VisibleIndex="1">
                        <EditFormSettings Visible="False" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="PARTIDA" FieldName="PARTIDA" 
                                    ReadOnly="True" VisibleIndex="2">
                                    <EditFormSettings Visible="False" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="REQUISICION" FieldName="ID_REQUISICION" 
                                    VisibleIndex="3">
                                    <EditFormSettings Visible="False" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="CANTIDAD" FieldName="CANTIDAD" 
                                    VisibleIndex="5">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn VisibleIndex="6">
                                    <EditFormSettings Visible="False" />
                                    <dataitemtemplate>
                                        <dx:ASPxButton ID="btnCapturarCotizacion" runat="server" 
                                            onclick="btnCapturarCotizacion_Click" Text="Capturar Cotizacion" 
                                            Theme="BlackGlass">
                                        </dx:ASPxButton>
                                    </dataitemtemplate>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataComboBoxColumn Caption="MATERIAL" FieldName="ID_MATERIAL" 
                                    VisibleIndex="4">
                                    <propertiescombobox datasourceid="Materiales" 
                                        incrementalfilteringmode="Contains" textfield="MATERIAL" 
                                        valuefield="ID_MATERIAL">
                        </propertiescombobox>
                                </dx:GridViewDataComboBoxColumn>
                            </Columns>
                            <SettingsBehavior AllowSelectByRowClick="True" 
                    AllowSelectSingleRowOnly="True" AllowFocusedRow="True" ConfirmDelete="True" />
                            <SettingsDetail AllowOnlyOneMasterRowExpanded="True" ShowDetailRow="True" />
                            <styles>
                                <header horizontalalign="Center" verticalalign="Middle" wrap="True">
                                </header>
                                <cell horizontalalign="Center" verticalalign="Middle" wrap="True">
                                </cell>
                            </styles>
                            <templates>
                                <detailrow>
                                    <dx:ASPxGridView ID="grdCuadroComparativo" runat="server" 
                                        AutoGenerateColumns="False" Caption="COTIZACIONES" 
                                        ClientInstanceName="grdCuadroComparativo" DataSourceID="COTIZACION_PARTIDA" 
                                        EnableTheming="True" KeyFieldName="ID_COTIZACION" Theme="BlackGlass" 
                                        Width="100%" EnableCallbackAnimation="True" 
                                        EnablePagingCallbackAnimation="True">
                                        <Columns>
                                            <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" 
                                                ShowNewButtonInHeader="True" VisibleIndex="0">
                                            </dx:GridViewCommandColumn>
                                            <dx:GridViewDataTextColumn Caption="COTIZACION" FieldName="ID_COTIZACION" 
                                                ReadOnly="True" Visible="False" VisibleIndex="1">
                                                <EditFormSettings Visible="False" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="ID_DETALLE_REQUISICION" Visible="False" 
                                                VisibleIndex="2">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="PRECIO UNITARIO" 
                                                FieldName="PRECIO_UNITARIO" VisibleIndex="5">
                                                <propertiestextedit>
                                                    <masksettings includeliterals="DecimalSymbol" 
                                                    mask="$&lt;0..999999999g&gt;.&lt;00..99&gt;" />
                                                </propertiestextedit>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataDateColumn Caption="FECHA DE ENTREGA" FieldName="FECHA_ENTREGA" 
                                                VisibleIndex="7">
                                            </dx:GridViewDataDateColumn>
                                            <dx:GridViewDataTextColumn Caption="CONDICIONES CREDITICIAS" 
                                                FieldName="CONDICIONES_CREDITICIAS" 
                                                VisibleIndex="9">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataComboBoxColumn Caption="CALIDAD DEL PRODUCTO" FieldName="CALIDAD" 
                                                VisibleIndex="8">
                                                <propertiescombobox incrementalfilteringmode="Contains">
                                                    <Items>
                                                        <dx:ListEditItem Text="MALA" Value="1" />
                                                        <dx:ListEditItem Text="REGULAR" Value="2" />
                                                        <dx:ListEditItem Text="BUENA" Value="3" />
                                                        <dx:ListEditItem Text="EXCELENTE" Value="4" />
                                                    </Items>
                                                </propertiescombobox>
                                            </dx:GridViewDataComboBoxColumn>
                                            <dx:GridViewDataComboBoxColumn Caption="PROVEEDOR" FieldName="ID_PROOVEDOR" 
                                                VisibleIndex="4">
                                                <propertiescombobox datasourceid="PROOVEDORES" textfield="PROOVEDOR" 
                                                    valuefield="ID_PROOVEDOR">
                                                </propertiescombobox>
                                            </dx:GridViewDataComboBoxColumn>
                                            <dx:GridViewDataTextColumn Caption="DESCUENTO" FieldName="DESCUENTO" 
                                                VisibleIndex="6">
                                                <propertiestextedit>
                                                    <masksettings mask="&lt;0..100&gt;" />
                                                </propertiestextedit>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataCheckColumn FieldName="ELEGIDO" VisibleIndex="10" 
                                                Caption="PROVEEDOR SELECCIONADO">
                                            </dx:GridViewDataCheckColumn>
                                        </Columns>
                                        <SettingsBehavior AllowFocusedRow="True" 
                                            AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" ConfirmDelete="True" />
                                        <Settings ShowGroupPanel="True" />
                                        <styles>
                                            <header horizontalalign="Center" verticalalign="Middle" wrap="True">
                                            </header>
                                            <cell horizontalalign="Center" verticalalign="Middle" wrap="True">
                                            </cell>
                                        </styles>
                                    </dx:ASPxGridView>
                                    <asp:SqlDataSource ID="PROOVEDORES" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
                                        SelectCommand="PROOVEDORES_MOSTRAR_TODOS" SelectCommandType="StoredProcedure">
                                    </asp:SqlDataSource>
                                    <asp:SqlDataSource ID="COTIZACION_PARTIDA" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
                                        InsertCommand="COTIZACIONES_INSERTAR" InsertCommandType="StoredProcedure" 
                                        SelectCommand="COTIZACIONES_MATERIALES_MOSTRAR_TODAS" 
                                        SelectCommandType="StoredProcedure" UpdateCommand="COTIZACIONES_MODIFICAR" 
                                        UpdateCommandType="StoredProcedure" 
                                        DeleteCommand="COTIZACIONES_MATERIALES_ELIMINAR_ITEM" 
                                        DeleteCommandType="StoredProcedure">
                                        <DeleteParameters>
                                            <asp:Parameter Name="ID_COTIZACION" Type="Int32" />
                                        </DeleteParameters>
                                        <InsertParameters>
                                            <asp:SessionParameter Name="ID_DETALLE_REQUISICION" SessionField="ID_PARTIDA" 
                                                Type="Int32" />
                                            <asp:Parameter Name="ID_PROOVEDOR" Type="Int32" />
                                            <asp:Parameter Name="PRECIO_UNITARIO" Type="Decimal" />
                                            <asp:Parameter Name="FECHA_ENTREGA" Type="DateTime" />
                                            <asp:Parameter Name="CALIDAD" Type="Int32" />
                                            <asp:Parameter Name="CONDICIONES_CREDITICIAS" Type="String" />
                                            <asp:Parameter Name="DESCUENTO" Type="Single" />
                                            <asp:Parameter Name="ELEGIDO" Type="Boolean" />
                                        </InsertParameters>
                                        <SelectParameters>
                                            <asp:SessionParameter Name="ID_PARTIDA" SessionField="ID_PARTIDA" 
                                                Type="Int32" />
                                        </SelectParameters>
                                        <UpdateParameters>
                                            <asp:Parameter Name="ID_COTIZACION" Type="Int32" />
                                            <asp:Parameter Name="ID_PROOVEDOR" Type="Int32" />
                                            <asp:SessionParameter Name="ID_DETALLE_REQUISICION" SessionField="ID_PARTIDA" 
                                                Type="Int32" />
                                            <asp:Parameter Name="PRECIO_UNITARIO" Type="Decimal" />
                                            <asp:Parameter Name="FECHA_ENTREGA" Type="DateTime" />
                                            <asp:Parameter Name="CALIDAD" Type="Int32" />
                                            <asp:Parameter Name="CONDICIONES_CREDITICIAS" Type="String" />
                                            <asp:Parameter Name="DESCUENTO" Type="Single" />
                                            <asp:Parameter Name="ELEGIDO" Type="Boolean" />
                                        </UpdateParameters>
                                    </asp:SqlDataSource>
                                </detailrow>
                            </templates>
                        </dx:ASPxGridView>
                        <asp:SqlDataSource ID="Materiales" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
                            SelectCommand="MATERIALES_MOSTRAR_TODOS" SelectCommandType="StoredProcedure">
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="PartidasRequisicionesMateriales" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
                            InsertCommand="REQUISICIONES_MATERIALES_DETALLES_INSERTAR" InsertCommandType="StoredProcedure" 
                            SelectCommand="REQUISICIONES_MOSTRAR_DETALLE_PARTIDAS" 
                            SelectCommandType="StoredProcedure" UpdateCommand="REQUISICIONES_MATERIALES_MODIFICAR_PARTIDAS_COMPARATIVO" 
                            UpdateCommandType="StoredProcedure" 
                            DeleteCommand="REQUISICIONES_MATERIALES_ELIMINAR_PARTIDAS_COMPARATIVO" 
                            DeleteCommandType="StoredProcedure">
                            <DeleteParameters>
                                <asp:Parameter Name="ID_DETALLE_REQUISICION" Type="Int32" />
                            </DeleteParameters>
                            <InsertParameters>
                                <asp:ControlParameter ControlID="cboRequisicion" Name="ID_REQUISICION" PropertyName="Value" Type="Int32" />
                                <asp:Parameter Name="ID_MATERIAL" Type="Int32" />
                                <asp:Parameter Name="CANTIDAD" Type="Decimal" />
                            </InsertParameters>
                            <SelectParameters>
                                <asp:ControlParameter ControlID="cboRequisicion" Name="ID_DETALLE_REQUISICION" 
                                    PropertyName="Value" Type="Int32" />
                            </SelectParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="ID_DETALLE_REQUISICION" Type="Int32" />
                                <asp:Parameter Name="CANTIDAD" Type="Single" />
                                <asp:Parameter Name="ID_MATERIAL" Type="Int32" />
                            </UpdateParameters>
                        </asp:SqlDataSource>
                        <dx:ASPxPopupControl ID="popupCotizaciones" runat="server" 
                            ClientInstanceName="popupCotizaciones" HeaderText="" Modal="True" 
                            PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" 
                            Theme="BlackGlass" Width="900px" AllowDragging="True" AllowResize="True" 
                            ShowMaximizeButton="True" ShowPageScrollbarWhenModal="True" 
                            ShowRefreshButton="True">
                            <contentcollection>
                                <dx:PopupControlContentControl runat="server">
                                    <dx:ASPxGridView ID="grdCuadroComparativo" runat="server" 
                                        AutoGenerateColumns="False" Caption="COTIZACIONES" 
                                        ClientInstanceName="grdCuadroComparativo" DataSourceID="COTIZACION_PARTIDA" 
                                        EnableTheming="True" Theme="BlackGlass" Width="100%" 
                                        KeyFieldName="ID_COTIZACION" EnableCallbackAnimation="True" 
                                        EnablePagingCallbackAnimation="True">
                                        <Columns>
                                            <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" 
                                                ShowInCustomizationForm="True" ShowNewButtonInHeader="True" VisibleIndex="0">
                                            </dx:GridViewCommandColumn>
                                            <dx:GridViewDataTextColumn Caption="COTIZACION" FieldName="ID_COTIZACION" 
                                                ReadOnly="True" ShowInCustomizationForm="True" Visible="False" 
                                                VisibleIndex="2">
                                                <EditFormSettings Visible="False" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="ID_DETALLE_REQUISICION" 
                                                ShowInCustomizationForm="True" Visible="False" VisibleIndex="3">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="PRECIO UNITARIO" FieldName="PRECIO_UNITARIO" 
                                                ShowInCustomizationForm="True" VisibleIndex="6">
                                                <propertiestextedit>
                                                    <masksettings includeliterals="DecimalSymbol" 
                                                    mask="$&lt;0..999999999g&gt;.&lt;00..99&gt;" />
                                                </propertiestextedit>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataDateColumn Caption="FECHA DE ENTREGA" FieldName="FECHA_ENTREGA" 
                                                ShowInCustomizationForm="True" VisibleIndex="8">
                                            </dx:GridViewDataDateColumn>
                                            <dx:GridViewDataTextColumn Caption="CONDICIONES CREDITICIAS" FieldName="CONDICIONES_CREDITICIAS" 
                                                ShowInCustomizationForm="True" VisibleIndex="10">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataComboBoxColumn Caption="CALIDAD DEL PRODUCTO" FieldName="CALIDAD" 
                                                ShowInCustomizationForm="True" VisibleIndex="9">
                                                <propertiescombobox incrementalfilteringmode="Contains">
                                                    <Items>
                                                        <dx:ListEditItem Text="MALA" Value="1" />
                                                        <dx:ListEditItem Text="REGULAR" Value="2" />
                                                        <dx:ListEditItem Text="BUENA" Value="3" />
                                                        <dx:ListEditItem Text="EXCELENTE" Value="4" />
                                                    </Items>
                                                </propertiescombobox>
                                            </dx:GridViewDataComboBoxColumn>
                                            <dx:GridViewDataComboBoxColumn Caption="PROVEEDOR" FieldName="ID_PROOVEDOR" 
                                                ShowInCustomizationForm="True" VisibleIndex="5">
                                                <propertiescombobox incrementalfilteringmode="Contains" 
                                                    datasourceid="PROOVEDORES" textfield="PROOVEDOR" valuefield="ID_PROOVEDOR">
                    <Items>
                        <dx:ListEditItem Text="MALA" Value="1" />
                        <dx:ListEditItem Text="REGULAR" Value="2" />
                        <dx:ListEditItem Text="BUENA" Value="3" />
                        <dx:ListEditItem Text="EXCELENTE" Value="4" />
                    </Items>
                </propertiescombobox>
                                            </dx:GridViewDataComboBoxColumn>
                                            <dx:GridViewDataTextColumn Caption="DESCUENTO" FieldName="DESCUENTO" 
                                                ShowInCustomizationForm="True" VisibleIndex="7">
                                                <propertiestextedit>
                                                    <masksettings mask="&lt;0..100&gt;" />
                                                </propertiestextedit>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataCheckColumn FieldName="ELEGIDO" ShowInCustomizationForm="True" 
                                                VisibleIndex="11" Caption="PROVEEDOR SELECCIONADO">
                                                <propertiescheckedit displaytextchecked="ES EL PROVEEDOR ELEGIDO" 
                                                    displaytextunchecked="NO ES EL PROVEEDOR ELEGIDO">
                                                </propertiescheckedit>
                                            </dx:GridViewDataCheckColumn>
                                        </Columns>
                                        <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" ConfirmDelete="True" />
        <Settings ShowGroupPanel="True" />
                                        <styles>
                                            <header horizontalalign="Center" verticalalign="Middle" wrap="True">
                                            </header>
                                            <cell horizontalalign="Center" verticalalign="Middle" wrap="True">
                                            </cell>
                                        </styles>
                                    </dx:ASPxGridView>
                                    <asp:SqlDataSource ID="PROOVEDORES" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
                                        SelectCommand="PROOVEDORES_MOSTRAR_TODOS" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                    <asp:SqlDataSource ID="COTIZACION_PARTIDA" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
                                        InsertCommand="COTIZACIONES_INSERTAR" InsertCommandType="StoredProcedure" 
                                        SelectCommand="COTIZACIONES_MATERIALES_MOSTRAR_TODAS" 
                                        SelectCommandType="StoredProcedure" UpdateCommand="COTIZACIONES_MODIFICAR" 
                                        UpdateCommandType="StoredProcedure" 
                                        DeleteCommand="COTIZACIONES_MATERIALES_ELIMINAR_ITEM" 
                                        DeleteCommandType="StoredProcedure">
                                        <DeleteParameters>
                                            <asp:Parameter Name="ID_COTIZACION" Type="Int32" />
                                        </DeleteParameters>
                                        <InsertParameters>
                                            <asp:SessionParameter Name="ID_DETALLE_REQUISICION" SessionField="ID_PARTIDA"  Type="Int32" />
                                            <asp:Parameter Name="ID_PROOVEDOR" Type="Int32" />
                                            <asp:Parameter Name="PRECIO_UNITARIO" Type="Decimal" />
                                            <asp:Parameter Name="FECHA_ENTREGA" Type="DateTime" />
                                            <asp:Parameter Name="CALIDAD" Type="Int32" />
                                            <asp:Parameter Name="CONDICIONES_CREDITICIAS" Type="String" />
                                            <asp:Parameter Name="DESCUENTO" Type="Single" />
                                            <asp:Parameter Name="ELEGIDO" Type="Boolean" />
                                        </InsertParameters>
                                        <SelectParameters>
                                            <asp:SessionParameter Name="ID_PARTIDA" SessionField="ID_PARTIDA" 
                                                Type="Int32" />
                                        </SelectParameters>
                                        <UpdateParameters>
                                            <asp:Parameter Name="ID_COTIZACION" Type="Int32" />
                                            <asp:Parameter Name="ID_PROOVEDOR" Type="Int32" />
                                            <asp:SessionParameter Name="ID_DETALLE_REQUISICION" SessionField="ID_PARTIDA"  Type="Int32" />
                                            <asp:Parameter Name="PRECIO_UNITARIO" Type="Decimal" />
                                            <asp:Parameter Name="FECHA_ENTREGA" Type="DateTime" />
                                            <asp:Parameter Name="CALIDAD" Type="Int32" />
                                            <asp:Parameter Name="CONDICIONES_CREDITICIAS" Type="String" />
                                            <asp:Parameter Name="DESCUENTO" Type="Single" />
                                            <asp:Parameter Name="ELEGIDO" Type="Boolean" />
                                        </UpdateParameters>
                                    </asp:SqlDataSource>
                                </dx:PopupControlContentControl>
                            </contentcollection>
                        </dx:ASPxPopupControl>
            <br />
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
                        <dx:ASPxPopupControl ID="popupReporte" runat="server" AllowDragging="True" 
                            AllowResize="True" ClientInstanceName="popupReporte" Modal="True" 
                            PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" 
                            Theme="BlackGlass" Width="900px">
                            <contentcollection>
                                <dx:PopupControlContentControl runat="server">
                                    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" 
                                        Font-Size="8pt" InteractiveDeviceInfos="(Collection)" 
                                        WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="100%">
                                    </rsweb:ReportViewer>
                                </dx:PopupControlContentControl>
                            </contentcollection>
                        </dx:ASPxPopupControl>
    <br />
    <asp:SqlDataSource ID="AprobacionesRequisicionesHerramientasDatos" 
        runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
        SelectCommand="ORDENES_COMPRAS_MATERIALES" 
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="ID_COMPAÑIA" SessionField="Compañia" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
