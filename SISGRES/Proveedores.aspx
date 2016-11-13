<%@ Page Title="Proveedores" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Proveedores.aspx.cs" Inherits="SISGRES.Proveedores" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Data.Linq" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <dx:ASPxGridView ID="grdProveedores" runat="server" AutoGenerateColumns="False" 
        DataSourceID="DATOSPRO" EnableTheming="True" KeyboardSupport="True" 
        KeyFieldName="ID_PROOVEDOR" Theme="Youthful" Width="700px" 
    Caption="PROVEEDORES">
        <Columns>
            <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" 
                ShowNewButtonInHeader="True" ShowUpdateButton="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn Caption="CLAVE DEL PROVEEDOR" 
                FieldName="ID_PROOVEDOR" ReadOnly="True" VisibleIndex="1">
                <PropertiesTextEdit>
                    <ValidationSettings ErrorTextPosition="Bottom">
                    </ValidationSettings>
                </PropertiesTextEdit>
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="NOMBRE DEL PROVEEDOR" FieldName="PROOVEDOR" 
                VisibleIndex="2">
                <PropertiesTextEdit>
                    <ValidationSettings SetFocusOnError="True">
                        <RequiredField IsRequired="True" />
                    </ValidationSettings>
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="DIRECCION" FieldName="DIRECCION" 
                VisibleIndex="3">
                <PropertiesTextEdit>
                    <ValidationSettings SetFocusOnError="True">
                        <RequiredField IsRequired="True" />
                    </ValidationSettings>
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="CODIGO POSTAL" FieldName="CODIGO_POSTAL" 
                VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="TELEFONO" VisibleIndex="11">
                <PropertiesTextEdit>
                    <ValidationSettings SetFocusOnError="True">
                        <RequiredField IsRequired="True" />
                    </ValidationSettings>
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="CORREO ELECTRONICO" FieldName="CORREO" 
                VisibleIndex="12">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="RFC" VisibleIndex="13">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="NOMBRE DEL CONTACTO" 
                FieldName="NOMBRECONTACTO" VisibleIndex="16">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="DIAS DE CREDITO" FieldName="DIASCREDITO" 
                VisibleIndex="17">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="MONTO DEL CREDITO" FieldName="MONTOCREDITO" 
                VisibleIndex="18">
                <PropertiesTextEdit DisplayFormatString="c2">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="NUMERO DE CUENTA BANCARIA" 
                FieldName="CUENTA" VisibleIndex="23">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="CLAVE INTERBANCARIA" FieldName="CLAVE" 
                VisibleIndex="24">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataComboBoxColumn Caption="PAIS" FieldName="PAIS" 
                VisibleIndex="10">
                <PropertiesComboBox DataSourceID="CIUDAD" TextField="PAIS" ValueField="ID_PAIS">
                </PropertiesComboBox>
                <EditFormSettings Visible="False" />
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn Caption="ESTADO" FieldName="ESTADO" 
                VisibleIndex="9">
                <PropertiesComboBox DataSourceID="CIUDAD" IncrementalFilteringMode="Contains" 
                    TextField="ESTADO" ValueField="ID_ESTADO">
                </PropertiesComboBox>
                <EditFormSettings Visible="False" />
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn FieldName="CIUDAD" VisibleIndex="8">
                <PropertiesComboBox DataSourceID="CIUDAD" IncrementalFilteringMode="Contains" 
                    TextField="CIUDAD" TextFormatString="{2}" ValueField="ID_CIUDAD">
                    <Columns>
                        <dx:ListBoxColumn Caption="PAIS" FieldName="PAIS" Name="PAIS" />
                        <dx:ListBoxColumn Caption="ESTADO" FieldName="ESTADO" Name="ESTADO" />
                        <dx:ListBoxColumn Caption="CIUDAD" FieldName="CIUDAD" Name="CIUDAD" />
                    </Columns>
                    <ValidationSettings SetFocusOnError="True">
                        <RequiredField IsRequired="True" />
                    </ValidationSettings>
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn Caption="NOMBRE DEL BANCO" FieldName="BANCO" 
                VisibleIndex="22">
                <PropertiesComboBox DataSourceID="BANCOS" ImageUrlField="URLLOGO" 
                    IncrementalFilteringMode="Contains" TextField="BANCO" ValueField="ID_BANCO">
                    <ItemImage Height="70%" Width="70%">
                    </ItemImage>
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn Caption="FORMA DE PAGO" FieldName="FORMAPAGO" 
                VisibleIndex="21">
                <PropertiesComboBox IncrementalFilteringMode="Contains">
                    <Items>
                        <dx:ListEditItem Text="CONTADO" Value="1" />
                        <dx:ListEditItem Text="CREDITO" Value="2" />
                    </Items>
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn Caption="GIRO DEL PROVEEDOR" FieldName="TIPO" 
                VisibleIndex="15">
                <PropertiesComboBox DataSourceID="GIROS" IncrementalFilteringMode="Contains" 
                    TextField="GIRO" ValueField="ID_GIRO">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
        </Columns>
        <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" 
            AllowSelectSingleRowOnly="True" ConfirmDelete="True" />
        <SettingsPager Position="TopAndBottom">
        </SettingsPager>
        <SettingsEditing Mode="PopupEditForm">
        </SettingsEditing>
        <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowTitlePanel="True" />
        <SettingsPopup>
            <EditForm HorizontalAlign="WindowCenter" Modal="True" 
                VerticalAlign="WindowCenter" Width="900px" />
        </SettingsPopup>
        <SettingsSearchPanel Visible="True" />
        <Styles>
            <Cell HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </Cell>
            <Header HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </Header>
        </Styles>
        <StylesPopup>
            <EditForm>
                <Header BackColor="#FFFF99" HorizontalAlign="Center" VerticalAlign="Middle" 
                    Wrap="True">
                </Header>
            </EditForm>
        </StylesPopup>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="DATOSPRO" runat="server" 
    ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
    InsertCommand="PROOVEDORES_INSERTAR" InsertCommandType="StoredProcedure" 
    SelectCommand="PROOVEDORES_MOSTRAR_TODOS" SelectCommandType="StoredProcedure" 
    UpdateCommand="PROOVEDORES_MODIFICAR" UpdateCommandType="StoredProcedure" DeleteCommand="PROVEEDORES_ELIMINAR" DeleteCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="ID_PROOVEDOR" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="PROOVEDOR" Type="String" />
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
            <asp:Parameter Name="ID_PROOVEDOR" Type="Int32" />
            <asp:Parameter Name="PROOVEDOR" Type="String" />
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
    <br />
</asp:Content>
