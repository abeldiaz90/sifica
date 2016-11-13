<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true"
    CodeBehind="Documentos.aspx.cs" Inherits="SISGRES.Documentos" %>

<%@ Register Assembly="DevExpress.Web.v14.2, Version=14.2.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dx" %>





<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <table align="center" width="100%">
        <tr>
            <td align="center" valign="middle">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                
                    <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="Cliente">
                    </dx:ASPxLabel>
                    <dx:ASPxComboBox ID="cboCliente" runat="server" Style="text-align: center" AutoPostBack="True"
                        AutoResizeWithContainer="True" DataSourceID="Clientes" EnableTheming="True" TextField="CLIENTE"
                        Theme="Mulberry" ValueField="ID_CLIENTE" Width="700px">
                    </dx:ASPxComboBox>
                    <asp:SqlDataSource ID="Clientes" runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>"
                        SelectCommand="CLIENTES_CONSULTAR" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                    <dx:ASPxLabel ID="ASPxLabel6" runat="server" Text="Proyecto">
                    </dx:ASPxLabel>
                    <dx:ASPxComboBox ID="cboProyecto" runat="server" Style="text-align: center" AutoResizeWithContainer="True"
                        DataSourceID="Proyectos" TextField="PROYECTO" Theme="Mulberry" ValueField="ID_PROYECTO"
                        Width="700px">
                    </dx:ASPxComboBox>
                    <asp:SqlDataSource ID="Proyectos" runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>"
                        SelectCommand="PROYECTOS_POR_CLIENTE" SelectCommandType="StoredProcedure">
                        <selectparameters>
                        <asp:ControlParameter ControlID="cboCliente" Name="ID_CLIENTE" 
                            PropertyName="Value" Type="Int32" />
                    </selectparameters>
                    </asp:SqlDataSource>
                    <dx:ASPxLabel ID="ASPxLabel4" runat="server" Text="Descripción de la publicación">
                    </dx:ASPxLabel>
                    <dx:ASPxMemo ID="txtDescripcion" runat="server" Height="71px" HorizontalAlign="Center"
                        Theme="Mulberry" Width="700px">
                    </dx:ASPxMemo>
                    <dx:ASPxLabel ID="ASPxLabel5" runat="server" Text="Documentos:">
                    </dx:ASPxLabel>
                    <dx:ASPxUploadControl ID="Subir" runat="server" EnableTheming="True" FileUploadMode="OnPageLoad"
                        OnFileUploadComplete="Subir_FileUploadComplete" ShowProgressPanel="True" ShowUploadButton="True"
                        Theme="Mulberry" UploadMode="Auto" Width="280px">
                        <ClientSideEvents FilesUploadComplete="function(s, e) {
	grdDocumentos.Refresh();
}" />
                        <AdvancedModeSettings EnableMultiSelect="True" />
                    </dx:ASPxUploadControl>
            </td>
        </tr>
        <tr>
            <td align="center" valign="middle" colspan="3">
                <dx:ASPxGridView ID="grdDocumentos" runat="server" AutoGenerateColumns="False" ClientInstanceName="grdDocumentos"
                    DataSourceID="DocumentosCalidad" EnableTheming="True" KeyFieldName="ID_DOCUMENTO"
                    Theme="Mulberry" Width="100%">
                    <Columns>
                        <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" VisibleIndex="0">
                        </dx:GridViewCommandColumn>
                        <dx:GridViewDataTextColumn Caption="NUMERO DE PUBLICACION" FieldName="ID_DOCUMENTO"
                            ReadOnly="True" VisibleIndex="1">
                            <EditFormSettings Visible="False" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="DESCRIPCIÓN" FieldName="DESCRIPCION" VisibleIndex="2">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="PROYECTO" FieldName="ID_PROYECTO" VisibleIndex="3">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataDateColumn Caption="FECHA DE PUBLICACIÓN" FieldName="FECHA_PUBLICACION"
                            VisibleIndex="4">
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataTextColumn Caption="LINK" FieldName="URL" Visible="False" VisibleIndex="5">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="SUBIDO POR" FieldName="CREADO_POR" VisibleIndex="6">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="LINK" VisibleIndex="7">
                            <DataItemTemplate>
                                <dx:ASPxButton ID="btnAbrirDocumentos" runat="server" AutoPostBack="False" OnClick="btnAbrirDocumentos_Click"
                                    Text="Abrir Documentos" Theme="Mulberry" UseSubmitBehavior="False">
                                </dx:ASPxButton>
                            </DataItemTemplate>
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" />
                    <Settings ShowGroupPanel="True" />
                    <SettingsDataSecurity AllowInsert="False" />
                    <Styles>
                        <Header HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
                        </Header>
                        <Cell HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
                        </Cell>
                    </Styles>
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="DocumentosCalidad" runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>"
                    SelectCommand="SELECT * FROM [DOCUMENTOS_CALIDAD]"></asp:SqlDataSource>
                <dx:ASPxPopupControl ID="popupDocumentos" runat="server" ClientInstanceName="popupDocumentos"
                    HeaderText="" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter"
                    Theme="Mulberry" Width="100%">
                    <ContentCollection>
                        <dx:PopupControlContentControl runat="server">
                            <dx:ASPxGridView ID="grdDocumentosDetalles" runat="server" AutoGenerateColumns="False"
                                EnableTheming="True" KeyFieldName="ID_DOCUMENTO_CALIDAD_DETALLE" Theme="Metropolis"
                                Width="100%" OnAfterPerformCallback="grdDocumentosDetalles_AfterPerformCallback">
                                <Columns>
                                    <dx:GridViewCommandColumn ShowClearFilterButton="True" ShowInCustomizationForm="True"
                                        VisibleIndex="0">
                                    </dx:GridViewCommandColumn>
                                    <dx:GridViewDataTextColumn Caption="FOLIO" FieldName="ID_DOCUMENTO_CALIDAD_DETALLE"
                                        ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="1">
                                        <EditFormSettings Visible="False" />
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="ID_DOCUMENTO" ShowInCustomizationForm="True"
                                        Visible="False" VisibleIndex="2">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataHyperLinkColumn Caption="DOCUMENTO" FieldName="URL" ShowInCustomizationForm="True"
                                        VisibleIndex="3">
                                        <PropertiesHyperLinkEdit Target="_blank">
                                        </PropertiesHyperLinkEdit>
                                    </dx:GridViewDataHyperLinkColumn>
                                </Columns>
                                <Settings ShowGroupPanel="True" ShowFilterRow="True" />
                                <Styles>
                                    <Cell HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
                                    </Cell>
                                    <Header HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
                                    </Header>
                                </Styles>
                            </dx:ASPxGridView>
                        </dx:PopupControlContentControl>
                    </ContentCollection>
                </dx:ASPxPopupControl>
            </td>
        </tr>
        <tr>
            <td align="center" valign="middle">
                &nbsp;
            </td>
            <td align="center" valign="middle">
                &nbsp;
            </td>
            <td align="center" valign="middle">
                &nbsp;
            </td>
        </tr>
    </table>
    <br />
    <br />
    </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
