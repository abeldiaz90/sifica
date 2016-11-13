<%@ Page Title="FLUJO DE EFECTIVO" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="FlujoEfectivo.aspx.cs" Inherits="SISGRES.FlujoEfectivo" %>
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<%@ Register assembly="DevExpress.Web.ASPxScheduler.v14.2, Version=14.2.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxScheduler.Controls" tagprefix="dxwschsc" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <table style="width:100%;">
        <tr>
            <td>
                <dx:ASPxPopupControl ID="popupSaldoIniciales" runat="server" 
                    HeaderText="CAPTURA DE SALDOS INICIALES" Modal="True" 
                    PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" 
                    Theme="Youthful">
                    <ContentCollection>
<dx:PopupControlContentControl runat="server">
    <table style="width:100%;">
        <tr>
            <td>
                <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="SELECCIONE UNA CUENTA">
                </dx:ASPxLabel>
                <dx:ASPxComboBox ID="cboCuenta" runat="server" DataSourceID="CuentasBancarias">
                </dx:ASPxComboBox>
                <asp:SqlDataSource ID="CuentasBancarias" runat="server"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>
                <dx:ASPxLabel ID="ASPxLabel4" runat="server" Text="SALDO AL DIA DE HOY" 
                    Theme="Youthful">
                </dx:ASPxLabel>
                <dx:ASPxTextBox ID="txtSaldo" runat="server" Width="170px">
                </dx:ASPxTextBox>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
        </tr>
    </table>
                        </dx:PopupControlContentControl>
</ContentCollection>
                </dx:ASPxPopupControl>
                <br />
                <dxwschsc:MonthEdit ID="MonthEdit1" runat="server" Theme="Youthful">
                </dxwschsc:MonthEdit>
                <dx:ASPxButton ID="ASPxButton2" runat="server" onclick="ASPxButton2_Click" 
                    Text="ASPxButton" Theme="Youthful">
                </dx:ASPxButton>
            </td>
        </tr>
    </table>
    <br />
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" 
        Font-Size="8pt" InteractiveDeviceInfos="(Collection)" 
        SizeToReportContent="True" WaitMessageFont-Names="Verdana" 
        WaitMessageFont-Size="14pt" Width="100%">
        <LocalReport ReportPath="ReporteFlujoEfectivo.rdlc">
            <DataSources>
                <rsweb:ReportDataSource DataSourceId="ObjectDataSource1" Name="FlujoEfectivo" />
            </DataSources>
        </LocalReport>
    </rsweb:ReportViewer>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" 
        SelectMethod="GetData" 
        TypeName="SIFICA.FlujoEfectivoReporteTableAdapters.FLUJO_EFECTIVO_REPORTETableAdapter">
    </asp:ObjectDataSource>
</asp:Content>
