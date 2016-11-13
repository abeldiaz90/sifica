<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="SISGRES.Login" %>

<%@ Register Assembly="DevExpress.Web.v14.2, Version=14.2.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>INICIO DE SESIÓN</title>
    <link rel="stylesheet" href="Scripts/bootstrap.min.css">
    <link rel="stylesheet" href="dist/css/bootstrapValidator.css" />

    <script type="text/javascript" src="Scripts/jquery-2.1.4.min.js"></script>
    <script type="text/javascript" src="Scripts/bootstrap.min.js"></script>
    <script type="text/javascript" src="dist/js/bootstrapValidator.js"></script>
    <style type="text/css">
        body {
            /*background: url('http://www.wallpaperup.com/uploads/wallpapers/2012/10/21/20181/cad2441dd3252cf53f12154412286ba0.jpg');*/
            background: url(../Fondo/Fondo.jpg) no-repeat;
            background-size: cover;
            padding: 50px;
        }
    </style>
</head>
<body top-margin="0">

    <%--  <form id="PnlSesion" runat="server">
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
                                    <table style="width: 100%;">
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
                    <td>&nbsp;</td>
                </tr>
            </table>

        </div>
    </form>--%>
    <div class="container">
        <div class="row">
            <div class="col-sm-6 col-md-4 col-md-offset-4">
                <h1 class="text-center login-title">Inicio de Sesion</h1>
                <div class="account-wall">
                    <img class="profile-img" src="https://lh5.googleusercontent.com/-b0-k99FZlyE/AAAAAAAAAAI/AAAAAAAAAAA/eu7opA4byxI/photo.jpg?sz=120"
                        alt="">
                    <form class="form-signin" runat="server">

                        <input type="text" class="form-control" placeholder="Usuario" required autofocus runat="server" id="txtUsuario" name="txtUsuario">
                        <input type="password" class="form-control" placeholder="Contraseña" required runat="server" id="txtPassword" name="txtPassword">
                        <button class="btn btn-lg btn-primary btn-block" type="submit" runat="server" onserverclick="btnIniciarSesion_Click">
                            Sign in</button>
                        <%--  <label class="checkbox pull-left">
                            <input type="checkbox" value="remember-me">
                            Remember me
                        </label>--%>
                        <a href="#" class="pull-right need-help">Need help? </a><span class="clearfix"></span>
                    </form>
                </div>
                <a href="#" class="text-center new-account">Create an account </a>
            </div>
        </div>
    </div>
</body>

</html>
