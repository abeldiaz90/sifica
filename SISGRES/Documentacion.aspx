<%@ Page Title="Documentos" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Documentacion.aspx.cs" Inherits="SISGRES.Documentacion" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <dx:ASPxGridView ID="grdRequisiciones" runat="server" AutoGenerateColumns="False" DataSourceID="Datos" EnableTheming="True" KeyFieldName="ID_REQUEST" Theme="Glass">
    <Columns>
        <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
        </dx:GridViewCommandColumn>
        <dx:GridViewDataTextColumn FieldName="ID_REQUEST" ReadOnly="True" Visible="False" VisibleIndex="1">
            <EditFormSettings Visible="False" />
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataDateColumn Caption="FECHA DE CREACIÓN DE REQUISICIÓN" FieldName="FECHA_CREACION_REQUISICION" VisibleIndex="4">
            <CellStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </CellStyle>
            <ExportCellStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </ExportCellStyle>
        </dx:GridViewDataDateColumn>
        <dx:GridViewDataDateColumn Caption="FECHA DE APROBACIÓN O RECHAZO DE REQUISICIÓN" FieldName="FECHA_APROBACION_RECHAZO_REQUEST" VisibleIndex="7">
            <CellStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </CellStyle>
            <ExportCellStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </ExportCellStyle>
        </dx:GridViewDataDateColumn>
        <dx:GridViewDataTextColumn FieldName="ESTADO" Visible="False" VisibleIndex="12">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="COMPAÑIA" Visible="False" VisibleIndex="13">
            <CellStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </CellStyle>
            <ExportCellStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </ExportCellStyle>
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn Caption="REQUISITOR" FieldName="REQUISITOR" ReadOnly="True" VisibleIndex="3">
            <CellStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </CellStyle>
            <ExportCellStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </ExportCellStyle>
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn Caption="APROBADOR REQUISICIÓN" FieldName="APROBADOR_RECHAZADOR_REQUISICION" ReadOnly="True" VisibleIndex="6">
            <CellStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </CellStyle>
            <ExportCellStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </ExportCellStyle>
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn Caption="FOLIO REQUISICIÓN" FieldName="FOLIO" ReadOnly="True" VisibleIndex="2">
            <CellStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </CellStyle>
            <ExportCellStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </ExportCellStyle>
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn Caption="FOLIO ORDEN DE COMPRA" FieldName="FOLIO_OC" ReadOnly="True" VisibleIndex="8">
            <CellStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </CellStyle>
            <ExportCellStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </ExportCellStyle>
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn Caption="ESTADO DE LA REQUISICIÓN" FieldName="ESTADO_REQUISICION" ReadOnly="True" VisibleIndex="5">
            <CellStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </CellStyle>
            <ExportCellStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </ExportCellStyle>
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn Caption="ESTADO DE LA ORDEN DE COMPRA" FieldName="ESTADO_OC" ReadOnly="True" VisibleIndex="9">
            <CellStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </CellStyle>
            <ExportCellStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </ExportCellStyle>
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="CORREO_ELECTRONICO" Visible="False" VisibleIndex="14">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="CORREO_ELECTRONICO1" Visible="False" VisibleIndex="15">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataHyperLinkColumn Caption="COTIZACIÓN" FieldName="ARCHIVO" VisibleIndex="16">
            <PropertiesHyperLinkEdit NavigateUrlFormatString="http://sifica-001-site2.htempurl.com/Cotizaciones/{0}" Target="_blank">
            </PropertiesHyperLinkEdit>
            <CellStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </CellStyle>
            <ExportCellStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </ExportCellStyle>
        </dx:GridViewDataHyperLinkColumn>
        <dx:GridViewDataTextColumn Caption="IMPORTE" FieldName="IMPORTE" VisibleIndex="11">
            <PropertiesTextEdit DisplayFormatString="C2">
            </PropertiesTextEdit>
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn Caption="REQUISICIÓN" VisibleIndex="17">
            <DataItemTemplate>
                <asp:LinkButton ID="lnkRequisicion" runat="server" OnClick="lnkRequisicion_Click">Abrir Requisición</asp:LinkButton>
            </DataItemTemplate>
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn Caption="PROVEEDOR" FieldName="PROOVEDOR" VisibleIndex="10">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn Caption="ORDEN DE COMPRA" VisibleIndex="18">
            <DataItemTemplate>
                <asp:LinkButton ID="lnkOrdenCompra" runat="server" OnClick="lnkOrdenCompra_Click">Orden de Compra</asp:LinkButton>
            </DataItemTemplate>
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn VisibleIndex="19">
            <DataItemTemplate>
                <dx:ASPxButton ID="btnCancelar" runat="server" CssClass="btn btn-danger" OnClick="btnCancelar_Click" Text="Cancelar">
                </dx:ASPxButton>
            </DataItemTemplate>
        </dx:GridViewDataTextColumn>
    </Columns>
    <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" />
    <Settings ShowFilterRow="True" ShowGroupPanel="True" />
    <SettingsSearchPanel Visible="True" />
    <Styles>
        <Header HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
        </Header>
    </Styles>
</dx:ASPxGridView>
    <dx:ASPxPopupControl ID="popupCancelaciones" runat="server" HeaderText="Cancelaciones" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowPageScrollbarWhenModal="True">
        <ContentCollection>
<dx:PopupControlContentControl runat="server">
    <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="¿Desea Cancelar?">
    </dx:ASPxLabel>
    <br />
    <dx:ASPxButton ID="btnOk" runat="server" CssClass="btn btn-success" OnClick="btnOk_Click" Text="Ok">
    </dx:ASPxButton>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <dx:ASPxButton ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" Text="Cancel">
    </dx:ASPxButton>
            </dx:PopupControlContentControl>
</ContentCollection>
    </dx:ASPxPopupControl>
<asp:SqlDataSource ID="Datos" runat="server" ConnectionString="<%$ ConnectionStrings:PARTIDAS %>" SelectCommand="REQUICIONES_OR_TODOS_DATOS" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
<dx:ASPxPopupControl ID="popupRequisicion" runat="server" HeaderText="" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowPageScrollbarWhenModal="True" Maximized="True" Modal="True">
    <ContentCollection>
<dx:PopupControlContentControl runat="server">
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Height="100%" Width="100%">
    </rsweb:ReportViewer>
        </dx:PopupControlContentControl>
</ContentCollection>
</dx:ASPxPopupControl>
</asp:Content>
