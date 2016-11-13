<%@ Page Title="APROBACIÓN DE REQUISICIONES DE HERRAMIENTAS" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="AprobacionesRequisicionesHerramientas.aspx.cs" Inherits="SISGRES.AprobacionesRequisicionesHerramientas" EnableEventValidation="true" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <dx:ASPxGridView ID="grdAprobaciones" runat="server" 
        AutoGenerateColumns="False" 
        DataSourceID="AprobacionesRequisicionesHerramientasDatos" EnableTheming="True" 
        KeyFieldName="ID_REQUISICION" Theme="Youthful" Width="100%" 
    ClientInstanceName="grdAprobaciones" EnableCallbackAnimation="True" 
    EnablePagingCallbackAnimation="True">
        <Columns>
            <dx:GridViewCommandColumn SelectAllCheckboxMode="Page" 
                ShowSelectCheckbox="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn Caption="FOLIO" FieldName="ID_REQUISICION" 
                ReadOnly="True" VisibleIndex="1">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="NOMBRE DEL SOLICITANTE" FieldName="NOMBRE" 
                ReadOnly="True" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="CORREO ELECTRÓNICO" 
                FieldName="CORREO_ELECTRONICO" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn Caption="FECHA DE SOLICITUD" FieldName="FECHA" 
                VisibleIndex="4">
                <PropertiesDateEdit DisplayFormatString="" EditFormat="DateTime">
                </PropertiesDateEdit>
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn Caption="COMPAÑIA" FieldName="COMPAÑIA" 
                VisibleIndex="5">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="JUSTIFICACIÓN" FieldName="JUSTIFICACION" 
                VisibleIndex="6">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn VisibleIndex="7">
                <DataItemTemplate>
                    <asp:LinkButton ID="lnkDetalle" runat="server" onclick="lnkDetalle_Click">Visualizar Requisición</asp:LinkButton>
                </DataItemTemplate>
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" />
        <Settings ShowFilterRow="True" ShowGroupPanel="True" />
        <Styles>
            <Cell HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </Cell>
            <Header HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </Header>
        </Styles>
    </dx:ASPxGridView>
    <dx:ASPxButton ID="ASPxButton4" runat="server" AutoPostBack="False" 
        EnableTheming="True" Text="Procesar Requisiciones" Theme="BlackGlass" 
        UseSubmitBehavior="False">
        <ClientSideEvents Click="function(s, e) {
	popupComentarios.Show();
}" />
    </dx:ASPxButton>
    <asp:SqlDataSource ID="AprobacionesRequisicionesHerramientasDatos" 
        runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
        SelectCommand="REQUISICIONES_HERRAMIENTAS_MOSTRAR_TODAS" 
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="ID_COMPAÑIA" SessionField="Compañia" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <dx:ASPxPopupControl ID="popupComentarios" runat="server" 
        ClientInstanceName="popupComentarios" HeaderText="Escriba un Comentario" 
        Modal="True" PopupHorizontalAlign="WindowCenter" 
        PopupVerticalAlign="WindowCenter" Width="300px" Theme="Youthful">
        <ContentCollection>
<dx:PopupControlContentControl runat="server">
    <dx:ASPxMemo ID="txtComentarios" runat="server" Height="71px" Width="100%">
    </dx:ASPxMemo>
    <table align="center" style="width: 100%;">
        <tr>
            <td align="center">
                <dx:ASPxButton ID="ASPxButton2" runat="server" OnClick="ASPxButton2_Click" 
                    Text="Aprobar" Theme="Youthful">
                    <ClientSideEvents Click="function(s, e) {
	grdAprobaciones.Refresh();
}" />
                </dx:ASPxButton>
            </td>
            <td align="center">
                <dx:ASPxButton ID="ASPxButton3" runat="server" OnClick="ASPxButton3_Click" 
                    Text="Rechazar" Theme="Youthful">
                    <ClientSideEvents Click="function(s, e) {
	grdAprobaciones.Refresh();
}" />
                </dx:ASPxButton>
            </td>
        </tr>
    </table>
            </dx:PopupControlContentControl>
</ContentCollection>
    </dx:ASPxPopupControl>
    <dx:ASPxPopupControl ID="popupReporte" runat="server" 
        ClientInstanceName="popupReporte" HeaderText="" 
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="TopSides" 
        Theme="Youthful" Width="700px" Modal="True" 
    ShowPageScrollbarWhenModal="True" ShowPinButton="True" 
        ShowRefreshButton="True" Height="700px">
        <ContentCollection>
<dx:PopupControlContentControl runat="server">
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" 
        Font-Size="8pt" InteractiveDeviceInfos="(Collection)" 
        WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="100%" 
        Height="650px">
    </rsweb:ReportViewer>
            </dx:PopupControlContentControl>
</ContentCollection>
    </dx:ASPxPopupControl>
</asp:Content>
