<%@ Page Title="VENDEDORES" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Vendedores.aspx.cs" Inherits="SISGRES.Vendedores" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <dx:ASPxGridView ID="grdVendedores" runat="server" AutoGenerateColumns="False" 
        DataSourceID="VENDEDORESDATOS" EnableTheming="True" KeyFieldName="ID_VENDEDOR" 
        Theme="Youthful">
        <Columns>
            <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" 
                ShowNewButtonInHeader="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn Caption="CLAVE" FieldName="ID_VENDEDOR" 
                ReadOnly="True" VisibleIndex="1">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="VENDEDOR" FieldName="VENDEDOR" 
                VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="DOMICILIO" FieldName="DIRECCION" 
                VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="CODIGO POSTAL" FieldName="CODIGO_POSTAL" 
                VisibleIndex="10">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="TELEFONO" FieldName="TELEFONO" 
                VisibleIndex="11">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="CORREO" FieldName="CORREO" 
                VisibleIndex="12">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="RFC" FieldName="RFC" VisibleIndex="13">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="CUENTA" FieldName="CUENTA" 
                VisibleIndex="16">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="CLAVE INTERBANCARIA" FieldName="CLAVE" 
                VisibleIndex="17">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn Caption="CREADO EL:" FieldName="FECHA_CREACION" 
                Visible="False" VisibleIndex="18">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn Caption="CREO:" FieldName="CREO" Visible="False" 
                VisibleIndex="19">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataComboBoxColumn Caption="PAIS" FieldName="PAIS" VisibleIndex="5">
                <PropertiesComboBox DataSourceID="DatosClientes" 
                    IncrementalFilteringMode="Contains" TextField="PAIS" ValueField="ID_PAIS">
                </PropertiesComboBox>
                <EditFormSettings Visible="False" />
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn Caption="ESTADO" FieldName="ESTADO" 
                VisibleIndex="7">
                <PropertiesComboBox DataSourceID="DatosClientes" 
                    IncrementalFilteringMode="Contains" TextField="ESTADO" ValueField="ID_ESTADO">
                </PropertiesComboBox>
                <EditFormSettings Visible="False" />
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn Caption="CIUDAD" FieldName="CIUDAD" 
                VisibleIndex="9">
                <PropertiesComboBox DataSourceID="DatosClientes" 
                    IncrementalFilteringMode="Contains" TextField="CIUDAD" ValueField="ID_CIUDAD">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn Caption="BANCO" FieldName="BANCO" 
                VisibleIndex="15">
                <PropertiesComboBox DataSourceID="Bancos" IncrementalFilteringMode="Contains" 
                    TextField="BANCO" ValueField="ID_BANCO">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
        </Columns>
        <SettingsPager Position="TopAndBottom">
        </SettingsPager>
        <Settings ShowFilterRow="True" />
        <Styles>
            <Cell HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </Cell>
            <Header HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </Header>
            <Row HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </Row>
        </Styles>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="VENDEDORESDATOS" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
        InsertCommand="VENDEDORES_INSERTAR" InsertCommandType="StoredProcedure" 
        SelectCommand="VENDEDORES_CONSULTAR" SelectCommandType="StoredProcedure" 
        UpdateCommand="VENDEDORES_MODIFICAR" UpdateCommandType="StoredProcedure">
        <InsertParameters>
            <asp:Parameter Name="VENDEDOR" Type="String" />
            <asp:Parameter Name="DIRECCION" Type="String" />
            <asp:Parameter Name="PAIS" Type="String" />
            <asp:Parameter Name="ESTADO" Type="Int32" />
            <asp:Parameter Name="CIUDAD" Type="Int32" />
            <asp:Parameter Name="CODIGO_POSTAL" Type="Int32" />
            <asp:Parameter Name="TELEFONO" Type="String" />
            <asp:Parameter Name="CORREO" Type="String" />
            <asp:Parameter Name="RFC" Type="String" />
            <asp:Parameter Name="BANCO" Type="Int32" />
            <asp:Parameter Name="CUENTA" Type="Int64" />
            <asp:Parameter Name="CLAVE" Type="Int64" />
            <asp:Parameter Name="FECHA_CREACION" Type="DateTime" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="ID_VENDEDOR" Type="Int32" />
            <asp:Parameter Name="VENDEDOR" Type="String" />
            <asp:Parameter Name="DIRECCION" Type="String" />
            <asp:Parameter Name="CIUDAD" Type="Int32" />
            <asp:Parameter Name="CODIGO_POSTAL" Type="Int32" />
            <asp:Parameter Name="TELEFONO" Type="String" />
            <asp:Parameter Name="CORREO" Type="String" />
            <asp:Parameter Name="RFC" Type="String" />
            <asp:Parameter Name="BANCO" Type="Int32" />
            <asp:Parameter Name="CUENTA" Type="Int64" />
            <asp:Parameter Name="CLAVE" Type="Int64" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DatosClientes" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
        SelectCommand="GEOGRAFIA_MOSTRAR_ESTRUCTURA" 
        SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <asp:SqlDataSource ID="Bancos" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
        SelectCommand="BANCOS_MOSTRAR_TODOS" SelectCommandType="StoredProcedure">
    </asp:SqlDataSource>
</asp:Content>
