<%@ Page Title="NOMINA" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true"
    CodeBehind="Nomina.aspx.cs" Inherits="SISGRES.Nomina" %>

<%@ Register Assembly="DevExpress.Web.v14.2, Version=14.2.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dx" %>



<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .style1
        {
            height: 105px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">

            <table style="width:100%;">
                <tr>
                    <td align="center" valign="middle">
                        <dx:ASPxRadioButtonList ID="cboOpciones" runat="server" AutoPostBack="True" 
                            EnableTheming="True" onselectedindexchanged="cboOpciones_SelectedIndexChanged" 
                            RepeatDirection="Horizontal" Theme="Youthful">
                            <Items>
                                <dx:ListEditItem Text="NUEVA NOMINA" Value="1" />
                                <dx:ListEditItem Text="NOMINAS ANTERIORES" Value="2" />
                            </Items>
                        </dx:ASPxRadioButtonList>
                        <dx:ASPxPanel ID="pnlHistorico" runat="server" RenderMode="Table" 
                            style="text-align: center" Width="100%">
                            <panelcollection>
                                <dx:PanelContent runat="server">
                                    <dx:ASPxGridView ID="grdHistorico" runat="server" AutoGenerateColumns="False" 
                                        Caption="HISTORICO DE NOMINAS" ClientInstanceName="grdHistorico" 
                                        DataSourceID="NOMINASHISTORICAS" EnableTheming="True" KeyFieldName="ID_NOMINA" 
                                        OnAfterPerformCallback="grdHistorico_AfterPerformCallback" Theme="Youthful" 
                                        Width="100%">
                                        <Columns>
                                            <dx:GridViewDataTextColumn Caption="NUMERO DE NOMINA" FieldName="ID_NOMINA" 
                                                ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="4">
                                                <EditFormSettings Visible="False" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataDateColumn Caption="PERIODO INICIAL" 
                                                FieldName="PERIODO_INICIAL" ShowInCustomizationForm="True" 
                                                VisibleIndex="5">
                                            </dx:GridViewDataDateColumn>
                                            <dx:GridViewDataDateColumn Caption="PERIODO FINAL" FieldName="PERIODO_FINAL" 
                                                ShowInCustomizationForm="True" VisibleIndex="6">
                                            </dx:GridViewDataDateColumn>
                                            <dx:GridViewDataTextColumn ShowInCustomizationForm="True" VisibleIndex="0">
                                                <dataitemtemplate>
                                                    <dx:ASPxButton ID="btnConsultar" runat="server" 
                                                        HorizontalAlign="Center" onclick="btnConsultar_Click" Text="Consultar" 
                                                        Theme="Youthful">
                                                    </dx:ASPxButton>
                                                </dataitemtemplate>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataComboBoxColumn Caption="TIPO DE NOMINA" FieldName="ID_TIPO" 
                                                ShowInCustomizationForm="True" VisibleIndex="7">
                                                <propertiescombobox>
                                        <Items>
                                            <dx:ListEditItem Text="ADMINISTRATIVA" Value="1" />
                                            <dx:ListEditItem Text="OPERATIVA" Value="2" />
                                        </Items>
                                    </propertiescombobox>
                                            </dx:GridViewDataComboBoxColumn>
                                            <dx:GridViewDataTextColumn Caption="Imprimir" ShowInCustomizationForm="True" 
                                                VisibleIndex="1">
                                                <dataitemtemplate>
                                                    <asp:ImageButton ID="btnPrinter" runat="server" ImageUrl="~/Logos/Imprimir.png" 
                                                        onclick="btnPrinter_Click" />
                                                </dataitemtemplate>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataComboBoxColumn Caption="COMPAÑIA" FieldName="ID_COMPAÑIA" 
                                                ShowInCustomizationForm="True" VisibleIndex="8">
                                                <propertiescombobox datasourceid="COMPAÑIA" incrementalfilteringmode="Contains" 
                                                    textfield="COMPAÑIA" valuefield="ID_COMPAÑIA">
                                                </propertiescombobox>
                                            </dx:GridViewDataComboBoxColumn>
                                            <dx:GridViewDataTextColumn Caption="LISTADO DE NOMINA" 
                                                ShowInCustomizationForm="True" VisibleIndex="3">
                                                <DataItemTemplate>
                                                    <dx:ASPxButton ID="btnConsultar" runat="server" AutoPostBack="False" 
                                                        HorizontalAlign="Center" onclick="btnConsultar_Click1" Text="Listado de Nomina" 
                                                        Theme="BlackGlass" UseSubmitBehavior="False">
                                                    </dx:ASPxButton>
                                                </DataItemTemplate>
                                            </dx:GridViewDataTextColumn>
                                        </Columns>
                                        <SettingsBehavior AllowFocusedRow="True" 
                    AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" />
                                        <Settings ShowFilterRow="True" ShowGroupPanel="True" />
                                        <styles>
                                            <cell horizontalalign="Center" verticalalign="Middle" wrap="True">
                                            </cell>
                                            <header horizontalalign="Center" verticalalign="Middle" wrap="True">
                                            </header>
                                        </styles>
                                    </dx:ASPxGridView>
                                    <asp:SqlDataSource ID="NOMINASHISTORICAS" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
                                        SelectCommand="NOMINA_CONSULTAR_TODAS" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:SessionParameter Name="ID_COMPAÑIA" SessionField="Compañia" Type="Int32" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <asp:SqlDataSource ID="COMPAÑIA" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
                                        SelectCommand="COMPAÑIAS_MOSTRAR_TODAS" SelectCommandType="StoredProcedure">
                                    </asp:SqlDataSource>
                                </dx:PanelContent>
                            </panelcollection>
                        </dx:ASPxPanel>
                        <dx:ASPxPanel ID="pnlNuevaNomina" runat="server" Visible="False" Width="100%">
                            <panelcollection>
                                <dx:PanelContent runat="server">
                                    <table width="100%">
                                        <tr>
                                            <td align="center" class="style1" colspan="2">
                                                <dx:ASPxLabel ID="lblNomina" runat="server" Font-Bold="True" ForeColor="Red">
                                                </dx:ASPxLabel>
                                                <br />
                                                <dx:ASPxLabel ID="ASPxLabel5" runat="server" Text="TIPO DE NOMINA:">
                                                </dx:ASPxLabel>
                                                <dx:ASPxComboBox ID="cboTipoNomina" runat="server" 
                                                    AutoResizeWithContainer="True" EnableTheming="True" HorizontalAlign="Center" 
                                                    IncrementalFilteringMode="Contains" Theme="Youthful">
                                                    <Items>
                                                        <dx:ListEditItem Text="Administrativa" Value="1" />
                                                        <dx:ListEditItem Text="Operativa" Value="2" />
                                                    </Items>
                                                </dx:ASPxComboBox>
                                                <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="PERIODO INICIAL" 
                                                    Theme="BlackGlass">
                                                </dx:ASPxLabel>
                                                <dx:ASPxDateEdit ID="PeriodoInicial" runat="server" HorizontalAlign="Center" 
                                                    OnDateChanged="PeriodoInicial_DateChanged" Theme="Youthful">
                                                </dx:ASPxDateEdit>
                                                <dx:ASPxLabel ID="ASPxLabel4" runat="server" Text="PERIODO FINAL" 
                                                    Theme="BlackGlass">
                                                </dx:ASPxLabel>
                                                <dx:ASPxDateEdit ID="PeriodoFinal" runat="server" AutoPostBack="True" 
                                                    HorizontalAlign="Center" OnDateChanged="PeriodoFinal_DateChanged" 
                                                    Theme="Youthful" EnableTheming="True">
                                                </dx:ASPxDateEdit>
                                                <dx:ASPxButton ID="btnNuevaNomina" runat="server" OnClick="ASPxButton2_Click" 
                                                    Text="Generar Nueva Nomina" Theme="Youthful">
                                                </dx:ASPxButton>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <dx:ASPxGridView ID="grdEmpleados" runat="server" AutoGenerateColumns="False" 
                                                    EnableTheming="True" KeyFieldName="ID_EMPLEADO" 
                                                    OnAfterPerformCallback="grdEmpleados_AfterPerformCallback" Theme="Youthful" 
                                                    Width="100%">
                                                    <Columns>
                                                        <dx:GridViewDataTextColumn Caption="NUMERO DE EMPLEADO" FieldName="ID_EMPLEADO" 
                                                            ShowInCustomizationForm="True" VisibleIndex="2">

                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="NOMBRE COMPLETO" FieldName="NOMBRE" 
                                                            ShowInCustomizationForm="True" VisibleIndex="3">
                                                            <propertiestextedit displayformatstring="c2">
                                                </propertiestextedit>
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="DEPARTAMENTO" FieldName="DEPARTAMENTO" 
                                                            ShowInCustomizationForm="True" VisibleIndex="4">
                                                            <propertiestextedit displayformatstring="c2">
                                                </propertiestextedit>
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="PUESTO" FieldName="PUESTO" 
                                                            ShowInCustomizationForm="True" VisibleIndex="5">
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="SUELDO DIARIO" FieldName="SALARIO_DIARIO" 
                                                            ShowInCustomizationForm="True" VisibleIndex="11">
                                                            <propertiestextedit displayformatstring="c2">
                                                            </propertiestextedit>
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="TIPO DE PERSONAL" 
                                                            FieldName="TIPO_PERSONAL" ShowInCustomizationForm="True" VisibleIndex="12">
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="NSS" FieldName="NSS" 
                                                            ShowInCustomizationForm="True" VisibleIndex="13">
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="RFC" FieldName="RFC" 
                                                            ShowInCustomizationForm="True" VisibleIndex="14">
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn 
                                                            ShowInCustomizationForm="True" VisibleIndex="0">
                                                            <dataitemtemplate>
                                                                <dx:ASPxButton ID="btnDiasLaborados" runat="server" 
                                                                    CausesValidation="False" EnableTheming="True" HorizontalAlign="Center" 
                                                                    onclick="btnDiasLaborados_Click" Text="Capturar Dias Laborados" 
                                                                    Theme="BlackGlass" VerticalAlign="Middle" 
                                                                    Width="50px">
                                                                    <ClientSideEvents Click="function(s, e) {

}" />
                                                                </dx:ASPxButton>
                                                            </dataitemtemplate>
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn 
                                                            ShowInCustomizationForm="True" VisibleIndex="1" Visible="False">
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn ShowInCustomizationForm="True" VisibleIndex="15" 
                                                            Caption="COMPAÑIA" FieldName="COMPAÑIA">
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn ShowInCustomizationForm="True" 
                                                            VisibleIndex="16" Caption="DIAS LABORADOS" FieldName="DIAS_LABORADOS">
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="PERCEPCION POR SALARIO" FieldName="PERCEPCION_SALARIO" 
                                                            ShowInCustomizationForm="True" VisibleIndex="18">
                                                            <propertiestextedit displayformatstring="c2">
                                                            </propertiestextedit>
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="OTRAS PERCEPCIONES" FieldName="OTRAS_PERCEPCIONES" 
                                                            ShowInCustomizationForm="True" VisibleIndex="19">
                                                            <propertiestextedit displayformatstring="c2">
                                                </propertiestextedit>
                                                            <propertiestextedit displayformatstring="c2">
                                                            </propertiestextedit>
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="TOTAL A PAGAR" 
                                                            ShowInCustomizationForm="True" VisibleIndex="20" FieldName="TOTAL">                                                            
                                                            <propertiestextedit displayformatstring="c2">
                                                            </propertiestextedit>
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataDateColumn Caption="FECHA DE BAJA" FieldName="FECHA_BAJA" 
                                                            ShowInCustomizationForm="True" VisibleIndex="8">
                                                        </dx:GridViewDataDateColumn>
                                                        <dx:GridViewDataDateColumn Caption="FECHA DE INGRESO" FieldName="FECHA_INGRESO" 
                                                            ShowInCustomizationForm="True" VisibleIndex="7">
                                                        </dx:GridViewDataDateColumn>
                                                        <dx:GridViewDataDateColumn Caption="FECHA DE NACIMIENTO" 
                                                            FieldName="FECHA_NACIMIENTO" ShowInCustomizationForm="True" VisibleIndex="10">
                                                        </dx:GridViewDataDateColumn>
                                                    </Columns>
                                                    <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" 
                                    AllowSelectSingleRowOnly="True" />
                                                    <Settings ShowFilterRow="True" ShowGroupPanel="True" />
                                                    <SettingsDataSecurity AllowDelete="False" 
                                    AllowEdit="False" AllowInsert="False" />
                                                    <styles>
                                                        <header horizontalalign="Center" verticalalign="Middle" wrap="True">
                                                        </header>
                                                        <cell horizontalalign="Center" verticalalign="Middle" wrap="True">
                                                        </cell>
                                                    </styles>
                                                </dx:ASPxGridView>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <dx:ASPxPopupControl ID="popupCalendario" runat="server" 
                                                    ClientInstanceName="popupCalendario" FooterText="" HeaderText="" Modal="True" 
                                                    PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" 
                                                    ShowMaximizeButton="True" ShowPageScrollbarWhenModal="True" Theme="Youthful" 
                                                    Width="430px">
                                                    <contentstyle horizontalalign="Center" verticalalign="Middle" wrap="True">
                                                    </contentstyle>
                                                    <contentcollection>
                                                        <dx:PopupControlContentControl runat="server">
                                                            <dx:ASPxCalendar ID="Calendario" runat="server" DayNameFormat="Full" 
                                                                EnableMultiSelect="True" ShowTodayButton="False" 
                                                                Theme="Youthful" ChangeVisibleDateAnimationType="Slide">
                                                                <DayStyle Font-Bold="True" />
                                                                <DaySelectedStyle BackColor="#3399FF">
                                                                </DaySelectedStyle>
                                                                <DayOtherMonthStyle Font-Bold="False">
                                                                </DayOtherMonthStyle>
                                                                <DayOutOfRangeStyle Font-Bold="True">
                                                                </DayOutOfRangeStyle>
                                                                <DayDisabledStyle HorizontalAlign="Center" VerticalAlign="Middle">
                                                                </DayDisabledStyle>
                                                                <ReadOnlyStyle BackColor="Gray" ForeColor="White">
                                                                </ReadOnlyStyle>
                                                                <DisabledStyle BackColor="Gray" ForeColor="White">
                                                                </DisabledStyle>
                                                            </dx:ASPxCalendar>
                                                            <dx:ASPxGridView ID="grdPercepciones" runat="server" 
                                                                AutoGenerateColumns="False" Caption="OTRAS PERCEPCIONES" 
                                                                DataSourceID="OTRASPERCEPCIONES" EnableTheming="True" KeyboardSupport="True" 
                                                                KeyFieldName="ID_PERCEPCION_DETALLE" Theme="Youthful" Width="100%" 
                                                                EnableCallbackAnimation="True" EnablePagingCallbackAnimation="True">
                                                                <Columns>
                                                                    <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" 
                                                                        ShowInCustomizationForm="True" ShowNewButtonInHeader="True" 
                                                                        VisibleIndex="0">
                                                                    </dx:GridViewCommandColumn>
                                                                    <dx:GridViewDataTextColumn FieldName="ID_PERCEPCION_DETALLE" ReadOnly="True" 
                                                                        ShowInCustomizationForm="True" Visible="False" VisibleIndex="1">
                                                                    </dx:GridViewDataTextColumn>
                                                                    <dx:GridViewDataTextColumn FieldName="ID_NOMINA" ShowInCustomizationForm="True" 
                                                                        Visible="False" VisibleIndex="4">
                                                                    </dx:GridViewDataTextColumn>
                                                                    <dx:GridViewDataTextColumn FieldName="ID_EMPLEADO" 
                                                                        ShowInCustomizationForm="True" Visible="False" VisibleIndex="5">
                                                                        <EditFormSettings Visible="False" />
                                                                    </dx:GridViewDataTextColumn>
                                                                    <dx:GridViewDataTextColumn FieldName="MONTO" 
                                                                        ShowInCustomizationForm="True" VisibleIndex="6">
                                                                        <propertiestextedit displayformatstring="c2">
                                                                        </propertiestextedit>
                                                                    </dx:GridViewDataTextColumn>
                                                                    <dx:GridViewDataComboBoxColumn Caption="PERCEPCION" FieldName="ID_PERCEPCION" 
                                                                        ShowInCustomizationForm="True" VisibleIndex="3">
                                                                        <propertiescombobox datasourceid="Percepciones" 
                                                                            incrementalfilteringmode="Contains" textfield="PERCEPCION" 
                                                                            valuefield="ID_PERCEPCION">
                                                                        </propertiescombobox>
                                                                    </dx:GridViewDataComboBoxColumn>
                                                                </Columns>
                                                                <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" 
                                                        AllowSelectSingleRowOnly="True" ConfirmDelete="True" />
                                                                <Settings ShowFilterRow="True" EnableFilterControlPopupMenuScrolling="True" 
                                                                    ShowFilterBar="Visible" ShowFilterRowMenu="True" 
                                                                    ShowFilterRowMenuLikeItem="True" ShowFooter="True" ShowGroupPanel="True" 
                                                                    ShowHeaderFilterBlankItems="False" ShowHeaderFilterButton="True" 
                                                                    ShowPreview="True" ShowTitlePanel="True" />
                                                                <styles>
                                                                    <header horizontalalign="Center" verticalalign="Middle" wrap="True">
                                                                    </header>
                                                                    <cell horizontalalign="Center" verticalalign="Middle" wrap="True">
                                                                    </cell>
                                                                </styles>
                                                            </dx:ASPxGridView>
                                                            <asp:SqlDataSource ID="OTRASPERCEPCIONES" runat="server" 
                                                                ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
                                                                DeleteCommand="PERCEPCIONES_NOMINA_ELIMINAR" 
                                                                DeleteCommandType="StoredProcedure" 
                                                                InsertCommand="PERCEPCIONES_NOMINA_INSERTAR" 
                                                                InsertCommandType="StoredProcedure" SelectCommand="PERCEPCIONES_NOMINA_MOSTRAR" 
                                                                SelectCommandType="StoredProcedure" 
                                                                UpdateCommand="PERCEPCIONES_NOMINA_MODIFICAR" 
                                                                UpdateCommandType="StoredProcedure">
                                                                <DeleteParameters>
                                                                    <asp:Parameter Name="ID_PERCEPCION_DETALLE" Type="Int32" />
                                                                </DeleteParameters>
                                                                <InsertParameters>
                                                                    <asp:SessionParameter Name="ID_NOMINA" SessionField="Nomina" Type="Int32" />
                                                                    <asp:SessionParameter Name="ID_EMPLEADO" SessionField="ID_EMPLEADO" 
                                                                        Type="Int32" />
                                                                    <asp:Parameter Name="ID_PERCEPCION" Type="Int32" />
                                                                    <asp:Parameter Name="MONTO" Type="Decimal" />
                                                                </InsertParameters>
                                                                <SelectParameters>
                                                                    <asp:SessionParameter Name="ID_NOMINA" SessionField="Nomina" Type="Int32" />
                                                                    <asp:SessionParameter Name="ID_EMPLEADO" SessionField="ID_EMPLEADO" 
                                                                        Type="Int32" />
                                                                </SelectParameters>
                                                                <UpdateParameters>
                                                                    <asp:Parameter Name="ID_PERCEPCION_DETALLE" Type="Int32" />
                                                                    <asp:Parameter Name="ID_PERCEPCION" Type="Int32" />
                                                                    <asp:Parameter Name="MONTO" Type="Decimal" />
                                                                </UpdateParameters>
                                                            </asp:SqlDataSource>
                                                            <asp:SqlDataSource ID="Percepciones" runat="server" 
                                                                ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
                                                                SelectCommand="PERCEPCIONES_CONSULTAR" SelectCommandType="StoredProcedure">
                                                            </asp:SqlDataSource>
                                                            <dx:ASPxButton ID="btnGuardar" runat="server" OnClick="btnGuardar_Click" 
                                                                Text="GUARDAR" Theme="Youthful">
                                                            </dx:ASPxButton>
                                                            <br />
                                                        </dx:PopupControlContentControl>
                                                    </contentcollection>
                                                </dx:ASPxPopupControl>
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                    </table>
                                    <br />
                                </dx:PanelContent>
                            </panelcollection>
                        </dx:ASPxPanel>
                        <dx:ASPxPopupControl ID="popupNomina" runat="server" AllowDragging="True" 
                            AllowResize="True" ClientInstanceName="popupNomina" HeaderText="" Modal="True" 
                            PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" 
                            ShowMaximizeButton="True" ShowPageScrollbarWhenModal="True" 
                            ShowPinButton="True" ShowShadow="False" Theme="Youthful" Width="900px">
                            <contentcollection>
                                <dx:PopupControlContentControl runat="server">
                                    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" 
                                        Font-Size="8pt" InteractiveDeviceInfos="(Collection)" 
                                        WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="100%" 
                                        BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" 
                                        SizeToReportContent="True">
                                    </rsweb:ReportViewer>
                                </dx:PopupControlContentControl>
                            </contentcollection>
                        </dx:ASPxPopupControl>
                        <br />
                    </td>
                </tr>
            </table>

    <br />
</asp:Content>
