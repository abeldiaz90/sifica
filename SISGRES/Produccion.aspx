<%@ Page Title="PRODUCCIÓN DE PLANTA DE CONCRETO" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Produccion.aspx.cs" Inherits="SISGRES.Produccion" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="ProduccionDatos" EnableTheming="True" 
        KeyFieldName="ID_PRODUCCION" Theme="Moderno">
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" ShowDeleteButton="True" 
                ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
                <FilterTemplate>
                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Logos/Excel.png" 
                        onclick="ImageButton1_Click" />
                </FilterTemplate>
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn Caption="FOLIO" FieldName="ID_PRODUCCION" 
                ReadOnly="True" VisibleIndex="1" Visible="False">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn Caption="FECHA" FieldName="FECHA" VisibleIndex="3">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataDateColumn Caption="SALIDA DE PLANTA" FieldName="SALIDA" 
                VisibleIndex="4">
                <PropertiesDateEdit DisplayFormatString="HH:mm:ss" EditFormat="Time" 
                    EditFormatString="HH:mm:ss">
                </PropertiesDateEdit>
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn Caption="LUGAR DE ENTREGA" FieldName="LUGAR_ENTREGA" 
                VisibleIndex="8">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="PRECIO DE VENTA FINAL" 
                FieldName="PRECIO_VENTA_FINAL" VisibleIndex="10">
                <PropertiesTextEdit DisplayFormatString="c2">
                    <MaskSettings IncludeLiterals="DecimalSymbol" 
                        Mask="$&lt;0..9999999999g&gt;.&lt;00..99&gt;" />
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="CANTIDAD" FieldName="CANTIDAD" 
                VisibleIndex="11">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="CAMION" FieldName="CAMION" VisibleIndex="6">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="IMPORTE" FieldName="TOTAL" ReadOnly="True" 
                VisibleIndex="17">
                <PropertiesTextEdit DisplayFormatString="c2">
                </PropertiesTextEdit>
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataComboBoxColumn Caption="OPERADOR" FieldName="ID_EMPLEADO" 
                VisibleIndex="5">
                <PropertiesComboBox DataSourceID="Empleados" 
                    IncrementalFilteringMode="Contains" TextField="NOMBRE" ValueField="ID_EMPLEADO">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn Caption="CLIENTE" FieldName="ID_CLIENTE" 
                VisibleIndex="7">
                <PropertiesComboBox DataSourceID="SqlDataSource1" 
                    IncrementalFilteringMode="Contains" TextField="CLIENTE" ValueField="ID_CLIENTE">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn Caption="VENDEDOR" FieldName="ID_VENDEDOR" 
                VisibleIndex="13">
                <PropertiesComboBox DataSourceID="vendedores" 
                    IncrementalFilteringMode="Contains" TextField="VENDEDOR" 
                    ValueField="ID_VENDEDOR">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn Caption="TIPO DE CONCRETO" 
                FieldName="ID_TIPO_CONCRETO" VisibleIndex="9">
                <PropertiesComboBox DataSourceID="Concretos" 
                    IncrementalFilteringMode="Contains" TextField="TIPO_CONCRETO" 
                    ValueField="ID_TIPO_CONCRETO" TextFormatString="{5}">
                    <Columns>
                        <dx:ListBoxColumn Caption="TIPO DE CONCRETO" FieldName="TIPO_CONCRETO" />
                        <dx:ListBoxColumn Caption="TIPO DE BOMBEO" FieldName="TIPO_BOMBEO" />
                        <dx:ListBoxColumn Caption="EDAD COMPROMISO" FieldName="EDAD_COMPROMISO" />
                        <dx:ListBoxColumn Caption="TAMAÑO DE MATERIAL" FieldName="TAMAÑO_MATERIAL" />
                        <dx:ListBoxColumn Caption="REVENIMIENTO" FieldName="REVENIMIENTO" />
                        <dx:ListBoxColumn Caption="DESCRIPCION" FieldName="CONCATENADO" />
                    </Columns>
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataTextColumn Caption="REMISION" FieldName="REMISION" 
                VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataComboBoxColumn Caption="UNIDAD DE MEDIDA" FieldName="ID_UNIDAD" 
                VisibleIndex="12">
                <PropertiesComboBox DataSourceID="UnidadesMedida" 
                    IncrementalFilteringMode="Contains" TextField="UNIDAD" ValueField="ID_UNIDAD">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn Caption="TIPO DE PAGO" FieldName="ID_TIPO" 
                VisibleIndex="15">
                <PropertiesComboBox IncrementalFilteringMode="Contains">
                    <Items>
                        <dx:ListEditItem Text="CONTADO" Value="1" />
                        <dx:ListEditItem Text="CREDITO" Value="2" />
                    </Items>
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataCheckColumn Caption="REQUIERE FACTURA" FieldName="FACTURA" 
                VisibleIndex="16">
                <PropertiesCheckEdit DisplayTextChecked="" DisplayTextUnchecked="" DisplayTextGrayed="False" DisplayTextUndefined="False" ValueGrayed="False">
                </PropertiesCheckEdit>
            </dx:GridViewDataCheckColumn>
        </Columns>
        <Settings ShowFilterRow="True" ShowGroupPanel="True" />
        <Styles>
            <Header HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </Header>
            <Cell HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </Cell>
        </Styles>
    </dx:ASPxGridView>
    <dx:ASPxGridViewExporter ID="Exportar" runat="server" 
        GridViewID="ASPxGridView1">
    </dx:ASPxGridViewExporter>
    <asp:SqlDataSource ID="ProduccionDatos" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
        DeleteCommand="PRODUCCION_ELIMINAR" DeleteCommandType="StoredProcedure" 
        InsertCommand="PRODUCCION_INSERTAR" InsertCommandType="StoredProcedure" 
        SelectCommand="PRODUCCION_CONSULTAR" SelectCommandType="StoredProcedure" 
        UpdateCommand="PRODUCCION_MODIFICAR" UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="ID_PRODUCCION" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="FECHA" Type="DateTime" />
            <asp:Parameter Name="ID_EMPLEADO" Type="Int32" />
            <asp:Parameter Name="SALIDA" Type="DateTime" />
            <asp:Parameter Name="ID_CLIENTE" Type="Int32" />
            <asp:Parameter Name="LUGAR_ENTREGA" Type="String" />
            <asp:Parameter Name="ID_TIPO_CONCRETO" Type="Int32" />
            <asp:Parameter Name="PRECIO_VENTA_FINAL" Type="Decimal" />
            <asp:Parameter Name="ID_VENDEDOR" Type="Int32" />
            <asp:Parameter Name="CANTIDAD" Type="Int32" />
            <asp:Parameter Name="CAMION" Type="String" />
            <asp:Parameter Name="REMISION" Type="String" />
            <asp:Parameter Name="ID_UNIDAD" Type="Int32" />
            <asp:Parameter Name="ID_TIPO" Type="Int32" />
            <asp:Parameter Name="FACTURA" Type="Boolean" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="ID_PRODUCCION" Type="Int32" />
            <asp:Parameter Name="FECHA" Type="DateTime" />
            <asp:Parameter Name="ID_EMPLEADO" Type="Int32" />
            <asp:Parameter Name="SALIDA" Type="DateTime" />
            <asp:Parameter Name="ID_CLIENTE" Type="Int32" />
            <asp:Parameter Name="LUGAR_ENTREGA" Type="String" />
            <asp:Parameter Name="ID_TIPO_CONCRETO" Type="Int32" />
            <asp:Parameter Name="PRECIO_VENTA_FINAL" Type="Decimal" />
            <asp:Parameter Name="ID_VENDEDOR" Type="Int32" />
            <asp:Parameter Name="CANTIDAD" Type="Int32" />
            <asp:Parameter Name="CAMION" Type="String" />
            <asp:Parameter Name="REMISION" Type="String" />
            <asp:Parameter Name="ID_UNIDAD" Type="Int32" />
            <asp:Parameter Name="ID_TIPO" Type="Int32" />
            <asp:Parameter Name="FACTURA" Type="Boolean" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="Empleados" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
        SelectCommand="EMPLEADOS_MOSTRAR_ID_COMPAÑIA" 
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="ID_COMPAÑIA" SessionField="Compañia" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
        SelectCommand="CLIENTES_CONSULTAR" SelectCommandType="StoredProcedure">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="Concretos" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
        SelectCommand="TIPO_CONCRETO_CONSULTAR_COLUMNAS_FILTROS" 
        SelectCommandType="StoredProcedure">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="vendedores" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
        SelectCommand="VENDEDORES_CONSULTAR" SelectCommandType="StoredProcedure">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="UnidadesMedida" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
        SelectCommand="UNIDADESMEDIDA_MOSTRAR_TODOS" 
        SelectCommandType="StoredProcedure"></asp:SqlDataSource>
</asp:Content>
