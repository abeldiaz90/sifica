<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Kardex.aspx.cs" Inherits="SISGRES.Kardex" %>

<%@ Register Assembly="DevExpress.Web.v14.2, Version=14.2.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Historia de ITEMS</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <dx:ASPxGridView ID="grdHistoria" runat="server"></dx:ASPxGridView>
    </div>
    </form>
</body>
</html>
