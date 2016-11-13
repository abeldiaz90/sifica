<%@ Page Title="Herramientas" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Herramientas.aspx.cs" Inherits="SISGRES.Herramientas" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <dx:ASPxGridView ID="grdHerramientas" runat="server" 
        AutoGenerateColumns="False" ClientInstanceName="grdHerramientas" 
        DataSourceID="HERRAMIENTAS_DATOS" EnableTheming="True" 
        KeyFieldName="ID_HERRAMIENTA" Theme="Youthful" Width="100%" 
        EnableCallbackAnimation="True" EnablePagingCallbackAnimation="True">
        <Columns>
            <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" 
                ShowNewButtonInHeader="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn Caption="CLAVE DE HERRAMIENTA" 
                FieldName="ID_HERRAMIENTA" ReadOnly="True" VisibleIndex="1">
                <Settings AutoFilterCondition="Contains" />
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="HERRAMIENTA" 
                VisibleIndex="2">
                <Settings AutoFilterCondition="Contains" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="NUMERO DE PARTE" FieldName="NUMBER_PART" 
                VisibleIndex="7">
                <Settings AutoFilterCondition="Contains" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataComboBoxColumn Caption="UNIDAD DE MEDIDA" FieldName="ID_UNIDAD" 
                VisibleIndex="4">
                <PropertiesComboBox DataSourceID="UnidadesMedida" 
                    IncrementalFilteringMode="Contains" TextField="UNIDAD" ValueField="ID_UNIDAD">
                </PropertiesComboBox>
                <Settings AutoFilterCondition="Contains" />
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn Caption="GIRO COMERCIAL" FieldName="ID_GIRO" 
                VisibleIndex="6">
                <PropertiesComboBox DataSourceID="TipoMaterial" 
                    IncrementalFilteringMode="Contains" TextField="GIRO" ValueField="ID_GIRO">
                </PropertiesComboBox>
                <Settings AutoFilterCondition="Contains" />
            </dx:GridViewDataComboBoxColumn>
        </Columns>
        <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" 
            AllowSelectSingleRowOnly="True" ConfirmDelete="True" />
        <SettingsPager PageSize="20" Position="TopAndBottom">
        </SettingsPager>
        <Settings ShowFilterRow="True" ShowGroupPanel="True" />
        <Styles>
            <Cell HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </Cell>
            <Header HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </Header>
        </Styles>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="HERRAMIENTAS_DATOS" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
        InsertCommand="HERRAMIENTAS_INSERTAR" InsertCommandType="StoredProcedure" 
        SelectCommand="HERRAMIENTAS_MOSTRAR_TODOS" SelectCommandType="StoredProcedure" 
        UpdateCommand="HERRAMIENTAS_MODIFICAR" UpdateCommandType="StoredProcedure" 
        DeleteCommand="HERRAMIENTAS_ELIMINAR" DeleteCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="ID_HERRAMIENTA" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="HERRAMIENTA" Type="String" />
            <asp:Parameter Name="ID_UNIDAD" Type="Int32" />
            <asp:Parameter Name="ID_GIRO" Type="Int32" />
            <asp:Parameter Name="NUMBER_PART" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="ID_HERRAMIENTA" Type="Int32" />
            <asp:Parameter Name="HERRAMIENTA" Type="String" />
            <asp:Parameter Name="ID_UNIDAD" Type="Int32" />
            <asp:Parameter Name="ID_GIRO" Type="Int32" />
            <asp:Parameter Name="NUMBER_PART" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="UnidadesMedida" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
        SelectCommand="UNIDADESMEDIDA_MOSTRAR_TODOS" 
        SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <asp:SqlDataSource ID="TipoMaterial" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
        SelectCommand="GIROS_MOSTRAR_TODOS" SelectCommandType="StoredProcedure">
    </asp:SqlDataSource>
</asp:Content>
