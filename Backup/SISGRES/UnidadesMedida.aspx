<%@ Page Title="Unidades de Medida" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="UnidadesMedida.aspx.cs" Inherits="SISGRES.UnidadesMedida" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <dx:ASPxGridView ID="grdUnidadesMedida" runat="server" 
        AutoGenerateColumns="False" DataSourceID="UnidadesMedidaDatos" 
        EnableTheming="True" KeyFieldName="ID_UNIDAD" Theme="Youthful" 
        Width="100%" EnableCallbackAnimation="True" 
        EnablePagingCallbackAnimation="True">
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" ShowDeleteButton="True" 
                ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn Caption="CLAVE" FieldName="ID_UNIDAD" 
                ReadOnly="True" VisibleIndex="1">
                <editformsettings visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="UNIDAD" FieldName="UNIDAD" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="ABREVIATURA" FieldName="ABREVIATURA" 
                VisibleIndex="3">
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" 
            AllowSelectSingleRowOnly="True" />
        <SettingsPager Position="TopAndBottom">
        </SettingsPager>
        <settings showfilterrow="True" />
        <SettingsDataSecurity AllowDelete="False" />
        <styles>
            <cell horizontalalign="Center" verticalalign="Middle">
            </cell>
            <header horizontalalign="Center" verticalalign="Middle" wrap="True">
            </header>
        </styles>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="UnidadesMedidaDatos" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
        InsertCommand="UNIDADESMEDIDA_INSERTAR" InsertCommandType="StoredProcedure" 
        SelectCommand="UNIDADESMEDIDA_MOSTRAR_TODOS" 
        SelectCommandType="StoredProcedure" UpdateCommand="UNIDADESMEDIDA_MODIFICAR" 
        UpdateCommandType="StoredProcedure">
        <InsertParameters>
            <asp:Parameter Name="UNIDAD" Type="String" />
            <asp:Parameter Name="ABREVIATURA" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="ID_UNIDAD" Type="Int32" />
            <asp:Parameter Name="UNIDAD" Type="String" />
            <asp:Parameter Name="ABREVIATURA" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <br />
</asp:Content>
