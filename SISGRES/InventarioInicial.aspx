<%@ Page Title="Inventario Inicial" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="InventarioInicial.aspx.cs" Inherits="SISGRES.InventarioInicial" %>

<%@ Register Assembly="DevExpress.Web.v14.2, Version=14.2.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="page-header">
                <h1>Inventario Inicial</h1>
            </div>
            <dx:ASPxGridView ID="grdInventarioInicial" runat="server" AutoGenerateColumns="False" DataSourceID="InventarioInicialDatos" EnableTheming="True" KeyboardSupport="True" KeyFieldName="ID_ITEM" Theme="Glass" Width="100%">
                <Columns>
                    <dx:GridViewCommandColumn ShowClearFilterButton="True" ShowEditButton="True" VisibleIndex="0">
                    </dx:GridViewCommandColumn>
                    <dx:GridViewDataTextColumn FieldName="ID_ITEM" ReadOnly="True" Visible="False" VisibleIndex="1">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn Caption="DESCRIPCIÓN" FieldName="DESCRIPCION" ReadOnly="True" VisibleIndex="2">
                        <EditFormSettings Visible="False" />
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn Caption="CANTIDAD" FieldName="CANTIDAD" VisibleIndex="3">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn Caption="COSTO UNITARIO" FieldName="COSTO_UNITARIO" VisibleIndex="4">
                        <propertiestextedit displayformatstring="C2">
                        </propertiestextedit>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn Caption="CAPTURO" FieldName="USUARIO" ReadOnly="True" VisibleIndex="5">
                        <EditFormSettings Visible="False" />
                    </dx:GridViewDataTextColumn>
                </Columns>
                <Settings ShowFilterRow="True" />
                <SettingsSearchPanel Visible="True" />
                <Styles>
                    <Header HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
                    </Header>
                    <Cell HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
                    </Cell>
                </Styles>
            </dx:ASPxGridView>
            <asp:SqlDataSource ID="InventarioInicialDatos" runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>" SelectCommand="INVENTARIO_INICIAL_ITEMS" SelectCommandType="StoredProcedure" UpdateCommand="INVENTARIO_INICIAL_EDITAR" UpdateCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:SessionParameter Name="ID_COMPAÑIA" SessionField="Compañia" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="ID_ITEM" Type="Int32" />
                    <asp:Parameter Name="CANTIDAD" Type="Decimal" />
                    <asp:Parameter Name="COSTO_UNITARIO" Type="Decimal" />
                    <asp:Parameter Name="USUARIO" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
