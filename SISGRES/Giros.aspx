<%@ Page Title="Giros empresariales" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Giros.aspx.cs" Inherits="SISGRES.Giros" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <dx:ASPxGridView ID="grdGirosEmpresariales" runat="server" 
    AutoGenerateColumns="False" ClientInstanceName="grdGirosEmpresariales" 
    DataSourceID="GIROSDATOS" EnableTheming="True" KeyFieldName="ID_GIRO" 
    Theme="Youthful" Width="100%">

<Settings ShowFilterRow="True" ShowGroupPanel="True"></Settings>

    <Columns>
        <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" 
            ShowNewButtonInHeader="True" VisibleIndex="0">
        </dx:GridViewCommandColumn>
        <dx:GridViewDataTextColumn Caption="CLAVE" FieldName="ID_GIRO" ReadOnly="True" 
            VisibleIndex="1">
            <EditFormSettings Visible="False" />
<EditFormSettings Visible="False"></EditFormSettings>
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn Caption="GIROS COMERCIALES" FieldName="GIRO" 
            VisibleIndex="2">
            <Settings AutoFilterCondition="Contains" />
        </dx:GridViewDataTextColumn>
    </Columns>
        <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" 
            AllowSelectSingleRowOnly="True" />
    <Settings ShowFilterRow="True" ShowGroupPanel="True" />

    <Styles>
        <Cell HorizontalAlign="Center" VerticalAlign="Middle">
        </Cell>
        <Header HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
        </Header>
    </Styles>
</dx:ASPxGridView>
<asp:SqlDataSource ID="GIROSDATOS" runat="server" 
    ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
    InsertCommand="GIROS_INSERTAR" InsertCommandType="StoredProcedure" 
    SelectCommand="GIROS_MOSTRAR_TODOS" SelectCommandType="StoredProcedure" 
    UpdateCommand="GIROS_MODIFICAR" UpdateCommandType="StoredProcedure">
    <InsertParameters>
        <asp:Parameter Name="GIRO" Type="String" />
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name="ID_GIRO" Type="Int32" />
        <asp:Parameter Name="GIRO" Type="String" />
    </UpdateParameters>
</asp:SqlDataSource>
</asp:Content>
