<%@ Page Title="Reporte de Flujo de Efectivo" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="FlujoEfectivoReporte.aspx.cs" Inherits="SISGRES.ReportePronosticoVentas" %><%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<%@ Register assembly="DevExpress.Web.ASPxScheduler.v14.2, Version=14.2.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxScheduler.Controls" tagprefix="dxwschsc" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.ASPxScheduler.v14.2, Version=14.2.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxScheduler" tagprefix="dxwschs" %>
<%@ Register assembly="DevExpress.XtraScheduler.v14.2.Core, Version=14.2.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.XtraScheduler" tagprefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <table style="width:100%;">
        <tr>
            <td align="center" valign="top">
                <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="PERIODO INICIAL">
                </dx:ASPxLabel>
                <dx:ASPxDateEdit ID="fechaInicial" runat="server" 
                    AutoResizeWithContainer="True" HorizontalAlign="Center" Theme="Youthful">
                    <ValidationSettings ErrorTextPosition="Bottom" SetFocusOnError="True" 
                        ValidationGroup="GENERARREPORTE">
                        <RequiredField IsRequired="True" />
                    </ValidationSettings>
                </dx:ASPxDateEdit>
            </td>
            <td align="center" valign="top">
                <dx:ASPxLabel ID="ASPxLabel6" runat="server" Text="PERIODO INICIAL">
                </dx:ASPxLabel>
                <dx:ASPxDateEdit ID="fechaFinal" runat="server" AutoResizeWithContainer="True" 
                    HorizontalAlign="Center" Theme="Youthful">
                    <ValidationSettings ErrorTextPosition="Bottom" SetFocusOnError="True" 
                        ValidationGroup="GENERARREPORTE">
                        <RequiredField IsRequired="True" />
                    </ValidationSettings>
                </dx:ASPxDateEdit>
            </td>
            <td align="center" valign="top">
                <dx:ASPxLabel ID="ASPxLabel4" runat="server" Text="AÑO">
                </dx:ASPxLabel>
                <dx:ASPxComboBox ID="cboAño" runat="server" EnableTheming="True" 
                    HorizontalAlign="Center" IncrementalFilteringMode="Contains" 
                    Theme="Youthful" AutoResizeWithContainer="True">
                    <Items>
                        <dx:ListEditItem Text="2014" Value="2014" />
                        <dx:ListEditItem Text="2015" Value="2015" />
                        <dx:ListEditItem Text="2016" Value="2016" />
                    </Items>
                    <ValidationSettings ErrorTextPosition="Bottom" SetFocusOnError="True" 
                        ValidationGroup="GENERARREPORTE">
                        <RequiredField IsRequired="True" />
                    </ValidationSettings>
                </dx:ASPxComboBox>
            </td>
            <td align="center" valign="top">
                <dx:ASPxLabel ID="ASPxLabel5" runat="server" Text="CUENTA BANCARIA">
                </dx:ASPxLabel>
                <dx:ASPxComboBox ID="cboCuenta" runat="server" DataSourceID="CuentasBancarias" 
                    EnableTheming="True" HorizontalAlign="Center" 
                    IncrementalFilteringMode="Contains" 
                    onselectedindexchanged="ASPxComboBox2_SelectedIndexChanged" TextField="CUENTA" 
                    Theme="Youthful" ValueField="ID_CUENTA" AutoResizeWithContainer="True">
                    <ValidationSettings ErrorTextPosition="Bottom" SetFocusOnError="True" 
                        ValidationGroup="GENERARREPORTE">
                        <RequiredField IsRequired="True" />
                    </ValidationSettings>
                </dx:ASPxComboBox>
                <asp:SqlDataSource ID="CuentasBancarias" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
                    SelectCommand="CUENTAS_BANCARIAS_CONSULTAR" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="ID_COMPAÑIA" SessionField="Compañia" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td align="center" colspan="4">
                <dx:ASPxButton ID="btnGenerar" runat="server" onclick="btnGenerar_Click" 
                    Text="GENERAR REPORTE" Theme="Youthful" ValidationGroup="GENERARREPORTE">
                </dx:ASPxButton>
            </td>
        </tr>
    </table>
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" 
        Font-Size="8pt" InteractiveDeviceInfos="(Collection)" 
        SizeToReportContent="True" WaitMessageFont-Names="Verdana" 
        WaitMessageFont-Size="14pt" Width="100%" BorderStyle="Solid" 
        BorderWidth="1px" ZoomMode="PageWidth">
        <LocalReport EnableExternalImages="True" EnableHyperlinks="True" ReportPath="">
            <DataSources>
                <rsweb:ReportDataSource DataSourceId="ObjectDataSource1" 
                    Name="PronosticoVentas" />
            </DataSources>
        </LocalReport>
    </rsweb:ReportViewer>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" 
        SelectMethod="GetData" 
        TypeName="SIFICA.PronosticoVentasTableAdapters.PRONOSTICO_VENTAS_REPORTETableAdapter">
    </asp:ObjectDataSource>
</asp:Content>
