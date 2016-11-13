<%@ Page Title="Concentrado de Ingresos" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="ConcentradoIngresos.aspx.cs" Inherits="SISGRES.ConcentradoIngresos" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<%@ Register assembly="DevExpress.Web.ASPxScheduler.v14.2, Version=14.2.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxScheduler.Controls" tagprefix="dxwschsc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table style="width:100%;">
                <tr>
                    <td>
                        <table style="width:100%;">
                            <tr>
                                <td align="center" valign="top">
                                    <dx:ASPxLabel ID="ASPxLabel5" runat="server" 
                                        Text="Seleccione la Cuenta Bancaria">
                                    </dx:ASPxLabel>
                                    <dx:ASPxComboBox ID="cboCuentasBancarias" runat="server" 
                                        AutoResizeWithContainer="True" DataSourceID="CuentasBancarias" 
                                        EnableTheming="True" HorizontalAlign="Center" 
                                        IncrementalFilteringMode="Contains" 
                                        onselectedindexchanged="cboCuentasBancarias_SelectedIndexChanged" 
                                        style="margin-bottom: 0px" TextField="CUENTA" TextFormatString="{0}" 
                                        Theme="Youthful" ValueField="ID_CUENTA">
                                        <Columns>
                                            <dx:ListBoxColumn Caption="CUENTA" FieldName="CUENTA" />
                                            <dx:ListBoxColumn Caption="BANCO" FieldName="BANCO" />
                                            <dx:ListBoxColumn Caption="MONEDA" FieldName="MONEDA" />
                                        </Columns>
                                        <validationsettings errortextposition="Bottom" setfocusonerror="True" 
                                            validationgroup="Consulta">
                                            <RequiredField IsRequired="True" />
                                        </validationsettings>
                                    </dx:ASPxComboBox>
                                </td>
                                <td align="center" valign="top">
                                    <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="Seleccione el Mes" 
                                        Theme="Youthful">
                                    </dx:ASPxLabel>
                                    <dxwschsc:MonthEdit ID="cboMes" runat="server" HorizontalAlign="Center" 
                                        IncrementalFilteringMode="Contains" Theme="Youthful">
                                        <Items>
                                            <dx:ListEditItem Selected="True" Text="January" Value="1" />
                                            <dx:ListEditItem Text="February" Value="2" />
                                            <dx:ListEditItem Text="March" Value="3" />
                                            <dx:ListEditItem Text="April" Value="4" />
                                            <dx:ListEditItem Text="May" Value="5" />
                                            <dx:ListEditItem Text="June" Value="6" />
                                            <dx:ListEditItem Text="July" Value="7" />
                                            <dx:ListEditItem Text="August" Value="8" />
                                            <dx:ListEditItem Text="September" Value="9" />
                                            <dx:ListEditItem Text="October" Value="10" />
                                            <dx:ListEditItem Text="November" Value="11" />
                                            <dx:ListEditItem Text="December" Value="12" />
                                        </Items>
                                        <validationsettings errortextposition="Bottom" setfocusonerror="True" 
                                            validationgroup="Consulta">
                                            <RequiredField IsRequired="True" />
                                        </validationsettings>
                                    </dxwschsc:MonthEdit>
                                    <asp:SqlDataSource ID="CuentasBancarias" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
                                        SelectCommand="CUENTAS_BANCARIAS_CONSULTAR" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:SessionParameter Name="ID_COMPAÑIA" SessionField="Compañia" Type="Int32" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <dx:ASPxButton ID="Consulta" runat="server" HorizontalAlign="Center" 
                                        onclick="ASPxButton2_Click" Text="Consultar" Theme="Youthful">
                                    </dx:ASPxButton>
                                </td>
                                <td align="center" valign="top">
                                    <dx:ASPxLabel ID="ASPxLabel4" runat="server" Text="Seleccione el Año:">
                                    </dx:ASPxLabel>
                                    <dx:ASPxComboBox ID="cboAño" runat="server" EnableTheming="True" 
                                        HorizontalAlign="Center" IncrementalFilteringMode="Contains" SelectedIndex="0" 
                                        Theme="Youthful">
                                        <Items>
                                            <dx:ListEditItem Selected="True" Text="2014" Value="2014" />
                                            <dx:ListEditItem Text="2015" Value="2015" />
                                            <dx:ListEditItem Text="2016" Value="2016" />
                                        </Items>
                                        <validationsettings errortextposition="Bottom" setfocusonerror="True" 
                                            validationgroup="Consulta">
                                            <RequiredField IsRequired="True" />
                                        </validationsettings>
                                    </dx:ASPxComboBox>
                                </td>
                            </tr>
                        </table>
                        <asp:UpdateProgress ID="UpdateProgress1" runat="server" 
                            AssociatedUpdatePanelID="UpdatePanel1">
                            <progresstemplate>
                                <br />
                                <asp:Image ID="Image2" runat="server" ImageUrl="~/Logos/22.gif" />
                            </progresstemplate>
                        </asp:UpdateProgress>
                        <dx:ASPxGridViewExporter ID="ASPxGridViewExporter1" runat="server" 
                            ExportEmptyDetailGrid="True" GridViewID="GrdIngresos">
                        </dx:ASPxGridViewExporter>
                        <dx:ASPxGridView ID="GrdIngresos" runat="server" AutoGenerateColumns="False" 
                            DataSourceID="Ingresos" EnableTheming="True" KeyFieldName="ID_INGRESO" 
                            Theme="Youthful" Width="100%">
                            <totalsummary>
                                <dx:ASPxSummaryItem DisplayFormat="c2" FieldName="IMPORTE" 
                                    ShowInColumn="IMPORTE" ShowInGroupFooterColumn="IMPORTE" SummaryType="Sum" 
                                    ValueDisplayFormat="c2" />
                            </totalsummary>
                            <Columns>
                                <dx:GridViewCommandColumn ShowClearFilterButton="True" ShowDeleteButton="True" 
                                    ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
                                    <filtertemplate>
                                        <dx:ASPxButton ID="ASPxButton2" runat="server" onclick="ASPxButton2_Click1" 
                                            Text="Exportar" Theme="Youthful" Width="100%">
                                        </dx:ASPxButton>
                                    </filtertemplate>
                                </dx:GridViewCommandColumn>
                                <dx:GridViewDataTextColumn FieldName="ID_INGRESO" ReadOnly="True" 
                                    Visible="False" VisibleIndex="1">
                                    <EditFormSettings Visible="False" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataDateColumn Caption="FECHA DE OPERACION" 
                                    FieldName="FECHA_OPERACION" VisibleIndex="2">
                                </dx:GridViewDataDateColumn>
                                <dx:GridViewDataDateColumn FieldName="FECHA_CREACION" Visible="False" 
                                    VisibleIndex="3">
                                </dx:GridViewDataDateColumn>
                                <dx:GridViewDataTextColumn Caption="IMPORTE" FieldName="IMPORTE" 
                                    VisibleIndex="8">
                                    <propertiestextedit displayformatstring="c2">
                            <masksettings includeliterals="DecimalSymbol" 
                                        mask="$&lt;0..9999999999g&gt;.&lt;00..99&gt;" />
                        </propertiestextedit>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="FOLIO" FieldName="FOLIO" VisibleIndex="13">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataComboBoxColumn Caption="TIPO DE INGRESO" FieldName="ORIGEN" 
                                    VisibleIndex="5">
                                    <propertiescombobox incrementalfilteringmode="Contains">
                            <Items>
                                <dx:ListEditItem Text="PRESTAMO" Value="1" />
                                <dx:ListEditItem Text="VENTA CONTADO" Value="2" />
                                <dx:ListEditItem Text="VENTA CREDITO" Value="3" />
                                <dx:ListEditItem Text="TRANSFERENCIA BANCARIA" Value="4" />
                            </Items>
                        </propertiescombobox>
                                </dx:GridViewDataComboBoxColumn>
                                <dx:GridViewDataComboBoxColumn Caption="DOCUMENTO" FieldName="DOCUMENTO" 
                                    VisibleIndex="7">
                                    <propertiescombobox incrementalfilteringmode="Contains">
                            <Items>
                                <dx:ListEditItem Text="FACTURA" Value="1" />
                                <dx:ListEditItem Text="TRANSFERENCIA" Value="2" />
                                <dx:ListEditItem Text="RECIBO" Value="3" />
                                <dx:ListEditItem Text="CHEQUE" Value="4" />
                            </Items>
                        </propertiescombobox>
                                </dx:GridViewDataComboBoxColumn>
                                <dx:GridViewDataComboBoxColumn Caption="CLIENTE" FieldName="CLIENTE" 
                                    VisibleIndex="14">
                                    <propertiescombobox datasourceid="Clientes" incrementalfilteringmode="Contains" 
                                        textfield="CLIENTE" valuefield="ID_CLIENTE">
                        </propertiescombobox>
                                </dx:GridViewDataComboBoxColumn>
                                <dx:GridViewDataComboBoxColumn Caption="ACREEDOR" FieldName="ACREEDOR" 
                                    VisibleIndex="16">
                                    <propertiescombobox datasourceid="Acreedores" 
                                        incrementalfilteringmode="Contains" textfield="ACREEDOR" 
                                        valuefield="ID_ACREEDOR">
                                    </propertiescombobox>
                                </dx:GridViewDataComboBoxColumn>
                                <dx:GridViewDataComboBoxColumn Caption="MONEDA" FieldName="MONEDA" 
                                    VisibleIndex="9">
                                    <propertiescombobox incrementalfilteringmode="Contains">
                            <Items>
                                <dx:ListEditItem Text="MXN" Value="MXN" />
                                <dx:ListEditItem Text="USD" Value="USD" />
                            </Items>
                        </propertiescombobox>
                                </dx:GridViewDataComboBoxColumn>
                                <dx:GridViewDataComboBoxColumn Caption="CUENTA" FieldName="ID_CUENTA" 
                                    VisibleIndex="19">
                                    <propertiescombobox datasourceid="CuentasBancarias" 
                                        incrementalfilteringmode="Contains" textfield="CUENTA" valuefield="ID_CUENTA">
                        </propertiescombobox>
                                </dx:GridViewDataComboBoxColumn>
                                <dx:GridViewDataComboBoxColumn Caption="CONCEPTO" FieldName="CONCEPTO" 
                                    VisibleIndex="12">
                                    <propertiescombobox datasourceid="Conceptos" 
                                        incrementalfilteringmode="Contains" textfield="CONCEPTO" 
                                        valuefield="ID_CONCEPTO">
                                    </propertiescombobox>
                                </dx:GridViewDataComboBoxColumn>
                                <dx:GridViewDataTextColumn Caption="OBSERVACIONES" FieldName="OBSERVACIONES" 
                                    VisibleIndex="20">
                                </dx:GridViewDataTextColumn>
                            </Columns>
                            <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" 
                    AllowSelectSingleRowOnly="True" ConfirmDelete="True" />
                            <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowFooter="True" ShowHeaderFilterButton="True" ShowPreview="True" ShowTitlePanel="True" />
                            <styles>
                                <cell horizontalalign="Center" verticalalign="Middle" wrap="True">
                                </cell>
                                <header horizontalalign="Center" verticalalign="Middle" wrap="True">
                                </header>
                            </styles>
                        </dx:ASPxGridView>
                        <asp:SqlDataSource ID="Ingresos" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
                            InsertCommand="INGRESOS_INSERTAR" InsertCommandType="StoredProcedure" 
                            SelectCommand="INGRESOS_CONSULTAR_TODOS" SelectCommandType="StoredProcedure" 
                            UpdateCommand="INGRESOS_MODIFICAR" UpdateCommandType="StoredProcedure" 
                            DeleteCommand="INGRESOS_ELIMINAR" DeleteCommandType="StoredProcedure">
                            <DeleteParameters>
                                <asp:Parameter Name="ID_INGRESO" Type="Int32" />
                            </DeleteParameters>
                            <InsertParameters>
                                <asp:Parameter Name="FECHA_OPERACION" Type="DateTime" />
                                <asp:Parameter Name="ORIGEN" Type="Int32" />
                                <asp:Parameter Name="DOCUMENTO" Type="Int32" />
                                <asp:Parameter Name="IMPORTE" Type="Decimal" />
                                <asp:Parameter Name="CONCEPTO" Type="Int32" />
                                <asp:Parameter Name="CLIENTE" Type="Int32" />
                                <asp:Parameter Name="ACREEDOR" Type="Int32" />
                                <asp:Parameter Name="MONEDA" Type="String" />
                                <asp:Parameter Name="ID_CUENTA" Type="Int32" />
                                <asp:Parameter Name="FOLIO" Type="String" />
                                <asp:Parameter Name="ID_CUENTA_ORIGEN" Type="Int32" />
                                <asp:Parameter Name="OBSERVACIONES" Type="String" />
                            </InsertParameters>
                            <SelectParameters>
                                <asp:ControlParameter ControlID="cboCuentasBancarias" Name="ID_CUENTA" 
                                    PropertyName="Value" Type="Int32" />
                                <asp:ControlParameter ControlID="cboMes" Name="MES" PropertyName="Value" 
                                    Type="String" />
                                <asp:ControlParameter ControlID="cboAño" Name="AÑO" PropertyName="Value" 
                                    Type="String" />
                            </SelectParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="ID_INGRESO" Type="Int32" />
                                <asp:Parameter Name="FECHA_OPERACION" Type="DateTime" />
                                <asp:Parameter Name="ORIGEN" Type="Int32" />
                                <asp:Parameter Name="DOCUMENTO" Type="Int32" />
                                <asp:Parameter Name="IMPORTE" Type="Decimal" />
                                <asp:Parameter Name="CONCEPTO" Type="Int32" />
                                <asp:Parameter Name="CLIENTE" Type="Int32" />
                                <asp:Parameter Name="ACREEDOR" Type="Int32" />
                                <asp:Parameter Name="MONEDA" Type="String" />
                                <asp:Parameter Name="ID_CUENTA" Type="Int32" />
                                <asp:Parameter Name="FOLIO" Type="String" />
                                <asp:Parameter Name="ID_CUENTA_ORIGEN" Type="Int32" />
                                <asp:Parameter Name="OBSERVACIONES" Type="String" />
                            </UpdateParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="Clientes" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
                            SelectCommand="CLIENTES_CONSULTAR" SelectCommandType="StoredProcedure">
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="Conceptos" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
                            SelectCommand="CONCEPTOS_CONSULTAR" SelectCommandType="StoredProcedure">
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="Acreedores" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
                            SelectCommand="SELECT [ID_ACREEDOR], [ACREEDOR] FROM [ACREEDORES] ORDER BY [ACREEDOR]">
                        </asp:SqlDataSource>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
    <br />
    <br />
</asp:Content>
