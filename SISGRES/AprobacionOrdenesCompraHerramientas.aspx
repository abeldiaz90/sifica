<%@ Page Title="Aprobaciones de Ordenes de compra de Herramientas" Language="C#" MasterPageFile="~/Principal.Master"
    AutoEventWireup="true" CodeBehind="AprobacionOrdenesCompraHerramientas.aspx.cs" Inherits="SISGRES.AprobacionOrdenesCompraHerramientas" %>

<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <dx:ASPxGridView ID="grdAprobaciones" runat="server" AutoGenerateColumns="False"
        DataSourceID="AprobacionesRequisicionesHerramientasDatos" EnableTheming="True"
        KeyFieldName="ID_ORDEN_COMPRA" Theme="Youthful" Width="100%" Caption="ORDENES DE COMPRA DE HERRAMIENTAS"
        AccessibilityCompliant="True" ClientInstanceName="grdAprobaciones" 
        EnableCallbackAnimation="True" EnablePagingCallbackAnimation="True">
        <Columns>
            <dx:GridViewDataTextColumn Caption="ORDEN DE COMPRA" 
                FieldName="ID_ORDEN_COMPRA" ReadOnly="True"
                VisibleIndex="1">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="REQUISICIÓN" FieldName="ID_REQUISICION"
                VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="SOLICITANTE"
                VisibleIndex="5" ReadOnly="True">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="DEPARTAMENTO" 
                VisibleIndex="6">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn VisibleIndex="7" Caption="TOTAL" FieldName="TOTAL" 
                ReadOnly="True">
                <PropertiesTextEdit DisplayFormatString="c2">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="MONEDA" VisibleIndex="8">
                <PropertiesTextEdit DisplayFormatString="c2">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="PROYECTO" FieldName="JUSTIFICACION" 
                VisibleIndex="9">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn VisibleIndex="0">
                <DataItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" onclick="lnkDetalle_Click1">Detalle</asp:LinkButton>
                </DataItemTemplate>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataComboBoxColumn Caption="PROVEEDOR" FieldName="ID_PROOVEDOR" 
                VisibleIndex="4">
                <PropertiesComboBox DataSourceID="Proveedores" 
                    IncrementalFilteringMode="Contains" TextField="PROOVEDOR" 
                    ValueField="ID_PROOVEDOR">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataTextColumn Caption="FOLIO" FieldName="FOLIO" VisibleIndex="10">
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
        ConnectionString="<%$ ConnectionStrings:SIFICA %>" SelectCommand="ORDENES_COMPRA_HERRAMIENTAS_PARA_APROBACION"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="ID_COMPAÑIA" SessionField="Compañia" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
                        <asp:SqlDataSource ID="Proveedores" runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>"
                            SelectCommand="PROOVEDORES_MOSTRAR_TODOS" 
                            SelectCommandType="StoredProcedure">
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="Proyectos" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
        SelectCommand="SELECT [ID_PROYECTO], [PROYECTO] FROM [PROYECTOS] ORDER BY [PROYECTO]">
    </asp:SqlDataSource>
    <dx:ASPxPopupControl ID="popupDetalle" runat="server" ClientInstanceName="popupReporte"
        HeaderText="" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="TopSides"
        Theme="Youthful" Width="750px" AllowDragging="True" AllowResize="True" Modal="True"
        ShowPageScrollbarWhenModal="True" ShowPinButton="True" ShowRefreshButton="True"
        CloseAction="CloseButton">
        <ContentStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
        </ContentStyle>
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <table style="width: 100%;">
                    <tr>
                        <td>
                            <dx:ASPxButton ID="btnAprobar" runat="server" EnableTheming="True" OnClick="ASPxButton2_Click1"
                                Text="Aprobar" Theme="Youthful">
                                <ClientSideEvents Click="function(s, e) {
	grdAprobaciones.Refresh();
}" />
                            </dx:ASPxButton>
                        </td>
                        <td>
                            <dx:ASPxButton ID="btnRetornarCompras" runat="server" 
                                OnClick="ASPxButton5_Click" Text="Retornar a Compras" Theme="Youthful">
                            </dx:ASPxButton>
                        </td>
                        <td>
                            <dx:ASPxButton ID="btnRechazar" runat="server" EnableTheming="True" 
                                OnClick="btnRechazar_Click" Text="Rechazar" Theme="Youthful">
                                <ClientSideEvents Click="function(s, e) {
	grdAprobaciones.Refresh();
}" />
                            </dx:ASPxButton>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" 
                                Font-Size="8pt" InteractiveDeviceInfos="(Colección)" 
                                WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="100%">
                                <LocalReport ReportPath="OrdenCompraMateriales.rdlc">
                                    <DataSources>
                                        <rsweb:ReportDataSource DataSourceId="ObjectDataSource1" 
                                            Name="OrdenesComprasDetalladas" />
                                    </DataSources>
                                </LocalReport>
                            </rsweb:ReportViewer>
                            <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" 
                                SelectMethod="GetData" 
                                TypeName="SIFICA.DetallesOrdenesComprasTableAdapters.ORDENES_COMPRA_MATERIALES_VER_DETALLE_PROOVEDOR_REQUISICIONTableAdapter">
                            </asp:ObjectDataSource>
                        </td>
                    </tr>
                </table>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>
    <dx:ASPxPopupControl ID="popupComentarios" runat="server" 
        ClientInstanceName="popupComentarios" HeaderText="Comentarios" Modal="True" 
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" 
        Theme="Youthful" Width="700px">
        <ContentCollection>
<dx:PopupControlContentControl runat="server">
    <table style="width:100%;">
        <tr>
            <td>
                <dx:ASPxMemo ID="txtComentarios" runat="server" Height="71px" Width="100%">
                </dx:ASPxMemo>
            </td>
        </tr>
        <tr>
            <td align="center">
                <dx:ASPxButton ID="btnProcesar" runat="server" OnClick="btnProcesar_Click" 
                    Text="EJECUTAR" Theme="Youthful">
                </dx:ASPxButton>
                <asp:Label ID="Label1" runat="server" Visible="False"></asp:Label>
            </td>
        </tr>
    </table>
            </dx:PopupControlContentControl>
</ContentCollection>
    </dx:ASPxPopupControl>
    <br />
</asp:Content>
