<%@ Page Title="Aprobacion de solicitudes de Egreso" Language="C#" MasterPageFile="~/Principal.Master"
    AutoEventWireup="true" CodeBehind="AprobacionSolicitudesEgreso.aspx.cs" Inherits="SISGRES.AprobacionSolicitudesEgreso" %>

<%@ Register Assembly="DevExpress.Web.v14.2, Version=14.2.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dx" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">

            <table style="width: 100%;">
                <tr>
                    <td align="center" valign="middle">
                        <dx:ASPxLabel ID="ASPxLabel3" runat="server" Style="font-weight: 700" Text="NUMERO DE SOLICITUD DE CHEQUE O TRANSFERENCIA">
                        </dx:ASPxLabel>
                        <dx:ASPxComboBox ID="cbosolicitudCheque" runat="server" AnimationType="Slide" AutoPostBack="True"
                            AutoResizeWithContainer="True" DataSourceID="DatosBeneficiarios" EnableTheming="True"
                            HorizontalAlign="Center" IncrementalFilteringMode="Contains" OnSelectedIndexChanged="cbosolicitudCheque_SelectedIndexChanged"
                            TextField="CONCEPTO" TextFormatString="{0}" Theme="Youthful" ValueField="ID_EGRESO"
                            PopupHorizontalAlign="Center">
                            <Columns>
                                <dx:ListBoxColumn Caption="FOLIO" FieldName="ID_EGRESO" />
                                <dx:ListBoxColumn Caption="SOLICITANTE" FieldName="SOLICITANTE" />
                                <dx:ListBoxColumn Caption="CONCEPTO" FieldName="CONCEPTO" />
                                <dx:ListBoxColumn FieldName="IMPORTE" />
                                <dx:ListBoxColumn Caption="MONEDA" FieldName="MONEDA" />
                            </Columns>
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True" />
                            <ListBoxStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
                            </ListBoxStyle>
                            <CaptionSettings HorizontalAlign="Center" Position="Top" VerticalAlign="Middle" />
                            <RootStyle VerticalAlign="Middle" Wrap="True">
                            </RootStyle>
                        </dx:ASPxComboBox>
                        <asp:SqlDataSource ID="DatosBeneficiarios" runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>"
                            SelectCommand="EGRESOS_PENDIENTES_APROBACION" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:SessionParameter Name="ID_COMPAÑIA" SessionField="Compañia" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <dx:ASPxButton ID="ASPxButton2" runat="server" EnableTheming="True" 
                            onclick="ASPxButton2_Click3" Text="Historico" Theme="Youthful">
                            <ClientSideEvents Click="function(s, e) {

}" />
                        </dx:ASPxButton>
                        <dx:ASPxPopupControl ID="popupSolicitudes" runat="server" 
                            ClientInstanceName="popupSolicitudes" HeaderText="HISTORICO DE SOLICITUDES" 
                            Modal="True" PopupHorizontalAlign="WindowCenter" 
                            PopupVerticalAlign="WindowCenter" ShowMaximizeButton="True" Theme="Youthful" 
                            Width="100%">
                            <contentcollection>
                                <dx:PopupControlContentControl runat="server">
                                    <asp:SqlDataSource ID="HistoricoSolicitudes" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
                                        SelectCommand="EGRESO_OBTENER_DATOS_TODOS" SelectCommandType="StoredProcedure">
                                    </asp:SqlDataSource>
                                    <dx:ASPxGridView ID="grdSolicitudes" runat="server" AutoGenerateColumns="False" 
                                        DataSourceID="HistoricoSolicitudes" EnableTheming="True" 
                                        KeyFieldName="ID_EGRESO" Theme="Youthful" Visible="False">
                                        <Columns>
                                            <dx:GridViewCommandColumn ShowClearFilterButton="True" 
                                                ShowInCustomizationForm="True" VisibleIndex="0">
                                            </dx:GridViewCommandColumn>
                                            <dx:GridViewDataTextColumn Caption="FOLIO" FieldName="ID_EGRESO" 
                                                ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="2">
                                                <EditFormSettings Visible="False" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="IMPORTE MXN" FieldName="IMPORTE" 
                                                ShowInCustomizationForm="True" VisibleIndex="5">
                                                <propertiestextedit displayformatstring="c2">
                </propertiestextedit>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="MONEDA" FieldName="MONEDA" 
                                                ShowInCustomizationForm="True" VisibleIndex="7">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="CONCEPTO" FieldName="CONCEPTO" 
                                                ShowInCustomizationForm="True" VisibleIndex="8">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="TIPO" ShowInCustomizationForm="True" 
                                                Visible="False" VisibleIndex="14">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="FOLIO" ShowInCustomizationForm="True" 
                                                Visible="False" VisibleIndex="15">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataDateColumn FieldName="FECHA_CREACION" 
                                                ShowInCustomizationForm="True" Visible="False" VisibleIndex="16">
                                            </dx:GridViewDataDateColumn>
                                            <dx:GridViewDataDateColumn Caption="FECHA DE OPERACION" 
                                                FieldName="FECHA_OPERACION" ShowInCustomizationForm="True" VisibleIndex="10">
                                            </dx:GridViewDataDateColumn>
                                            <dx:GridViewDataTextColumn FieldName="SOLICITANTE" 
                                                ShowInCustomizationForm="True" Visible="False" VisibleIndex="4">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="AUTORIZADOR" 
                                                ShowInCustomizationForm="True" Visible="False" VisibleIndex="17">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="RECIBIDO_POR" 
                                                ShowInCustomizationForm="True" Visible="False" VisibleIndex="18">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="BENEFICIARIO" FieldName="BENEFICIARIO" 
                                                ShowInCustomizationForm="True" VisibleIndex="9">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="ID_COMPAÑIA" 
                                                ShowInCustomizationForm="True" Visible="False" VisibleIndex="19">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="IMPORTE USD" FieldName="IMPORTE_USD" 
                                                ShowInCustomizationForm="True" VisibleIndex="6">
                                                <propertiestextedit displayformatstring="c2">
                </propertiestextedit>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="ESTADO" ShowInCustomizationForm="True" 
                                                Visible="False" VisibleIndex="20">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="ID_PROYECTO" 
                                                ShowInCustomizationForm="True" Visible="False" VisibleIndex="21">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="ID_CUENTA" ShowInCustomizationForm="True" 
                                                Visible="False" VisibleIndex="22">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="ID_CUENTA_DESTINO" 
                                                ShowInCustomizationForm="True" Visible="False" VisibleIndex="23">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="SOLICITANTE" FieldName="NOMBRESOLICITANTE" 
                                                ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="3">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="NOMBREAUTORIZADOR" ReadOnly="True" 
                                                ShowInCustomizationForm="True" Visible="False" VisibleIndex="24">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="NOMBRERECIBIDOPOR" ReadOnly="True" 
                                                ShowInCustomizationForm="True" Visible="False" VisibleIndex="25">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="OBSERVACIONES" 
                                                ShowInCustomizationForm="True" VisibleIndex="13">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataDateColumn FieldName="FECHA_PAGO" 
                                                ShowInCustomizationForm="True" VisibleIndex="11">
                                            </dx:GridViewDataDateColumn>
                                            <dx:GridViewDataTextColumn FieldName="STATUS" ReadOnly="True" 
                                                ShowInCustomizationForm="True" VisibleIndex="12">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn ShowInCustomizationForm="True" VisibleIndex="1">
                                                <EditFormSettings Visible="False" />
                                                <dataitemtemplate>
                                                    <asp:ImageButton ID="imgReporte" runat="server" Height="32px" 
                                                        ImageUrl="~/Logos/Imprimir.png" onclick="imgReporte_Click2" 
                                                        onclientclick="popupSolicitudes.Show();" ToolTip="Cancelar" />
                                                </dataitemtemplate>
                                            </dx:GridViewDataTextColumn>
                                        </Columns>
                                        <SettingsBehavior AllowFocusedRow="True" />
                                        <Settings ShowFilterRow="True" />
                                        <styles>
                                            <cell horizontalalign="Center" verticalalign="Middle" wrap="True">
                                            </cell>
                                        </styles>
                                    </dx:ASPxGridView>
                                </dx:PopupControlContentControl>
                            </contentcollection>
                        </dx:ASPxPopupControl>
                        <dx:ASPxPopupControl ID="popupDetalle" runat="server" 
                            ClientInstanceName="popupDetalle" HeaderText="" Height="500px" Modal="True" 
                            PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" 
                            Theme="BlackGlass" Width="1000px">
                            <contentcollection>
                                <dx:PopupControlContentControl runat="server">
                                    <rsweb:ReportViewer ID="ReportViewer1" runat="server" BackColor="#00CCFF" 
                                        BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="8pt" 
                                        Height="500px" InteractiveDeviceInfos="(Collection)" 
                                        WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="100%" 
                                        ZoomMode="PageWidth">
                                    </rsweb:ReportViewer>
                                </dx:PopupControlContentControl>
                            </contentcollection>
                        </dx:ASPxPopupControl>
                        <br />
                        <dx:ASPxRoundPanel ID="pnlSolicitudes" runat="server" ShowCollapseButton="true" ShowHeader="False"
                            Visible="False" Width="100%" Theme="Youthful">
                            <PanelCollection>
                                <dx:PanelContent runat="server">
                                    <table style="width: 100%;">
                                        <tr>
                                            <td align="justify" valign="middle" width="150px">
                                                <dx:ASPxLabel ID="ASPxLabel7" runat="server" Text="FECHA DE SOLICITUD:" Theme="BlackGlass">
                                                </dx:ASPxLabel>
                                            </td>
                                            <td align="left" valign="middle">
                                                <dx:ASPxDateEdit ID="fechaSolicitud" runat="server" Theme="Youthful" ReadOnly="True">
                                                    <ReadOnlyStyle BackColor="#CCCCCC">
                                                    </ReadOnlyStyle>
                                                    <FocusedStyle HorizontalAlign="Center">
                                                    </FocusedStyle>
                                                    <Border BorderStyle="Solid" BorderColor="Black" BorderWidth="1px" />
                                                </dx:ASPxDateEdit>
                                            </td>
                                            <td align="left" style="text-align: right" valign="middle">
                                                <dx:ASPxLabel ID="ASPxLabel12" runat="server" Text="FECHA DE PAGO:" Theme="BlackGlass">
                                                </dx:ASPxLabel>
                                            </td>
                                            <td align="left" valign="middle">
                                                <dx:ASPxDateEdit ID="fechaPago" runat="server" Theme="Youthful">
                                                    <ReadOnlyStyle BackColor="#CCCCCC">
                                                    </ReadOnlyStyle>
                                                    <FocusedStyle HorizontalAlign="Center">
                                                    </FocusedStyle>
                                                    <Border BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" />
                                                </dx:ASPxDateEdit>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="150px" align="justify">
                                                <dx:ASPxLabel ID="lblProyecto" runat="server" Text="PROYECTO:" Theme="BlackGlass">
                                                </dx:ASPxLabel>
                                            </td>
                                            <td colspan="3">
                                                <dx:ASPxComboBox ID="cboProyecto" runat="server" AutoResizeWithContainer="True" DataSourceID="proyectos"
                                                    EnableTheming="True" HorizontalAlign="Justify" IncrementalFilteringMode="Contains"
                                                    NullText="Seleccione el Proyecto" TextField="PROYECTO" Theme="Youthful" ValueField="ID_PROYECTO"
                                                    Width="100%" ReadOnly="True">
                                                    <ReadOnlyStyle BackColor="#CCCCCC">
                                                    </ReadOnlyStyle>
                                                    <FocusedStyle HorizontalAlign="Center">
                                                    </FocusedStyle>
                                                    <Border BorderStyle="Solid" BorderColor="Black" BorderWidth="1px" />
                                                </dx:ASPxComboBox>
                                                <asp:SqlDataSource ID="proyectos" runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>"
                                                    SelectCommand="SELECT 0 AS ID_PROYECTO,'NO APLICA PROYECTO' AS PROYECTO
	UNION
	SELECT ID_PROYECTO,PROYECTO FROM PROYECTOS WHERE ID_COMPAÑIA=@ID_COMPAÑIA">
                                                    <SelectParameters>
                                                        <asp:SessionParameter Name="ID_COMPAÑIA" SessionField="Compañia" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="150px" align="justify">
                                                <dx:ASPxLabel ID="lblMoneda" runat="server" Text="MONEDA:" Theme="BlackGlass">
                                                </dx:ASPxLabel>
                                            </td>
                                            <td align="justify" colspan="3">
                                                <dx:ASPxComboBox ID="cboMoneda" runat="server" EnableTheming="True" NullText="Seleccione la Moneda"
                                                    Theme="Youthful" ReadOnly="True" Width="70%">
                                                    <Items>
                                                        <dx:ListEditItem Text="MXN" Value="MXN" />
                                                        <dx:ListEditItem Text="USD" Value="USD" />
                                                    </Items>
                                                    <ReadOnlyStyle BackColor="#CCCCCC">
                                                    </ReadOnlyStyle>
                                                    <FocusedStyle HorizontalAlign="Center">
                                                    </FocusedStyle>
                                                    <Border BorderStyle="Solid" BorderColor="Black" BorderWidth="1px" />
                                                </dx:ASPxComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="150px" align="justify">
                                                <dx:ASPxLabel ID="ASPxLabel6" runat="server" Text="BENEFICIARIO:">
                                                </dx:ASPxLabel>
                                            </td>
                                            <td align="justify" colspan="3">
                                                <dx:ASPxComboBox ID="cboBeneficiario" runat="server" AnimationType="Fade" AutoResizeWithContainer="True"
                                                    DataSourceID="Beneficiario" EnableTheming="True" HorizontalAlign="Justify" IncrementalFilteringMode="Contains"
                                                    NullText="Seleccione un Beneficiario" TextField="BENEFICIARIO" Theme="Youthful"
                                                    ValueField="BENEFICIARIO" ReadOnly="True" Width="70%">
                                                    <ReadOnlyStyle BackColor="#CCCCCC">
                                                    </ReadOnlyStyle>
                                                    <FocusedStyle HorizontalAlign="Center">
                                                    </FocusedStyle>
                                                    <Border BorderStyle="Solid" BorderColor="Black" BorderWidth="1px" />
                                                </dx:ASPxComboBox>
                                                <asp:SqlDataSource ID="Beneficiario" runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>"
                                                    SelectCommand="BENEFICIARIOS_CONSULTAR" SelectCommandType="StoredProcedure">
                                                </asp:SqlDataSource>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="150px" align="justify">
                                                <dx:ASPxLabel ID="lblMonto" runat="server" Text="CANTIDAD:">
                                                </dx:ASPxLabel>
                                            </td>
                                            <td align="justify" colspan="3">
                                                <dx:ASPxTextBox ID="txtMonto" runat="server" Theme="Youthful" Width="70%" ReadOnly="True">
                                                    <MaskSettings IncludeLiterals="DecimalSymbol" Mask="$&lt;0..999999999g&gt;.&lt;00..99&gt;" />
                                                    <ReadOnlyStyle BackColor="#CCCCCC">
                                                    </ReadOnlyStyle>
                                                    <FocusedStyle HorizontalAlign="Center">
                                                    </FocusedStyle>
                                                    <Border BorderStyle="Solid" BorderColor="Black" BorderWidth="1px" />
                                                </dx:ASPxTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="150px" align="justify">
                                                <dx:ASPxLabel ID="ASPxLabel5" runat="server" Text="CONCEPTO:" Theme="BlackGlass">
                                                </dx:ASPxLabel>
                                            </td>
                                            <td colspan="3" align="left">
                                                <dx:ASPxComboBox ID="cboConcepto" runat="server" DataSourceID="ConceptosDatos" EnableTheming="True"
                                                    HorizontalAlign="Center" IncrementalFilteringMode="Contains" NullText="Seleccione un Concepto"
                                                    ReadOnly="True" TextField="CONCEPTO" Theme="Youthful" ValueField="ID_CONCEPTO"
                                                    Width="70%">
                                                    <ReadOnlyStyle BackColor="#CCCCCC">
                                                    </ReadOnlyStyle>
                                                </dx:ASPxComboBox>
                                                <asp:SqlDataSource ID="ConceptosDatos" runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>"
                                                    SelectCommand="CONCEPTOS_CONSULTAR" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="150px" align="justify">
                                                <dx:ASPxLabel ID="ASPxLabel10" runat="server" Text="STATUS" Theme="BlackGlass">
                                                </dx:ASPxLabel>
                                            </td>
                                            <td align="center" colspan="3">
                                                <dx:ASPxRadioButtonList ID="cboEstado" runat="server" AutoPostBack="True" EnableTheming="True"
                                                    OnSelectedIndexChanged="cboEstado_SelectedIndexChanged" RepeatDirection="Horizontal"
                                                    Theme="Youthful">
                                                    <Items>
                                                        <dx:ListEditItem Text="APROBADO" Value="1" />
                                                        <dx:ListEditItem Text="RECHAZADO" Value="2" />
                                                    </Items>
                                                    <FocusedStyle BackColor="Yellow">
                                                    </FocusedStyle>
                                                </dx:ASPxRadioButtonList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="justify" width="150px">
                                                <asp:ImageButton ID="imgEditar" runat="server" Height="32px" ImageUrl="~/Imagenes/1395205168_edit.png"
                                                    OnClick="imgEditar_Click" />
                                                <asp:ImageButton ID="imgGuardar" runat="server" Height="32px" ImageUrl="~/Imagenes/1395205972_save.png"
                                                    OnClick="imgGuardar_Click" Visible="False" />
                                                <asp:ImageButton ID="imgCancelar" runat="server" Height="32px" ImageUrl="~/Imagenes/1395206036_cancel.png"
                                                    OnClick="imgCancelar_Click" ToolTip="Cancelar" Visible="False" />
                                            </td>
                                            <td align="center" colspan="3">
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="justify" width="150px">
                                                &nbsp;
                                            </td>
                                            <td align="center">
                                                <dx:ASPxLabel ID="ASPxLabel11" runat="server" Text="CUENTA BANCARIA">
                                                </dx:ASPxLabel>
                                                <dx:ASPxComboBox ID="cboCuentaBancaria" runat="server" DataSourceID="CuentaBancaria"
                                                    EnableTheming="True" HorizontalAlign="Center" IncrementalFilteringMode="Contains"
                                                    ReadOnly="True" TextField="CUENTA" TextFormatString="{0}" Theme="Youthful" ValueField="ID_CUENTA">
                                                    <Columns>
                                                        <dx:ListBoxColumn Caption="CUENTA" FieldName="CUENTA" />
                                                        <dx:ListBoxColumn Caption="BANCO" FieldName="BANCO" />
                                                        <dx:ListBoxColumn Caption="MONEDA" FieldName="MONEDA" />
                                                    </Columns>
                                                    <ReadOnlyStyle BackColor="#CCCCCC">
                                                    </ReadOnlyStyle>
                                                    <FocusedStyle BackColor="Yellow">
                                                    </FocusedStyle>
                                                </dx:ASPxComboBox>
                                            </td>
                                            <td align="center">
                                                <dx:ASPxLabel ID="ASPxLabel8" runat="server" Text="TIPO DE TRANSACCION:">
                                                </dx:ASPxLabel>
                                                <dx:ASPxComboBox ID="cboTipoTransaccion" runat="server" AutoPostBack="True" AutoResizeWithContainer="True"
                                                    ClientInstanceName="cboTipoTransaccion" EnableTheming="True" HorizontalAlign="Center"
                                                    OnSelectedIndexChanged="cboTipoTransaccion_SelectedIndexChanged" ReadOnly="True"
                                                    Theme="Youthful">
                                                    <Items>
                                                        <dx:ListEditItem Text="CHEQUE" Value="1" />
                                                        <dx:ListEditItem Text="TRANSFERENCIA" Value="2" />
                                                    </Items>
                                                    <ReadOnlyStyle BackColor="#CCCCCC">
                                                    </ReadOnlyStyle>
                                                    <FocusedStyle BackColor="Yellow">
                                                    </FocusedStyle>
                                                </dx:ASPxComboBox>
                                            </td>
                                            <td align="center">
                                                <dx:ASPxLabel ID="ASPxLabel9" runat="server">
                                                </dx:ASPxLabel>
                                                <dx:ASPxTextBox ID="txtFolioTransaccion" runat="server" AutoResizeWithContainer="True"
                                                    HorizontalAlign="Center" ReadOnly="True" Width="170px" Theme="Youthful">
                                                    <ReadOnlyStyle BackColor="#CCCCCC">
                                                    </ReadOnlyStyle>
                                                    <FocusedStyle BackColor="Yellow">
                                                    </FocusedStyle>
                                                </dx:ASPxTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="150px" align="justify">
                                                &nbsp;
                                            </td>
                                            <td align="center" colspan="3">
                                                <asp:SqlDataSource ID="CuentaBancaria" runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>"
                                                    SelectCommand="CUENTAS_BANCARIAS_CONSULTAR" SelectCommandType="StoredProcedure">
                                                    <SelectParameters>
                                                        <asp:SessionParameter Name="ID_COMPAÑIA" SessionField="Compañia" Type="Int32" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                                <dx:ASPxButton ID="btnGuardar" runat="server" HorizontalAlign="Center" OnClick="btnGuardar_Click"
                                                    Text="GUARDAR" Theme="Youthful" ValidationGroup="Validar" VerticalAlign="Middle"
                                                    EnableTheming="True">
                                                </dx:ASPxButton>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="justify" colspan="4" width="150px">
                                              
                                            </td>
                                        </tr>
                                    </table>
                                </dx:PanelContent>
                            </PanelCollection>
                        </dx:ASPxRoundPanel>
 
    </td>
    </tr> </table>
</asp:Content>
