<%@ Page Title="Requisiciones" Language="C#" MasterPageFile="~/Principal.Master"
    AutoEventWireup="true" CodeBehind="Requisiciones.aspx.cs" Inherits="SISGRES.Requisiciones" EnableEventValidation="true" %>

<%@ Register Assembly="DevExpress.Web.v14.2, Version=14.2.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v14.2, Version=14.2.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dx1" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <script language="javascript">
        function gridEditor_Init(s, e) {
            if (hf.Contains(s.cpHFKey))
                s.SetValue(hf.Get(s.cpHFKey));
        }

        function gridEditor_ValueChanged(s, e) {
            hf.Set(s.cpHFKey, s.GetValue());
        }
    </script>
    <dx:ASPxHiddenField ID="hiddenField" runat="server" ClientInstanceName="hf">
    </dx:ASPxHiddenField>
    <table style="width: 100%;">
        <tr>
            <td>
                <div>
                    <dx:ASPxPopupControl ID="popupJustificante" runat="server" 
                        ClientInstanceName="popupJustificante" CloseAction="CloseButton" 
                        HeaderText="Describir la Justificación de la Requisición" Modal="True" 
                        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" 
                        Theme="BlackGlass" Width="500px">
                        <ContentStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
                        </ContentStyle>
                        <ContentCollection>
<dx:PopupControlContentControl runat="server">
    <dx:ASPxMemo ID="txtJustificacion" runat="server" Height="71px" Theme="Moderno" 
        Width="100%">
        <ValidationSettings ErrorTextPosition="Bottom" SetFocusOnError="True" 
            ValidationGroup="EnvioRequisicion">
            <RequiredField IsRequired="True" />
        </ValidationSettings>
    </dx:ASPxMemo>
    <br />
    <table style="width:100%;">
        <tr>
            <td>
                <dx:ASPxButton ID="btnEnviarAprobación" runat="server" HorizontalAlign="Center" 
                    OnClick="btnEnviarAprobación_Click" Text="Enviar" Theme="Moderno" 
                    ValidationGroup="EnvioRequisicion" VerticalAlign="Middle">
                </dx:ASPxButton>
            </td>
        </tr>
    </table>
    <br />
                            </dx:PopupControlContentControl>
