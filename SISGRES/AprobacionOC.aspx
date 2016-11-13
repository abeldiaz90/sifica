<%@ Page Title="Aprobación de Ordenes de Compra" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="AprobacionOC.aspx.cs" Inherits="SISGRES.AprobacionOC" %>

<%@ Register Assembly="DevExpress.Web.v14.2, Version=14.2.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <script type="text/javascript">
        function showalert(message, alerttype) {

            $('#alert_placeholder').append('<div id="alertdiv" class="alert ' + alerttype + '"><a class="close" data-dismiss="alert">×</a><span>' + message + '</span></div>')

            setTimeout(function () { // this will automatically close the alert and remove this if the users doesnt close it in 5 secs


                $("#alertdiv").remove();

            }, 5000);
        }

        function Alerta() {
            $('#Alerta').modal({
                show: true

            });
        }
    </script>

    <div class="page-header">
        <h1>Aprobación de Ordenes de Compra</h1>
    </div>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <dx:ASPxGridView ID="grdAprobaciones" runat="server" AutoGenerateColumns="False" DataSourceID="SolicitudesPendientes" EnableTheming="True" Theme="Aqua" Width="100%" KeyFieldName="ID_REQUEST">
                <Columns>
                    <dx:GridViewDataTextColumn FieldName="ID_REQUEST" ReadOnly="True" VisibleIndex="0" Visible="False">
                        <EditFormSettings Visible="False" />
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="SOLICITANTE" ReadOnly="True" VisibleIndex="2" Width="200px">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataDateColumn FieldName="FECHA_CREACION_REQUISICION" VisibleIndex="6" Caption="FECHA DE REQUISICIÓN" Width="100px">
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataDateColumn FieldName="PROOVEDOR" VisibleIndex="4" Caption="PROVEEDOR" Width="100px">
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataTextColumn FieldName="ESTADO" ReadOnly="True" VisibleIndex="7" Width="100px" Visible="False">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="JUSTIFICACION_REQUISICION" ReadOnly="True" VisibleIndex="5" Caption="JUSTIFICACIÓN" Width="150px">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="SUMA" ReadOnly="True" VisibleIndex="8" Caption="IMPORTE" Width="100px">
                        <PropertiesTextEdit DisplayFormatString="C2">
                        </PropertiesTextEdit>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn VisibleIndex="9">
                        <propertiestextedit width="200px">
                        </propertiestextedit>
                        <DataItemTemplate>
                            <dx:ASPxButton ID="btnAprobar" runat="server" CssClass="btn btn-success" OnClick="btnAprobar_Click" Text="Aprobar">
                            </dx:ASPxButton>
                            <dx:ASPxButton ID="btnRechazar" runat="server" CssClass="btn btn-warning" OnClick="btnRechazar_Click" Text="Rechazar">
                            </dx:ASPxButton>
                            <dx:ASPxButton ID="btnAbrir" runat="server" CssClass="btn btn-primary" OnClick="btnAbrir_Click" Text="Abrir">
                            </dx:ASPxButton>
                        </DataItemTemplate>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn Caption="FOLIO" FieldName="FOLIO_OC" VisibleIndex="1" Width="100px">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn Caption="APROBADOR REQUISICIÓN" FieldName="APROBADOR_REQUISICION" VisibleIndex="3">
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
            <asp:SqlDataSource ID="SolicitudesPendientes" runat="server" ConnectionString="<%$ ConnectionStrings:PARTIDAS %>" SelectCommand="OC_CONSULTAR_PENDIENTES" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            <div class="modal fade bs-example-modal-lg" id="Alerta" tabindex="-1" role="dialog" aria-labelledby="AlertaLabel">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h4 class="modal-title" id="AlertaLabel">Falta de Permisos</h4>

                        </div>
                        <div class="modal-body">
                            <div class="alert alert-danger" role="alert">No cuenta con permisos para realizar esta operación</div>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">
                            Cerrar
                        </button>

                    </div>
                </div>
            </div>
        </ContentTemplate>
        <triggers>
            <asp:PostBackTrigger ControlID="grdAprobaciones" />
        </triggers>
    </asp:UpdatePanel>
    <dx:ASPxPopupControl ID="popupOrdenCompra" runat="server" HeaderText="Orden de Compra" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowPageScrollbarWhenModal="True" Maximized="True" Modal="True">
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Height="100%" Width="100%">
                </rsweb:ReportViewer>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>
</asp:Content>
