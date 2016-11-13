<%@ Page Title="PROYECTOS" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Proyectos.aspx.cs" Inherits="SISGRES.Proyectos" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <dx:ASPxGridView ID="grdProyectos" runat="server" AutoGenerateColumns="False" 
    DataSourceID="ProyectosDatos" EnableTheming="True" KeyFieldName="ID_PROYECTO" 
    Theme="BlackGlass" Width="100%">
    <Columns>
        <dx:GridViewCommandColumn ShowClearFilterButton="True" ShowDeleteButton="True" 
            ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
        </dx:GridViewCommandColumn>
        <dx:GridViewDataTextColumn FieldName="ID_PROYECTO" ReadOnly="True" 
            Visible="False" VisibleIndex="1">
            <EditFormSettings Visible="False" />
<EditFormSettings Visible="False"></EditFormSettings>
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn Caption="PROYECTO" FieldName="PROYECTO" 
            VisibleIndex="2">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataDateColumn Caption="FECHA DE INICIO" FieldName="FECHA_INICIO" 
            VisibleIndex="3">
        </dx:GridViewDataDateColumn>
        <dx:GridViewDataDateColumn Caption="FECHA DE TERMINO" 
            FieldName="FECHA_VIGENCIA" VisibleIndex="4">
        </dx:GridViewDataDateColumn>
        <dx:GridViewDataTextColumn Caption="MONTO USD" FieldName="MONTO_USD" 
            VisibleIndex="5">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn Caption="MONTO MXN" FieldName="MONTO_MXN" 
            VisibleIndex="6">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn Caption="COMPAÑIA" FieldName="ID_COMPAÑIA" 
            VisibleIndex="7">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn Caption="NUMERO" FieldName="NUMERO" 
            VisibleIndex="10">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataComboBoxColumn Caption="CLIENTE" FieldName="ID_CLIENTE" 
            VisibleIndex="9">
            <PropertiesComboBox DataSourceID="Clientes" TextField="CLIENTE" 
                ValueField="ID_CLIENTE" incrementalfilteringmode="Contains">
            </PropertiesComboBox>
        </dx:GridViewDataComboBoxColumn>
    </Columns>
    <Settings ShowFilterRow="True" />

<Settings ShowFilterRow="True"></Settings>

    <Styles>
        <Cell HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
        </Cell>
    </Styles>
</dx:ASPxGridView>
<asp:SqlDataSource ID="ProyectosDatos" runat="server" 
    ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
    InsertCommand="PROYECTOS_INSERTAR" InsertCommandType="StoredProcedure" 
    SelectCommand="PROYECTOS_CONSULTAR_COMPAÑIA" 
    SelectCommandType="StoredProcedure" UpdateCommand="PROYECTOS_MODIFICAR" 
    UpdateCommandType="StoredProcedure">
    <InsertParameters>
        <asp:Parameter Name="PROYECTO" Type="String" />
        <asp:Parameter Name="FECHA_INICIO" Type="DateTime" />
        <asp:Parameter Name="FECHA_VIGENCIA" Type="DateTime" />
        <asp:Parameter Name="MONTO_USD" Type="Decimal" />
        <asp:Parameter Name="MONTO_MXN" Type="Decimal" />
        <asp:Parameter Name="ID_COMPAÑIA" Type="Int32" />
        <asp:Parameter Name="ID_CLIENTE" Type="Int32" />
        <asp:Parameter Name="NUMERO" Type="String" />
    </InsertParameters>
    <SelectParameters>
        <asp:SessionParameter Name="ID_COMPAÑIA" SessionField="Compañia" Type="Int32" />
    </SelectParameters>
    <UpdateParameters>
        <asp:Parameter Name="ID_PROYECTO" Type="Int32" />
        <asp:Parameter Name="PROYECTO" Type="String" />
        <asp:Parameter Name="FECHA_INICIO" Type="DateTime" />
        <asp:Parameter Name="FECHA_VIGENCIA" Type="DateTime" />
        <asp:Parameter Name="MONTO_USD" Type="Decimal" />
        <asp:Parameter Name="MONTO_MXN" Type="Decimal" />
        <asp:Parameter Name="ID_COMPAÑIA" Type="Int32" />
        <asp:Parameter Name="ID_CLIENTE" Type="Int32" />
        <asp:Parameter Name="NUMERO" Type="String" />
    </UpdateParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="Clientes" runat="server" 
    ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
    SelectCommand="CLIENTES_CONSULTAR" SelectCommandType="StoredProcedure">
</asp:SqlDataSource>
</asp:Content>
