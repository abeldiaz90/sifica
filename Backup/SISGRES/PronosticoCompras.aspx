<%@ Page Title="PRONOSTICO DE GASTOS" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="PronosticoCompras.aspx.cs" Inherits="SISGRES.PronosticoCompras" %><%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <dx:ASPxGridView ID="grdCompras" runat="server" AutoGenerateColumns="False" 
        DataSourceID="PronosticosGastos" EnableTheming="True" 
        KeyFieldName="ID_PRONOSTICO_COMPRAS" Theme="Youthful">
        <Columns>
            <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" 
                ShowNewButtonInHeader="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn Caption="FOLIO" FieldName="ID_PRONOSTICO_COMPRAS" 
                ReadOnly="True" VisibleIndex="1">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="VOLUMEN" FieldName="VOLUMEN" 
                VisibleIndex="6">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="IMPORTE" FieldName="IMPORTE" 
                VisibleIndex="9">
                <PropertiesTextEdit DisplayFormatString="c2">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn Caption="FECHA DEL DOCUMENTO" FieldName="FECHA_DOCUMENTO" 
                VisibleIndex="10">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn Caption="DIAS DE CREDITO" FieldName="DIAS_CREDITO" 
                VisibleIndex="11">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataComboBoxColumn Caption="PROVEEDOR" FieldName="ID_PROVEEDOR" 
                VisibleIndex="3">
                <PropertiesComboBox DataSourceID="Proveedores" 
                    IncrementalFilteringMode="Contains" TextField="PROOVEDOR" 
                    ValueField="ID_PROOVEDOR">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn Caption="MATERIAL" FieldName="ID_MATERIAL" 
                VisibleIndex="5">
                <PropertiesComboBox DataSourceID="Materiales" 
                    IncrementalFilteringMode="Contains" TextField="MATERIAL" 
                    ValueField="ID_MATERIAL">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn Caption="UNIDAD DE MEDIDA" 
                FieldName="ID_UNIDAD_MEDIDA" VisibleIndex="8">
                <PropertiesComboBox DataSourceID="UnidadMedida" 
                    IncrementalFilteringMode="Contains" TextField="UNIDAD" ValueField="ID_UNIDAD">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataDateColumn Caption="FECHA DE VENCIMIENTO" FieldName="CREDITOS" 
                VisibleIndex="13">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataComboBoxColumn Caption="TIPO DE VENTA" FieldName="TIPO_VENTA" 
                VisibleIndex="14">
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
        <Settings ShowFilterRow="True" ShowGroupPanel="True" />
        <Styles>
            <Cell HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </Cell>
            <Header HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </Header>
        </Styles>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="PronosticosGastos" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
        DeleteCommand="PRONOSTICO_COMPRAS_ELIMINAR" DeleteCommandType="StoredProcedure" 
        InsertCommand="PRONOSTICO_COMPRAS_INSERTAR" InsertCommandType="StoredProcedure" 
        SelectCommand="PRONOSTICO_COMPRAS_CONSULTAR" 
        SelectCommandType="StoredProcedure" 
        UpdateCommand="PRONOSTICO_COMPRAS_MODIFICAR" 
        UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="ID_PRONOSTICO_COMPRAS" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="ID_PROVEEDOR" Type="Int32" />
            <asp:Parameter Name="ID_MATERIAL" Type="Int32" />
            <asp:Parameter Name="VOLUMEN" Type="Single" />
            <asp:Parameter Name="ID_UNIDAD_MEDIDA" Type="Int32" />
            <asp:Parameter Name="IMPORTE" Type="Decimal" />
            <asp:Parameter Name="FECHA_DOCUMENTO" Type="DateTime" />
            <asp:Parameter Name="DIAS_CREDITO" Type="Int32" />
            <asp:Parameter Name="TIPO_VENTA" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="ID_PRONOSTICO_COMPRAS" Type="Int32" />
            <asp:Parameter Name="ID_PROVEEDOR" Type="Int32" />
            <asp:Parameter Name="ID_MATERIAL" Type="Int32" />
            <asp:Parameter Name="VOLUMEN" Type="Single" />
            <asp:Parameter Name="ID_UNIDAD_MEDIDA" Type="Int32" />
            <asp:Parameter Name="IMPORTE" Type="Decimal" />
            <asp:Parameter Name="FECHA_DOCUMENTO" Type="DateTime" />
            <asp:Parameter Name="DIAS_CREDITO" Type="Int32" />
            <asp:Parameter Name="TIPO_VENTA" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="Proveedores" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
        SelectCommand="SELECT [ID_PROOVEDOR], [PROOVEDOR] FROM [PROVEEDORES] ORDER BY [PROOVEDOR]">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="Materiales" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
        SelectCommand="SELECT [ID_MATERIAL], [MATERIAL] FROM [MATERIALES]">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="UnidadMedida" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
        SelectCommand="UNIDADESMEDIDA_MOSTRAR_TODOS" 
        SelectCommandType="StoredProcedure"></asp:SqlDataSource>
</asp:Content>
