<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PruebaMail.aspx.cs" Inherits="SISGRES.PruebaMail" %>

<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <dx:ASPxMemo ID="txtDatos" runat="server" Height="71px" Width="170px">
        </dx:ASPxMemo>
        <br />
        <asp:Button ID="Button1" runat="server" Text="Button" OnClick="Button1_Click" />
    
    </div>
    </form>
</body>
</html>
