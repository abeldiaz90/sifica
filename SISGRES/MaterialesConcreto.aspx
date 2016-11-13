<%@ Page Title="Materiales para fabricar concreto" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="MaterialesConcreto.aspx.cs" Inherits="SISGRES.MaterialesConcreto" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <dx:ASPxGridView ID="grdMaterialesConcreto" runat="server" 
        AutoGenerateColumns="False" Caption="MATERIALES ADICIONALES PARA CONCRETO" 
        DataSourceID="MaterialesConcretosDatos" EnableTheming="True" 
        KeyFieldName="ID_MATERIALES_CONCRETO" Theme="Youthful" Width="100%">
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" ShowDeleteButton="True" 
                ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn Caption="CLAVE" FieldName="ID_MATERIALES_CONCRETO" 
                ReadOnly="True" VisibleIndex="1">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="MATERIAL" VisibleIndex="2" 
                Caption="MATERIAL">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="PRECIO" VisibleIndex="4" 
                Caption="PRECIO UNITARIO">
                <PropertiesTextEdit DisplayFormatString="C2">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataComboBoxColumn Caption="UNIDAD DE MEDIDA" FieldName="ID_UNIDAD" 
                VisibleIndex="3">
                <PropertiesComboBox DataSourceID="UnidadesMedida" 
                    IncrementalFilteringMode="Contains" TextField="UNIDAD" ValueField="ID_UNIDAD">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
        </Columns>
        <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" 
            AllowSelectSingleRowOnly="True" ConfirmDelete="True" />
        <Settings ShowFilterRow="True" />
        <Styles>
            <Cell HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </Cell>
            <Header HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </Header>
        </Styles>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="MaterialesConcretosDatos" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
        DeleteCommand="MATERIALES_CONCRETO_ELIMINAR" 
        DeleteCommandType="StoredProcedure" 
        InsertCommand="MATERIALES_CONCRETO_INSERTAR" 
        InsertCommandType="StoredProcedure" 
        SelectCommand="MATERIALES_CONCRETO_CONSULTAR" 
        SelectCommandType="StoredProcedure" 
        UpdateCommand="MATERIALES_CONCRETO_MODIFICAR" 
        UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="ID_MATERIALES_CONCRETO" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="MATERIAL" Type="String" />
            <asp:Parameter Name="ID_UNIDAD" Type="Int32" />
            <asp:Parameter Name="PRECIO" Type="Decimal" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="ID_MATERIALES_CONCRETO" Type="Int32" />
            <asp:Parameter Name="MATERIAL" Type="String" />
            <asp:Parameter Name="ID_UNIDAD" Type="Int32" />
            <asp:Parameter Name="PRECIO" Type="Decimal" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="UnidadesMedida" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
        SelectCommand="UNIDADESMEDIDA_MOSTRAR_TODOS" 
        SelectCommandType="StoredProcedure"></asp:SqlDataSource>
</asp:Content>
