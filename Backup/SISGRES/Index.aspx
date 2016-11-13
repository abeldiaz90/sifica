<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="SISGRES.Index" %>

<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>




<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>MINERALES DEL MAYAB S.A DE C.V</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <dx:ASPxPageControl ID="ASPxPageControl1" runat="server" ActiveTabIndex="0" 
            EnableTheming="True" TabAlign="Justify" Theme="MetropolisBlue" Width="100%">
            <TabPages>
                <dx:TabPage Text="Inicio">
                    <ContentCollection>
                        <dx:ContentControl runat="server">
                            <dx:ASPxNewsControl ID="ASPxNewsControl1" runat="server" Width="100%">
                            </dx:ASPxNewsControl>
                        </dx:ContentControl>
                    </ContentCollection>
                </dx:TabPage>
                <dx:TabPage Text="Clientes">
                    <ContentCollection>
                        <dx:ContentControl runat="server">
                        </dx:ContentControl>
                    </ContentCollection>
                </dx:TabPage>
                <dx:TabPage Text="Servicios que Ofrecemos">
                    <ContentCollection>
                        <dx:ContentControl runat="server">
                        </dx:ContentControl>
                    </ContentCollection>
                </dx:TabPage>
                <dx:TabPage Text="Contactenos">
                    <ContentCollection>
                        <dx:ContentControl runat="server">
                        </dx:ContentControl>
                    </ContentCollection>
                </dx:TabPage>
                <dx:TabPage Text="Galeria Fotografica">
                    <ContentCollection>
                        <dx:ContentControl runat="server">
                        </dx:ContentControl>
                    </ContentCollection>
                </dx:TabPage>
                <dx:TabPage Text="Intranet">
                    <ContentCollection>
                        <dx:ContentControl runat="server">
                            <dx:ASPxHyperLink ID="ASPxHyperLink1" runat="server" NavigateUrl="~/Login.aspx" 
                                Text="SIFICA" Theme="Moderno">
                            </dx:ASPxHyperLink>
                        </dx:ContentControl>
                    </ContentCollection>
                </dx:TabPage>
            </TabPages>
        </dx:ASPxPageControl>
    
    </div>
    </form>
</body>
</html>
