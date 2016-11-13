<%@ Page Title="Centro de Costos" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="CentroCostos.aspx.cs" Inherits="SISGRES.CentroCostos" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <dx:ASPxGridView ID="grdCentroCostos" runat="server" AutoGenerateColumns="False" DataSourceID="CENTROCOSTODATOS" KeyFieldName="ID" Width="100%">
        <Columns>
            <dx:GridViewCommandColumn ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" VisibleIndex="1" Visible="False">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CODIGO" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="DESCRIPCION" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataCheckColumn FieldName="ESTADO" VisibleIndex="4">
            </dx:GridViewDataCheckColumn>
            <dx:GridViewDataTextColumn FieldName="ID_COMPAÑIA" VisibleIndex="5" Visible="False">
            </dx:GridViewDataTextColumn>
        </Columns>
        <Settings ShowGroupPanel="True" ShowFilterRow="True" />
        <SettingsSearchPanel Visible="True" />
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="CENTROCOSTODATOS" runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>" DeleteCommand="ABONOS_CONSULTAR" DeleteCommandType="StoredProcedure" InsertCommand="CENTRO_COSTOS_INSERTAR" InsertCommandType="StoredProcedure" SelectCommand="CENTRO_COSTOS_CONSULTAR_TODOS" SelectCommandType="StoredProcedure" UpdateCommand="CENTRO_COSTOS_MODIFICAR" UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="NUM_FACTURA" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="CODIGO" Type="String" />
            <asp:Parameter Name="DESCRIPCION" Type="String" />
            <asp:Parameter Name="ESTADO" Type="Boolean" />
            <asp:SessionParameter Name="ID_COMPAÑIA" SessionField="Compañia" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:SessionParameter Name="ID_COMPAÑIA" SessionField="Compañia" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="ID" Type="Int32" />
            <asp:Parameter Name="CODIGO" Type="String" />
            <asp:Parameter Name="DESCRIPCION" Type="String" />
            <asp:Parameter Name="ESTADO" Type="Boolean" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
