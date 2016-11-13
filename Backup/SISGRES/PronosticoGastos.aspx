<%@ Page Title="Pronostico de Gastos" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="PronosticoGastos.aspx.cs" Inherits="SISGRES.PronosticoGastos" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <dx:ASPxGridView ID="grdPronosticoGastos" runat="server" 
        AutoGenerateColumns="False" DataSourceID="PronosticoGastosDatos" 
        EnableTheming="True" KeyFieldName="ID_PRONOSTICO_GASTOS" Theme="Youthful" 
        Width="100%">
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" ShowDeleteButton="True" 
                ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn Caption="FOLIO" FieldName="ID_PRONOSTICO_GASTOS" 
                ReadOnly="True" VisibleIndex="1">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="DESCRIPCIÓN" FieldName="DESCRIPCION" 
                VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="IMPORTE MENSUAL" 
                FieldName="IMPORTE_MENSUAL" VisibleIndex="5">
                <PropertiesTextEdit DisplayFormatString="c2">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="IMPORTE VENCIDO" 
                FieldName="IMPORTE_VENCIDO" VisibleIndex="9">
                <PropertiesTextEdit DisplayFormatString="c2">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="NOTAS" FieldName="NOTAS" VisibleIndex="10">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn Caption="FECHA DEL DOCUMENTO" 
                FieldName="FECHA_DOCUMENTO" VisibleIndex="6">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn Caption="DIAS DE CREDITO" FieldName="DIAS_CREDITO" 
                VisibleIndex="7">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataComboBoxColumn Caption="PROVEEDOR" FieldName="ID_PROVEEDOR" 
                VisibleIndex="2">
                <PropertiesComboBox DataSourceID="Proveedores" 
                    IncrementalFilteringMode="Contains" TextField="PROOVEDOR" 
                    ValueField="ID_PROOVEDOR">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn Caption="CONCEPTO" FieldName="ID_CONCEPTO" 
                VisibleIndex="3">
                <PropertiesComboBox DataSourceID="Materiales" 
                    IncrementalFilteringMode="Contains" TextField="CONCEPTO" 
                    ValueField="ID_CONCEPTO">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataDateColumn Caption="FECHA DE VENCIMIENTO" FieldName="CREDITOS" 
                VisibleIndex="8">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataDateColumn>
        </Columns>
        <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" 
            AllowSelectSingleRowOnly="True" ConfirmDelete="True" />
        <Settings ShowFilterRow="True" ShowGroupPanel="True" />
        <Styles>
            <Cell HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </Cell>
        </Styles>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="PronosticoGastosDatos" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
        DeleteCommand="PRONOSTICO_GASTOS_ELIMINAR" DeleteCommandType="StoredProcedure" 
        InsertCommand="PRONOSTICO_GASTOS_INSERTAR" InsertCommandType="StoredProcedure" 
        SelectCommand="PRONOSTICO_GASTOS_CONSULTAR" SelectCommandType="StoredProcedure" 
        UpdateCommand="PRONOSTICO_GASTOS_MODIFICAR" UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="ID_PRONOSTICO_GASTOS" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="ID_PROVEEDOR" Type="Int32" />
            <asp:Parameter Name="ID_CONCEPTO" Type="Int32" />
            <asp:Parameter Name="DESCRIPCION" Type="String" />
            <asp:Parameter Name="IMPORTE_MENSUAL" Type="Decimal" />
            <asp:Parameter Name="IMPORTE_VENCIDO" Type="Decimal" />
            <asp:Parameter Name="NOTAS" Type="String" />
            <asp:Parameter Name="FECHA_DOCUMENTO" Type="DateTime" />
            <asp:Parameter Name="DIAS_CREDITO" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="ID_PROVEEDOR" Type="Int32" />
            <asp:Parameter Name="ID_CONCEPTO" Type="Int32" />
            <asp:Parameter Name="DESCRIPCION" Type="String" />
            <asp:Parameter Name="IMPORTE_MENSUAL" Type="Decimal" />
            <asp:Parameter Name="IMPORTE_VENCIDO" Type="Decimal" />
            <asp:Parameter Name="NOTAS" Type="String" />
            <asp:Parameter Name="ID_PRONOSTICO_GASTOS" Type="Int32" />
            <asp:Parameter Name="FECHA_DOCUMENTO" Type="DateTime" />
            <asp:Parameter Name="DIAS_CREDITO" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="Proveedores" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
        SelectCommand="SELECT [ID_PROOVEDOR], [PROOVEDOR] FROM [PROVEEDORES] ORDER BY [PROOVEDOR]">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="Materiales" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
        
        SelectCommand="SELECT [ID_CONCEPTO], [CONCEPTO] FROM [CONCEPTOS] ORDER BY [CONCEPTO]">
    </asp:SqlDataSource>
    </asp:Content>
