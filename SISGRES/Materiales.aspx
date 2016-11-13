<%@ Page Title="Catalogo de Materiales" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Materiales.aspx.cs" Inherits="SISGRES.Materiales" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <dx:ASPxGridView ID="grdMateriales" runat="server" AutoGenerateColumns="False" 
        DataSourceID="MaterialesDatos" EnableTheming="True" KeyFieldName="ID_MATERIAL" 
        Theme="Youthful" Width="100%" EnableCallbackAnimation="True" 
        EnablePagingCallbackAnimation="True">
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" ShowDeleteButton="True" 
                ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn Caption="CLAVE DEL MATERIAL" FieldName="ID_MATERIAL" 
                ReadOnly="True" VisibleIndex="1">
                <Settings AutoFilterCondition="Contains" />
                <EditFormSettings Visible="False" />
                <CellStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
                </CellStyle>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="DESCRIPCIÓN" FieldName="MATERIAL" 
                VisibleIndex="2">
                <Settings AutoFilterCondition="Contains" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataComboBoxColumn Caption="UNIDAD DE MEDIDA" FieldName="ID_UNIDAD" 
                VisibleIndex="4">
                <PropertiesComboBox DataSourceID="UnidadesMedida" 
                    IncrementalFilteringMode="Contains" TextField="UNIDAD" ValueField="ID_UNIDAD">
                </PropertiesComboBox>
                <Settings AutoFilterCondition="Contains" />
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn Caption="TIPO DE MATERIAL" FieldName="ID_GIRO" 
                VisibleIndex="5">
                <PropertiesComboBox DataSourceID="TipoMaterial" TextField="GIRO" 
                    ValueField="ID_GIRO">
                </PropertiesComboBox>
                <Settings AutoFilterCondition="Contains" />
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataTextColumn Caption="NUMERO DE PARTE" FieldName="NUMBER_PART" 
                VisibleIndex="6">
                <Settings AutoFilterCondition="Contains" />
                <EditFormCaptionStyle HorizontalAlign="Center" VerticalAlign="Middle" 
                    Wrap="True">
                </EditFormCaptionStyle>
            </dx:GridViewDataTextColumn>
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
    <asp:SqlDataSource ID="MaterialesDatos" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
        InsertCommand="MATERIALES_INSERTAR" InsertCommandType="StoredProcedure" 
        SelectCommand="MATERIALES_MOSTRAR_TODOS" SelectCommandType="StoredProcedure" 
        UpdateCommand="MATERIALES_MODIFICAR" UpdateCommandType="StoredProcedure" 
        DeleteCommand="MATERIALES_ELIMINAR" DeleteCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="ID_MATERIAL" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="MATERIAL" Type="String" />
            <asp:Parameter Name="ID_UNIDAD" Type="Int32" />
            <asp:Parameter Name="ID_GIRO" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="ID_MATERIAL" Type="Int32" />
            <asp:Parameter Name="MATERIAL" Type="String" />
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
