<%@ Page Title="Catalogo de Usuarios" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Usuarios.aspx.cs" Inherits="SISGRES.Usuarios" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<%@ Register assembly="DevExpress.Web.ASPxTreeList.v14.2, Version=14.2.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxTreeList" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <dx:ASPxGridView ID="grdUsuarios" runat="server" AutoGenerateColumns="False" 
    DataSourceID="UsuariosDatos" EnableTheming="True" KeyFieldName="ID_USUARIO" 
    Theme="Youthful" Width="100%" ClientInstanceName="grdUsuarios">
    <Columns>
        <dx:GridViewCommandColumn ShowClearFilterButton="True" ShowEditButton="True" 
            ShowNewButtonInHeader="True" VisibleIndex="0">
        </dx:GridViewCommandColumn>
        <dx:GridViewDataTextColumn FieldName="ID_USUARIO" ReadOnly="True" 
            Visible="False" VisibleIndex="1">
            <EditFormSettings Visible="False" />
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="USUARIO" VisibleIndex="2">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="PASSWORD" VisibleIndex="3">
            <PropertiesTextEdit Password="True">
            </PropertiesTextEdit>
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataComboBoxColumn Caption="EMPLEADO" FieldName="ID_EMPLEADO" 
            VisibleIndex="4">
            <PropertiesComboBox DataSourceID="Empleados" 
                IncrementalFilteringMode="Contains" TextField="NOMBRE" ValueField="ID_EMPLEADO">
            </PropertiesComboBox>
        </dx:GridViewDataComboBoxColumn>
        <dx:GridViewDataComboBoxColumn Caption="ROL" FieldName="ID_ROL" 
            VisibleIndex="5">
            <PropertiesComboBox DataSourceID="Roles" IncrementalFilteringMode="Contains" 
                TextField="ROL" ValueField="ID_ROL">
            </PropertiesComboBox>
        </dx:GridViewDataComboBoxColumn>
    </Columns>
    <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" 
        AllowSelectSingleRowOnly="True" ConfirmDelete="True" />
        <SettingsPager PageSize="20" Position="TopAndBottom">
        </SettingsPager>
    <Settings ShowFilterRow="True" />
    <Styles>
        <Cell HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
        </Cell>
        <Header HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
        </Header>
    </Styles>
</dx:ASPxGridView>
<asp:SqlDataSource ID="Empleados" runat="server" 
    ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
    SelectCommand="EMPLEADOS_MOSTRAR_ID_COMPAÑIA" 
    SelectCommandType="StoredProcedure">
    <SelectParameters>
      <asp:SessionParameter Name="ID_COMPAÑIA" SessionField="Compañia" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="UsuariosDatos" runat="server" 
    ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
    InsertCommand="USUARIOS_INSERTAR" InsertCommandType="StoredProcedure" 
    SelectCommand="USUARIOS_MOSTRAR_TODOS" SelectCommandType="StoredProcedure" 
    DeleteCommand="USUARIOS_ELIMINAR" DeleteCommandType="StoredProcedure" 
    UpdateCommand="USUARIOS_MODIFICAR" UpdateCommandType="StoredProcedure">
    <DeleteParameters>
        <asp:Parameter Name="ID_USUARIO" Type="Int32" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="ID_EMPLEADO" Type="Int32" />
        <asp:Parameter Name="USUARIO" Type="String" />
        <asp:Parameter Name="PASSWORD" Type="String" />
        <asp:Parameter Name="ID_ROL" Type="Int32" />
    </InsertParameters>
    <SelectParameters>
        <asp:SessionParameter Name="ID_COMPAÑIA" SessionField="Compañia" Type="Int32" />
    </SelectParameters>
    <UpdateParameters>
        <asp:Parameter Name="ID_USUARIO" Type="Int32" />
        <asp:Parameter Name="ID_EMPLEADO" Type="Int32" />
        <asp:Parameter Name="USUARIO" Type="String" />
        <asp:Parameter Name="PASSWORD" Type="String" />
        <asp:Parameter Name="ID_ROL" Type="Int32" />
    </UpdateParameters>
</asp:SqlDataSource>
    <asp:SqlDataSource ID="Roles" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
        SelectCommand="ROLES_MOSTRAR_TODOS" SelectCommandType="StoredProcedure">
    </asp:SqlDataSource>
</asp:Content>
