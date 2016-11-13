<%@ Page Title="Salidas" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Salidas.aspx.cs" Inherits="SISGRES.Salidas" MaintainScrollPositionOnPostback="true" %>

<%@ Register Assembly="DevExpress.Web.v14.2, Version=14.2.11.0, Culture=neutral, PublicKeyToken=B88D1754D700E49A"
    Namespace="DevExpress.Web" TagPrefix="dx" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>


<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <div class="page-header">
        <h1>Salidas de Almacen</h1>
    </div>
    <div class="jumbotron">
        <script type="text/javascript">
            Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(BeginRequestHandler);
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
            function BeginRequestHandler(sender, args) {
                lp.Show();
            }
            function EndRequestHandler(sender, args) {
                lp.Hide();
            }

            function NoPuedesAgregar() {
                $('#NoPuedesAgregar').modal({
                    show: true
                });
            }

           

        </script>

        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>

                <br />
                <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server"
                    HeaderText="Salida de Material" HorizontalAlign="Center"
                    ShowCollapseButton="true" Width="100%" Theme="Office2003Blue">
                    <PanelCollection>
                        <dx:PanelContent runat="server">
                            <form class="form-group">
                                <div class="form-group">
                                    <table style="width: 100%;">
                                        <tr>
                                            <td align="center" valign="top">
                                                &nbsp;</td>
                                            <td align="center" valign="top" colspan="2">
                                                &nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td colspan="3" align="center" valign="top">
                                                <label for="txtItem">Escriba y seleccione el Item</label>
                                                <asp:TextBox ID="txtItem" runat="server" BorderStyle="Solid" CssClass="form-control" Font-Names="Trebuchet MS" Font-Size="Large" TabIndex="1" AutoCompleteType="Disabled"></asp:TextBox>

                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" valign="top">
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
                                                <asp:AutoCompleteExtender ID="txtItem_AutoCompleteExtender" runat="server"
                                                    CompletionInterval="1" CompletionSetCount="1" DelimiterCharacters=""
                                                    Enabled="True" MinimumPrefixLength="1"
                                                    ServiceMethod="BusquedaItems" ServicePath="~/ServicioWeb.asmx"
                                                    TargetControlID="txtItem" ShowOnlyCurrentWordInCompletionListItem="True">
                                                </asp:AutoCompleteExtender>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                                    BorderStyle="Solid" ControlToValidate="txtItem" Display="None"
                                                    ErrorMessage="Capture y Seleccione el Material" Font-Bold="True"
                                                    ForeColor="Red" SetFocusOnError="True" ValidationGroup="Agregar"></asp:RequiredFieldValidator>
                                                <asp:ValidatorCalloutExtender ID="RequiredFieldValidator1_ValidatorCalloutExtender"
                                                    runat="server" Enabled="True" PopupPosition="BottomRight"
                                                    TargetControlID="RequiredFieldValidator1">
                                                </asp:ValidatorCalloutExtender>

                                            </td>
                                            <td align="center" valign="top">
                                                <dx:ASPxCheckBox ID="chkDevolucion" runat="server" CheckState="Unchecked" Text="Debera ser Devuelto">
                                                </dx:ASPxCheckBox>
                                                <span class="label label-default"> &nbsp;<dx:ASPxLabel ID="lblConteo" runat="server">
                                                </dx:ASPxLabel></span>
                                               
                                            </td>
                                            <td align="center" valign="top">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td align="center" colspan="2" valign="top">
                                                <asp:LinkButton ID="Agregar" runat="server" Class="button btn-success" CssClass="btn btn-success" OnClick="Agregar_Click">Agregar</asp:LinkButton>
                                            </td>
                                            <td align="center" valign="top">&nbsp;</td>
                                        </tr>
                                    </table>
                                </div>
                            </form>



                            <dx:ASPxGridView ID="grdSalidas" runat="server" AutoGenerateColumns="False"
                                EnableTheming="True" Font-Size="Small" KeyFieldName="ID"
                                OnAfterPerformCallback="ASPxGridView1_AfterPerformCallback" Theme="Office2003Blue"
                                Width="100%" DataSourceID="CosultarSalidas">
                                <TotalSummary>
                                    <dx:ASPxSummaryItem DisplayFormat="C2" FieldName="IMPORTE" ShowInColumn="IMPORTE" ShowInGroupFooterColumn="IMPORTE" SummaryType="Sum" Tag="Total:" ValueDisplayFormat="C2" />
                                </TotalSummary>
                                <Columns>
                                    <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" ShowInCustomizationForm="True" ShowNewButtonInHeader="True" VisibleIndex="0" Width="100px">
                                    </dx:GridViewCommandColumn>
                                    <dx:GridViewDataTextColumn FieldName="ID"
                                        ShowInCustomizationForm="True" VisibleIndex="1" ReadOnly="True" Visible="False" Width="100px">
                                        <EditFormSettings Visible="False" />
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="ITEM"
                                        ShowInCustomizationForm="True" VisibleIndex="2">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="CANTIDAD"
                                        ShowInCustomizationForm="True" VisibleIndex="3" Width="100px">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataCheckColumn FieldName="DEVOLVER" ShowInCustomizationForm="True" VisibleIndex="4" Width="100px">
                                    </dx:GridViewDataCheckColumn>
                                </Columns>
                                <SettingsBehavior AllowFocusedRow="True"
                                    AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" ConfirmDelete="True" />
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
                            <%--   </div>
                        </div>--%>


                            <asp:SqlDataSource ID="CosultarSalidas" runat="server" ConnectionString="<%$ ConnectionStrings:PARTIDAS %>" SelectCommand="SALIDAS_CONSULTAR_TEMPORAL" SelectCommandType="StoredProcedure" DeleteCommand="SALIDAS_ELIMINAR" DeleteCommandType="StoredProcedure" InsertCommand="SALIDAS_INSERTAR" InsertCommandType="StoredProcedure" UpdateCommand="SALIDAS_MODIFICAR" UpdateCommandType="StoredProcedure">
                                <DeleteParameters>
                                    <asp:Parameter Name="ID" Type="Int32" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="ID_EMPLEADO" Type="Int32" />
                                    <asp:Parameter Name="ID_CENTRO_COSTO" Type="Int32" />
                                    <asp:Parameter Name="ITEM" Type="String" />
                                    <asp:Parameter Name="CANTIDAD" Type="Decimal" />
                                    <asp:Parameter Name="ENTREGO" Type="String" />
                                    <asp:Parameter Name="DEVOLVER" Type="Boolean" />
                                </InsertParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="CANTIDAD" Type="Decimal" />
                                    <asp:Parameter Name="DEVOLVER" Type="Boolean" />
                                    <asp:Parameter Name="ID" Type="Int32" />
                                </UpdateParameters>
                            </asp:SqlDataSource>


                            <table>
                                <tr>

                                    <td align="center">
                                        <dx:ASPxButton ID="btnEnviarRequisicion" runat="server"
                                            OnClick="btnEnviarRequisicion_Click" Text="Generar Salida"
                                            Theme="Moderno">
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

                                            <div class="form-group">
                                                <label for="txtDescripcionItem">Descripción del Item:</label>
                                                <textarea class="form-control" rows="3" runat="server" id="Textarea1"></textarea>
                                            </div>
                                            <%--             <form class="form-inline">--%>
                                            <div class="row">
                                                <div class="col-lg-6">
                                                    <div class="input-group">
                                                        <label for="cboUnidadMedia">Unidad de Medida</label>
                                                        <dx:ASPxComboBox ID="ASPxComboBox1" runat="server" DataSourceID="UnidadesMedidaDatos" TextField="UNIDAD" ValueField="ID_UNIDAD" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="GuardarItem" ValidationSettings-ErrorTextPosition="Right">
                                                            <validationsettings validationgroup="GuardarItem">
                                                                <requiredfield isrequired="True" />
                                                            </validationsettings>
                                                        </dx:ASPxComboBox>
                                                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>" SelectCommand="UNIDADESMEDIDA_MOSTRAR_TODOS" SelectCommandType="StoredProcedure"></asp:SqlDataSource>

                                                    </div>
                                                    <div class="form-group">
                                                        <label for="cboClasificacion">Clasificación del Item</label>
                                                        <dx:ASPxComboBox ID="ASPxComboBox2" runat="server" DataSourceID="ClasificacionDatos" TextField="CLASIFICACION" ValueField="ID_CLASIFICACION" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="GuardarItem" ValidationSettings-ErrorTextPosition="Right">
                                                            <validationsettings validationgroup="GuardarItem">
                                                                <requiredfield isrequired="True" />
                                                            </validationsettings>
                                                        </dx:ASPxComboBox>
                                                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>" SelectCommand="CLASIFICACIONES_CONSULTAR_TODAS_ACTIVAS" SelectCommandType="StoredProcedure"></asp:SqlDataSource>

                                                    </div>
                                                    <div class="form-group">
                                                        <label for="cboGiro">Giro:</label>
                                                        <dx:ASPxComboBox ID="ASPxComboBox3" runat="server" DataSourceID="GirosDatos" TextField="GIRO" ValueField="ID_GIRO" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="GuardarItem" ValidationSettings-ErrorTextPosition="Right">
                                                            <validationsettings validationgroup="GuardarItem">
                                                                <requiredfield isrequired="True" />
                                                            </validationsettings>
                                                        </dx:ASPxComboBox>
                                                        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>" SelectCommand="GIROS_MOSTRAR_TODOS" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="txtNumeroParte">Numero de Parte:</label>
                                                        <dx:ASPxTextBox ID="ASPxTextBox1" runat="server" Width="170px" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="GuardarItem" ValidationSettings-ErrorTextPosition="Right">
                                                            <validationsettings validationgroup="GuardarItem">
                                                                <requiredfield isrequired="True" />
                                                            </validationsettings>
                                                        </dx:ASPxTextBox>
                                                    </div>
                                                </div>
                                            </div>
                                            <%--   </form>--%>
                                        </div>

                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal">
                                            Cerrar
                                        </button>
                                        <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Guardar Item" CssClass="btn btn-primary" ValidationGroup="GuardarItem" OnClick="btnGuardarItem_Click">
                                            <ClientSideEvents Click="function(s, e){return textbox2.GetIsValid();}" />
                                        </dx:ASPxButton>
                                    </div>
                                </div>
                            </div>
                        </dx:PanelContent>
                    </PanelCollection>
                </dx:ASPxRoundPanel>
                <dx:ASPxPopupControl ID="popupSalidas" runat="server" AllowDragging="True" AllowResize="True" AutoUpdatePosition="True" CloseAnimationType="Slide" CloseOnEscape="True" HeaderText="Salida de Materiales" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowPageScrollbarWhenModal="True" Theme="Glass" Width="300px">
                    <contentcollection>
                        <dx:PopupControlContentControl runat="server">
                            <label for="cboCtroCosto">
                            Seleccione el centro de costo</label><dx:ASPxComboBox ID="cboCtroCosto" runat="server" DataSourceID="CentroCostos" HorizontalAlign="Center" TextField="DESCRIPCION" Theme="Glass" ValueField="ID" Width="100%">
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True" />
                                <validationsettings errortextposition="Bottom" setfocusonerror="True" validationgroup="Envio">
                                    <RequiredField IsRequired="True" />
                                </validationsettings>
                            </dx:ASPxComboBox>
                            <asp:SqlDataSource ID="CentroCostos" runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>" SelectCommand="CENTRO_COSTOS_CONSULTAR_ACTIVOS" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                            <label for="cboEmpleados">
                            Indique el solicitante</label><dx:ASPxComboBox ID="cboEmpleados" runat="server" DataSourceID="Empleados" HorizontalAlign="Center" TextField="NOMBRE" Theme="Glass" ValueField="ID_EMPLEADO" Width="100%">
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True" />
                                <validationsettings errortextposition="Bottom" setfocusonerror="True" validationgroup="Envio">
                                    <RequiredField IsRequired="True" />
                                </validationsettings>
                            </dx:ASPxComboBox>
                            <asp:SqlDataSource ID="Empleados" runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>" SelectCommand="EMPLEADOS_NOMBRE_ACTIVOS" SelectCommandType="StoredProcedure">
                                <SelectParameters>
                                    <asp:SessionParameter Name="ID_COMPAÑIA" SessionField="Compañia" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <dx:ASPxMemo ID="txtComentarios" runat="server" Caption="Comentarios" Height="71px" Theme="Office2003Blue" Width="100%">
                                <CaptionSettings Position="Top" />
                            </dx:ASPxMemo>
                            <dx:ASPxButton ID="btnSalida" runat="server" OnClick="btnSalida_Click" Text="Aceptar" ValidationGroup="Envio">
                            </dx:ASPxButton>
                        </dx:PopupControlContentControl>
                    </contentcollection>
                </dx:ASPxPopupControl>
                <dx:ASPxLoadingPanel ID="lp" runat="server" ClientInstanceName="lp" Modal="True">
                </dx:ASPxLoadingPanel>
                <div class="modal fade bs-example-modal-lg" id="NoPuedesAgregar" tabindex="-1" role="dialog" aria-labelledby="NoPuedesAgregarLabel">
                    <div class="modal-dialog modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                                <h4 class="modal-title" id="NoPuedesAgregarLabel">No hay en Existencia</h4>
                            </div>
                            <div class="modal-body">
                                <div class="alert alert-danger" role="alert">El item no se encuentra en existencia</div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">
                                    Cerrar
                                </button>
                              <%--  <dx:ASPxButton ID="btnEnviarAprobacion" runat="server" Text="Enviar a Aprobación" CssClass="btn btn-primary" ValidationGroup="Envio" OnClick="btnEnviarAprobacion_Click">
                                    <ClientSideEvents Click="function(s, e){return textbox2.GetIsValid();}" />
                                </dx:ASPxButton>--%>
                            </div>
                        </div>
                    </div>
                </div>

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

                                <div class="form-group">
                                    <label for="txtDescripcionItem">Descripción del Item:</label>
                                    <textarea class="form-control" rows="3" runat="server" id="txtDescripcionItem"></textarea>
                                </div>
                                <%--             <form class="form-inline">--%>
                                <div class="row">
                                    <div class="col-lg-6">
                                        <div class="input-group">
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
                                            <dx:ASPxTextBox ID="txtNumeroParte" runat="server" Width="170px" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="GuardarItem" ValidationSettings-ErrorTextPosition="Right"></dx:ASPxTextBox>
                                        </div>
                                    </div>
                                </div>
                                <%--   </form>--%>
                            </div>

                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">
                                Cerrar
                            </button>
                            <dx:ASPxButton ID="btnGuardarItem" runat="server" Text="Guardar Item" CssClass="btn btn-primary" ValidationGroup="GuardarItem" OnClick="btnGuardarItem_Click">
                                <ClientSideEvents Click="function(s, e){return textbox2.GetIsValid();}" />
                            </dx:ASPxButton>
                        </div>
                    </div>
                </div>
                </div>
                   
            </ContentTemplate>
        </asp:UpdatePanel>

    </div>
</asp:Content>
