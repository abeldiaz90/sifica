<%@ Page Title="Clasificiones" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Clasificaciones.aspx.cs" Inherits="SISGRES.Clasificaciones" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="CLASIFICACIONESDATOS" KeyFieldName="ID_CLASIFICACION">
        <Columns>
            <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="ID_CLASIFICACION" ReadOnly="True" Visible="False" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CLASIFICACION" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataCheckColumn FieldName="ESTADO" VisibleIndex="3">
            </dx:GridViewDataCheckColumn>
        </Columns>
        <SettingsSearchPanel Visible="True" />
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="CLASIFICACIONESDATOS" runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>" DeleteCommand="CLASIFICACIONES_ELIMINAR" DeleteCommandType="StoredProcedure" InsertCommand="CLASIFICACIONES_INSERTAR" InsertCommandType="StoredProcedure" SelectCommand="CLASIFICACIONES_CONSULTAR_TODAS" SelectCommandType="StoredProcedure" UpdateCommand="CLASIFICACIONES_MODIFICAR" UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="ID_CLASIFICACION" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="CLASIFICACION" Type="String" />
            <asp:Parameter Name="ESTADO" Type="Boolean" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="ID_CLASIFICACION" Type="Int32" />
            <asp:Parameter Name="CLASIFICACION" Type="String" />
            <asp:Parameter Name="ESTADO" Type="Boolean" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
