<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="SISGRES.Login" %>

<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>



<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>INICIO DE SESIÓN</title>
</head>
<body top-margin="0">
<form id="PnlSesion" runat="server">
    <div align="center">    
        <table align="center" cellpadding="0" cellspacing="0" width="100%" 
            style="height: 639px">
            <tr>
                <td align="center" valign="middle" bgcolor="#669999">
                    <asp:ScriptManager ID="ScriptManager1" runat="server">
                    </asp:ScriptManager>
                    <dx:ASPxRoundPanel ID="pnlInicioSesion" runat="server" 
                        AllowCollapsingByHeaderClick="True" Font-Size="Large" 
                        HeaderText="Inicio de Sesión" HorizontalAlign="Center" 
                        LoadContentViaCallback="True" ShowCollapseButton="true" Theme="Youthful" 
                        Width="400px">
                        <HeaderImage Url="~/Logos/Password.png">
                        </HeaderImage>
                        <PanelCollection>
<dx:PanelContent runat="server">
    <table style="width:100%;">
        <tr>
            <td>
                <dx:ASPxLabel ID="ASPxLabel1" runat="server" Font-Size="Large" Text="Usuario">
                </dx:ASPxLabel>
                <dx:ASPxTextBox ID="txtUsuario" runat="server" Font-Size="Large" 
                    HorizontalAlign="Center" Theme="Youthful" Width="100%">
                    <ValidationSettings ErrorTextPosition="Bottom" SetFocusOnError="True">
                        <RequiredField IsRequired="True" />
                    </ValidationSettings>
                </dx:ASPxTextBox>
                <asp:RoundedCornersExtender ID="txtUsuario_RoundedCornersExtender" 
                    runat="server" Enabled="True" TargetControlID="txtUsuario">
                </asp:RoundedCornersExtender>
            </td>
        </tr>
        <tr>
            <td>
                <dx:ASPxLabel ID="ASPxLabel2" runat="server" Font-Size="Large" 
                    Text="Contraseña">
                </dx:ASPxLabel>
                <dx:ASPxTextBox ID="txtPassword" runat="server" Font-Size="Large" 
                    HorizontalAlign="Center" Password="True" Theme="Youthful" Width="100%">
                    <ValidationSettings ErrorTextPosition="Bottom" SetFocusOnError="True">
                        <RequiredField IsRequired="True" />
                    </ValidationSettings>
                </dx:ASPxTextBox>
                <asp:RoundedCornersExtender ID="txtPassword_RoundedCornersExtender" 
                    runat="server" Enabled="True" TargetControlID="txtPassword">
                </asp:RoundedCornersExtender>
            </td>
        </tr>
        <tr>
            <td>
                <dx:ASPxButton ID="btnIniciarSesion" runat="server" Font-Size="Large" 
                    HorizontalAlign="Center" OnClick="btnIniciarSesion_Click" Text="Iniciar Sesión" 
                    Theme="Youthful">
                </dx:ASPxButton>
                <br />
                <dx:ASPxLabel ID="lblError" runat="server">
                </dx:ASPxLabel>
            </td>
        </tr>
    </table>
                            </dx:PanelContent>
</PanelCollection>
                    </dx:ASPxRoundPanel>
                </td>
                <td>
                    &nbsp;</td>
            </tr>
            </table>
    
    </div>
    </form>
    </form>
    </form>
</body>
</html>
