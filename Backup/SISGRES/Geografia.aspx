<%@ Page Title="Datos Geograficos" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Geografia.aspx.cs" Inherits="SISGRES.Geografia" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<%@ Register assembly="DevExpress.Web.ASPxTreeList.v14.2, Version=14.2.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxTreeList" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <dx:ASPxTreeList ID="ASPxTreeList1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="Id" 
        ParentFieldName="ParentId" PreviewFieldName="Name" Theme="Youthful" 
        Width="100%" KeyboardSupport="True" EnableCallbackAnimation="True" 
        EnablePagingCallbackAnimation="True">
        <Columns>
            <dx:TreeListTextColumn FieldName="Name" VisibleIndex="0">
            </dx:TreeListTextColumn>
            <dx:TreeListCommandColumn ShowNewButtonInHeader="True" VisibleIndex="1" 
                Width="100px">
                <EditButton Visible="True">
                </EditButton>
                <NewButton Visible="True">
                </NewButton>
                <DeleteButton Visible="True">
                </DeleteButton>
            </dx:TreeListCommandColumn>
        </Columns>
        <SettingsBehavior AllowFocusedNode="True" />
        <SettingsPager Mode="ShowPager">
        </SettingsPager>
        <SettingsSelection Enabled="True" />
        <SettingsEditing AllowNodeDragDrop="True" />
    </dx:ASPxTreeList>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
        InsertCommand="GEOGRAFIA_INSERTAR" InsertCommandType="StoredProcedure" 
        SelectCommand="GEOGRAFIA_MOSTRAR_TODO" SelectCommandType="StoredProcedure" 
        UpdateCommand="GEOGRAFIA_MODIFICAR" 
    UpdateCommandType="StoredProcedure" DeleteCommand="GEOGRAFIA_ELIMINAR" 
    DeleteCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
            <asp:Parameter Name="Name" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="ParentId" Type="Int32" />
            <asp:Parameter Name="Name" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Id" Type="Int32" />
            <asp:Parameter Name="Name" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
