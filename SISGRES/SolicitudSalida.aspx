<%@ Page Title="Solicitud de Salidas de Materiales" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="SolicitudSalida.aspx.cs" Inherits="SISGRES.SolicitudSalida" %>

<%@ Register Assembly="DevExpress.Web.v14.2, Version=14.2.12.0, Culture=neutral, PublicKeyToken=B88D1754D700E49A"
    Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
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
    <div class="panel panel-default">
        <!-- Default panel contents -->
        <div class="panel-heading">Solicitud de Salida de Materiales</div>

        <!-- Table -->

        <div class="row">
            <div class="col-lg-4">
                <label for="txtItem">Escriba el elemento que desea solicitar</label>
                <asp:TextBox ID="txtItem" runat="server" BorderStyle="Solid" CssClass="form-control" Font-Names="Trebuchet MS" Font-Size="Large" TabIndex="1" AutoCompleteType="Disabled" placeholder="Escriba el Item"></asp:TextBox>
                <asp:AutoCompleteExtender ID="txtItem_AutoCompleteExtender" runat="server"
                    CompletionInterval="1" CompletionSetCount="1" DelimiterCharacters=""
                    Enabled="True" MinimumPrefixLength="1"
                    ServiceMethod="BusquedaItems" ServicePath="~/ServicioWeb.asmx"
                    TargetControlID="txtItem" ShowOnlyCurrentWordInCompletionListItem="True">
                </asp:AutoCompleteExtender>
            </div>


            <div class="col-lg-4">
                <label for="txtCantidad">Escriba la Cantidad</label>
                <asp:TextBox ID="txtCantidad" runat="server" BorderStyle="Solid" CssClass="form-control" Font-Names="Trebuchet MS" Font-Size="Large" TabIndex="1" AutoCompleteType="Disabled" placeholder="Indique la Cantidad"></asp:TextBox>

            </div>
            <div class="col-lg-4">
                <label for="chkDevolver">¿Devolvera este Elemento?</label>
                <asp:CheckBox ID="chkDevolver" runat="server" />

            </div>
        </div>
        <div class="row">
            <div class="col-lg-4">
                <label for="cboCtroCosto">Seleccione el centro de costo</label>
                <dx:ASPxComboBox ID="cboCtroCosto" runat="server" DataSourceID="CentroCostos" HorizontalAlign="Center" TextField="DESCRIPCION" Theme="Glass" ValueField="ID">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True" />
                    <ValidationSettings ErrorTextPosition="Bottom" SetFocusOnError="True" ValidationGroup="Envio">
                        <RequiredField IsRequired="True" />
                    </ValidationSettings>
                </dx:ASPxComboBox>
                <asp:SqlDataSource ID="CentroCostos" runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>" SelectCommand="CENTRO_COSTOS_CONSULTAR_ACTIVOS" SelectCommandType="StoredProcedure"></asp:SqlDataSource>

            </div>
            <div class="col-lg-4">
                <label for="txtJustificacion">Justificacion</label>
                <dx:ASPxMemo ID="txtJustificacion" runat="server" Height="71px" Width="400px"></dx:ASPxMemo>
            </div>
            <div class="col-lg-4">

                <asp:LinkButton ID="lnkAgregar" runat="server" CssClass="btn btn-primary" OnClick="lnkAgregar_Click">Agregar</asp:LinkButton>
                <span class="label label-default">
                    <dx:ASPxLabel runat="server" ID="lblConteo"></dx:ASPxLabel>
                </span>
            </div>
        </div>





        <dx:ASPxGridView runat="server" KeyFieldName="ID" AutoGenerateColumns="False" DataSourceID="CosultarSalidas" Theme="Office2003Blue" Width="100%" EnableTheming="True" Font-Size="Small" ID="grdSalidas">
            <TotalSummary>
                <dx:ASPxSummaryItem SummaryType="Sum" FieldName="IMPORTE" DisplayFormat="C2" ValueDisplayFormat="C2" ShowInColumn="IMPORTE" ShowInGroupFooterColumn="IMPORTE" Tag="Total:"></dx:ASPxSummaryItem>
            </TotalSummary>
            <Columns>
                <dx:GridViewCommandColumn ShowEditButton="True" ShowDeleteButton="True" ShowNewButtonInHeader="True" ShowInCustomizationForm="True" Width="100px" VisibleIndex="0"></dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" ShowInCustomizationForm="True" Width="100px" Visible="False" VisibleIndex="1">
                    <EditFormSettings Visible="False"></EditFormSettings>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="ITEM" ShowInCustomizationForm="True" VisibleIndex="2"></dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="CANTIDAD" ShowInCustomizationForm="True" Width="100px" VisibleIndex="3"></dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="DEVOLVER" ShowInCustomizationForm="True" Width="100px" VisibleIndex="4"></dx:GridViewDataCheckColumn>
            </Columns>

            <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" ConfirmDelete="True"></SettingsBehavior>

            <SettingsPager Mode="ShowAllRecords" Position="TopAndBottom"></SettingsPager>

            <Settings ShowFilterRow="True" ShowFooter="True"></Settings>

            <SettingsSearchPanel Visible="True"></SettingsSearchPanel>

            <Styles>
                <Header HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True"></Header>

                <Cell HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True"></Cell>
            </Styles>
        </dx:ASPxGridView>




        <asp:SqlDataSource runat="server" ConnectionString="<%$ ConnectionStrings:PARTIDAS %>" DeleteCommand="SALIDAS_ELIMINAR" DeleteCommandType="StoredProcedure" InsertCommand="SALIDAS_INSERTAR" InsertCommandType="StoredProcedure" SelectCommand="SALIDAS_CONSULTAR_TEMPORAL_USUARIOS" SelectCommandType="StoredProcedure" UpdateCommand="SALIDAS_MODIFICAR" UpdateCommandType="StoredProcedure" ID="CosultarSalidas">
            <DeleteParameters>
                <asp:Parameter Name="ID" Type="Int32"></asp:Parameter>
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="ITEM" Type="String"></asp:Parameter>
                <asp:Parameter Name="CANTIDAD" Type="Decimal"></asp:Parameter>
                <asp:Parameter Name="ENTREGO" Type="String"></asp:Parameter>
                <asp:Parameter Name="DEVOLVER" Type="Boolean"></asp:Parameter>
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="CANTIDAD" Type="Decimal"></asp:Parameter>
                <asp:Parameter Name="DEVOLVER" Type="Boolean"></asp:Parameter>
                <asp:Parameter Name="ID" Type="Int32"></asp:Parameter>
            </UpdateParameters>
        </asp:SqlDataSource>
        <dx:ASPxButton runat="server" Text="Enviar Solicitud" Theme="Moderno" ID="btnEnviarRequisicion" OnClick="btnEnviarRequisicion_Click"></dx:ASPxButton>
        <dx:ASPxButton runat="server" Text="Cancelar Solicitud" Theme="Moderno" ID="ASPxButton3" OnClick="ASPxButton3_Click"></dx:ASPxButton>


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
    </div>

</asp:Content>
