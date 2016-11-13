<%@ Page Title="Requisiciones" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Request.aspx.cs" Inherits="SISGRES.Request" %>

<%@ Register Assembly="DevExpress.Web.v14.2, Version=14.2.12.0, Culture=neutral, PublicKeyToken=B88D1754D700E49A"
    Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <div class="row">
        <div class="col-md-4">
            <button class="btn btn-primary" type="button">
                Consecutivo de Folio: <span class="badge">
                    <dx:ASPxLabel ID="lblConsecutivo" runat="server" Text=""></dx:ASPxLabel>
                </span>
            </button>
        </div>
        <div class="col-md-4"></div>
        <div class="col-md-4">
            <dx:ASPxButton ID="btnMisRequisiciones" runat="server" Text="Mis Requisiciones" CssClass="btn btn-primary" AutoPostBack="False" OnClick="btnMisRequisiciones_Click">
                <ClientSideEvents Click="function(s, e) {
}" />
            </dx:ASPxButton>
        </div>
    </div>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Requisiciones</h3>
                </div>
                <div class="panel-body">
                    <script type="text/javascript">
                        Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(BeginRequestHandler);
                        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
                        function BeginRequestHandler(sender, args) {
                            lp.Show();
                        }
                        function EndRequestHandler(sender, args) {
                            lp.Hide();
                        }

                        function EnvioRequisicion() {
                            $('#EnvioRequisicion').modal({
                                show: true

                            });
                        }

                        function CierreEnvio() {
                            $('#EnvioRequisicion').modal({
                                show: false,
                                keyboard: true
                            });
                        }


                        function popupAddItemOpen() {
                            $('#popupAddItem').modal({
                                show: true
                                //backdrop: 'static'
                            });
                        }

                        function popupAddItemClose() {
                            $('#popupAddItem').modal({
                                show: false
                            });
                        }

                    </script>
                    <div class="row">
                        <div class="col-md-4">
                            <label for="cboCtroCosto">Seleccione el centro de Costos</label>
                            <dx:ASPxComboBox ID="cboCtroCosto" runat="server" DataSourceID="CentroCostos" TextField="DESCRIPCION" ValueField="ID" Theme="Glass" Width="50%">
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True" />
                                <ValidationSettings ErrorTextPosition="Bottom" SetFocusOnError="True" ValidationGroup="Envio">
                                    <RequiredField IsRequired="True" />
                                </ValidationSettings>
                            </dx:ASPxComboBox>
                            <asp:SqlDataSource ID="CentroCostos" runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>" SelectCommand="CENTRO_COSTOS_CONSULTAR_ACTIVOS" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                        </div>
                        <div class="col-md-4">
                            <label for="txtItem">Escriba y seleccione el Item</label>
                            <asp:TextBox ID="txtItem" runat="server" BorderStyle="Solid" CssClass="form-control" Font-Names="Trebuchet MS" Font-Size="Large" TabIndex="1" AutoCompleteType="Disabled" AutoComplete="off"></asp:TextBox>
                            <asp:AutoCompleteExtender ID="txtItem_AutoCompleteExtender" runat="server"
                                CompletionInterval="1"
                                Enabled="True" MinimumPrefixLength="1"
                                EnableCaching="true" CompletionSetCount="1"
                                DelimiterCharacters="" ShowOnlyCurrentWordInCompletionListItem="true"
                                ServiceMethod="BusquedaItems" ServicePath="~/ServicioWeb.asmx"
                                TargetControlID="txtItem">
                            </asp:AutoCompleteExtender>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                BorderStyle="Solid" ControlToValidate="txtItem" Display="None"
                                ErrorMessage="Capture y Seleccione el Material" Font-Bold="True"
                                ForeColor="Red" SetFocusOnError="True" ValidationGroup="Agregar"></asp:RequiredFieldValidator>
                            <asp:ValidatorCalloutExtender ID="RequiredFieldValidator1_ValidatorCalloutExtender"
                                runat="server" Enabled="True" PopupPosition="BottomRight"
                                TargetControlID="RequiredFieldValidator1">
                            </asp:ValidatorCalloutExtender>
                        </div>
                        <div class="col-md-4">
                            <label for="txtCantidad">Ingrese la Cantidad</label>
                            <dx:ASPxTextBox ID="txtCantidad" runat="server" CssClass="form-control" Font-Size="Small" HorizontalAlign="Center" Theme="BlackGlass" Width="170px">
                                <MaskSettings Mask="&lt;0..99999999g&gt;.&lt;00..99&gt;" />
                                <CaptionSettings HorizontalAlign="Center" Position="Top" VerticalAlign="Middle" />
                                <ValidationSettings ErrorTextPosition="Bottom" SetFocusOnError="True" ValidationGroup="Agregar">
                                    <RequiredField IsRequired="True" />
                                </ValidationSettings>
                                <FocusedStyle BackColor="YellowGreen">
                                </FocusedStyle>
                            </dx:ASPxTextBox>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <dx:ASPxTextBox ID="txtPrecioUnitario" runat="server" Caption="Precio Unitario:" CssClass="form-control" Font-Size="Small" HorizontalAlign="Center" Theme="BlackGlass" Width="170px">
                                <MaskSettings Mask="$&lt;0..9999999999g&gt;.&lt;00..99&gt;" IncludeLiterals="DecimalSymbol" />
                                <CaptionSettings HorizontalAlign="Center" Position="Top" VerticalAlign="Middle" />
                                <ValidationSettings ErrorTextPosition="Bottom" SetFocusOnError="True" ValidationGroup="Agregar">
                                    <RequiredField IsRequired="True" />
                                </ValidationSettings>
                                <FocusedStyle BackColor="YellowGreen">
                                </FocusedStyle>
                            </dx:ASPxTextBox>
                        </div>
                        <div class="col-md-4">
                            <asp:LinkButton ID="Agregar" runat="server" Class="button btn-success" CssClass="btn btn-success" OnClick="Agregar_Click">Agregar</asp:LinkButton>
                        </div>
                    </div>
                    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False"
                        EnableTheming="True" Font-Size="Small" KeyFieldName="ID_PARTIDA"
                        OnAfterPerformCallback="ASPxGridView1_AfterPerformCallback" Theme="Glass"
                        Width="100%">
                        <TotalSummary>
                            <dx:ASPxSummaryItem DisplayFormat="C2" FieldName="IMPORTE" ShowInColumn="IMPORTE" ShowInGroupFooterColumn="IMPORTE" SummaryType="Sum" Tag="Total:" ValueDisplayFormat="C2" />
                        </TotalSummary>
                        <Columns>
                            <dx:GridViewCommandColumn ShowClearFilterButton="True" ShowInCustomizationForm="True" Visible="False" VisibleIndex="0" Width="1px">
                            </dx:GridViewCommandColumn>
                            <dx:GridViewDataTextColumn Caption="PARTIDA" FieldName="ID_PARTIDA"
                                ShowInCustomizationForm="True" VisibleIndex="2" Visible="False" Name="ID_PARTIDA">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn Caption="CLAVE DEL MATERIAL" FieldName="ID_ITEM"
                                ShowInCustomizationForm="True" VisibleIndex="4" Visible="False" Name="ID_ITEM">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn Caption="DESCRIPCIÓN" FieldName="DESCRIPCION"
                                ShowInCustomizationForm="True" VisibleIndex="8" Name="DESCRIPCION">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn Caption="CANTIDAD" FieldName="CANTIDAD"
                                ShowInCustomizationForm="True" VisibleIndex="6" Width="100px" Name="CANTIDAD">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn ShowInCustomizationForm="True" VisibleIndex="1" Width="230px">
                                <DataItemTemplate>
                                    <asp:LinkButton ID="lnkModificar" runat="server" OnClick="lnkModificar_Click" CssClass="btn btn-primary" ForeColor="White">Modificar</asp:LinkButton>
                                    &nbsp;<asp:LinkButton ID="lnkEliminar" runat="server" OnClick="lnkEliminar_Click" CssClass="btn btn-danger" ForeColor="White">Eliminar</asp:LinkButton>
                                </DataItemTemplate>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn Caption="NUMERO DE PARTE" FieldName="NUMBER_PART"
                                ShowInCustomizationForm="True" VisibleIndex="5" Visible="False" Name="NUMBER_PART">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataComboBoxColumn Caption="UNIDAD DE MEDIDA" FieldName="UNIDAD"
                                ShowInCustomizationForm="True" VisibleIndex="7" Width="100px" Name="UNIDAD">
                                <PropertiesComboBox DataSourceID="UNIDAD" IncrementalFilteringMode="Contains"
                                    TextField="UNIDAD" ValueField="ID_UNIDAD">
                                </PropertiesComboBox>
                            </dx:GridViewDataComboBoxColumn>
                            <dx:GridViewDataTextColumn Caption="CONTEO" FieldName="CONTEO" ShowInCustomizationForm="True" VisibleIndex="3" Name="CONTEO" Width="100px">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn Caption="PRECIO UNITARIO" FieldName="COSTO_UNITARIO" ShowInCustomizationForm="True" VisibleIndex="9" Width="100px" Name="COSTO_UNITARIO">
                                <PropertiesTextEdit DisplayFormatInEditMode="True" DisplayFormatString="c2">
                                    <MaskSettings IncludeLiterals="DecimalSymbol" Mask="$&lt;0..999999999g&gt;.&lt;00..99&gt;" />
                                </PropertiesTextEdit>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn Caption="IMPORTE" FieldName="IMPORTE" ShowInCustomizationForm="True" VisibleIndex="10" Width="100px" Name="IMPORTE">
                                <PropertiesTextEdit DisplayFormatInEditMode="True" DisplayFormatString="c2">
                                    <MaskSettings IncludeLiterals="DecimalSymbol" Mask="$&lt;0..999999999g&gt;.&lt;00..99&gt;" />
                                </PropertiesTextEdit>
                            </dx:GridViewDataTextColumn>
                        </Columns>
                        <SettingsBehavior AllowFocusedRow="True"
                            AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" />
                        <SettingsPager Mode="ShowAllRecords" Position="TopAndBottom">
                        </SettingsPager>
                        <Settings ShowFilterRow="True" ShowFooter="True" />
                        <SettingsSearchPanel Visible="True" />
                        <Styles>
                            <Cell HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
                            </Cell>
                            <Header HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
                            </Header>
                        </Styles>
                    </dx:ASPxGridView>

                    <table>
                        <tr>

                            <td align="center">
                                <dx:ASPxButton ID="btnEnviarRequisicion" runat="server"
                                    OnClick="btnEnviarRequisicion_Click" Text="Enviar a Aprobación"
                                    Theme="Moderno" ValidationGroup="Envio">
                                </dx:ASPxButton>
                                &nbsp;&nbsp;&nbsp;
                            </td>
                            <td>
                                <dx:ASPxButton ID="ASPxButton3" runat="server" OnClick="ASPxButton3_Click"
                                    Text="Cancelar Solicitud" Theme="Moderno">
                                </dx:ASPxButton>
                            </td>
                        </tr>
                    </table>

                    <asp:SqlDataSource ID="UNIDAD" runat="server"
                        ConnectionString="<%$ ConnectionStrings:SIFICA %>"
                        SelectCommand="UNIDADESMEDIDA_MOSTRAR_TODOS"
                        SelectCommandType="StoredProcedure"></asp:SqlDataSource>

                    <dx:ASPxLoadingPanel ID="lp" runat="server" ClientInstanceName="lp" Modal="True">
                    </dx:ASPxLoadingPanel>

                    <dx:ASPxPopupControl runat="server"
                        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter"
                        ClientInstanceName="popupHistorialRequisiciones" HeaderText="Mis Requisiciones"
                        Theme="BlackGlass" Width="1000px" ID="popupHistorialRequisiciones" CloseOnEscape="True" Maximized="True" Modal="True" ShowMaximizeButton="True">
                        <ContentCollection>
                            <dx:PopupControlContentControl runat="server">
                                <dx:ASPxGridView runat="server" ClientInstanceName="grdAprobaciones"
                                    EnableCallbackAnimation="True" EnablePagingCallbackAnimation="True"
                                    KeyFieldName="ID_REQUEST" AutoGenerateColumns="False" Theme="BlackGlass"
                                    Width="100%" EnableTheming="True" ID="grdAprobaciones"
                                    OnAfterPerformCallback="grdAprobaciones_AfterPerformCallback" Font-Size="Large">
                                    <Columns>
                                        <dx:GridViewCommandColumn ShowSelectCheckbox="True" SelectAllCheckboxMode="Page" ShowInCustomizationForm="True"
                                            VisibleIndex="0" Visible="False">
                                        </dx:GridViewCommandColumn>
                                        <dx:GridViewDataTextColumn FieldName="FECHA_CREACION_REQUISICION" ReadOnly="True" ShowInCustomizationForm="True" Caption="FECHA DE CREACIÓN"
                                            VisibleIndex="2">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="REQUISITOR" ReadOnly="True" ShowInCustomizationForm="True"
                                            Caption="NOMBRE DEL SOLICITANTE" VisibleIndex="3">
                                            <EditFormSettings Visible="False"></EditFormSettings>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="ESTADO_REQUISICION" ShowInCustomizationForm="True" Caption="ESTATUS REQUISICION"
                                            VisibleIndex="4">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="ESTADO_OC" ShowInCustomizationForm="True" Caption="ESTADO ORDEN DE COMPRA"
                                            VisibleIndex="6">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="FOLIO_OC" ShowInCustomizationForm="True" Caption="FOLIO ORDEN DE COMPRA"
                                            VisibleIndex="8">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn ShowInCustomizationForm="True" VisibleIndex="10">
                                            <DataItemTemplate>
                                                <dx:ASPxButton ID="btnAbrir" runat="server" CssClass="btn btn-primary" OnClick="btnAbrir_Click" Text="Abrir" HorizontalAlign="Center">
                                                </dx:ASPxButton>

                                            </DataItemTemplate>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="FOLIO" ShowInCustomizationForm="True" Caption="FOLIO REQUISICION" VisibleIndex="7">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn Caption="ID_REQUEST" FieldName="ID_REQUEST" ShowInCustomizationForm="True" Visible="False" VisibleIndex="1">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataHyperLinkColumn Caption="COTIZACIÓN" FieldName="ARCHIVO" ShowInCustomizationForm="True" VisibleIndex="9">
                                            <PropertiesHyperLinkEdit NavigateUrlFormatString="/Cotizaciones/{0}">
                                            </PropertiesHyperLinkEdit>
                                        </dx:GridViewDataHyperLinkColumn>
                                        <dx:GridViewDataTextColumn Caption="APROBADOR REQUISICION" FieldName="APROBADOR_RECHAZADOR_REQUISICION" ShowInCustomizationForm="True" VisibleIndex="5">
                                        </dx:GridViewDataTextColumn>
                                    </Columns>

                                    <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True"></SettingsBehavior>

                                    <Settings ShowFilterRow="True" ShowGroupPanel="True"></Settings>

                                    <Styles>
                                        <Cell HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True"></Cell>

                                        <Header HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True"></Header>
                                    </Styles>
                                </dx:ASPxGridView>

                            </dx:PopupControlContentControl>
                        </ContentCollection>
                    </dx:ASPxPopupControl>

                    <dx:ASPxPopupControl ID="PopupAlerta" runat="server" ForeColor="White" HeaderText="WARNING" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Theme="Default" ShowPageScrollbarWhenModal="True">
                        <ContentStyle HorizontalAlign="Center" VerticalAlign="Middle">
                        </ContentStyle>
                        <HeaderStyle BackColor="Red" Font-Bold="True" ForeColor="White" VerticalAlign="Middle" />
                        <ContentCollection>
                            <dx:PopupControlContentControl runat="server">
                                <table style="width: 100%;">
                                    <tr>
                                        <td colspan="3">
                                            <dx:ASPxLabel ID="lblEditar" runat="server" ForeColor="Black" Text="Hay una Requisicion en Borrador">
                                            </dx:ASPxLabel>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <dx:ASPxButton ID="btnEditar" runat="server" OnClick="btnEditar_Click" Text="Continuar Editando" CssClass="btn btn-primary">
                                            </dx:ASPxButton>
                                        </td>
                                        <td>&nbsp;</td>
                                        <td>
                                            <dx:ASPxButton ID="btnCancelar" runat="server" OnClick="btnCancelar_Click" Text="Cancelar Edición y Borrar" CssClass="btn btn-danger">
                                            </dx:ASPxButton>
                                        </td>
                                    </tr>
                                </table>
                            </dx:PopupControlContentControl>
                        </ContentCollection>
                    </dx:ASPxPopupControl>

                    <div class="modal fade bs-example-modal-lg" id="EnvioRequisicion" tabindex="-1" role="dialog" aria-labelledby="EnvioRequisicionLabel">
                        <div class="modal-dialog modal-lg" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                    <h4 class="modal-title" id="EnvioRequisicionLabel">Enviar a aprobación</h4>
                                </div>
                                <div class="modal-body">

                                    <div class="form-group">
                                        <label for="cboProveedor">Proveedor</label>
                                        <dx:ASPxComboBox ID="cboProveedor" ClientInstanceName="cboProveedor" runat="server" DataSourceID="Proveedores" EnableTheming="True" TextField="PROOVEDOR" Theme="Metropolis" ValueField="ID_PROOVEDOR" ValidationSettings-ValidationGroup="Enviar" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ErrorTextPosition="Right"></dx:ASPxComboBox>
                                        <dx:ASPxHyperLink ID="lnkOtros" runat="server" Text="Dar de alta Proveedor">
                                            <ClientSideEvents Click="function(s, e) {
	popupProveedores.Show();
}" />
                                        </dx:ASPxHyperLink>
                                        <asp:SqlDataSource ID="Proveedores" runat="server" ConnectionString="<%$ ConnectionStrings:PARTIDAS %>" SelectCommand="PROOVEDORES_MOSTRAR_TODOS" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                        <p></p>
                                        <label for="fileCotizacion">Cotizacion</label>
                                        <asp:AsyncFileUpload ID="fileCotizacion" runat="server" />


                                    </div>

                                    <div class="form-group">
                                        <label for="txtJustificacion">Justificación</label>
                                        <textarea class="form-control" rows="3" runat="server" id="txtJustificacion"></textarea>
                                    </div>
                                    <div class="form-group">
                                        <label for="FechaEntrega">Fecha de Entrega</label>
                                        <dx:ASPxDateEdit ID="FechaEntrega" runat="server" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ErrorTextPosition="Right" ValidationSettings-ValidationGroup="Enviar"></dx:ASPxDateEdit>
                                    </div>
                                    <div class="form-group">
                                        <label for="txtlugarEntrega">Lugar de Entrega</label>
                                        <dx:ASPxTextBox ID="txtlugarEntrega" runat="server" Width="170px" CssClass="form-control"></dx:ASPxTextBox>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">
                                        Cerrar
                                    </button>
                                    <dx:ASPxButton ID="btnEnviarAprobacion" runat="server" Text="Enviar a Aprobación" CssClass="btn btn-primary" ValidationGroup="Enviar" OnClick="btnEnviarAprobacion_Click">
                                        <ClientSideEvents Click="function(s, e){return textbox2.GetIsValid();}" />
                                    </dx:ASPxButton>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
            <dx:ASPxPopupControl runat="server"
                PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter"
                Modal="True" Theme="BlackGlass" Width="900px" ID="popupReporte"
                Height="700px" AllowDragging="True" AllowResize="True" CloseOnEscape="True" EnableCallbackAnimation="True" HeaderText="" Maximized="True" HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Middle" FooterStyle-VerticalAlign="Middle" FooterStyle-HorizontalAlign="Center" LoadingPanelStyle-HorizontalAlign="Center" LoadingPanelStyle-VerticalAlign="Middle" ShowPageScrollbarWhenModal="True">
                <FooterStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                <LoadingPanelStyle HorizontalAlign="Center" VerticalAlign="Middle">
                </LoadingPanelStyle>
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt" SizeToReportContent="False" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" ShowToolBar="True" Width="100%" Height="100%">
                        </rsweb:ReportViewer>
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>
            <div class="modal fade bs-example-modal-lg" id="popupAddItem" tabindex="-1" role="dialog" aria-labelledby="popupAddItemLabel">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h4 class="modal-title" id="popupAddItemLabel">Agregar Item</h4>

                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label for="txtDescripcionItem">Descripción del Item:</label>
                                        <textarea class="form-control" rows="3" runat="server" id="txtDescripcionItem"></textarea>
                                    </div>

                                    <div class="form-group">
                                        <label for="cboUnidadMedia">Unidad de Medida</label>
                                        <dx:ASPxComboBox ID="cboUnidadMedia" runat="server" DataSourceID="UnidadesMedidaDatos" TextField="UNIDAD" ValueField="ID_UNIDAD" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="GuardarItem" ValidationSettings-ErrorTextPosition="Right"></dx:ASPxComboBox>
                                        <asp:SqlDataSource ID="UnidadesMedidaDatos" runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>" SelectCommand="UNIDADESMEDIDA_MOSTRAR_TODOS" SelectCommandType="StoredProcedure"></asp:SqlDataSource>

                                    </div>
                                    <div class="form-group">
                                        <label for="cboClasificacion">Clasificación del Item</label>
                                        <dx:ASPxComboBox ID="cboClasificacion" runat="server" DataSourceID="ClasificacionDatos" TextField="CLASIFICACION" ValueField="ID_CLASIFICACION" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="GuardarItem" ValidationSettings-ErrorTextPosition="Right"></dx:ASPxComboBox>
                                        <asp:SqlDataSource ID="ClasificacionDatos" runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>" SelectCommand="CLASIFICACIONES_CONSULTAR_TODAS_ACTIVAS" SelectCommandType="StoredProcedure"></asp:SqlDataSource>

                                    </div>
                                    <div class="form-group">
                                        <label for="cboGiro">Giro:</label>
                                        <dx:ASPxComboBox ID="cboGiro" runat="server" DataSourceID="GirosDatos" TextField="GIRO" ValueField="ID_GIRO" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="GuardarItem" ValidationSettings-ErrorTextPosition="Right"></dx:ASPxComboBox>
                                        <asp:SqlDataSource ID="GirosDatos" runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>" SelectCommand="GIROS_MOSTRAR_TODOS" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                    </div>
                                    <div class="form-group">
                                        <label for="txtNumeroParte">Numero de Parte:</label>
                                        <dx:ASPxTextBox ID="txtNumeroParte" runat="server" Width="170px"></dx:ASPxTextBox>
                                    </div>
                                    <div class="form-group">
                                        <label for="txtMaximo">Maximo:</label>
                                        <dx:ASPxTextBox ID="txtMaximo" runat="server" Width="170px" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="GuardarItem" ValidationSettings-ErrorTextPosition="Right">
                                            <MaskSettings Mask="&lt;0..9999999999g&gt;.&lt;00..99&gt;" />
                                            <ValidationSettings ValidationGroup="GuardarItem">
                                                <RequiredField IsRequired="True" />
                                            </ValidationSettings>
                                        </dx:ASPxTextBox>
                                    </div>
                                    <div class="form-group">
                                        <label for="txtMinimo">Minimo:</label>
                                        <dx:ASPxTextBox ID="txtMinimo" runat="server" Width="170px" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="GuardarItem" ValidationSettings-ErrorTextPosition="Right">
                                            <MaskSettings Mask="&lt;0..9999999999g&gt;.&lt;00..99&gt;" />
                                            <ValidationSettings ValidationGroup="GuardarItem">
                                                <RequiredField IsRequired="True" />
                                            </ValidationSettings>
                                        </dx:ASPxTextBox>
                                        <dx:ASPxCheckBox ID="chkInventariable" runat="server" Text="Es Inventariable"></dx:ASPxCheckBox>
                                    </div>
                              <%--      <div class="alert alert-success" role="alert">
                                        <dx:ASPxLabel ID="lblItem" runat="server" Text="" Visible="false"></dx:ASPxLabel>
                                    </div>--%>
                                </div>
                            </div>

                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">
                                Cerrar
                            </button>
                            <dx:ASPxButton ID="btnGuardarItem" runat="server" Text="Guardar Item" CssClass="btn btn-primary" ValidationGroup="GuardarItem" OnClick="btnGuardarItem_Click" UseSubmitBehavior="true">
                                <ClientSideEvents Click="function(s, e){return textbox2.GetIsValid();}" />
                            </dx:ASPxButton>
                        </div>
                    </div>

                </div>
            </div>
            <dx:ASPxPopupControl ID="popupProveedores" ClientInstanceName="popupProveedores" runat="server" HeaderText="Proveedores" Maximized="True" ShowPageScrollbarWhenModal="True" CloseOnEscape="True" Theme="Glass" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ContentUrl="~/CatalogoProveedores.aspx">
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <%--<dx:ASPxGridView ID="grdProveedores" runat="server" AutoGenerateColumns="False"
                            DataSourceID="DATOSPRO" EnableTheming="True"
                            KeyFieldName="ID_PROOVEDOR" Theme="Youthful" Width="700px"
                            Caption="PROVEEDORES">
                            <Columns>
                                <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True"
                                    ShowNewButtonInHeader="True" ShowUpdateButton="True" VisibleIndex="0">
                                </dx:GridViewCommandColumn>
                                <dx:GridViewDataTextColumn Caption="CLAVE DEL PROVEEDOR"
                                    FieldName="ID_PROOVEDOR" ReadOnly="True" VisibleIndex="1">
                                    <PropertiesTextEdit>
                                        <ValidationSettings ErrorTextPosition="Bottom">
                                        </ValidationSettings>
                                    </PropertiesTextEdit>
                                    <EditFormSettings Visible="False" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="NOMBRE DEL PROVEEDOR" FieldName="PROOVEDOR"
                                    VisibleIndex="2">
                                    <PropertiesTextEdit>
                                        <ValidationSettings SetFocusOnError="True">
                                            <RequiredField IsRequired="True" />
                                        </ValidationSettings>
                                    </PropertiesTextEdit>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="DIRECCION" FieldName="DIRECCION"
                                    VisibleIndex="3">
                                    <PropertiesTextEdit>
                                        <ValidationSettings SetFocusOnError="True">
                                            <RequiredField IsRequired="True" />
                                        </ValidationSettings>
                                    </PropertiesTextEdit>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="CODIGO POSTAL" FieldName="CODIGO_POSTAL"
                                    VisibleIndex="4">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="TELEFONO" VisibleIndex="11">
                                    <PropertiesTextEdit>
                                        <ValidationSettings SetFocusOnError="True">
                                            <RequiredField IsRequired="True" />
                                        </ValidationSettings>
                                    </PropertiesTextEdit>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="CORREO ELECTRONICO" FieldName="CORREO"
                                    VisibleIndex="12">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="RFC" VisibleIndex="13">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="NOMBRE DEL CONTACTO"
                                    FieldName="NOMBRECONTACTO" VisibleIndex="16">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="DIAS DE CREDITO" FieldName="DIASCREDITO"
                                    VisibleIndex="17">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="MONTO DEL CREDITO" FieldName="MONTOCREDITO"
                                    VisibleIndex="18">
                                    <PropertiesTextEdit DisplayFormatString="c2">
                                    </PropertiesTextEdit>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="NUMERO DE CUENTA BANCARIA"
                                    FieldName="CUENTA" VisibleIndex="23">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="CLAVE INTERBANCARIA" FieldName="CLAVE"
                                    VisibleIndex="24">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataComboBoxColumn Caption="PAIS" FieldName="PAIS"
                                    VisibleIndex="10">
                                    <PropertiesComboBox DataSourceID="CIUDAD" TextField="PAIS" ValueField="ID_PAIS">
                                    </PropertiesComboBox>
                                    <EditFormSettings Visible="False" />
                                </dx:GridViewDataComboBoxColumn>
                                <dx:GridViewDataComboBoxColumn Caption="ESTADO" FieldName="ESTADO"
                                    VisibleIndex="9">
                                    <PropertiesComboBox DataSourceID="CIUDAD" IncrementalFilteringMode="Contains"
                                        TextField="ESTADO" ValueField="ID_ESTADO">
                                    </PropertiesComboBox>
                                    <EditFormSettings Visible="False" />
                                </dx:GridViewDataComboBoxColumn>
                                <dx:GridViewDataComboBoxColumn FieldName="CIUDAD" VisibleIndex="8">
                                    <PropertiesComboBox DataSourceID="CIUDAD" IncrementalFilteringMode="Contains"
                                        TextField="CIUDAD" TextFormatString="{2}" ValueField="ID_CIUDAD">
                                        <Columns>
                                            <dx:ListBoxColumn Caption="PAIS" FieldName="PAIS" Name="PAIS" />
                                            <dx:ListBoxColumn Caption="ESTADO" FieldName="ESTADO" Name="ESTADO" />
                                            <dx:ListBoxColumn Caption="CIUDAD" FieldName="CIUDAD" Name="CIUDAD" />
                                        </Columns>
                                        <ValidationSettings SetFocusOnError="True">
                                            <RequiredField IsRequired="True" />
                                        </ValidationSettings>
                                    </PropertiesComboBox>
                                </dx:GridViewDataComboBoxColumn>
                                <dx:GridViewDataComboBoxColumn Caption="NOMBRE DEL BANCO" FieldName="BANCO"
                                    VisibleIndex="22">
                                    <PropertiesComboBox DataSourceID="BANCOS" ImageUrlField="URLLOGO"
                                        IncrementalFilteringMode="Contains" TextField="BANCO" ValueField="ID_BANCO">
                                        <ItemImage Height="70%" Width="70%">
                                        </ItemImage>
                                    </PropertiesComboBox>
                                </dx:GridViewDataComboBoxColumn>
                                <dx:GridViewDataComboBoxColumn Caption="FORMA DE PAGO" FieldName="FORMAPAGO"
                                    VisibleIndex="21">
                                    <PropertiesComboBox IncrementalFilteringMode="Contains">
                                        <Items>
                                            <dx:ListEditItem Text="CONTADO" Value="1" />
                                            <dx:ListEditItem Text="CREDITO" Value="2" />
                                        </Items>
                                    </PropertiesComboBox>
                                </dx:GridViewDataComboBoxColumn>
                                <dx:GridViewDataComboBoxColumn Caption="GIRO DEL PROVEEDOR" FieldName="TIPO"
                                    VisibleIndex="15">
                                    <PropertiesComboBox DataSourceID="GIROS" IncrementalFilteringMode="Contains"
                                        TextField="GIRO" ValueField="ID_GIRO">
                                    </PropertiesComboBox>
                                </dx:GridViewDataComboBoxColumn>
                            </Columns>
                            <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True"
                                AllowSelectSingleRowOnly="True" ConfirmDelete="True" />
                            <SettingsPager Position="TopAndBottom">
                            </SettingsPager>
                            <SettingsEditing Mode="PopupEditForm">
                            </SettingsEditing>
                            <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowTitlePanel="True" />
                            <SettingsPopup>
                                <EditForm HorizontalAlign="WindowCenter" Modal="True"
                                    VerticalAlign="WindowCenter" Width="900px" />
                            </SettingsPopup>
                            <SettingsSearchPanel Visible="True" />
                            <Styles>
                                <Cell HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
                                </Cell>
                                <Header HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
                                </Header>
                            </Styles>
                            <StylesPopup>
                                <EditForm>
                                    <Header BackColor="#FFFF99" HorizontalAlign="Center" VerticalAlign="Middle"
                                        Wrap="True">
                                    </Header>
                                </EditForm>
                            </StylesPopup>
                        </dx:ASPxGridView>--%>
                        <asp:SqlDataSource ID="DATOSPRO" runat="server"
                            ConnectionString="<%$ ConnectionStrings:SIFICA %>"
                            InsertCommand="PROOVEDORES_INSERTAR" InsertCommandType="StoredProcedure"
                            SelectCommand="PROOVEDORES_MOSTRAR_TODOS" SelectCommandType="StoredProcedure"
                            UpdateCommand="PROOVEDORES_MODIFICAR" UpdateCommandType="StoredProcedure">
                            <InsertParameters>
                                <asp:Parameter Name="PROOVEDOR" Type="String" />
                                <asp:Parameter Name="DIRECCION" Type="String" />
                                <asp:Parameter Name="PAIS" Type="String" />
                                <asp:Parameter Name="ESTADO" Type="Int32" />
                                <asp:Parameter Name="CIUDAD" Type="Int32" />
                                <asp:Parameter Name="CODIGO_POSTAL" Type="Int32" />
                                <asp:Parameter Name="TELEFONO" Type="String" />
                                <asp:Parameter Name="CORREO" Type="String" />
                                <asp:Parameter Name="RFC" Type="String" />
                                <asp:Parameter Name="TIPO" Type="Int32" />
                                <asp:Parameter Name="NOMBRECONTACTO" Type="String" />
                                <asp:Parameter Name="DIASCREDITO" Type="Int32" />
                                <asp:Parameter Name="MONTOCREDITO" Type="Decimal" />
                                <asp:Parameter Name="FORMAPAGO" Type="Int32" />
                                <asp:Parameter Name="BANCO" Type="Int32" />
                                <asp:Parameter Name="CUENTA" Type="Int64" />
                                <asp:Parameter Name="CLAVE" Type="Int64" />
                                <asp:Parameter Name="FECHA_CREACION" Type="DateTime" />
                            </InsertParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="ID_PROOVEDOR" Type="Int32" />
                                <asp:Parameter Name="PROOVEDOR" Type="String" />
                                <asp:Parameter Name="DIRECCION" Type="String" />
                                <asp:Parameter Name="CIUDAD" Type="Int32" />
                                <asp:Parameter Name="CODIGO_POSTAL" Type="Int32" />
                                <asp:Parameter Name="TELEFONO" Type="String" />
                                <asp:Parameter Name="CORREO" Type="String" />
                                <asp:Parameter Name="RFC" Type="String" />
                                <asp:Parameter Name="TIPO" Type="Int32" />
                                <asp:Parameter Name="NOMBRECONTACTO" Type="String" />
                                <asp:Parameter Name="DIASCREDITO" Type="Int32" />
                                <asp:Parameter Name="MONTOCREDITO" Type="Decimal" />
                                <asp:Parameter Name="FORMAPAGO" Type="Int32" />
                                <asp:Parameter Name="BANCO" Type="Int32" />
                                <asp:Parameter Name="CUENTA" Type="Int64" />
                                <asp:Parameter Name="CLAVE" Type="Int64" />
                            </UpdateParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="CIUDAD" runat="server"
                            ConnectionString="<%$ ConnectionStrings:SIFICA %>"
                            SelectCommand="GEOGRAFIA_MOSTRAR_ESTRUCTURA"
                            SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                        <asp:SqlDataSource ID="BANCOS" runat="server"
                            ConnectionString="<%$ ConnectionStrings:SIFICA %>"
                            SelectCommand="BANCOS_MOSTRAR_TODOS" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                        <asp:SqlDataSource ID="GIROS" runat="server"
                            ConnectionString="<%$ ConnectionStrings:SIFICA %>"
                            SelectCommand="GIROS_MOSTRAR_TODOS" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnEnviarAprobacion" />
            <%--         <asp:PostBackTrigger ControlID="popupHistorialRequisiciones" />--%>
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
