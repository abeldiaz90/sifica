<%@ Page Title="CONTROL DE MOVIMIENTOS DE EFECTIVO" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Control.aspx.cs" Inherits="SISGRES.Control" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<%@ Register assembly="DevExpress.Web.ASPxScheduler.v14.2, Version=14.2.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxScheduler.Controls" tagprefix="dxwschsc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <table style="width:100%;" align="center">
        <tr>
            <td align="center">
                <table style="width:100%;">
                    <tr>
                        <td align="center" valign="middle">
                            &nbsp;</td>
                        <td align="center" valign="middle">
                            <dx:ASPxLabel ID="ASPxLabel4" runat="server" Font-Bold="True" 
                                Text="SELECCIONE LA CUENTA BANCARIA">
                            </dx:ASPxLabel>
                <dx:ASPxComboBox ID="cboCuenta" runat="server" 
                    AutoResizeWithContainer="True" DataSourceID="CuentasBancariasDatos" 
                    EnableTheming="True" HorizontalAlign="Center" 
                    IncrementalFilteringMode="Contains" 
                    onselectedindexchanged="cboCuenta_SelectedIndexChanged" TextField="CUENTA" 
                    TextFormatString="{2}" Theme="Youthful" ValueField="ID_CUENTA">
                    <Columns>
                        <dx:ListBoxColumn Caption="BANCO" FieldName="BANCO" />
                        <dx:ListBoxColumn Caption="MONEDA" FieldName="MONEDA" />
                        <dx:ListBoxColumn Caption="CUENTA" FieldName="CUENTA" />
                    </Columns>
                </dx:ASPxComboBox>
                <asp:SqlDataSource ID="CuentasBancariasDatos" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
                    SelectCommand="CUENTAS_BANCARIAS_CONSULTAR" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="ID_COMPAÑIA" SessionField="Compañia" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                            <dx:ASPxLabel ID="ASPxLabel3" runat="server" Font-Bold="True" 
                                Text="SELECCIONE EL MES">
                            </dx:ASPxLabel>
                            <dx:ASPxDateEdit ID="PeriodoFinal" runat="server" HorizontalAlign="Center" 
                                Theme="Youthful">
                            </dx:ASPxDateEdit>
                            <dx:ASPxButton ID="ASPxButton2" runat="server" HorizontalAlign="Center" 
                                onclick="ASPxButton2_Click" Text="Consultar" Theme="Youthful">
                                <Border BorderColor="Black" BorderStyle="Solid" BorderWidth="2px" />
                            </dx:ASPxButton>
                        </td>
                        <td align="center" valign="middle">
                            &nbsp;</td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <div align="center">
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%" 
            BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" 
            Font-Size="Medium" SizeToReportContent="True" ZoomMode="FullPage">
            <LocalReport EnableExternalImages="True" EnableHyperlinks="True">
            </LocalReport>
        </rsweb:ReportViewer>
    </div>

</asp:Content>
