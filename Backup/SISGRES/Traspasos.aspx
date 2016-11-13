<%@ Page Title="Traspasos Bancarios" Language="C#" MasterPageFile="~/Principal.Master"
    AutoEventWireup="true" CodeBehind="Traspasos.aspx.cs" Inherits="SISGRES.Traspasos" %>

<%@ Register Assembly="DevExpress.Web.v14.2, Version=14.2.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dx" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .style1
        {
            height: 68px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table style="width: 100%;">
                <tr align="center" valign="top">
                    <td align="center" valign="top">
                        <dx:ASPxRoundPanel ID="pnlTransferencia" runat="server" 
                            HeaderText="TRANSFERENCIAS" HorizontalAlign="Center" ShowCollapseButton="true" 
                            Theme="BlackGlass" Width="90%">
                            <panelcollection>
                                <dx:PanelContent runat="server">
                                    <dx:ASPxLabel ID="ASPxLabel25" runat="server" Text="FECHA DE TRANSFERENCIA">
                                    </dx:ASPxLabel>
                                    <dx:ASPxDateEdit ID="fechTransferencia" runat="server" Font-Size="Medium" 
                                        HorizontalAlign="Center" Theme="BlackGlass">
                                    </dx:ASPxDateEdit>
                                    <dx:ASPxLabel ID="ASPxLabel11" runat="server" Text="IMPORTE A TRANSFERIR:">
                                    </dx:ASPxLabel>
                                    <dx:ASPxTextBox ID="txtImporteTransferido" runat="server" AutoPostBack="True" 
                                        AutoResizeWithContainer="True" Font-Size="Medium" HorizontalAlign="Center" 
                                        NullText="Ingrese el monto a transferir" 
                                        OnTextChanged="txtImporteTransferido_TextChanged" Theme="BlackGlass" 
                                        Width="70%">
                                <MaskSettings IncludeLiterals="DecimalSymbol" 
                                    Mask="$&lt;0..9999999999g&gt;.&lt;00..99&gt;" />
                                        <validationsettings errortextposition="Bottom" setfocusonerror="True" 
                                            validationgroup="Transferir">
                                    <RequiredField IsRequired="True" />
                                        </validationsettings>
                                    </dx:ASPxTextBox>
                                    <dx:ASPxLabel ID="ASPxLabel12" runat="server" Text="MONEDA ORIGEN">
                                    </dx:ASPxLabel>
                                    <dx:ASPxComboBox ID="cboMonedaOrigen" runat="server" AutoPostBack="True" 
                                        AutoResizeWithContainer="True" Font-Size="Medium" HorizontalAlign="Center" 
                                        NullText="Seleccione la Moneda de Origen" 
                                        OnSelectedIndexChanged="cboMoneda_SelectedIndexChanged" Theme="BlackGlass" 
                                        Width="70%">
                                        <Items>
                                            <dx:ListEditItem Text="MXN" Value="MXN" />
                                            <dx:ListEditItem Text="USD" Value="USD" />
                                        </Items>
                                        <validationsettings errortextposition="Bottom" setfocusonerror="True" 
                                            validationgroup="Transferir">
                                    <RequiredField IsRequired="True" />
                                        </validationsettings>
                                    </dx:ASPxComboBox>
                                    <dx:ASPxLabel ID="ASPxLabel15" runat="server" Text="MONEDA DESTINO">
                                    </dx:ASPxLabel>
                                    <dx:ASPxComboBox ID="cboMonedaDestino" runat="server" AutoPostBack="True" 
                                        AutoResizeWithContainer="True" Font-Size="Medium" HorizontalAlign="Center" 
                                        NullText="Seleccione la Moneda de Destino" 
                                        OnSelectedIndexChanged="cboMonedaDestino_SelectedIndexChanged" 
                                        Theme="BlackGlass" Width="70%">
                                        <Items>
                                            <dx:ListEditItem Text="MXN" Value="MXN" />
                                            <dx:ListEditItem Text="USD" Value="USD" />
                                        </Items>
                                        <validationsettings errortextposition="Bottom" setfocusonerror="True" 
                                            validationgroup="Transferir">
                                    <RequiredField IsRequired="True" />
                                        </validationsettings>
                                    </dx:ASPxComboBox>
                                    <dx:ASPxLabel ID="lblTipoCambio" runat="server" Text="TIPO DE CAMBIO:" 
                                        Visible="False">
                                    </dx:ASPxLabel>
                                    <dx:ASPxComboBox ID="cboTipoCambio" runat="server" AutoPostBack="True" 
                                        AutoResizeWithContainer="True" EnableTheming="True" Font-Size="Medium" 
                                        HorizontalAlign="Center" IncrementalFilteringMode="Contains" 
                                        NullText="Seleccione el tipo de cambio" 
                                        OnSelectedIndexChanged="cboTipoCambio_SelectedIndexChanged" Theme="BlackGlass" 
                                        Visible="False" Width="70%">
                                        <Columns>
                                            <dx:ListBoxColumn Caption="FECHA" FieldName="FECHA" />
                                            <dx:ListBoxColumn Caption="IMPORTE VENTA" FieldName="IMPORTE_VENTA" />
                                            <dx:ListBoxColumn Caption="IMPORTE COMPRA" FieldName="IMPORTE_COMPRA" />
                                        </Columns>
                                        <validationsettings errortextposition="Bottom" setfocusonerror="True" 
                                            validationgroup="Transferir">
                                    <RequiredField IsRequired="True" />
                                        </validationsettings>
                                    </dx:ASPxComboBox>
                                    <dx:ASPxLabel ID="ASPxLabel13" runat="server" Text="IMPORTE MONEDA ORIGEN" 
                                        Theme="BlackGlass">
                                    </dx:ASPxLabel>
                                    <dx:ASPxTextBox ID="txtTotalMonedaOrigen" runat="server" Font-Size="Medium" 
                                        HorizontalAlign="Center" Theme="BlackGlass" Width="70%">
                                <MaskSettings IncludeLiterals="DecimalSymbol" 
                                    Mask="$&lt;0..999999999999999g&gt;.&lt;00..99&gt;" />
                                        <validationsettings errortextposition="Bottom" setfocusonerror="True" 
                                            validationgroup="Transferir">
                                    <RequiredField IsRequired="True" />
                                        </validationsettings>
                                    </dx:ASPxTextBox>
                                    <dx:ASPxLabel ID="ASPxLabel14" runat="server" Text="IMPORTE MONEDA DESTINO" 
                                        Theme="BlackGlass">
                                    </dx:ASPxLabel>
                                    <dx:ASPxTextBox ID="txtTotalMonedaDestino" runat="server" Font-Size="Medium" 
                                        HorizontalAlign="Center" Theme="BlackGlass" Width="70%">
                                <MaskSettings IncludeLiterals="DecimalSymbol" 
                                    Mask="$&lt;0..9999999999999g&gt;.&lt;00..99&gt;" />
                                        <validationsettings errortextposition="Bottom" setfocusonerror="True" 
                                            validationgroup="Transferir">
                                    <RequiredField IsRequired="True" />
                                        </validationsettings>
                                    </dx:ASPxTextBox>
                                    <dx:ASPxLabel ID="ASPxLabel24" runat="server" Text="FOLIO DE OPERACION:">
                                    </dx:ASPxLabel>
                                    <dx:ASPxTextBox ID="txtFolioTransaccion" runat="server" Font-Size="Medium" 
                                        HorizontalAlign="Center" Theme="BlackGlass" Width="70%">
                                        <validationsettings errortextposition="Bottom" setfocusonerror="True">
                                    <RequiredField IsRequired="True" />
                                        </validationsettings>
                                    </dx:ASPxTextBox>
                                </dx:PanelContent>
                            </panelcollection>
                        </dx:ASPxRoundPanel>
                    </td>
                    <td align="center" colspan="2" valign="top">
                        <table style="width:100%;">
                            <tr>
                                <td>
                                    <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" 
                                        HeaderText="CUENTA ORIGEN" Height="235px" HorizontalAlign="Center" 
                                        ShowCollapseButton="True" ShowDefaultImages="False" Theme="BlackGlass" 
                                        Width="90%">
                                        <panelcollection>
                                            <dx:PanelContent runat="server">
                                                <dx:ASPxComboBox ID="cboCuentaOrigen" runat="server" AutoPostBack="True" 
                                                    AutoResizeWithContainer="True" DataSourceID="CuentasBancarias" 
                                                    EnableTheming="True" HorizontalAlign="Center" 
                                                    IncrementalFilteringMode="Contains" NullText="Seleccione la Cuenta de Origen" 
                                                    OnSelectedIndexChanged="cboCuentaOrigen_SelectedIndexChanged" 
                                                    TextField="CUENTA" Theme="BlackGlass" ValueField="ID_CUENTA">
                                                    <validationsettings errortextposition="Bottom" setfocusonerror="True" 
                                                        validationgroup="Transferir">
                                                        <RequiredField IsRequired="True" />
                                                    </validationsettings>
                                                </dx:ASPxComboBox>
                                                <asp:SqlDataSource ID="CuentasBancarias" runat="server" 
                                                    ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
                                                    SelectCommand="CUENTAS_BANCARIAS_CONSULTAR" SelectCommandType="StoredProcedure">
                                                    <SelectParameters>
                                                        <asp:SessionParameter Name="ID_COMPAÑIA" SessionField="Compañia" Type="Int32" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                                <dx:ASPxLabel ID="ASPxLabel17" runat="server" Text="BANCO" Theme="BlackGlass">
                                                </dx:ASPxLabel>
                                                <dx:ASPxTextBox ID="txtBancoOrigen" runat="server" 
                                                    AutoResizeWithContainer="True" Font-Bold="True" HorizontalAlign="Center" 
                                                    ReadOnly="True" Width="170px">
                                                    <validationsettings errortextposition="Bottom">
                                                    </validationsettings>
                                                    <readonlystyle backcolor="#CCCCCC">
                                                    </readonlystyle>
                                                    <border bordercolor="Black" borderstyle="Solid" borderwidth="1px"></border>
                                                </dx:ASPxTextBox>
                                                <dx:ASPxLabel ID="ASPxLabel18" runat="server" Text="MONEDA">
                                                </dx:ASPxLabel>
                                                <dx:ASPxTextBox ID="txtMoneda" runat="server" AutoResizeWithContainer="True" 
                                                    Font-Bold="True" HorizontalAlign="Center" ReadOnly="True" Width="170px">
                                                    <validationsettings errortextposition="Bottom">
                                                    </validationsettings>
                                                    <readonlystyle backcolor="#CCCCCC">
                                                    </readonlystyle>
                                                    <border bordercolor="Black" borderstyle="Solid" borderwidth="1px"></border>
                                                </dx:ASPxTextBox>
                                                <dx:ASPxLabel ID="ASPxLabel19" runat="server" Text="SALDO ACTUAL" 
                                                    Theme="BlackGlass">
                                                </dx:ASPxLabel>
                                                <dx:ASPxSpinEdit ID="txtSaldoActual" runat="server" DisplayFormatString="c2" 
                                                    HorizontalAlign="Center" Number="0" ReadOnly="True">
                                                    <readonlystyle backcolor="#CCCCCC">
                                                    </readonlystyle>
                                                </dx:ASPxSpinEdit>
                                            </dx:PanelContent>
                                        </panelcollection>
                                    </dx:ASPxRoundPanel>
                                </td>
                                <td>
                                    <dx:ASPxRoundPanel ID="ASPxRoundPanel2" runat="server" 
                                        HeaderText="CUENTA DESTINO" Height="235px" HorizontalAlign="Center" 
                                        ShowCollapseButton="True" ShowDefaultImages="False" Theme="BlackGlass" 
                                        Width="90%">
                                        <panelcollection>
                                            <dx:PanelContent runat="server">
                                                <dx:ASPxComboBox ID="cboCuentaDestino" runat="server" AutoPostBack="True" 
                                                    AutoResizeWithContainer="True" DataSourceID="CuentasBancariasDestinos" 
                                                    HorizontalAlign="Center" IncrementalFilteringMode="Contains" 
                                                    NullText="Seleccione la Cuenta Destino" 
                                                    OnSelectedIndexChanged="cboCuentaDestino_SelectedIndexChanged" 
                                                    TextField="CUENTA" Theme="BlackGlass" ValueField="ID_CUENTA">
                                                    <validationsettings errortextposition="Bottom" setfocusonerror="True" 
                                                        validationgroup="Transferir">
                                                        <RequiredField IsRequired="True" />
                                                    </validationsettings>
                                                </dx:ASPxComboBox>
                                                <asp:SqlDataSource ID="CuentasBancariasDestinos" runat="server" 
                                                    ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
                                                    SelectCommand="CUENTAS_BANCARIAS_CONSULTAR" SelectCommandType="StoredProcedure">
                                                    <SelectParameters>
                                                        <asp:SessionParameter Name="ID_COMPAÑIA" SessionField="Compañia" Type="Int32" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                                <dx:ASPxLabel ID="ASPxLabel21" runat="server" Text="BANCO" Theme="BlackGlass">
                                                </dx:ASPxLabel>
                                                <dx:ASPxTextBox ID="txtBancoDestino" runat="server" 
                                                    AutoResizeWithContainer="True" Font-Bold="True" HorizontalAlign="Center" 
                                                    ReadOnly="True" Width="170px">
                                                    <validationsettings errortextposition="Bottom">
                                                    </validationsettings>
                                                    <readonlystyle backcolor="#CCCCCC">
                                                    </readonlystyle>
                                                    <border bordercolor="Black" borderstyle="Solid" borderwidth="1px"></border>
                                                </dx:ASPxTextBox>
                                                <dx:ASPxLabel ID="ASPxLabel22" runat="server" Text="MONEDA">
                                                </dx:ASPxLabel>
                                                <dx:ASPxTextBox ID="txtMonedaDestino" runat="server" 
                                                    AutoResizeWithContainer="True" Font-Bold="True" HorizontalAlign="Center" 
                                                    ReadOnly="True" Width="170px">
                                                    <validationsettings errortextposition="Bottom">
                                                    </validationsettings>
                                                    <readonlystyle backcolor="#CCCCCC">
                                                    </readonlystyle>
                                                    <border bordercolor="Black" borderstyle="Solid" borderwidth="1px"></border>
                                                </dx:ASPxTextBox>
                                                <dx:ASPxLabel ID="ASPxLabel23" runat="server" Text="SALDO ACTUAL" 
                                                    Theme="BlackGlass">
                                                </dx:ASPxLabel>
                                                <dx:ASPxSpinEdit ID="txtSaldoDestino" runat="server" DisplayFormatString="c2" 
                                                    HorizontalAlign="Center" Number="0" ReadOnly="True">
                                                    <readonlystyle backcolor="#CCCCCC">
                                                    </readonlystyle>
                                                </dx:ASPxSpinEdit>
                                            </dx:PanelContent>
                                        </panelcollection>
                                    </dx:ASPxRoundPanel>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <dx:ASPxLabel ID="ASPxLabel26" runat="server" Text="Observaciones:">
                                    </dx:ASPxLabel>
                                    <dx:ASPxMemo ID="txtObservaciones" runat="server" Height="71px" 
                                        Theme="BlackGlass" Width="90%">
                                    </dx:ASPxMemo>
                                    <dx:ASPxButton ID="ASPxButton2" runat="server" OnClick="ASPxButton2_Click" 
                                        Text="Transferir" Theme="BlackGlass" ValidationGroup="Transferir">
                                    </dx:ASPxButton>
                                    <asp:UpdateProgress ID="UpdateProgress1" runat="server" 
                                        AssociatedUpdatePanelID="UpdatePanel1">
                                        <progresstemplate>
                                            <asp:Image ID="Image2" runat="server" ImageAlign="Middle" 
                                                ImageUrl="~/Logos/22.gif" />
                                        </progresstemplate>
                                    </asp:UpdateProgress>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr align="center" valign="top">
                    <td align="center" valign="top">
                        &nbsp;</td>
                    <td align="center" colspan="2" valign="top">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td align="center" class="style1" colspan="2" valign="middle">
                        <dx:ASPxPopupControl ID="popupMensajeria" runat="server" HeaderText="" 
                            PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" 
                            Theme="BlackGlass">
                            <contentcollection>
                                <dx:PopupControlContentControl runat="server">
                                    <dx:ASPxLabel ID="lblMensaje" runat="server" Theme="BlackGlass">
                                    </dx:ASPxLabel>
                                </dx:PopupControlContentControl>
                            </contentcollection>
                        </dx:ASPxPopupControl>
                    </td>
                    <td align="center" class="style1" valign="middle">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="2" valign="middle">
                        <dx:ASPxButton ID="btnTransferir" runat="server" OnClick="btnTransferir_Click" 
                            Text="Transferir" Theme="BlackGlass" Visible="False">
                        </dx:ASPxButton>
                    </td>
                    <td align="center" valign="middle">
                        &nbsp;
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
    <br />
</asp:Content>
