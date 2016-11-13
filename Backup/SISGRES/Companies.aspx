<%@ Page Title="Compañias" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Companies.aspx.cs" Inherits="SISGRES.Companies" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>




<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <dx:ASPxPanel ID="ASPxPanel1" runat="server" Width="100%">
    <PanelCollection>
        <dx:PanelContent runat="server">
            <dx:ASPxGridView ID="grdCompañias" runat="server" AutoGenerateColumns="False" 
                DataSourceID="CompañiasDatos" EnableTheming="True" KeyFieldName="ID_COMPAÑIA" 
                Theme="Youthful" AccessibilityCompliant="True" 
                ClientInstanceName="grdCompañias" Width="100%" 
                EnableCallbackAnimation="True" EnablePagingCallbackAnimation="True">

<SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True"></SettingsBehavior>

<Settings ShowFilterRow="True" ShowGroupPanel="True"></Settings>

                <Columns>
                    <dx:GridViewCommandColumn ShowClearFilterButton="True" ShowDeleteButton="True" 
                        ShowEditButton="True" ShowInCustomizationForm="True" ShowNewButton="True" 
                        ShowNewButtonInHeader="True" VisibleIndex="0">
                    </dx:GridViewCommandColumn>
                    <dx:GridViewDataTextColumn FieldName="ID_COMPAÑIA" ReadOnly="True" 
                        ShowInCustomizationForm="True" Visible="False" VisibleIndex="1">
                        <EditFormSettings Visible="False" />
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn Caption="COMPAÑIA" FieldName="COMPAÑIA" 
                        ShowInCustomizationForm="True" VisibleIndex="2">
                        <Settings AutoFilterCondition="Contains" />
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn Caption="DIRECCIÓN" FieldName="DIRECCION" 
                        ShowInCustomizationForm="True" VisibleIndex="3">
                        <Settings AutoFilterCondition="Contains" />
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="RFC" ShowInCustomizationForm="True" 
                        VisibleIndex="4">
                        <Settings AutoFilterCondition="Contains" />
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="TELEFONO" ShowInCustomizationForm="True" 
                        VisibleIndex="5">
                        <Settings AutoFilterCondition="Contains" />
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="CODIGO_POSTAL" ShowInCustomizationForm="True" 
                        VisibleIndex="12" Caption="CODIGO POSTAL">
                        <Settings AutoFilterCondition="Contains" />
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn Caption="REPRESENTANTE LEGAL" FieldName="REPRESENTANTE_LEGAL" 
                        ShowInCustomizationForm="True" VisibleIndex="13">
                        <Settings AutoFilterCondition="Contains" />
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="CREO" ShowInCustomizationForm="True" 
                        VisibleIndex="14" Visible="False">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataDateColumn FieldName="FECHA_CREACION" 
                        ShowInCustomizationForm="True" Visible="False" VisibleIndex="15">
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataBinaryImageColumn FieldName="LOGO" 
                        ShowInCustomizationForm="True" VisibleIndex="16">
                        <PropertiesBinaryImage ImageAlign="Middle" ImageHeight="100px" 
                            ImageWidth="100px" ShowLoadingImage="True">
                        </PropertiesBinaryImage>
                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </dx:GridViewDataBinaryImageColumn>
                    <dx:GridViewDataTextColumn ShowInCustomizationForm="True" VisibleIndex="17">
                        <DataItemTemplate>
                            <dx:ASPxHyperLink ID="ASPxHyperLink1" runat="server" Text="Cambiar Imagen">
                                <ClientSideEvents Click="function(s, e) {
	popupLogos.Show();
}" />
                            </dx:ASPxHyperLink>
                        </DataItemTemplate>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataComboBoxColumn Caption="PAÍS" FieldName="PAIS" 
                        ShowInCustomizationForm="True" VisibleIndex="7">
                        <PropertiesComboBox DataSourceID="CIUDAD" IncrementalFilteringMode="Contains" 
                            TextField="PAIS" ValueField="ID_PAIS">
                        </PropertiesComboBox>
                        <Settings AutoFilterCondition="Contains" />
                        <EditFormSettings Visible="False" />
                    </dx:GridViewDataComboBoxColumn>
                    <dx:GridViewDataComboBoxColumn FieldName="ESTADO" 
                        ShowInCustomizationForm="True" VisibleIndex="9">
                        <PropertiesComboBox DataSourceID="CIUDAD" IncrementalFilteringMode="Contains" 
                            TextField="ESTADO" ValueField="ID_ESTADO">
                        </PropertiesComboBox>
                        <Settings AutoFilterCondition="Contains" />
                        <EditFormSettings Visible="False" />
                    </dx:GridViewDataComboBoxColumn>
                    <dx:GridViewDataComboBoxColumn FieldName="CIUDAD" 
                        ShowInCustomizationForm="True" VisibleIndex="11">
                        <PropertiesComboBox DataSourceID="CIUDAD" IncrementalFilteringMode="Contains" 
                            TextField="CIUDAD" TextFormatString="{2}" ValueField="ID_CIUDAD">
                            <Columns>
                                <dx:ListBoxColumn FieldName="PAIS" />
                                <dx:ListBoxColumn FieldName="ESTADO" />
                                <dx:ListBoxColumn FieldName="CIUDAD" />
                            </Columns>
                        </PropertiesComboBox>
                        <Settings AutoFilterCondition="Contains" />
                    </dx:GridViewDataComboBoxColumn>
                </Columns>

                <Styles>
                    <Header HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
                    </Header>
                    <Cell HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
                    </Cell>
                </Styles>
            </dx:ASPxGridView>
            <asp:SqlDataSource ID="CompañiasDatos" runat="server" 
                ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
                InsertCommand="COMPAÑIAS_INSERTAR" InsertCommandType="StoredProcedure" 
                SelectCommand="COMPAÑIAS_MOSTRAR_TODAS" SelectCommandType="StoredProcedure" 
                UpdateCommand="COMPAÑIAS_ACTUALIZAR" UpdateCommandType="StoredProcedure" 
                DeleteCommand="COMPAÑIAS_ELIMINAR" DeleteCommandType="StoredProcedure">
                <DeleteParameters>
                    <asp:Parameter Name="ID_COMPAÑIA" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="ID_COMPAÑIA" Type="Int32" />
                    <asp:Parameter Name="COMPAÑIA" Type="String" />
                    <asp:Parameter Name="DIRECCION" Type="String" />
                    <asp:Parameter Name="RFC" Type="String" />
                    <asp:Parameter Name="TELEFONO" Type="String" />
                    <asp:Parameter Name="PAIS" Type="Int32" />
                    <asp:Parameter Name="ESTADO" Type="Int32" />
                    <asp:Parameter Name="CIUDAD" Type="Int32" />
                    <asp:Parameter Name="CODIGO_POSTAL" Type="Int32" />
                    <asp:Parameter Name="REPRESENTANTE_LEGAL" Type="String" />
                    <asp:Parameter Name="CREO" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="ID_COMPAÑIA" Type="Int32" />
                    <asp:Parameter Name="COMPAÑIA" Type="String" />
                    <asp:Parameter Name="DIRECCION" Type="String" />
                    <asp:Parameter Name="RFC" Type="String" />
                    <asp:Parameter Name="TELEFONO" Type="String" />
                    <asp:Parameter Name="PAIS" Type="Int32" />
                    <asp:Parameter Name="ESTADO" Type="Int32" />
                    <asp:Parameter Name="CIUDAD" Type="Int32" />
                    <asp:Parameter Name="CODIGO_POSTAL" Type="Int32" />
                    <asp:Parameter Name="REPRESENTANTE_LEGAL" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="CIUDAD" runat="server" 
                ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
                SelectCommand="GEOGRAFIA_MOSTRAR_ESTRUCTURA" 
                SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            <dx:ASPxPopupControl ID="popupLogos" runat="server" 
                ClientInstanceName="popupLogos" HeaderText="Seleccione la Imagen" Modal="True" 
                PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" 
                Theme="Youthful" Width="300px">
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <dx:ASPxUploadControl ID="Subir" runat="server" FileUploadMode="OnPageLoad" 
                            OnFileUploadComplete="ASPxUploadControl1_FileUploadComplete" 
                            ShowProgressPanel="True" ShowUploadButton="True" UploadMode="Auto" 
                            Width="280px" Theme="Youthful">
                            <ClientSideEvents FileUploadComplete="function(s, e) {
	grdCompañias.Refresh();
}" />
                        </dx:ASPxUploadControl>
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>
        </dx:PanelContent>
    </PanelCollection>
</dx:ASPxPanel>
</asp:Content>
