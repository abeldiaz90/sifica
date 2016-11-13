<%@ Page Title="Fondo del sistema" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Fondo.aspx.cs" Inherits="SISGRES.Fondo" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <dx:ASPxUploadControl ID="ASPxUploadControl1" runat="server" FileUploadMode="OnPageLoad" OnFileUploadComplete="ASPxUploadControl1_FileUploadComplete" ShowProgressPanel="True" ShowUploadButton="True" UploadMode="Auto" Width="100%">
        <AdvancedModeSettings EnableDragAndDrop="True">
        </AdvancedModeSettings>
    </dx:ASPxUploadControl>
</asp:Content>
