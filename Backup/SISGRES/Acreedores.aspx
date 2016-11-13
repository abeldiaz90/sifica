<%@ Page Title="Acreedores" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Acreedores.aspx.cs" Inherits="SISGRES.Acreedores" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <dx:ASPxGridView ID="grdClientes" runat="server" AutoGenerateColumns="False" 
        DataSourceID="DatosClientes" EnableTheming="True" KeyFieldName="ID_ACREEDOR" 
        Theme="Youthful" Width="100%" EnableCallbackAnimation="True" 
        EnablePagingCallbackAnimation="True">
        <Columns>
            <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" 
                ShowNewButtonInHeader="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
<dx:GridViewDataTextColumn FieldName="ID_ACREEDOR" ReadOnly="True" 
                Caption="NUMERO DE ACREEDOR" VisibleIndex="1">
<EditFormSettings Visible="False"></EditFormSettings>
</dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ACREEDOR" 
                VisibleIndex="2" Caption="ACREEDOR">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="DIRECCION" VisibleIndex="3" 
                Caption="DIRECCIÓN">
            </dx:GridViewDataTextColumn>
<dx:GridViewDataTextColumn FieldName="CODIGO_POSTAL" Caption="CODIGO POSTAL" 
                VisibleIndex="9"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="TELEFONO" 
                VisibleIndex="10">
            </dx:GridViewDataTextColumn>