</ContentCollection>
                    </dx:ASPxPopupControl>
                    <dx:ASPxButton ID="btnEnviarAprobacion" runat="server" AutoPostBack="False" 
                        EnableTheming="True" HorizontalAlign="Center" Text="Enviar a Aprobacion" 
                        Theme="Moderno" UseSubmitBehavior="False" VerticalAlign="Middle">
                        <ClientSideEvents Click="function(s, e) {
	popupJustificante.Show();
}" />
                    </dx:ASPxButton>
                    <asp:AlwaysVisibleControlExtender ID="btnEnviarAprobacion_AlwaysVisibleControlExtender" 
                        runat="server" Enabled="True" TargetControlID="btnEnviarAprobacion" 
                        UseAnimation="True" VerticalSide="Middle">
                    </asp:AlwaysVisibleControlExtender>
                </div>
                <dx:ASPxGridViewExporter ID="ASPxGridViewExporter1" runat="server">
                </dx:ASPxGridViewExporter>
                <dx:ASPxGridView ID="grdHerramientas" runat="server" AutoGenerateColumns="False"
                    Caption="REQUISICIONES DE HERRAMIENTAS" DataSourceID="HERRAMIENTAS_DATOS" EnableTheming="True"
                    KeyFieldName="ID_HERRAMIENTA" Theme="BlackGlass" Width="100%" 
                    OnHtmlDataCellPrepared="grdHerramientas_HtmlDataCellPrepared">
                    <Columns>
                        <dx:GridViewCommandColumn VisibleIndex="0" ShowClearFilterButton="True">
                            <HeaderCaptionTemplate>
                                <table style="width: 100%;">
                                    <tr>
                                        <td align="center">
                                            <asp:ImageButton ID="imgExportar" runat="server" ImageAlign="Middle" 
                                                ImageUrl="~/Logos/Pdf.png" OnClick="imgExportar_Click" />
                                        </td>
                                        <td align="center">
                                            <asp:ImageButton ID="imgExcel" runat="server" ImageUrl="~/Logos/Excel.png" 
                                                OnClick="imgExcel_Click" />
                                        </td>
                                        <td align="center">
                                            <asp:ImageButton ID="imgVer" runat="server" ImageUrl="~/Logos/Detalles.png" 
                                                OnClick="imgVer_Click" />
                                        </td>
                                    </tr>
                                </table>
                            </HeaderCaptionTemplate>
                        </dx:GridViewCommandColumn>
                        <dx:GridViewDataTextColumn Caption="CLAVE DE LA HERRAMIENTA" FieldName="ID_HERRAMIENTA"
                            ReadOnly="True" VisibleIndex="1">
                            <EditFormSettings Visible="False" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="DESCRIPCIÓN" FieldName="HERRAMIENTA" VisibleIndex="2">
                            <Settings AutoFilterCondition="Contains" />
                            <FilterCellStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
                            </FilterCellStyle>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataComboBoxColumn Caption="UNIDAD" FieldName="ID_UNIDAD" VisibleIndex="4">
                            <PropertiesComboBox DataSourceID="UnidadesMedida" IncrementalFilteringMode="Contains"
                                TextField="UNIDAD" ValueField="ID_UNIDAD">
                            </PropertiesComboBox>
                        </dx:GridViewDataComboBoxColumn>
                        <dx:GridViewDataComboBoxColumn Caption="CLASIFICACIÓN" FieldName="ID_GIRO" VisibleIndex="5">
                            <PropertiesComboBox DataSourceID="TipoMaterial" IncrementalFilteringMode="Contains"
                                TextField="GIRO" ValueField="ID_GIRO">
                            </PropertiesComboBox>
                            <Settings AutoFilterCondition="Contains" />
                        </dx:GridViewDataComboBoxColumn>
                        <dx:GridViewDataTextColumn Caption="CANTIDAD" VisibleIndex="6" Name='Cantidad'>
                            <DataItemTemplate>
                                <dx:ASPxTextBox ID="txtCantidad" runat="server" ClientInstanceName="txtCantidad"
                                    HorizontalAlign="Center" Theme="Mulberry" Width="170px" OnInit="txText_Init">
                                    <ClientSideEvents Init="gridEditor_Init" ValueChanged="gridEditor_ValueChanged" />
                                </dx:ASPxTextBox>
                            </DataItemTemplate>
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" />
                    <SettingsPager Mode="ShowAllRecords">
                    </SettingsPager>
                    <Settings ShowTitlePanel="True" ShowFilterRow="True" />
                    <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
                    <Styles>
                        <Cell HorizontalAlign="Center" VerticalAlign="Middle">
                        </Cell>
                        <Header HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
                        </Header>
                    </Styles>
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="HERRAMIENTAS_DATOS" runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>"
                    SelectCommand="HERRAMIENTAS_MOSTRAR_TODOS" SelectCommandType="StoredProcedure">
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="UnidadesMedida" runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>"
                    SelectCommand="UNIDADESMEDIDA_MOSTRAR_TODOS" SelectCommandType="StoredProcedure">
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="TipoMaterial" runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>"
                    SelectCommand="GIROS_MOSTRAR_TODOS" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
                <dx:ASPxPopupControl ID="ASPxPopupControl1" runat="server" CloseAction="None" 
                    HeaderText="" Modal="True" PopupHorizontalAlign="WindowCenter" 
                    PopupVerticalAlign="WindowCenter" Theme="BlackGlass" Width="100%" 
                    ShowPageScrollbarWhenModal="True">
                    <ContentStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
                    </ContentStyle>
                    <ContentCollection>
<dx:PopupControlContentControl runat="server">
    <dx:ASPxLabel ID="ASPxLabel1" runat="server" 
        Text="SE GENERO LA REQUISICION EXITOSAMENTE Y SE ENVIO A APROBACIÓN" 
        Theme="Moderno">
    </dx:ASPxLabel>
    <br />
    <br />
    <dx:ASPxButton ID="ASPxButton1" runat="server" OnClick="ASPxButton1_Click" 
        Text="ACEPTAR" Theme="Metropolis">
    </dx:ASPxButton>
                        </dx:PopupControlContentControl>
</ContentCollection>
                </dx:ASPxPopupControl>
                <dx:ASPxPopupControl ID="popupRequisicion" runat="server" 
                    ClientInstanceName="popupRequisicion" HeaderText="Requisición" Modal="True" 
                    PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" 
                    ShowPageScrollbarWhenModal="True" Theme="BlackGlass" Width="700px">
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
            </td>
        </tr>
    </table>
</asp:Content>
