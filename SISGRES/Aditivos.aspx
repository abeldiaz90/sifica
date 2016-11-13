<%@ Page Title="Catalogo de Aditivos" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Aditivos.aspx.cs" Inherits="SISGRES.Aditivos" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <dx:ASPxGridView ID="grdAditivos" runat="server" AutoGenerateColumns="False" 
        Caption="ADITIVOS PARA CONCRETO" DataSourceID="AditivosDatos" EnableTheming="True" 
        KeyFieldName="ID_ADITIVO" Theme="Youthful" Width="100%">
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" ShowDeleteButton="True" 
                ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn Caption="CLAVE" FieldName="ID_ADITIVO" 
                ReadOnly="True" VisibleIndex="1">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="ADITIVO" FieldName="ADITIVO" 
                VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="PRECIO UNITARIO" FieldName="PRECIO" 
                VisibleIndex="4">
                <PropertiesTextEdit DisplayFormatString="C2">
                    <MaskSettings IncludeLiterals="DecimalSymbol" 
                        Mask="$&lt;0..99999g&gt;.&lt;00..99&gt;" />
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataComboBoxColumn Caption="UNIDAD DE MEDIDA" FieldName="ID_UNIDAD" 
                VisibleIndex="3">
                <PropertiesComboBox DataSourceID="UnidadesMedida" 
                    IncrementalFilteringMode="Contains" TextField="UNIDAD" 
                    ValueField="ID_UNIDAD">
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
    <asp:SqlDataSource ID="AditivosDatos" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
        DeleteCommand="ADITIVOS_ELIMINAR" DeleteCommandType="StoredProcedure" 
        InsertCommand="ADITIVOS_INSERTAR" InsertCommandType="StoredProcedure" 
        SelectCommand="ADITIVOS_CONSULTAR" SelectCommandType="StoredProcedure" 
        UpdateCommand="ADITIVOS_MODIFICAR" UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="ID_ADITIVO" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="ADITIVO" Type="String" />
            <asp:Parameter Name="ID_UNIDAD" Type="Int32" />
            <asp:Parameter Name="PRECIO" Type="Decimal" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="ID_ADITIVO" Type="Int32" />
            <asp:Parameter Name="ADITIVO" Type="String" />
            <asp:Parameter Name="ID_UNIDAD" Type="Int32" />
            <asp:Parameter Name="PRECIO" Type="Decimal" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="UnidadesMedida" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
        SelectCommand="UNIDADESMEDIDA_MOSTRAR_TODOS" 
        SelectCommandType="StoredProcedure"></asp:SqlDataSource>
</asp:Content>