<dx:GridViewDataTextColumn FieldName="CORREO" Caption="CORREO ELECTRÓNICO" 
                VisibleIndex="11"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="RFC" FieldName="RFC" 
                VisibleIndex="12">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="TIPO" FieldName="TIPO" 
                VisibleIndex="13" Visible="False">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="NOMBRE DEL CONTACTO" FieldName="NOMBRECONTACTO" 
                VisibleIndex="14">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="DIAS DE CREDITO" FieldName="DIASCREDITO" 
                VisibleIndex="15">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="MONTO DEL CREDITO" FieldName="MONTOCREDITO" 
                VisibleIndex="16">
                <PropertiesTextEdit DisplayFormatString="C2">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="CLAVE INTERBANCARIA" 
                FieldName="CLAVE" VisibleIndex="24">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn Caption="CREADO EL" FieldName="FECHA_CREACION" 
                Visible="False" VisibleIndex="25">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn Caption="CREO" FieldName="CREO" 
                VisibleIndex="26" Visible="False">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataComboBoxColumn Caption="PAIS" FieldName="PAIS" VisibleIndex="4">
                <PropertiesComboBox IncrementalFilteringMode="Contains">
                    <Items>
                        <dx:ListEditItem Text="CONTADO" Value="1" />
                        <dx:ListEditItem Text="CREDITO" Value="2" />
                    </Items>
                </PropertiesComboBox>
                <PropertiesComboBox DataSourceID="CIUDAD" IncrementalFilteringMode="Contains" 
                    TextField="PAIS" ValueField="ID_PAIS">
                </PropertiesComboBox>
                <EditFormSettings Visible="False" />
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn Caption="ESTADO" FieldName="ESTADO" 
                VisibleIndex="6">
                <PropertiesComboBox DataSourceID="CIUDAD" IncrementalFilteringMode="Contains" 
                    TextField="ESTADO" ValueField="ID_ESTADO">
                </PropertiesComboBox>
                <EditFormSettings Visible="False" />
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn Caption="CIUDAD" FieldName="CIUDAD" 
                VisibleIndex="8">
                <PropertiesComboBox DataSourceID="CIUDAD" IncrementalFilteringMode="Contains" 
                    TextField="CIUDAD" ValueField="ID_CIUDAD" TextFormatString="{2}">
                    <Columns>
                        <dx:ListBoxColumn Caption="PAIS" FieldName="PAIS" />
                        <dx:ListBoxColumn Caption="ESTADO" FieldName="ESTADO" />
                        <dx:ListBoxColumn Caption="CIUDAD" FieldName="CIUDAD" />
                    </Columns>
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn Caption="BANCO" FieldName="BANCO" 
                VisibleIndex="20">
                <PropertiesComboBox DataSourceID="BANCOS" IncrementalFilteringMode="Contains" 
                    TextField="BANCO" ValueField="ID_BANCO">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataTextColumn Caption="CUENTA BANCARIA" FieldName="CUENTA" 
                VisibleIndex="23">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataComboBoxColumn Caption="FORMA DE PAGO" FieldName="FORMAPAGO" 
                VisibleIndex="19">
                
                <PropertiesComboBox IncrementalFilteringMode="Contains">
                    <Items>
                        <dx:ListEditItem Text="CONTADO" Value="1" />
                        <dx:ListEditItem Text="CREDITO" Value="2" />
                    </Items>
                </PropertiesComboBox>
                
            </dx:GridViewDataComboBoxColumn>
        </Columns>
        <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" 
            AllowSelectSingleRowOnly="True" ConfirmDelete="True" />
        <SettingsPager Position="TopAndBottom">
        </SettingsPager>
        <Settings ShowFilterRow="True" ShowTitlePanel="True" />
        <Styles>
            <Header HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </Header>
            <Cell HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </Cell>
        </Styles>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="DatosClientes" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
        InsertCommand="ACREEDORES_INSERTAR" InsertCommandType="StoredProcedure" 
        SelectCommand="ACREEDORES_CONSULTAR" SelectCommandType="StoredProcedure" 
        UpdateCommand="ACREEDORES_MODIFICAR" UpdateCommandType="StoredProcedure">
        <InsertParameters>
            <asp:Parameter Name="ACREEDOR" Type="String" />
            <asp:Parameter Name="DIRECCION" Type="String" />
            <asp:Parameter Name="PAIS" Type="String" />
            <asp:Parameter Name="ESTADO" Type="Int32" />
            <asp:Parameter Name="CIUDAD" Type="Int32" />
            <asp:Parameter Name="CODIGO_POSTAL" Type="Int32" />
            <asp:Parameter Name="TELEFONO" Type="String" />
            <asp:Parameter Name="CORREO" Type="String" />
            <asp:Parameter Name="RFC" Type="String" />
            <asp:Parameter Name="TIPO" Type="Int32" />
            <asp:Parameter Name="NOMBRECONTACTO" Type="String" />
            <asp:Parameter Name="DIASCREDITO" Type="Int32" />
            <asp:Parameter Name="MONTOCREDITO" Type="Decimal" />
            <asp:Parameter Name="FORMAPAGO" Type="Int32" />
            <asp:Parameter Name="BANCO" Type="Int32" />
            <asp:Parameter Name="CUENTA" Type="Int64" />
            <asp:Parameter Name="CLAVE" Type="Int64" />
            <asp:Parameter Name="FECHA_CREACION" Type="DateTime" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="ID_ACREEDOR" Type="Int32" />
            <asp:Parameter Name="ACREEDOR" Type="String" />
            <asp:Parameter Name="DIRECCION" Type="String" />
            <asp:Parameter Name="CIUDAD" Type="Int32" />
            <asp:Parameter Name="CODIGO_POSTAL" Type="Int32" />
            <asp:Parameter Name="TELEFONO" Type="String" />
            <asp:Parameter Name="CORREO" Type="String" />
            <asp:Parameter Name="RFC" Type="String" />
            <asp:Parameter Name="TIPO" Type="Int32" />
            <asp:Parameter Name="NOMBRECONTACTO" Type="String" />
            <asp:Parameter Name="DIASCREDITO" Type="Int32" />
            <asp:Parameter Name="MONTOCREDITO" Type="Decimal" />
            <asp:Parameter Name="FORMAPAGO" Type="Int32" />
            <asp:Parameter Name="BANCO" Type="Int32" />
            <asp:Parameter Name="CUENTA" Type="Int64" />
            <asp:Parameter Name="CLAVE" Type="Int64" />
        </UpdateParameters>
    </asp:SqlDataSource>
<asp:SqlDataSource ID="CIUDAD" runat="server" 
    ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
    SelectCommand="GEOGRAFIA_MOSTRAR_ESTRUCTURA" 
    SelectCommandType="StoredProcedure"></asp:SqlDataSource>
<asp:SqlDataSource ID="BANCOS" runat="server" 
    ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
    SelectCommand="BANCOS_MOSTRAR_TODOS" SelectCommandType="StoredProcedure">
</asp:SqlDataSource>
<asp:SqlDataSource ID="GIROS" runat="server" 
    ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
    SelectCommand="GIROS_MOSTRAR_TODOS" SelectCommandType="StoredProcedure">
</asp:SqlDataSource>
    </asp:Content>
