<%@ Page Title="Bancos" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Bancos.aspx.cs" Inherits="SISGRES.Bancos" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <dx:ASPxGridView ID="grdBancos" runat="server" AutoGenerateColumns="False" 
    Caption="BANCOS" ClientInstanceName="grdBancos" DataSourceID="BancosDatos" 
    EnableTheming="True" KeyFieldName="ID_BANCO" Theme="Youthful" Width="100%">
    <Columns>
        <dx:GridViewCommandColumn ShowClearFilterButton="True" ShowEditButton="True" 
            ShowNewButton="True" ShowNewButtonInHeader="True" VisibleIndex="0" 
            ShowDeleteButton="True">
        </dx:GridViewCommandColumn>
        <dx:GridViewDataTextColumn Caption="CLAVE" FieldName="ID_BANCO" ReadOnly="True" 
            VisibleIndex="1">
            <EditFormSettings Visible="False" />
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn Caption="BANCO" FieldName="BANCO" VisibleIndex="2">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="URLLOGO" Visible="False" VisibleIndex="3">
            <EditFormSettings Visible="False" />
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataBinaryImageColumn Caption="LOGO" FieldName="LOGO" 
            VisibleIndex="4">
            <PropertiesBinaryImage ImageAlign="Middle" ImageHeight="30%" ImageWidth="30%">
            </PropertiesBinaryImage>
            <EditFormSettings Visible="False" />
        </dx:GridViewDataBinaryImageColumn>
        <dx:GridViewDataTextColumn VisibleIndex="5">
            <EditFormSettings Visible="False" />
            <DataItemTemplate>
                <dx:ASPxHyperLink ID="ASPxHyperLink1" runat="server" Text="Cambiar Logo">
                    <ClientSideEvents Click="function(s, e) {
	popupLogos.Show();
}" />
                </dx:ASPxHyperLink>
            </DataItemTemplate>
        </dx:GridViewDataTextColumn>
    </Columns>
    <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" 
        AllowSelectSingleRowOnly="True" ConfirmDelete="True" />
    <Settings ShowFilterRow="True" ShowGroupPanel="True" />
    <Styles>
        <Cell HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
        </Cell>
        <Header HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
        </Header>
    </Styles>
</dx:ASPxGridView>
<dx:ASPxPopupControl ID="popupLogos" runat="server" AllowDragging="True" 
    AllowResize="True" ClientInstanceName="popupLogos" 
    HeaderText="Seleccionar Logo" Modal="True" PopupHorizontalAlign="WindowCenter" 
    PopupVerticalAlign="WindowCenter" ShowPageScrollbarWhenModal="True" 
    Theme="Youthful" Width="400px">
    <ContentCollection>
<dx:PopupControlContentControl runat="server">
    <dx:ASPxUploadControl ID="Subir" runat="server" EnableTheming="True" 
        FileUploadMode="OnPageLoad" OnFileUploadComplete="Subir_FileUploadComplete" 
        ShowProgressPanel="True" ShowUploadButton="True" Theme="Youthful" 
        UploadMode="Auto" Width="100%">
        <ClientSideEvents FileUploadComplete="function(s, e) {
	grdBancos.Refresh();
}" />
    </dx:ASPxUploadControl>
        </dx:PopupControlContentControl>
</ContentCollection>
</dx:ASPxPopupControl>
<asp:SqlDataSource ID="BancosDatos" runat="server" 
    ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
    InsertCommand="BANCOS_INSERTAR" InsertCommandType="StoredProcedure" 
    SelectCommand="BANCOS_MOSTRAR_TODOS" SelectCommandType="StoredProcedure" 
    UpdateCommand="BANCOS_MODIFICAR" UpdateCommandType="StoredProcedure" 
        DeleteCommand="BANCOS_ELIMINAR" DeleteCommandType="StoredProcedure">
    <DeleteParameters>
        <asp:Parameter Name="ID_BANCO" Type="Int32" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="BANCO" Type="String" />
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name="ID_BANCO" Type="Int32" />
        <asp:Parameter Name="BANCO" Type="String" />
    </UpdateParameters>
</asp:SqlDataSource>
</asp:Content>
