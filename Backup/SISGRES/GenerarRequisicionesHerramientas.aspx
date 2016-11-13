<%@ Page Title="Creacion de Requisiciones De Herramientas" Language="C#" MasterPageFile="~/Principal.Master"
    AutoEventWireup="true" CodeBehind="GenerarRequisicionesHerramientas.aspx.cs"
    Inherits="SISGRES.GenerarRequisicionesHerramientas" %>

<%@ Register Assembly="DevExpress.Web.v14.2, Version=14.2.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>






<%@ Register Assembly="DevExpress.Web.v14.2, Version=14.2.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dx1" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .style2
        {
        }
        .style3
        {
            height: 32px;
        }
        .style4
        {
            height: 32px;
            width: 350px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">

            <br />
            <dx:ASPxMenu ID="ASPxMenu2" runat="server" EnableTheming="True" Theme="BlackGlass"
                OnItemClick="ASPxMenu2_ItemClick">
                <ClientSideEvents ItemClick="function(s, e) {

}" />
                <Items>
                    <dx:MenuItem Name="Historial" Text="Historial de Requisiciones">
                    </dx:MenuItem>
                    <dx:MenuItem Name="Catalogo" Text="Catalogo de Herramientas">
                    </dx:MenuItem>
                </Items>
            </dx:ASPxMenu>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" 
                        HeaderText="Captura de Requisiciones" HorizontalAlign="Center" 
                        ShowCollapseButton="true" Theme="Metropolis" Width="100%">
                        <panelcollection>
                            <dx:PanelContent runat="server">
                                <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="HERRAMIENTA:">
                                </dx:ASPxLabel>
                                    <br />
                                    <asp:TextBox ID="txtItem" runat="server" BorderStyle="Solid" 
                                    Font-Names="Trebuchet MS" Font-Size="Medium" TabIndex="1" Width="800px"></asp:TextBox>
                                <asp:AutoCompleteExtender ID="txtItem_AutoCompleteExtender" runat="server" 
                                    CompletionInterval="1" CompletionSetCount="1" DelimiterCharacters="" 
                                    Enabled="True" MinimumPrefixLength="1" 
                                    ServiceMethod="BusquedaElementosHerramientas" ServicePath="~/ServicioWeb.asmx" 
                                    TargetControlID="txtItem">
                                </asp:AutoCompleteExtender>
                                    <br />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                    BorderStyle="Solid" ControlToValidate="txtItem" Display="None" 
                                    ErrorMessage="Capture y Seleccione el Material" Font-Bold="True" 
                                    ForeColor="Red" SetFocusOnError="True" ValidationGroup="Agregar"></asp:RequiredFieldValidator>
                                    <br />
                                    <dx:ASPxLabel ID="ASPxLabel4" runat="server" Text="CANTIDAD">
                                </dx:ASPxLabel>
                                <asp:ValidatorCalloutExtender ID="RequiredFieldValidator1_ValidatorCalloutExtender" 
                                    runat="server" Enabled="True" PopupPosition="BottomRight" 
                                    TargetControlID="RequiredFieldValidator1">
                                </asp:ValidatorCalloutExtender>
                                <dx:ASPxTextBox ID="txtCantidad" runat="server" AutoResizeWithContainer="True" 
                                    Font-Size="Large" HorizontalAlign="Center" Theme="BlackGlass" Width="170px">
                                        <MaskSettings Mask="&lt;0..99999999g&gt;.&lt;00..99&gt;" />
                                        <validationsettings errortextposition="Bottom" setfocusonerror="True">
                                            <RequiredField IsRequired="True" />
                                        </validationsettings>
                                        <Border BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" />
                                    </dx:ASPxTextBox>
                                <asp:ImageButton ID="imgGuardar" runat="server" 
                                    ImageUrl="~/Imagenes/1395205972_save.png" OnClick="imgGuardar_Click" 
                                    Visible="False" />
                                <table>
                                    <tr>
                                        <td align="center">
                                            <dx:ASPxButton ID="Agregar" runat="server" HorizontalAlign="Center" 
                                                OnClick="Agregar_Click" Text="Agregar" Theme="Moderno" 
                                                ValidationGroup="Agregar">
                                            </dx:ASPxButton>
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        </td>
                                        <td align="center">
                                            <dx:ASPxButton ID="btnEnviarRequisicion" runat="server" 
                                                HorizontalAlign="Center" OnClick="btnEnviarRequisicion_Click" 
                                                Text="Enviar a Aprobación" Theme="Moderno">
                                            </dx:ASPxButton>
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        </td>
                                        <td align="center">
                                            <dx:ASPxButton ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" 
                                                Text="Limpiar" Theme="Moderno">
                                            </dx:ASPxButton>
                                        </td>
                                    </tr>
                                </table>
                                <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
                                    EnableTheming="True" Font-Size="Large" KeyFieldName="ID_PARTIDA" 
                                    OnAfterPerformCallback="ASPxGridView1_AfterPerformCallback" Theme="BlackGlass" 
                                    Width="100%">
                                    <Columns>
                                        <dx:GridViewDataTextColumn Caption="PARTIDA" FieldName="ID_PARTIDA" 
                                            ShowInCustomizationForm="True" VisibleIndex="1">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn Caption="CLAVE DE LA HERRAMIENTA" 
                                            FieldName="ID_HERRAMIENTA" ShowInCustomizationForm="True" VisibleIndex="2">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn Caption="DESCRIPCIÓN" FieldName="HERRAMIENTA" 
                                            ShowInCustomizationForm="True" VisibleIndex="3">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn Caption="CANTIDAD" FieldName="CANTIDAD" 
                                            ShowInCustomizationForm="True" VisibleIndex="7">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn ShowInCustomizationForm="True" VisibleIndex="0">
                                            <dataitemtemplate>
                                                <asp:LinkButton ID="lnkModificar" runat="server" OnClick="lnkModificar_Click">Modificar</asp:LinkButton>
                                                &nbsp;&nbsp;&nbsp;
                                                <asp:LinkButton ID="lnkEliminar" runat="server" OnClick="lnkEliminar_Click">Eliminar</asp:LinkButton>
                                            </dataitemtemplate>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn Caption="NUMERO DE PARTE" FieldName="NUMBER_PART" 
                                            ShowInCustomizationForm="True" VisibleIndex="6">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataComboBoxColumn Caption="UNIDAD DE MEDIDA" FieldName="UNIDAD" 
                                            ShowInCustomizationForm="True" VisibleIndex="5">
                                            <propertiescombobox datasourceid="UNIDAD" incrementalfilteringmode="Contains" 
                                                textfield="UNIDAD" valuefield="ID_UNIDAD">
                                            </propertiescombobox>
                                        </dx:GridViewDataComboBoxColumn>
                                    </Columns>
                                    <SettingsBehavior AllowFocusedRow="True" 
                                            AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" />
                                    <settingspager mode="ShowAllRecords" position="TopAndBottom">
                                    </settingspager>
                                    <styles>
                                        <cell horizontalalign="Center" verticalalign="Middle" wrap="True">
                                        </cell>
                                        <header horizontalalign="Center" verticalalign="Middle" wrap="True">
                                        </header>
                                    </styles>
                                </dx:ASPxGridView>
                                <asp:SqlDataSource ID="UNIDAD" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
                                    SelectCommand="UNIDADESMEDIDA_MOSTRAR_TODOS" 
                                    SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                <dx:ASPxPopupControl ID="popupEnvioRequisicion" runat="server" 
                                    HeaderText="DATOS DE ENTREGA" Modal="True" PopupHorizontalAlign="WindowCenter" 
                                    PopupVerticalAlign="WindowCenter" ShowPageScrollbarWhenModal="True" 
                                    Theme="BlackGlass" Width="700px">
                                    <contentcollection>
                                        <dx:PopupControlContentControl runat="server">
                                            <table style="width: 100%;">
                                                <tr>
                                                    <td align="center" class="style4" valign="top">
                                                        <dx:ASPxLabel ID="ASPxLabel5" runat="server" Text="Lugar de Entrega:">
                                                        </dx:ASPxLabel>
                                                        <dx:ASPxMemo ID="txtLugarEntrega" runat="server" Height="71px" 
                                                            Theme="BlackGlass" Width="90%">
                                                            <validationsettings errortextposition="Bottom" setfocusonerror="True" 
                                                                validationgroup="ValidacionGuardado">
                                                                <RequiredField IsRequired="True" />
                                                            </validationsettings>
                                                        </dx:ASPxMemo>
                                                    </td>
                                                    <td align="center" class="style3" valign="top">
                                                        <dx:ASPxLabel ID="ASPxLabel6" runat="server" Text="Fecha de Entrega:">
                                                        </dx:ASPxLabel>
                                                        <dx:ASPxDateEdit ID="FechaEntrega" runat="server" Theme="BlackGlass">
                                                            <validationsettings errortextposition="Bottom" setfocusonerror="True" 
                                                                validationgroup="ValidacionGuardado">
                                                                <RequiredField IsRequired="True" />
                                                            </validationsettings>
                                                        </dx:ASPxDateEdit>
                                                        <dx:ASPxLabel ID="ASPxLabel8" runat="server" Text="Nombre del Proyecto:">
                                                        </dx:ASPxLabel>
                                                        <dx:ASPxComboBox ID="cboProyectos" runat="server" DataSourceID="DatosProyectos" 
                                                            HorizontalAlign="Center" IncrementalFilteringMode="Contains" 
                                                            TextField="PROYECTO" Theme="BlackGlass" ValueField="ID_PROYECTO">
                                                            <validationsettings errortextposition="Bottom" setfocusonerror="True" 
                                                                validationgroup="ValidacionGuardado">
                                                                <RequiredField IsRequired="True" />
                                                            </validationsettings>
                                                        </dx:ASPxComboBox>
                                                        <asp:SqlDataSource ID="DatosProyectos" runat="server" 
                                                            ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
                                                            SelectCommand="SELECT [ID_PROYECTO], [PROYECTO] FROM [PROYECTOS] ORDER BY [PROYECTO]">
                                                        </asp:SqlDataSource>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        <dx:ASPxButton ID="ASPxButton2" runat="server" OnClick="ASPxButton2_Click" 
                                                            Style="height: 21px" Text="Enviar" Theme="BlackGlass" 
                                                            ValidationGroup="ValidacionGuardado">
                                                        </dx:ASPxButton>
                                                        <br />
                                                        <asp:Label ID="lblError" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </dx:PopupControlContentControl>
                                    </contentcollection>
                                </dx:ASPxPopupControl>
                            </dx:PanelContent>
                        </panelcollection>
                    </dx:ASPxRoundPanel>
                </ContentTemplate>
            </asp:UpdatePanel>
            <table style="width: 100%;">
                <tr>
                    <td class="style2" bgcolor="#CCCCCC">
            <dx:ASPxPopupControl ID="popupRequisiciones" runat="server" ClientInstanceName="popupRequisiciones"
                ContentUrl="~/Herramientas.aspx" HeaderText="" Height="700px" Modal="True" PopupHorizontalAlign="WindowCenter"
                PopupVerticalAlign="WindowCenter" Theme="BlackGlass" Width="1100px">
            </dx:ASPxPopupControl>
            <dx:ASPxPopupControl ID="popupHistorialRequisiciones" runat="server" ClientInstanceName="popupHistorialRequisiciones"
                HeaderText="Mis Requisiciones" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter"
                Theme="BlackGlass" Width="1100px">
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <dx:ASPxGridView ID="grdAprobaciones" runat="server" AutoGenerateColumns="False"
                            ClientInstanceName="grdAprobaciones" EnableCallbackAnimation="True" EnablePagingCallbackAnimation="True"
                            EnableTheming="True" KeyFieldName="ID_REQUISICION" Theme="BlackGlass" Width="100%">
                            <Columns>
                                <dx:GridViewCommandColumn SelectAllCheckboxMode="Page" ShowInCustomizationForm="True"
                                    ShowSelectCheckbox="True" VisibleIndex="0">
                                </dx:GridViewCommandColumn>
                                <dx:GridViewDataTextColumn Caption="FOLIO" FieldName="ID_REQUISICION" ReadOnly="True"
                                    ShowInCustomizationForm="True" VisibleIndex="1">
                                    <EditFormSettings Visible="False" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="NOMBRE DEL SOLICITANTE" FieldName="NOMBRE" ReadOnly="True"
                                    ShowInCustomizationForm="True" VisibleIndex="2">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="CORREO ELECTRÓNICO" FieldName="CORREO_ELECTRONICO"
                                    ShowInCustomizationForm="True" VisibleIndex="3">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataDateColumn Caption="FECHA DE SOLICITUD" FieldName="FECHA" ShowInCustomizationForm="True"
                                    VisibleIndex="4">
                                    <PropertiesDateEdit DisplayFormatString="" EditFormat="DateTime">
                                    </PropertiesDateEdit>
                                </dx:GridViewDataDateColumn>
                                <dx:GridViewDataTextColumn Caption="COMPAÑIA" FieldName="COMPAÑIA" ShowInCustomizationForm="True"
                                    VisibleIndex="5">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="JUSTIFICACIÓN" FieldName="JUSTIFICACION" ShowInCustomizationForm="True"
                                    VisibleIndex="6">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn ShowInCustomizationForm="True" VisibleIndex="8">
                                    <DataItemTemplate>
                                        <asp:LinkButton ID="lnkDetalle" runat="server" OnClick="lnkDetalle_Click">Visualizar 
                                        Requisición</asp:LinkButton>
                                    </DataItemTemplate>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="ESTADO" FieldName="STATUS" ShowInCustomizationForm="True"
                                    VisibleIndex="7">
                                </dx:GridViewDataTextColumn>
                            </Columns>
                            <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" />
                            <Settings ShowFilterRow="True" ShowGroupPanel="True" />
                            <Styles>
                                <Cell HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
                                </Cell>
                                <Header HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
                                </Header>
                            </Styles>
                        </dx:ASPxGridView>
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>
            <dx:ASPxPopupControl ID="popupReporte" runat="server" Modal="True" PopupHorizontalAlign="WindowCenter"
                PopupVerticalAlign="WindowCenter" Theme="BlackGlass" Width="900px">
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt"
                            InteractiveDeviceInfos="(Collection)" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt"
                            Width="100%">
                        </rsweb:ReportViewer>
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>

                    </td>
                </tr>
                <tr>
                    <td align="center" bgcolor="#CCCCCC">
                        &nbsp;</td>
                </tr>
            </table>
            
</asp:Content>
