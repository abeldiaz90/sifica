<%@ Page Title="EGRESOS" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Egresos.aspx.cs" Inherits="SISGRES.Egresos" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<%@ Register assembly="DevExpress.Web.ASPxScheduler.v14.2, Version=14.2.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxScheduler.Controls" tagprefix="dxwschsc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .style1
        {
            text-align: center;
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <table style="width:100%;">
        <tr>
            <td colspan="4">
                <table style="width:100%;">
                    <tr>
                        <td>
                            <table style="width:100%;">
                                <tr>
                                    <td align="center" valign="top">
                                        <dx:ASPxLabel ID="ASPxLabel3" runat="server" 
                                            Text="SELECCIONE LA CUENTA BANCARIA">
                                        </dx:ASPxLabel>
                        <dx:ASPxComboBox ID="cboCuentasBancarias" runat="server" 
                            AutoResizeWithContainer="True" DataSourceID="CuentasBancarias" 
                            EnableTheming="True" HorizontalAlign="Center" 
                            IncrementalFilteringMode="Contains" 
                            onselectedindexchanged="cboCuentasBancarias_SelectedIndexChanged" 
                            TextField="CUENTA" TextFormatString="{0}" Theme="Youthful" 
                            ValueField="ID_CUENTA">
                            <Columns>
                                <dx:ListBoxColumn Caption="CUENTA" FieldName="CUENTA" />
                                <dx:ListBoxColumn Caption="BANCO" FieldName="BANCO" />
                                <dx:ListBoxColumn Caption="MONEDA" FieldName="MONEDA" />
                            </Columns>
                            <ValidationSettings ErrorTextPosition="Bottom" SetFocusOnError="True" 
                                ValidationGroup="Consulta">
                                <RequiredField IsRequired="True" />
                            </ValidationSettings>
                        </dx:ASPxComboBox>
                                    </td>
                                    <td align="center" valign="top">
                                        <dx:ASPxLabel ID="ASPxLabel4" runat="server" Text="MES">
                                        </dx:ASPxLabel>
                                        <dxwschsc:MonthEdit ID="cboMes" runat="server" HorizontalAlign="Center" 
                                            IncrementalFilteringMode="Contains" Theme="Youthful">
                                            <Items>
<dx:ListEditItem Selected="True" Text="January" Value="1"></dx:ListEditItem>
<dx:ListEditItem Text="February" Value="2"></dx:ListEditItem>
<dx:ListEditItem Text="March" Value="3"></dx:ListEditItem>
<dx:ListEditItem Text="April" Value="4"></dx:ListEditItem>
<dx:ListEditItem Text="May" Value="5"></dx:ListEditItem>
<dx:ListEditItem Text="June" Value="6"></dx:ListEditItem>
<dx:ListEditItem Text="July" Value="7"></dx:ListEditItem>
<dx:ListEditItem Text="August" Value="8"></dx:ListEditItem>
<dx:ListEditItem Text="September" Value="9"></dx:ListEditItem>
<dx:ListEditItem Text="October" Value="10"></dx:ListEditItem>
<dx:ListEditItem Text="November" Value="11"></dx:ListEditItem>
<dx:ListEditItem Text="December" Value="12"></dx:ListEditItem>
</Items>
                                            <ValidationSettings ErrorTextPosition="Bottom" SetFocusOnError="True" 
                                                ValidationGroup="Consulta">
                                                <RequiredField IsRequired="True" />
                                            </ValidationSettings>
                                        </dxwschsc:MonthEdit>
                                        <dx:ASPxButton ID="ASPxButton2" runat="server" onclick="ASPxButton2_Click" 
                                            Text="Consulta" Theme="Youthful">
                                        </dx:ASPxButton>
                        <asp:SqlDataSource ID="CuentasBancarias" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
                            SelectCommand="CUENTAS_BANCARIAS_CONSULTAR" 
                            SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:SessionParameter Name="ID_COMPAÑIA" SessionField="Compañia" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                                    </td>
                                    <td align="center" valign="top">
                                        <dx:ASPxLabel ID="ASPxLabel5" runat="server" Text="AÑO" Theme="Youthful">
                                        </dx:ASPxLabel>
                                        <dx:ASPxComboBox ID="cboAño" runat="server" EnableTheming="True" 
                                            HorizontalAlign="Center" IncrementalFilteringMode="Contains" Theme="Youthful">
                                            <Items>
                                                <dx:ListEditItem Text="2014" Value="2014" />
                                                <dx:ListEditItem Text="2015" Value="2015" />
                                                <dx:ListEditItem Text="2016" Value="2016" />
                                            </Items>
                                            <ValidationSettings ErrorTextPosition="Bottom" SetFocusOnError="True" 
                                                ValidationGroup="Consulta">
                                                <RequiredField IsRequired="True" />
                                            </ValidationSettings>
                                        </dx:ASPxComboBox>
                                    </td>
                                </tr>
                            </table>
                            <dx:ASPxGridViewExporter ID="ASPxGridViewExporter1" runat="server">
                            </dx:ASPxGridViewExporter>
                <dx:ASPxGridView ID="grdEgresos" runat="server" AutoGenerateColumns="False" 
                    Caption="EGRESOS" DataSourceID="EGRESOSDATOS" EnableTheming="True" 
                    KeyboardSupport="True" KeyFieldName="ID_EGRESO" Theme="Youthful">
                    <TotalSummary>
                        <dx:ASPxSummaryItem DisplayFormat="c2" FieldName="IMPORTE" 
                            ShowInColumn="IMPORTE" ShowInGroupFooterColumn="IMPORTE" SummaryType="Sum" 
                            ValueDisplayFormat="c2" />
                        <dx:ASPxSummaryItem DisplayFormat="c2" FieldName="IMPORTE_USD" 
                            ShowInColumn="IMPORTE USD" ShowInGroupFooterColumn="IMPORTE USD" 
                            SummaryType="Sum" ValueDisplayFormat="c2" />
                    </TotalSummary>
                    <Columns>
                        <dx:GridViewCommandColumn SelectAllCheckboxMode="Page" ShowDeleteButton="True" 
                            ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
                            <FilterTemplate>
                                <dx:ASPxButton ID="ASPxButton3" runat="server" onclick="ASPxButton3_Click" 
                                    Text="Exportar" Theme="Youthful" Width="100%">
                                </dx:ASPxButton>
                            </FilterTemplate>
                        </dx:GridViewCommandColumn>
                        <dx:GridViewDataTextColumn 
                            FieldName="ID_EGRESO" ReadOnly="True" VisibleIndex="2" Caption="ID">
                            <EditFormSettings Visible="False" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="IMPORTE MXN" FieldName="IMPORTE" 
                            VisibleIndex="7">
                            <PropertiesTextEdit DisplayFormatString="c2">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="FOLIO" 
                            VisibleIndex="11">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataDateColumn FieldName="FECHA_CREACION" 
                            VisibleIndex="12" Visible="False">
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataDateColumn Caption="FECHA DE SOLICITUD" 
                            FieldName="FECHA_OPERACION" VisibleIndex="3">
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataTextColumn Caption="IMPORTE USD" FieldName="IMPORTE_USD" 
                            VisibleIndex="8">
                            <PropertiesTextEdit DisplayFormatString="c2">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataComboBoxColumn FieldName="MONEDA" VisibleIndex="9">
                            <PropertiesComboBox IncrementalFilteringMode="Contains">
                                <Items>
                                    <dx:ListEditItem Text="MXN" Value="1" />
                                    <dx:ListEditItem Text="USD" Value="2" />
                                </Items>
                            </PropertiesComboBox>
                        </dx:GridViewDataComboBoxColumn>
                        <dx:GridViewDataComboBoxColumn FieldName="TIPO" VisibleIndex="10">
                            <PropertiesComboBox IncrementalFilteringMode="Contains">
                                <Items>
                                    <dx:ListEditItem Text="CHEQUE" Value="1" />
                                    <dx:ListEditItem Text="TRANSFERENCIA" Value="2" />
                                </Items>
                            </PropertiesComboBox>
                        </dx:GridViewDataComboBoxColumn>
                        <dx:GridViewDataComboBoxColumn Caption="SOLICITADO POR:" 
                            FieldName="SOLICITANTE" VisibleIndex="13">
                            <PropertiesComboBox DataSourceID="EMPLEADOS" 
                                IncrementalFilteringMode="Contains" TextField="NOMBRE" ValueField="ID_EMPLEADO">
                            </PropertiesComboBox>
                        </dx:GridViewDataComboBoxColumn>
                        <dx:GridViewDataComboBoxColumn Caption="AUTORIZADO POR:" 
                            FieldName="AUTORIZADOR" VisibleIndex="14">
                            <PropertiesComboBox DataSourceID="EMPLEADOS" 
                                IncrementalFilteringMode="Contains" TextField="NOMBRE" ValueField="ID_EMPLEADO">
                            </PropertiesComboBox>
                        </dx:GridViewDataComboBoxColumn>
                        <dx:GridViewDataComboBoxColumn Caption="RECIBIDO POR:" FieldName="RECIBIDO_POR" 
                            VisibleIndex="15">
                            <PropertiesComboBox DataSourceID="EMPLEADOS" 
                                IncrementalFilteringMode="Contains" TextField="NOMBRE" ValueField="ID_EMPLEADO">
                            </PropertiesComboBox>
                        </dx:GridViewDataComboBoxColumn>
                        <dx:GridViewDataComboBoxColumn FieldName="BENEFICIARIO" VisibleIndex="16">
                            <PropertiesComboBox DataSourceID="BENEFICIARIOS" TextField="BENEFICIARIO" 
                                ValueField="BENEFICIARIO" IncrementalFilteringMode="Contains">
                            </PropertiesComboBox>
                        </dx:GridViewDataComboBoxColumn>
                        <dx:GridViewDataComboBoxColumn Caption="PROYECTO" FieldName="ID_PROYECTO" 
                            VisibleIndex="18">
                            <PropertiesComboBox DataSourceID="PROYECTOS" 
                                IncrementalFilteringMode="Contains" TextField="PROYECTO" 
                                ValueField="ID_PROYECTO">
                            </PropertiesComboBox>
                        </dx:GridViewDataComboBoxColumn>
                        <dx:GridViewDataComboBoxColumn Caption="COMPAÑIA" FieldName="ID_COMPAÑIA" 
                            VisibleIndex="17">
                            <PropertiesComboBox DataSourceID="Compañias" 
                                IncrementalFilteringMode="Contains" TextField="COMPAÑIA" 
                                ValueField="ID_COMPAÑIA">
                            </PropertiesComboBox>
                        </dx:GridViewDataComboBoxColumn>
                        <dx:GridViewDataComboBoxColumn Caption="CUENTA DESTINO" 
                            FieldName="ID_CUENTA_DESTINO" VisibleIndex="19" Visible="False">
                            <PropertiesComboBox DataSourceID="CuentasBancarias" 
                                IncrementalFilteringMode="Contains" TextField="CUENTA" ValueField="ID_CUENTA">
                            </PropertiesComboBox>
                        </dx:GridViewDataComboBoxColumn>
                        <dx:GridViewDataComboBoxColumn FieldName="CONCEPTO" VisibleIndex="6">
                            <PropertiesComboBox DataSourceID="Conceptos" 
                                IncrementalFilteringMode="Contains" TextField="CONCEPTO" 
                                ValueField="ID_CONCEPTO">
                            </PropertiesComboBox>
                            <Settings AllowAutoFilterTextInputTimer="True" AutoFilterCondition="Contains" />
                        </dx:GridViewDataComboBoxColumn>
                        <dx:GridViewDataTextColumn VisibleIndex="1">
                            <EditFormSettings Visible="False" />
                            <DataItemTemplate>
                                <asp:ImageButton ID="imgImprimir" runat="server" ImageAlign="Middle" 
                                    ImageUrl="~/Logos/Imprimir.png" onclick="imgImprimir_Click" />
                            </DataItemTemplate>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="OBSERVACIONES" FieldName="OBSERVACIONES" 
                            VisibleIndex="20">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataDateColumn Caption="FECHA DE PAGO" FieldName="FECHA_PAGO" 
                            VisibleIndex="5">
                        </dx:GridViewDataDateColumn>
                    </Columns>
                    <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" 
                        AllowSelectSingleRowOnly="True" ConfirmDelete="True" />
                    <SettingsEditing Mode="PopupEditForm">
                    </SettingsEditing>
                    <Settings ShowFilterRow="True" ShowFooter="True" ShowGroupedColumns="True" 
                        ShowGroupPanel="True" />
                    <SettingsPopup>
                        <EditForm AllowResize="True" HorizontalAlign="WindowCenter" Modal="True" 
                            VerticalAlign="WindowCenter" Width="700px" />
                    </SettingsPopup>
                    <Styles>
                        <Cell HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
                        </Cell>
                        <Header HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
                        </Header>
                    </Styles>
                </dx:ASPxGridView>
                        </td>
                    </tr>
                </table>
                <dx:ASPxPopupControl ID="popupDetalle" runat="server" 
                    ClientInstanceName="popupDetalle" FooterText="" HeaderText="" 
                    PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" 
                    ShowMaximizeButton="True" ShowPageScrollbarWhenModal="True" 
                    ShowPinButton="True" ShowRefreshButton="True" Theme="BlackGlass" Width="900px">
                    <ContentCollection>
<dx:PopupControlContentControl runat="server">
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" 
        Font-Size="8pt" InteractiveDeviceInfos="(Collection)" 
        WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="100%">
    </rsweb:ReportViewer>
                        </dx:PopupControlContentControl>
</ContentCollection>
                </dx:ASPxPopupControl>
                <br />
                <asp:SqlDataSource ID="EGRESOSDATOS" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
                    DeleteCommand="EGRESOS_ELIMINAR" DeleteCommandType="StoredProcedure" 
                    InsertCommand="EGRESOS_INSERTAR" InsertCommandType="StoredProcedure" 
                    SelectCommand="EGRESOS_CONSULTAR" SelectCommandType="StoredProcedure" 
                    UpdateCommand="EGRESOS_MODIFICAR" UpdateCommandType="StoredProcedure">
                    <DeleteParameters>
                        <asp:Parameter Name="ID_EGRESO" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="IMPORTE" Type="Decimal" />
                        <asp:Parameter Name="MONEDA" Type="String" />
                        <asp:Parameter Name="CONCEPTO" Type="String" />
                        <asp:Parameter Name="TIPO" Type="Int32" />
                        <asp:Parameter Name="FOLIO" Type="String" />
                        <asp:Parameter Name="FECHA_OPERACION" Type="DateTime" />
                        <asp:Parameter Name="SOLICITANTE" Type="Int32" />
                        <asp:Parameter Name="AUTORIZADOR" Type="Int32" />
                        <asp:Parameter Name="RECIBIDO_POR" Type="Int32" />
                        <asp:Parameter Name="BENEFICIARIO" Type="String" />
                        <asp:SessionParameter Name="ID_COMPAÑIA" SessionField="Compañia" Type="Int32" />
                        <asp:Parameter Name="IMPORTE_USD" Type="Decimal" />
                        <asp:Parameter Name="ID_PROYECTO" Type="Int32" />
                        <asp:Parameter Name="ID_CUENTA" Type="Int32" />
                        <asp:Parameter Name="ID_CUENTA_DESTINO" Type="Int32" />
                        <asp:Parameter Name="ESTADO" Type="Int32" />
                        <asp:Parameter Name="OBSERVACIONES" Type="String" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:SessionParameter Name="ID_COMPAÑIA" SessionField="Compañia" Type="Int32" />
                        <asp:ControlParameter ControlID="cboCuentasBancarias" Name="ID_CUENTA" 
                            PropertyName="Value" Type="Int32" />
                        <asp:ControlParameter ControlID="cboMes" Name="MES" PropertyName="Value" 
                            Type="String" />
                        <asp:ControlParameter ControlID="cboAño" Name="AÑO" PropertyName="Value" 
                            Type="String" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="ID_EGRESO" Type="Int32" />
                        <asp:Parameter Name="IMPORTE" Type="Decimal" />
                        <asp:Parameter Name="MONEDA" Type="String" />
                        <asp:Parameter Name="CONCEPTO" Type="String" />
                        <asp:Parameter Name="TIPO" Type="Int32" />
                        <asp:Parameter Name="FOLIO" Type="String" />
                        <asp:Parameter Name="FECHA_OPERACION" Type="DateTime" />
                        <asp:Parameter Name="SOLICITANTE" Type="Int32" />
                        <asp:Parameter Name="AUTORIZADOR" Type="Int32" />
                        <asp:Parameter Name="RECIBIDO_POR" Type="Int32" />
                        <asp:Parameter Name="BENEFICIARIO" Type="String" />
                        <asp:Parameter Name="IMPORTE_USD" Type="Decimal" />
                        <asp:Parameter Name="ID_PROYECTO" Type="Int32" />
                        <asp:Parameter Name="OBSERVACIONES" Type="String" />
                        <asp:Parameter Name="FECHA_PAGO" Type="DateTime" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="BENEFICIARIOS" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
                    SelectCommand="BENEFICIARIOS_CONSULTAR" SelectCommandType="StoredProcedure">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>
                <asp:SqlDataSource ID="EMPLEADOS" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
                    SelectCommand="EMPLEADOS_MOSTRAR_ID_COMPAÑIA" 
                    SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="ID_COMPAÑIA" SessionField="Compañia" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="PROYECTOS" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
                    SelectCommand="SELECT 0 AS ID_PROYECTO,'SIN PROYECTO' AS PROYECTO 
UNION
SELECT ID_PROYECTO,PROYECTO FROM PROYECTOS WHERE ID_COMPAÑIA=@ID_COMPAÑIA">
                    <SelectParameters>
                        <asp:SessionParameter Name="ID_COMPAÑIA" SessionField="Compañia" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="Compañias" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
                    SelectCommand="COMPAÑIAS_MOSTRAR_ID" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="ID_COMPAÑIA" SessionField="Compañia" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="Conceptos" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
                    SelectCommand="CONCEPTOS_CONSULTAR" SelectCommandType="StoredProcedure">
                </asp:SqlDataSource>
            </td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
    </table>
</asp:Content>
