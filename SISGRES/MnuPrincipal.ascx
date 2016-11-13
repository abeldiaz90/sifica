<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MnuPrincipal.ascx.cs" Inherits="SISGRES.MnuPrincipal" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<dx:ASPxMenu ID="ASPxMenu1" runat="server" 
    BorderBetweenItemAndSubMenu="HideRootOnly" ClientIDMode="AutoID" 
    CssFilePath="~/App_Themes/Office2003Blue/{0}/styles.css" 
    CssPostfix="Office2003Blue" ShowPopOutImages="True" 
    SpriteCssFilePath="~/App_Themes/Office2003Blue/{0}/sprite.css">
    <LoadingPanelImage Url="~/App_Themes/Office2003Blue/Web/Loading.gif">
    </LoadingPanelImage>
    <ItemSubMenuOffset FirstItemX="2" LastItemX="2" X="2" />
    <ItemStyle HorizontalAlign="Left" />
    <SubMenuStyle GutterWidth="17px" />
</dx:ASPxMenu>

