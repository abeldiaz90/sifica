<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Upload.aspx.cs" Inherits="SISGRES.Upload" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <table style="width:100%;">
        <tr>
            <td align="center" valign="middle">
                <dx:ASPxLabel ID="ASPxLabel3" runat="server" Font-Bold="True" Text="CARGAR DATOS DE CLIENTES Y CONDUCTORES">
                </dx:ASPxLabel>
    <dx:ASPxUploadControl ID="SubirArchivos2" runat="server" FileUploadMode="OnPageLoad" OnFileUploadComplete="SubirArchivos2_FileUploadComplete" ShowProgressPanel="True" ShowUploadButton="True" Theme="Moderno" UploadMode="Auto" Width="280px">
        <ClientSideEvents FilesUploadComplete="function(s, e) {
	grdUpload.Refresh();
}" />
    </dx:ASPxUploadControl>
            </td>
            <td align="center" valign="middle">
                <dx:ASPxLabel ID="ASPxLabel4" runat="server" Font-Bold="True" Text="CARGAR DATOS DE VOLUMEN GENERADO">
                </dx:ASPxLabel>
    <dx:ASPxUploadControl ID="SubirArchivos" runat="server" FileUploadMode="OnPageLoad" OnFileUploadComplete="SubirArchivos_FileUploadComplete" ShowProgressPanel="True" ShowUploadButton="True" Theme="Moderno" UploadMode="Auto" Width="280px">
        <ClientSideEvents FilesUploadComplete="function(s, e) {
	grdUpload.Refresh();
}" />
    </dx:ASPxUploadControl>
            </td>
        </tr>
        <tr>
            <td align="center" colspan="2" valign="middle">
                <dx:ASPxButton ID="btnEnviarProduccion" runat="server" HorizontalAlign="Center" OnClick="btnEnviarProduccion_Click" Text="Enviar a Producción" Theme="Moderno">
                </dx:ASPxButton>
            </td>
        </tr>
    </table>
    <dx:ASPxGridView ID="grdUpload" runat="server" Theme="Moderno" AutoGenerateColumns="False" ClientInstanceName="grdUpload" DataSourceID="UploadFile" KeyFieldName="ID" Width="100%">
        <Columns>
            <dx:GridViewDataTextColumn FieldName="ID" VisibleIndex="0">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn Caption="FECHA DE PRODUCCIÓN" FieldName="FECHA" VisibleIndex="1">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn Caption="VOLUMEN GENERADO" FieldName="METROS" VisibleIndex="6">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="MATERIALES" FieldName="MATERIALES" VisibleIndex="11">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="UNIDAD DE MEDIDA" FieldName="UNIDADES" VisibleIndex="7">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="NOTA DE REMISIÓN" FieldName="NOTAREMISION" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="CANTIDAD" FieldName="CANTIDADMATERIAL" VisibleIndex="12">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="TIPO DE CONCRETO" FieldName="TIPOCONCRETO" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="UNIDAD DE MEDIDA" FieldName="UNIDADMEDIDA" VisibleIndex="10">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CAMION" VisibleIndex="8">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="ORDEN DE SERVICIO" FieldName="NUMEROORDEN" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="VALOR" Visible="False" VisibleIndex="13">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="CLIENTE" FieldName="CLIENTE" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="CONDUCTOR" FieldName="CONDUCTOR" VisibleIndex="9">
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" AllowSort="False" />
        <Styles>
            <Header HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </Header>
            <Cell HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </Cell>
        </Styles>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="UploadFile" runat="server" ConnectionString="<%$ ConnectionStrings:PARTIDAS %>" SelectCommand="SELECT * FROM [PRECARGA] ORDER BY [ID]"></asp:SqlDataSource>
    <br />
</asp:Content>
