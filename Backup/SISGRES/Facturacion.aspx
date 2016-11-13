<%@ Page Title="Facturación" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Facturacion.aspx.cs" Inherits="SISGRES.Facturacion" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
 <dx:ASPxGridView ID="grdCobranza" runat="server" AutoGenerateColumns="False" 
        DataSourceID="CobranzaDatos" EnableTheming="True" KeyFieldName="ID_PRODUCCION" 
        Theme="Moderno" Width="100%" EnableCallbackAnimation="True" 
        EnablePagingCallbackAnimation="True">
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0" 
                ShowEditButton="True">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="ID_PRODUCCION" ReadOnly="True" 
                VisibleIndex="1">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="FECHA" VisibleIndex="2">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="NOMBRE" ReadOnly="True" VisibleIndex="3">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CLIENTE" VisibleIndex="4">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="SUBTOTAL" ReadOnly="True" 
                VisibleIndex="5">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="IVA" ReadOnly="True" VisibleIndex="6">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="TOTAL" ReadOnly="True" VisibleIndex="7">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="NUM_FACTURA" 
                VisibleIndex="8">
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" 
            AllowSelectSingleRowOnly="True" ConfirmDelete="True" />
        <Settings ShowFilterRow="True" ShowGroupPanel="True" />
        <Styles>
            <Cell HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </Cell>
        </Styles>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="CobranzaDatos" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
        SelectCommand="FACTURACION_CONSULTAR" SelectCommandType="StoredProcedure" 
        UpdateCommand="FACTURACION_MODIFICAR" UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter Name="ID_PRODUCCION" Type="Int32" />
            <asp:Parameter Name="NUM_FACTURA" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

</asp:Content>
