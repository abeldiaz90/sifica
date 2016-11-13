<%@ Page Title="Aprobación de Requisiciones" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="AprobacionRequest.aspx.cs" Inherits="SISGRES.AprobacionRequest" %>
<%@ Register Assembly="DevExpress.Web.v14.2, Version=14.2.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <dx:ASPxGridView ID="grdAprobaciones" runat="server" AutoGenerateColumns="False" DataSourceID="SolicitudesPendientes" EnableTheming="True" KeyFieldName="ID_REQUEST" Theme="Aqua" Width="100%">
                <Columns>
                    <dx:GridViewDataTextColumn FieldName="ID_REQUEST" ReadOnly="True" Visible="False" VisibleIndex="0">
                        <EditFormSettings Visible="False" />
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="SOLICITANTE" ReadOnly="True" VisibleIndex="1" Width="200px">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataDateColumn Caption="FECHA DE CREACIÓN" FieldName="FECHA_CREACION_REQUISICION" VisibleIndex="2" Width="100px">
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataTextColumn FieldName="ESTADO" ReadOnly="True" VisibleIndex="3" Width="100px">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn Caption="JUSTIFICACIÓN" FieldName="JUSTIFICACION_REQUISICION" ReadOnly="True" VisibleIndex="4">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn Caption="IMPORTE" FieldName="SUMA" ReadOnly="True" VisibleIndex="5" Width="100px">
                        <PropertiesTextEdit DisplayFormatString="C2">
                        </PropertiesTextEdit>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn VisibleIndex="6">
                        <DataItemTemplate>
                            <dx:ASPxButton ID="btnAprobar" runat="server" CssClass="btn btn-success" OnClick="btnAprobar_Click" Text="Aprobar">
                            </dx:ASPxButton>
                            <dx:ASPxButton ID="btnRechazar" runat="server" CssClass="btn btn-warning" OnClick="btnRechazar_Click" Text="Rechazar">
                            </dx:ASPxButton>
                            <dx:ASPxButton ID="btnAbrir" runat="server" CssClass="btn btn-primary" OnClick="btnAbrir_Click" Text="Abrir">
                            </dx:ASPxButton>
                        </DataItemTemplate>
                    </dx:GridViewDataTextColumn>
                </Columns>
                <SettingsBehavior AllowFixedGroups="True" AllowFocusedRow="True" AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" />
                <Settings ShowFilterRow="True" ShowGroupPanel="True" />
                <SettingsSearchPanel Visible="True" />
                <Styles>
                    <Cell HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
                    </Cell>
                </Styles>
            </dx:ASPxGridView>
            <asp:SqlDataSource ID="SolicitudesPendientes" runat="server" ConnectionString="<%$ ConnectionStrings:PARTIDAS %>" SelectCommand="REQUISICIONES_CONSULTAR_PENDIENTES" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
        </ContentTemplate>
        <triggers>
            <asp:PostBackTrigger ControlID="grdAprobaciones" />
        </triggers>
    </asp:UpdatePanel>
    <dx:ASPxPopupControl ID="popupRequisicion" runat="server" HeaderText="" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowPageScrollbarWhenModal="True" Maximized="True" Modal="True">
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <rsweb:reportviewer id="ReportViewer1" runat="server" font-names="Verdana" font-size="8pt" waitmessagefont-names="Verdana" waitmessagefont-size="14pt" Height="100%" Width="100%">
    </rsweb:reportviewer>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>
</asp:Content>
