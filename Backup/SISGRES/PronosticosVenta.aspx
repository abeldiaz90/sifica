<%@ Page Title="Pronosticos de Venta" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="PronosticosVenta.aspx.cs" Inherits="SISGRES.PronosticosVenta" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx1" %>
<%@ Register assembly="DevExpress.Web.ASPxScheduler.v14.2, Version=14.2.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxScheduler.Controls" tagprefix="dxwschsc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <dx:ASPxGridView ID="grdPronostico" runat="server" AutoGenerateColumns="False" 
        DataSourceID="DatosVenta" EnableTheming="True" 
        KeyFieldName="ID_PRONOSTICO_VENTAS" Theme="Youthful" Width="100%">
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" ShowDeleteButton="True" 
                ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
                <FilterTemplate>
                    <dx:ASPxButton ID="ASPxButton2" runat="server" onclick="ASPxButton2_Click" 
                        Text="Reporte" Theme="Youthful" VerticalAlign="Middle" Width="100%">
                    </dx:ASPxButton>
                </FilterTemplate>
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn Caption="ID" FieldName="ID_PRONOSTICO_VENTAS" 
                ReadOnly="True" VisibleIndex="1">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="VOLUMEN" FieldName="VOLUMEN" 
                VisibleIndex="7">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="PRECIO DE VENTA(BASE)" FieldName="PRECIO_VENTA" 
                VisibleIndex="9">
                <PropertiesTextEdit DisplayFormatString="c2">
                </PropertiesTextEdit>
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="SEMANA" FieldName="SEMANA" 
                VisibleIndex="12">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="IMPORTE" FieldName="IMPORTE" 
                VisibleIndex="11">
                <PropertiesTextEdit DisplayFormatString="c2">
                </PropertiesTextEdit>
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataComboBoxColumn Caption="CLIENTE" FieldName="ID_CLIENTE" 
                VisibleIndex="2">
                <PropertiesComboBox DataSourceID="Cliente" IncrementalFilteringMode="Contains" 
                    TextField="CLIENTE" ValueField="ID_CLIENTE">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn Caption="TIPO DE CONCRETO" 
                FieldName="ID_TIPO_CONCRETO" VisibleIndex="3">
                <PropertiesComboBox DataSourceID="TiposConcretos" 
                    IncrementalFilteringMode="Contains" TextField="TIPO_CONCRETO" 
                    TextFormatString="{8}" ValueField="ID_TIPO_CONCRETO">
                    <Columns>
                        <dx:ListBoxColumn Caption="ID" FieldName="ID_TIPO_CONCRETO" />
                        <dx:ListBoxColumn Caption="FUERZA DE COMPRESION" 
                            FieldName="FUERZA_COMPRESION" />
                        <dx:ListBoxColumn Caption="MODULO DE ROTURA" FieldName="MODULO_ROTURA" />
                        <dx:ListBoxColumn Caption="RESISTENCIA RAPIDA" FieldName="RESISTENCIA_RAPIDA" />
                        <dx:ListBoxColumn Caption="REVENIMIENTO" FieldName="REVENIMIENTO" />
                        <dx:ListBoxColumn Caption="TAMAÑO DEL MATERIAL" FieldName="TAMAÑO_MATERIAL" />
                        <dx:ListBoxColumn Caption="TIPO DE BOMBEO" FieldName="TIPO_BOMBEO" />
                        <dx:ListBoxColumn Caption="TIPO DE ORIGEN" FieldName="TIPO_ORIGEN" />
                        <dx:ListBoxColumn Caption="TIPO DE CONCRETO" FieldName="TIPO_CONCRETO" />
                    </Columns>
                </PropertiesComboBox>
                <FilterCellStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
                </FilterCellStyle>
                <EditFormCaptionStyle HorizontalAlign="Center" VerticalAlign="Middle" 
                    Wrap="True">
                </EditFormCaptionStyle>
                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True" />
                <CellStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
                </CellStyle>
                <GroupFooterCellStyle HorizontalAlign="Center" VerticalAlign="Middle" 
                    Wrap="True">
                </GroupFooterCellStyle>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn Caption="UNIDAD DE MEDIDA" 
                FieldName="ID_UNIDAD_MEDIDA" VisibleIndex="8">
                <PropertiesComboBox DataSourceID="UnidadMedida" 
                    IncrementalFilteringMode="Contains" TextField="UNIDAD" ValueField="ID_UNIDAD">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn Caption="VENDEDOR" FieldName="ID_VENDEDOR" 
                VisibleIndex="13">
                <PropertiesComboBox DataSourceID="Vendedor" IncrementalFilteringMode="Contains" 
                    TextField="VENDEDOR" ValueField="ID_VENDEDOR">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn Caption="TIPO DE VENTA" FieldName="TIPO_VENTA" 
                VisibleIndex="14">
                <PropertiesComboBox IncrementalFilteringMode="Contains">
                    <Items>
                        <dx:ListEditItem Text="CONTADO" Value="1" />
                        <dx:ListEditItem Text="CREDITO" Value="2" />
                    </Items>
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataTextColumn Caption="REVENIMIENTO" FieldName="REVENIMIENTO" 
                VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataComboBoxColumn Caption="TIPO BOMBEO" FieldName="TIPO_BOMBEO" 
                VisibleIndex="6">
                <PropertiesComboBox IncrementalFilteringMode="Contains">
                    <Items>
                        <dx:ListEditItem Text="DIRECTO" Value="1" />
                        <dx:ListEditItem Text="BOMBA" Value="2" />
                    </Items>
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataTextColumn Caption="PRECIO VENTA FINAL" 
                FieldName="PRECIO_VENTA_FINAL" VisibleIndex="10">
                <PropertiesTextEdit DisplayFormatString="c2">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" 
            AllowSelectSingleRowOnly="True" ConfirmDelete="True" />
        <Settings ShowFilterRow="True" />
        <Styles>
            <Header HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </Header>
            <Row HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </Row>
            <SelectedRow HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </SelectedRow>
            <Cell HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </Cell>
            <HeaderFilterItem HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </HeaderFilterItem>
        </Styles>
    </dx:ASPxGridView>
    <dx:ASPxGridViewExporter ID="ASPxGridViewExporter1" runat="server">
    </dx:ASPxGridViewExporter>
    <asp:SqlDataSource ID="DatosVenta" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
        DeleteCommand="PRONOSTICOS_VENTA_ELIMINAR" DeleteCommandType="StoredProcedure" 
        InsertCommand="PRONOSTICOS_VENTA_INSERTAR" InsertCommandType="StoredProcedure" 
        SelectCommand="PRONOSTICOS_VENTA_CONSULTAR" SelectCommandType="StoredProcedure" 
        UpdateCommand="PRONOSTICOS_VENTA_MODIFICAR" UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="ID_PRONOSTICO_VENTAS" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="ID_CLIENTE" Type="Int32" />
            <asp:Parameter Name="ID_TIPO_CONCRETO" Type="Int32" />
            <asp:Parameter Name="VOLUMEN" Type="Single" />
            <asp:Parameter Name="ID_UNIDAD_MEDIDA" Type="Int32" />
            <asp:Parameter Name="PRECIO_VENTA" Type="Decimal" />
            <asp:Parameter Name="SEMANA" Type="Int32" />
            <asp:Parameter Name="IMPORTE" Type="Int32" />
            <asp:Parameter Name="ID_VENDEDOR" Type="Int32" />
            <asp:Parameter Name="TIPO_VENTA" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="ID_PRONOSTICO_VENTAS" Type="Int32" />
            <asp:Parameter Name="ID_CLIENTE" Type="Int32" />
            <asp:Parameter Name="ID_TIPO_CONCRETO" Type="Int32" />
            <asp:Parameter Name="VOLUMEN" Type="Single" />
            <asp:Parameter Name="ID_UNIDAD_MEDIDA" Type="Int32" />
            <asp:Parameter Name="PRECIO_VENTA" Type="Decimal" />
            <asp:Parameter Name="SEMANA" Type="Int32" />
            <asp:Parameter Name="IMPORTE" Type="Int32" />
            <asp:Parameter Name="ID_VENDEDOR" Type="Int32" />
            <asp:Parameter Name="TIPO_VENTA" Type="Int32" />
            <asp:Parameter Name="PRECIO_VENTA_FINAL" Type="Decimal" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="Cliente" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
        SelectCommand="CLIENTES_CONSULTAR" SelectCommandType="StoredProcedure">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="Concretos" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
        SelectCommand="TIPO_CONCRETO_CONSULTAR" SelectCommandType="StoredProcedure">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="UnidadMedida" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
        SelectCommand="UNIDADESMEDIDA_MOSTRAR_TODOS" 
        SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <asp:SqlDataSource ID="Vendedor" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
        SelectCommand="VENDEDORES_CONSULTAR" SelectCommandType="StoredProcedure">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="TiposConcretos" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
        SelectCommand="TIPO_CONCRETO_CONSULTAR_COLUMNAS_FILTROS" 
        SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    </asp:Content>
