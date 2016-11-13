<%@ Page Title="Clientes" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Clientes.aspx.cs" Inherits="SISGRES.Clientes" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <dx:ASPxGridView ID="grdClientes" runat="server" AutoGenerateColumns="False" 
        DataSourceID="DatosClientes" EnableTheming="True" KeyFieldName="ID_CLIENTE" 
        Theme="Youthful" Width="100%" EnableCallbackAnimation="True" 
        EnablePagingCallbackAnimation="True">
        <Columns>
            <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" 
                ShowNewButtonInHeader="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="ID_CLIENTE" ReadOnly="True" 
                VisibleIndex="1" Caption="NUMERO DE CLIENTE">
                <editformsettings visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CLIENTE" VisibleIndex="2" 
                Caption="CLIENTE">
                <PropertiesTextEdit>
                    <ValidationSettings SetFocusOnError="True">
                        <RequiredField IsRequired="True" />
                    </ValidationSettings>
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="DIRECCION" FieldName="DIRECCION" 
                VisibleIndex="3">
                <PropertiesTextEdit>
                    <ValidationSettings>
                        <RequiredField IsRequired="True" />
                    </ValidationSettings>
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="CODIGO POSTAL" FieldName="CODIGO_POSTAL" 
                VisibleIndex="10">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="TELEFONO" FieldName="TELEFONO" 
                VisibleIndex="11">
                <PropertiesTextEdit>
                    <ValidationSettings SetFocusOnError="True">
                        <RequiredField IsRequired="True" />
                    </ValidationSettings>
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="CORREO" FieldName="CORREO" 
                VisibleIndex="12">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="RFC" FieldName="RFC" VisibleIndex="13">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="TIPO" FieldName="TIPO" VisibleIndex="14" 
                Visible="False">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="NOMBRE DEL CONTACTO" 
                FieldName="NOMBRECONTACTO" VisibleIndex="15">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="DIAS DE CREDITO" FieldName="DIASCREDITO" 
                VisibleIndex="16">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="MONTO DEL CREDITO" FieldName="MONTOCREDITO" 
                VisibleIndex="17">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="CUENTA BANCARIA" FieldName="CUENTA" 
                VisibleIndex="22">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="CLAVE INTERBANCARIA" FieldName="CLAVE" 
                VisibleIndex="23">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn Caption="CREADO EL" FieldName="FECHA_CREACION" 
                Visible="False" VisibleIndex="24">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="CREO" 
                VisibleIndex="25" Visible="False">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataComboBoxColumn Caption="CIUDAD" FieldName="CIUDAD" 
                VisibleIndex="9">
                <PropertiesComboBox DataSourceID="CIUDAD" IncrementalFilteringMode="Contains" 
                    TextField="CIUDAD" TextFormatString="{2}" ValueField="ID_CIUDAD">
                    <Columns>
                        <dx:ListBoxColumn Caption="PAIS" FieldName="PAIS" />
                        <dx:ListBoxColumn Caption="ESTADO" FieldName="ESTADO" />
                        <dx:ListBoxColumn Caption="CIUDAD" FieldName="CIUDAD" />
                    </Columns>
                    <ValidationSettings>
                        <RequiredField IsRequired="True" />
                    </ValidationSettings>
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn Caption="BANCO" FieldName="BANCO" 
                VisibleIndex="21">
                <PropertiesComboBox DataSourceID="BANCOS" IncrementalFilteringMode="Contains" 
                    TextField="BANCO" ValueField="ID_BANCO">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn Caption="PAIS" FieldName="PAIS" VisibleIndex="5">
                <PropertiesComboBox DataSourceID="CIUDAD" IncrementalFilteringMode="Contains" 
                    TextField="PAIS" ValueField="ID_PAIS">
                    <ValidationSettings>
                        <RequiredField IsRequired="True" />
                    </ValidationSettings>
                </PropertiesComboBox>
                <EditFormSettings Visible="False" />
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn Caption="ESTADO" FieldName="ESTADO" 
                VisibleIndex="8">
                <PropertiesComboBox DataSourceID="CIUDAD" IncrementalFilteringMode="Contains" 
                    TextField="ESTADO" ValueField="ID_ESTADO">
                </PropertiesComboBox>
                <EditFormSettings Visible="False" />
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn Caption="FORMA DE PAGO" FieldName="FORMAPAGO" 
                VisibleIndex="20">
                <PropertiesComboBox IncrementalFilteringMode="Contains">
                    <Items>
                        <dx:ListEditItem Text="CREDITO" Value="1" />
                        <dx:ListEditItem Text="CONTADO" Value="2" />
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
        InsertCommand="CLIENTES_INSERTAR" InsertCommandType="StoredProcedure" 
        SelectCommand="CLIENTES_CONSULTAR" SelectCommandType="StoredProcedure" 
        UpdateCommand="CLIENTES_MODIFICAR" UpdateCommandType="StoredProcedure" DeleteCommand="CLIENTES_ELIMINAR" DeleteCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="ID_CLIENTE" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="CLIENTE" Type="String" />
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
            <asp:Parameter Name="ID_CLIENTE" Type="Int32" />
            <asp:Parameter Name="CLIENTE" Type="String" />
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
