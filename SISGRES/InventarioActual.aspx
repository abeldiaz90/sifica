<%@ Page Title="Inventario actual" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="InventarioActual.aspx.cs" Inherits="SISGRES.InventarioActual" %>

<%@ Register Assembly="DevExpress.Web.v14.2, Version=14.2.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <div class="page-header">
        <h1>Inventario Actual</h1>
    </div>
    <dx:ASPxGridView ID="grdInventarioActual" runat="server" AutoGenerateColumns="False" DataSourceID="InventarioActualDatos" EnableTheming="True" Theme="Office2003Blue" Width="100%" KeyFieldName="ID_ITEM" EnableCallbackAnimation="True" EnablePagingCallbackAnimation="True">
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0" Visible="False">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="ID_ITEM" ReadOnly="True" Visible="False" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="ITEM" FieldName="DESCRIPCION" ReadOnly="True" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataHyperLinkColumn Caption="CANTIDAD" FieldName="CANTIDAD" ReadOnly="True" VisibleIndex="3" Width="100px">
                <PropertiesHyperLinkEdit NavigateUrlFormatString="/Kardex.aspx?ID_ITEM={0}" Target="_blank">
                </PropertiesHyperLinkEdit>
                <CellStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
                </CellStyle>
            </dx:GridViewDataHyperLinkColumn>
        </Columns>
        <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" />
        <Settings ShowFilterRow="True" ShowGroupPanel="True" />
        <SettingsSearchPanel Visible="True" />
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="InventarioActualDatos" runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>" SelectCommand="INVENTARIO_ACTUAL" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
</asp:Content>
