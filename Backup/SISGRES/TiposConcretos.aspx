<%@ Page Title="Tipos de Concreto" Language="C#" MasterPageFile="~/Principal.Master"
    AutoEventWireup="true" CodeBehind="TiposConcretos.aspx.cs" Inherits="SISGRES.TiposConcretos" %>

<%@ Register Assembly="DevExpress.Web.v14.2, Version=14.2.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dx" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .style1
        {
            text-align: center;
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <dx:ASPxGridView ID="grdTiposConcreto" runat="server" AutoGenerateColumns="False"
        DataSourceID="TiposConcretosDatos" EnableTheming="True" KeyFieldName="ID_TIPO_CONCRETO"
        Theme="Youthful" Width="100%" ClientInstanceName="grdTiposConcreto" 
        EnableCallbackAnimation="True" EnablePagingCallbackAnimation="True">
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" ShowDeleteButton="True" ShowEditButton="True"
                ShowNewButtonInHeader="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn Caption="CLAVE" FieldName="ID_TIPO_CONCRETO" ReadOnly="True"
                VisibleIndex="1">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="TIPO DE CONCRETO" FieldName="TIPO_CONCRETO" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="FUERZA DE COMPRESION   (F'C)" FieldName="FUERZA_COMPRESION"
                VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="TAMAÑO MATERIAL AGREGADO    (MM)" FieldName="TAMAÑO_MATERIAL"
                VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="EDAD COMPROMISO     (DIAS)" FieldName="EDAD_COMPROMISO"
                VisibleIndex="7">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="REVENIMIENTO" FieldName="REVENIMIENTO" VisibleIndex="10">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="MODULO DE RUPTURA" 
                FieldName="MODULO_ROTURA" VisibleIndex="11">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="RESISTENCIA RAPIDA    (DIAS)" FieldName="RESISTENCIA_RAPIDA"
                VisibleIndex="12">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataComboBoxColumn Caption="TIPO DE ORIGEN" FieldName="TIPO_ORIGEN" VisibleIndex="6">
                <PropertiesComboBox IncrementalFilteringMode="Contains">
                    <Items>
                        <dx:ListEditItem Text="CALIZA" Value="1" />
                    </Items>
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn Caption="TIPO DE BOMBEO" FieldName="TIPO_BOMBEO" VisibleIndex="9">
                <PropertiesComboBox IncrementalFilteringMode="Contains">
                    <Items>
                        <dx:ListEditItem Text="BOMBA" Value="1" />
                        <dx:ListEditItem Text="DIRECTO" Value="2" />
                    </Items>
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataTextColumn Caption="PRECIO DE VENTA(BASE)" FieldName="PRECIO" VisibleIndex="13">
                <PropertiesTextEdit DisplayFormatString="C2">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="ADITIVOS" VisibleIndex="14" 
                FieldName="ADITIVOS">
                <PropertiesTextEdit DisplayFormatString="C2">
                </PropertiesTextEdit>
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="MATERIALES ADICIONALES" VisibleIndex="15" 
                FieldName="MATERIALES">
                <PropertiesTextEdit DisplayFormatString="C2">
                </PropertiesTextEdit>
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="PRECIO DE VENTA (FINAL)" FieldName="PRECIO_FINAL"
                VisibleIndex="16">
                <PropertiesTextEdit DisplayFormatString="c2">
                </PropertiesTextEdit>
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataComboBoxColumn Caption="UNIDAD DE MEDIDA" FieldName="ID_UNIDAD" VisibleIndex="17">
                <PropertiesComboBox DataSourceID="UNIDAD_MEDIDA" IncrementalFilteringMode="Contains"
                    TextField="ABREVIATURA" ValueField="ID_UNIDAD">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataTextColumn VisibleIndex="18">
                <EditFormSettings Visible="False" />
                <DataItemTemplate>
                    <dx:ASPxButton ID="btnAditivos" runat="server" AutoPostBack="False" 
                        Height="32px" HorizontalAlign="Center" onclick="btnAditivos_Click" 
                        Text="Adicionar Aditivos" Theme="Youthful" UseSubmitBehavior="False" 
                        VerticalAlign="Middle" Width="68px" Wrap="True">
                    </dx:ASPxButton>
                </DataItemTemplate>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn ShowInCustomizationForm="False" VisibleIndex="19">
                <EditFormSettings Visible="False" />
                <DataItemTemplate>
                    <dx:ASPxButton ID="btnAdicionar" runat="server" AutoPostBack="False" 
                        EnableTheming="True" Height="32px" HorizontalAlign="Center" 
                        onclick="btnAdicionar_Click" Text="Adicionar Materiales" Theme="Youthful" 
                        UseSubmitBehavior="False" VerticalAlign="Middle" Width="68px" Wrap="True">
                    </dx:ASPxButton>
                </DataItemTemplate>
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True"
            ConfirmDelete="True" />
        <SettingsEditing Mode="PopupEditForm">
        </SettingsEditing>
        <Settings ShowFilterRow="True" />
        <SettingsPopup>
            <EditForm AllowResize="True" Modal="True" VerticalAlign="WindowCenter" 
                HorizontalAlign="WindowCenter" />
        </SettingsPopup>
        <Styles>
            <Cell HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </Cell>
            <Header HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </Header>
        </Styles>
    </dx:ASPxGridView>
    <dx:ASPxPopupControl ID="popupAdiciones" runat="server" AllowDragging="True" AllowResize="True"
        HeaderText="" Maximized="True" Modal="True" PopupHorizontalAlign="WindowCenter"
        PopupVerticalAlign="WindowCenter" ShowMaximizeButton="True" ShowPageScrollbarWhenModal="True"
        Theme="Youthful" Width="100%">
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <table style="width: 100%;">
                    <tr>
                        <td align="center" class="style1">
                            &nbsp;
                        </td>
                        <td align="center">
                            <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="TIPO DE CONCRETO">
                            </dx:ASPxLabel>
                            <dx:ASPxComboBox ID="cboTipoConcreto" runat="server" DataSourceID="TiposConcreto"
                                EnableTheming="True" HorizontalAlign="Center" IncrementalFilteringMode="Contains"
                                OnSelectedIndexChanged="cboTipoConcreto_SelectedIndexChanged" ReadOnly="True"
                                TextField="TIPO_CONCRETO" TextFormatString="{6}" Theme="Youthful" ValueField="ID_TIPO_CONCRETO">
                                <Columns>
                                    <dx:ListBoxColumn Caption="EDAD COMPROMISO" FieldName="EDAD_COMPROMISO" />
                                    <dx:ListBoxColumn Caption="FUERZA COMPRESION" FieldName="FUERZA_COMPRESION" />
                                    <dx:ListBoxColumn Caption="MODULO ROTURA" FieldName="MODULO_ROTURA" />
                                    <dx:ListBoxColumn Caption="PRECIO" FieldName="PRECIO" />
                                    <dx:ListBoxColumn Caption="REVENIMIENTO" FieldName="REVENIMIENTO" />
                                    <dx:ListBoxColumn Caption="RESISTENCIA RAPIDA" FieldName="RESISTENCIA_RAPIDA" />
                                    <dx:ListBoxColumn FieldName="TIPO_CONCRETO" />
                                </Columns>
                            </dx:ASPxComboBox>
                            <asp:SqlDataSource ID="TiposConcreto" runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>"
                                SelectCommand="TIPO_CONCRETO_CONSULTAR" SelectCommandType="StoredProcedure">
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="TiposDeConcreto" runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>"
                                DeleteCommand="ADITIVOS_ADICIONALES_ELIMINAR" DeleteCommandType="StoredProcedure"
                                InsertCommand="ADITIVOS_ADICIONALES_INSERTAR" InsertCommandType="StoredProcedure"
                                SelectCommand="ADITIVOS_ADICIONALES_MOSTRAR_POR_TIPO_CONCRETO" SelectCommandType="StoredProcedure"
                                UpdateCommand="ADITIVOS_ADICIONALES_MODIFICAR" UpdateCommandType="StoredProcedure">
                                <DeleteParameters>
                                    <asp:Parameter Name="ID_ADITIVO_ADICIONAL" Type="Int32" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="ID_ADITIVO" Type="Int32" />
                                    <asp:Parameter Name="IMPORTE" Type="Decimal" />
                                    <asp:ControlParameter ControlID="cboTipoConcreto" Name="ID_TIPO_CONCRETO" PropertyName="Value"
                                        Type="Int32" />
                                </InsertParameters>
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="cboTipoConcreto" Name="ID_TIPO_CONCRETO" PropertyName="Value"
                                        Type="Int32" />
                                </SelectParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="ID_ADITIVO_ADICIONAL" Type="Int32" />
                                    <asp:Parameter Name="ID_ADITIVO" Type="Int32" />
                                    <asp:Parameter Name="IMPORTE" Type="Decimal" />
                                    <asp:ControlParameter ControlID="cboTipoConcreto" Name="ID_TIPO_CONCRETO" PropertyName="Value"
                                        Type="Int32" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="TipoAditivo" runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>"
                                SelectCommand="ADITIVOS_CONSULTAR" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                        </td>
                        <td align="center" class="style1">
                            &nbsp;
                        </td>
                    </tr>
                </table>
                <dx:ASPxGridView ID="grdCostosAditivosAdicionales" runat="server" AutoGenerateColumns="False"
                    DataSourceID="TiposDeConcreto" EnableTheming="True" KeyFieldName="ID_ADITIVO_ADICIONAL"
                    Theme="Youthful" Width="100%" Caption="ADITIVO PARA CONCRETO">
                    <ClientSideEvents EndCallback="function(s, e) {
	grdTiposConcreto.Refresh();
}" />
                    <Columns>
                        <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" ShowInCustomizationForm="True"
                            ShowNewButtonInHeader="True" VisibleIndex="0">
                        </dx:GridViewCommandColumn>
                        <dx:GridViewDataTextColumn Caption="CLAVE" FieldName="ID_ADITIVO_ADICIONAL" ReadOnly="True"
                            ShowInCustomizationForm="True" VisibleIndex="1">
                            <EditFormSettings Visible="False" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="IMPORTE" FieldName="IMPORTE" ShowInCustomizationForm="True"
                            VisibleIndex="4">
                            <PropertiesTextEdit DisplayFormatString="C2">
                                <MaskSettings IncludeLiterals="DecimalSymbol" Mask="$&lt;0..99999999g&gt;.&lt;00..99&gt;" />
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataComboBoxColumn Caption="TIPO DE CONCRETO" FieldName="ID_TIPO_CONCRETO"
                            ShowInCustomizationForm="True" VisibleIndex="5" ReadOnly="True">
                            <PropertiesComboBox DataSourceID="TiposConcreto" IncrementalFilteringMode="Contains"
                                TextField="TIPO_CONCRETO" ValueField="ID_TIPO_CONCRETO">
                            </PropertiesComboBox>
                            <EditFormSettings Visible="False" />
                        </dx:GridViewDataComboBoxColumn>
                        <dx:GridViewDataComboBoxColumn Caption="ADITIVO" FieldName="ID_ADITIVO" ShowInCustomizationForm="True"
                            VisibleIndex="3">
                            <PropertiesComboBox DataSourceID="TipoAditivo" IncrementalFilteringMode="Contains"
                                TextField="ADITIVO" ValueField="ID_ADITIVO">
                            </PropertiesComboBox>
                        </dx:GridViewDataComboBoxColumn>
                    </Columns>
                    <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True"
                        ConfirmDelete="True" />
                    <Settings ShowFilterRow="True" />
                    <Styles>
                        <Cell HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
                        </Cell>
                        <Header HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
                        </Header>
                    </Styles>
                </dx:ASPxGridView>
                <dx:ASPxGridView ID="grdMaterialesAdicionales" runat="server" AutoGenerateColumns="False"
                    DataSourceID="MaterialesDatosAdicionales" EnableTheming="True" KeyFieldName="ID_MATERIAL_CONCRETO_ADICIONAL"
                    Theme="Youthful" Width="100%" 
                    Caption="MATERIALES ADICIONALES PARA CONCRETO">
                    <ClientSideEvents EndCallback="function(s, e) {
	grdTiposConcreto.Refresh();
}" />
                    <Columns>
                        <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" ShowInCustomizationForm="True"
                            ShowNewButtonInHeader="True" VisibleIndex="0">
                        </dx:GridViewCommandColumn>
                        <dx:GridViewDataTextColumn Caption="CLAVE" FieldName="ID_MATERIAL_CONCRETO_ADICIONAL"
                            ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="1">
                            <EditFormSettings Visible="False" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="IMPORTE" FieldName="IMPORTE"
                            ShowInCustomizationForm="True" VisibleIndex="4">
                            <PropertiesTextEdit DisplayFormatString="C2">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataComboBoxColumn Caption="TIPO DE CONCRETO" FieldName="ID_TIPO_CONCRETO"
                            ShowInCustomizationForm="True" VisibleIndex="5">
                            <PropertiesComboBox DataSourceID="TiposConcreto" IncrementalFilteringMode="Contains"
                                TextField="TIPO_CONCRETO" ValueField="ID_TIPO_CONCRETO">
                            </PropertiesComboBox>
                            <EditFormSettings Visible="False" />
                        </dx:GridViewDataComboBoxColumn>
                        <dx:GridViewDataComboBoxColumn Caption="MATERIAL ADICIONAL" 
                            FieldName="MATERIAL_CONCRETO_ADICIONAL" ShowInCustomizationForm="True" 
                            VisibleIndex="3">
                            <PropertiesComboBox DataSourceID="MaterialesconcretoParametro" 
                                IncrementalFilteringMode="Contains" TextField="MATERIAL" 
                                ValueField="ID_MATERIALES_CONCRETO">
                            </PropertiesComboBox>
                        </dx:GridViewDataComboBoxColumn>
                    </Columns>
                    <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" 
                        AllowSelectSingleRowOnly="True" ConfirmDelete="True" />
                    <Settings ShowFilterRow="True" ShowTitlePanel="True" />
                    <Styles>
                        <Cell HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
                        </Cell>
                        <Header HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
                        </Header>
                    </Styles>
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="MaterialesconcretoParametro" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
                    SelectCommand="MATERIALES_CONCRETO_CONSULTAR" 
                    SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                <asp:SqlDataSource ID="MaterialesDatosAdicionales" runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>"
                    DeleteCommand="MATERIALES_ADICIONALES_CONCRETO_ELIMINAR" DeleteCommandType="StoredProcedure"
                    InsertCommand="MATERIALES_ADICIONALES_CONCRETO_INSERTAR" InsertCommandType="StoredProcedure"
                    SelectCommand="MATERIALES_ADICIONALES_CONCRETO_CONSULTAR" SelectCommandType="StoredProcedure"
                    UpdateCommand="MATERIALES_ADICIONALES_CONCRETO_MODIFICAR" UpdateCommandType="StoredProcedure">
                    <DeleteParameters>
                        <asp:Parameter Name="ID_MATERIAL_CONCRETO_ADICIONAL" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="MATERIAL_CONCRETO_ADICIONAL" Type="String" />
                        <asp:Parameter Name="IMPORTE" Type="Decimal" />
                        <asp:ControlParameter ControlID="cboTipoConcreto" Name="ID_TIPO_CONCRETO" PropertyName="Value" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="cboTipoConcreto" Name="ID_TIPO_CONCRETO" 
                            PropertyName="Value" Type="Int32" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="ID_MATERIAL_CONCRETO_ADICIONAL" Type="Int32" />
                        <asp:Parameter Name="MATERIAL_CONCRETO_ADICIONAL" Type="String" />
                        <asp:Parameter Name="IMPORTE" Type="Decimal" />
                        <asp:ControlParameter ControlID="cboTipoConcreto" Name="ID_TIPO_CONCRETO" PropertyName="Value" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>
    <asp:SqlDataSource ID="TiposConcretosDatos" runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>"
        DeleteCommand="TIPO_CONCRETO_ELIMINAR" DeleteCommandType="StoredProcedure" InsertCommand="TIPO_CONCRETO_INSERTAR"
        InsertCommandType="StoredProcedure" SelectCommand="TIPO_CONCRETO_CONSULTAR" SelectCommandType="StoredProcedure"
        UpdateCommand="TIPO_CONCRETO_MODIFICAR" UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="ID_TIPO_CONCRETO" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="TIPO_CONCRETO" Type="String" />
            <asp:Parameter Name="FUERZA_COMPRESION" Type="Int32" />
            <asp:Parameter Name="TAMAÑO_MATERIAL" Type="Int32" />
            <asp:Parameter Name="TIPO_ORIGEN" Type="Int32" />
            <asp:Parameter Name="EDAD_COMPROMISO" Type="Int32" />
            <asp:Parameter Name="TIPO_BOMBEO" Type="Int32" />
            <asp:Parameter Name="REVENIMIENTO" Type="String" />
            <asp:Parameter Name="MODULO_ROTURA" Type="Int32" />
            <asp:Parameter Name="RESISTENCIA_RAPIDA" Type="Int32" />
            <asp:Parameter Name="PRECIO" Type="Decimal" />
            <asp:Parameter Name="ID_UNIDAD" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="ID_TIPO_CONCRETO" Type="Int32" />
            <asp:Parameter Name="TIPO_CONCRETO" Type="String" />
            <asp:Parameter Name="FUERZA_COMPRESION" Type="Int32" />
            <asp:Parameter Name="TAMAÑO_MATERIAL" Type="Int32" />
            <asp:Parameter Name="TIPO_ORIGEN" Type="Int32" />
            <asp:Parameter Name="EDAD_COMPROMISO" Type="Int32" />
            <asp:Parameter Name="TIPO_BOMBEO" Type="Int32" />
            <asp:Parameter Name="REVENIMIENTO" Type="String" />
            <asp:Parameter Name="MODULO_ROTURA" Type="Int32" />
            <asp:Parameter Name="RESISTENCIA_RAPIDA" Type="Int32" />
            <asp:Parameter Name="PRECIO" Type="Decimal" />
            <asp:Parameter Name="ID_UNIDAD" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="UNIDAD_MEDIDA" runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>"
        SelectCommand="UNIDADESMEDIDA_MOSTRAR_TODOS" SelectCommandType="StoredProcedure">
    </asp:SqlDataSource>
</asp:Content>
