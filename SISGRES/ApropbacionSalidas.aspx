<%@ Page Title="Aprobación de Salidas de Materiales" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="ApropbacionSalidas.aspx.cs" Inherits="SISGRES.ApropbacionSalidas" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <dx:ASPxGridView ID="grdSolicitudes" runat="server" AutoGenerateColumns="False" DataSourceID="DatosSolicitudes" EnableTheming="True" KeyFieldName="ID_SALIDA" Theme="Glass" Width="100%">
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="ID_SALIDA" ReadOnly="True" Visible="False" VisibleIndex="1">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="CENTRO DE COSTOS" FieldName="DESCRIPCION" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn Caption="FECHA DE SOLICITUD" FieldName="FECHA_SALIDA" VisibleIndex="3">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn Caption="SOLICITANTE" FieldName="NOMBRE" ReadOnly="True" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn VisibleIndex="5">
                <DataItemTemplate>
                    <asp:Button ID="btnAprobar" runat="server" CssClass="btn btn-primary" OnClick="btnAprobar_Click" Text="Aprobar" />
                </DataItemTemplate>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn VisibleIndex="6">
                <DataItemTemplate>
                    <asp:Button ID="btnDetalle" runat="server" CssClass="btn btn-success" OnClick="btnDetalle_Click" Text="Ver Detalle" />
                </DataItemTemplate>
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" />
        <Settings ShowFilterRow="True" ShowGroupPanel="True" />
        <SettingsSearchPanel Visible="True" />
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="DatosSolicitudes" runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>" SelectCommand="APROBACION_SOLICITUDES" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <dx:ASPxPopupControl ID="ASPxPopupControl1" runat="server" Maximized="True" Modal="True" PopupHorizontalAlign="WindowCenter" Width="600px">
        <ContentCollection>
<dx:PopupControlContentControl runat="server">
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt">
    </rsweb:ReportViewer>
            </dx:PopupControlContentControl>
</ContentCollection>
    </dx:ASPxPopupControl>
</asp:Content>
