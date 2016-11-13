<%@ Page Title="Solicitud de Cheques y Transferencias" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="SolicitudEgresos.aspx.cs" Inherits="SISGRES.SolicitudEgresos" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <table style="width:100%;">
        <tr>
            <td align="justify" valign="middle" width="150px">
                <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="FECHA DE SOLICITUD:" 
                    Theme="BlackGlass">
                </dx:ASPxLabel>
            </td>
            <td align="left" valign="middle">
                <dx:ASPxDateEdit ID="fechaSolicitud" runat="server" EditFormat="DateTime" 
                    Theme="BlackGlass">
                    <Border BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" />
                </dx:ASPxDateEdit>
            </td>
        </tr>
        <tr>
            <td width="150px">
                <dx:ASPxLabel ID="lblProyecto" runat="server" Text="PROYECTO:" 
                    Theme="BlackGlass">
                </dx:ASPxLabel>
            </td>
            <td>
                <dx:ASPxComboBox ID="cboProyecto" runat="server" AutoResizeWithContainer="True" 
                    DataSourceID="proyectos" EnableTheming="True" HorizontalAlign="Justify" 
                    IncrementalFilteringMode="Contains" NullText="Seleccione el Proyecto" 
                    TextField="PROYECTO" Theme="BlackGlass" ValueField="ID_PROYECTO" Width="100%">
                    <Border BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" />
                </dx:ASPxComboBox>
                <asp:SqlDataSource ID="proyectos" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
                    SelectCommand="PROYECTOS_CONSULTAR_COMPAÑIA" 
                    SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="ID_COMPAÑIA" SessionField="Compañia" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td width="150px">
                <dx:ASPxLabel ID="lblMoneda" runat="server" Text="MONEDA:" Theme="BlackGlass">
                </dx:ASPxLabel>
            </td>
            <td>
                <dx:ASPxComboBox ID="cboMoneda" runat="server" EnableTheming="True" 
                    NullText="Seleccione la Moneda" Theme="BlackGlass">
                    <Items>
                        <dx:ListEditItem Text="MXN" Value="1" />
                        <dx:ListEditItem Text="USD" Value="2" />
                    </Items>
                    <Border BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" />
                </dx:ASPxComboBox>
            </td>
        </tr>
        <tr>
            <td width="150px">
                <dx:ASPxLabel ID="ASPxLabel6" runat="server" Text="BENEFICIARIO:">
                </dx:ASPxLabel>
            </td>
            <td>
                <dx:ASPxComboBox ID="cboBeneficiario" runat="server" AnimationType="Fade" 
                    AutoResizeWithContainer="True" DataSourceID="Beneficiario" EnableTheming="True" 
                    HorizontalAlign="Justify" IncrementalFilteringMode="Contains" 
                    NullText="Seleccione un Beneficiario" TextField="BENEFICIARIO" 
                    Theme="BlackGlass" ValueField="BENEFICIARIO">
                    <Border BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" />
                </dx:ASPxComboBox>
                <asp:SqlDataSource ID="Beneficiario" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
                    SelectCommand="BENEFICIARIOS_CONSULTAR" SelectCommandType="StoredProcedure">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td width="150px">
                <dx:ASPxLabel ID="lblMonto" runat="server" Text="CANTIDAD:">
                </dx:ASPxLabel>
            </td>
            <td>
                <dx:ASPxTextBox ID="txtMonto" runat="server" Theme="BlackGlass" Width="170px" 
                    NullText="Ingrese la Cantidad">
                    <MaskSettings IncludeLiterals="DecimalSymbol" 
                        Mask="$&lt;0..999999999g&gt;.&lt;00..99&gt;" />
                    <Border BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" />
                </dx:ASPxTextBox>
            </td>
        </tr>
        <tr>
            <td width="150px">
                <dx:ASPxLabel ID="ASPxLabel5" runat="server" Text="CONCEPTO:" 
                    Theme="BlackGlass">
                </dx:ASPxLabel>
            </td>
            <td>
                <dx:ASPxComboBox ID="cboConcepto" runat="server" DataSourceID="ConceptosDatos" 
                    EnableTheming="True" HorizontalAlign="Center" 
                    IncrementalFilteringMode="Contains" NullText="Seleccione un Concepto" 
                    TextField="CONCEPTO" Theme="BlackGlass" ValueField="ID_CONCEPTO">
                </dx:ASPxComboBox>
                <asp:SqlDataSource ID="ConceptosDatos" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
                    SelectCommand="CONCEPTOS_CONSULTAR" SelectCommandType="StoredProcedure">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td width="150px">
                <dx:ASPxLabel ID="ASPxLabel7" runat="server" Text="OBSERVACIONES:" 
                    Theme="BlackGlass">
                </dx:ASPxLabel>
            </td>
            <td>
                <dx:ASPxMemo ID="txtObservaciones" runat="server" Height="71px" 
                    Theme="BlackGlass" Width="90%">
                </dx:ASPxMemo>
            </td>
        </tr>
        <tr>
            <td width="150px">
                &nbsp;</td>
            <td align="center">
                <dx:ASPxButton ID="ASPxButton2" runat="server" onclick="ASPxButton2_Click" 
                    Text="Generar Solicitud" Theme="BlackGlass">
                </dx:ASPxButton>
            </td>
        </tr>
    </table>
    <dx:ASPxPopupControl ID="popupDetalle" runat="server" 
        ClientInstanceName="popupDetalle" HeaderText="" Height="500px" Modal="True" 
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" 
        Theme="BlackGlass" Width="1000px">
        <ContentCollection>
<dx:PopupControlContentControl runat="server">
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" 
        Font-Size="8pt" InteractiveDeviceInfos="(Collection)" 
        WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="100%" 
        BackColor="#00CCFF" BorderStyle="Solid" BorderWidth="1px" Height="500px" 
        ZoomMode="PageWidth">
    </rsweb:ReportViewer>
            </dx:PopupControlContentControl>
</ContentCollection>
    </dx:ASPxPopupControl>
    <br />
</asp:Content>
