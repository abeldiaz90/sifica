<%@ Page Title="Empleados" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Empleados.aspx.cs" Inherits="SISGRES.Empleados" %>

<%@ Register Assembly="DevExpress.Web.v14.2, Version=14.2.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .style1 {
            text-align: center;
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <div class="page-header">
        <h1>Empleados</h1>
    </div>
    <table style="width: 100%;">
        <tr>
            <td>
                <dx:ASPxGridViewExporter ID="ASPxGridViewExporter1" runat="server"
                    DetailHorizontalOffset="1" DetailVerticalOffset="1" GridViewID="grdEmpleados"
                    Landscape="True" MaxColumnWidth="100" PaperKind="Executive">
                    <Styles>
                        <Header Font-Bold="True" Font-Names="Trebuchet MS" Font-Size="Smaller"
                            HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
                        </Header>
                        <Cell Font-Names="Trebuchet MS" Font-Size="Smaller" HorizontalAlign="Center"
                            VerticalAlign="Middle" Wrap="True">
                        </Cell>
                    </Styles>
                </dx:ASPxGridViewExporter>
                <dx:ASPxGridView ID="grdEmpleados" runat="server" AutoGenerateColumns="False"
                    ClientInstanceName="grdEmpleados" DataSourceID="EmpleadosDatos"
                    EnableTheming="True" KeyboardSupport="True" KeyFieldName="ID_EMPLEADO"
                    Theme="Youthful" AccessibilityCompliant="True" Caption="EMPLEADOS"
                    EnableCallbackAnimation="True" EnablePagingCallbackAnimation="True">
                    <Columns>
                        <dx:GridViewCommandColumn ShowEditButton="True"
                            ShowNewButton="True" ShowNewButtonInHeader="True" ShowUpdateButton="True"
                            VisibleIndex="0" ShowDeleteButton="True">
                            <HeaderTemplate>
                                <table style="width: 100%;">
                                    <tr>
                                        <td align="center">
                                            <asp:ImageButton ID="imgPDF" runat="server" ImageUrl="~/Logos/Pdf.png"
                                                OnClick="imgPDF_Click" />
                                        </td>
                                        <td align="center">
                                            <asp:ImageButton ID="imgEXCEL" runat="server" ImageUrl="~/Logos/Excel.png"
                                                OnClick="imgEXCEL_Click" />
                                        </td>
                                    </tr>
                                </table>
                            </HeaderTemplate>
                        </dx:GridViewCommandColumn>
                        <dx:GridViewDataTextColumn Caption="NUMERO DE EMPLEADO" FieldName="ID_EMPLEADO"
                            ReadOnly="True" VisibleIndex="3" Visible="False">
                            <Settings AutoFilterCondition="Contains" />
                            <EditFormSettings Visible="False" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="PRIMER NOMBRE" FieldName="NOMBRE"
                            VisibleIndex="4">
                            <PropertiesTextEdit>
                                <ValidationSettings ErrorTextPosition="Bottom" SetFocusOnError="True">
                                    <RequiredField IsRequired="True" />
                                </ValidationSettings>
                            </PropertiesTextEdit>
                            <Settings AutoFilterCondition="Contains" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="SEGUNDO NOMBRE" FieldName="SEGUNDO_NOMBRE"
                            VisibleIndex="5">
                            <Settings AutoFilterCondition="Contains" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="APELLIDO PATERNO"
                            FieldName="APELLIDO_PATERNO" VisibleIndex="6">
                            <PropertiesTextEdit>
                                <ValidationSettings ErrorTextPosition="Bottom" SetFocusOnError="True">
                                    <RequiredField IsRequired="True" />
                                </ValidationSettings>
                            </PropertiesTextEdit>
                            <Settings AutoFilterCondition="Contains" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="APELLIDO MATERNO"
                            FieldName="APELLIDO_MATERNO" VisibleIndex="7">
                            <Settings AutoFilterCondition="Contains" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataDateColumn Caption="FECHA DE NACIMIENTO"
                            FieldName="FECHA_NACIMIENTO" VisibleIndex="10">
                            <Settings AutoFilterCondition="Contains" />
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataTextColumn FieldName="CURP" VisibleIndex="11" Caption="CURP">
                            <Settings AutoFilterCondition="Contains" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="NSS" VisibleIndex="12" Caption="NSS">
                            <Settings AutoFilterCondition="Contains" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="RFC" VisibleIndex="13" Caption="RFC">
                            <Settings AutoFilterCondition="Contains" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="TELEFONO PARTICULAR"
                            FieldName="TELEFONO_CASA" VisibleIndex="14">
                            <Settings AutoFilterCondition="Contains" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="TELEFONO CELULAR"
                            FieldName="TELEFONO_MOVIL" VisibleIndex="15">
                            <Settings AutoFilterCondition="Contains" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="DOMICILIO" VisibleIndex="16"
                            Caption="DOMICILIO">
                            <Settings AutoFilterCondition="Contains" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="LUGAR_NACIMIENTO" VisibleIndex="19"
                            Caption="LUGAR DE NACIMIENTO">
                            <Settings AutoFilterCondition="Contains" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CORREO_ELECTRONICO" VisibleIndex="20"
                            Caption="CORREO ELECTRONICO">
                            <PropertiesTextEdit>
                                <ValidationSettings ErrorTextPosition="Bottom">
                                    <RegularExpression ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                                    <RequiredField IsRequired="True" />
                                </ValidationSettings>
                            </PropertiesTextEdit>
                            <Settings AutoFilterCondition="Contains" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataComboBoxColumn Caption="ESTADO CIVIL" FieldName="EDO_CIVIL"
                            VisibleIndex="18">
                            <PropertiesComboBox>
                                <Items>
                                    <dx:ListEditItem Text="SOLTERO" Value="1" />
                                    <dx:ListEditItem Text="CASADO" Value="2" />
                                </Items>
                            </PropertiesComboBox>
                            <Settings AutoFilterCondition="Contains" />
                        </dx:GridViewDataComboBoxColumn>
                        <dx:GridViewDataComboBoxColumn FieldName="COMPAÑIA" VisibleIndex="23"
                            Caption="COMPAÑIA">
                            <PropertiesComboBox DataSourceID="Compañias"
                                IncrementalFilteringMode="Contains" TextField="COMPAÑIA"
                                ValueField="ID_COMPAÑIA">
                                <ValidationSettings ErrorTextPosition="Bottom">
                                    <RequiredField IsRequired="True" />
                                </ValidationSettings>
                            </PropertiesComboBox>
                            <Settings AutoFilterCondition="Contains" />
                        </dx:GridViewDataComboBoxColumn>
                        <dx:GridViewDataComboBoxColumn FieldName="SEXO" VisibleIndex="21"
                            Caption="SEXO">
                            <PropertiesComboBox IncrementalFilteringMode="Contains">
                                <Items>
                                    <dx:ListEditItem Text="MASCULINO" Value="1" />
                                    <dx:ListEditItem Text="FEMENINO" Value="2" />
                                </Items>
                                <ValidationSettings ErrorTextPosition="Bottom">
                                    <RequiredField IsRequired="True" />
                                </ValidationSettings>
                            </PropertiesComboBox>
                            <Settings AutoFilterCondition="Contains" />
                        </dx:GridViewDataComboBoxColumn>
                        <dx:GridViewDataTextColumn VisibleIndex="2">
                            <EditFormSettings Visible="False" />
                            <DataItemTemplate>
                                <dx:ASPxButton ID="btnFotografia" runat="server" HorizontalAlign="Center"
                                    OnClick="btnFotografia_Click" Text="FOTOGRAFIA" Theme="BlackGlass"
                                    VerticalAlign="Middle">
                                </dx:ASPxButton>
                            </DataItemTemplate>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataComboBoxColumn Caption="DEPARTAMENTO" FieldName="DEPARTAMENTO"
                            Name="DEPARTAMENTO" VisibleIndex="8">
                            <PropertiesComboBox DataSourceID="DEPARTAMENTOS"
                                IncrementalFilteringMode="Contains" TextField="DEPARTAMENTO"
                                ValueField="ID_DEPARTAMENTO">
                            </PropertiesComboBox>
                            <Settings AutoFilterCondition="Contains" />
                            <EditFormSettings Visible="False" />
                        </dx:GridViewDataComboBoxColumn>
                        <dx:GridViewDataComboBoxColumn Caption="PUESTO" FieldName="PUESTO"
                            Name="PUESTO" VisibleIndex="9">
                            <PropertiesComboBox DataSourceID="PuestosTodos" DisplayFormatInEditMode="True"
                                IncrementalFilteringMode="Contains" LoadDropDownOnDemand="True"
                                TextField="PUESTO" ValueField="ID_PUESTO">
                                <ValidationSettings ErrorTextPosition="Bottom" SetFocusOnError="True">
                                    <RequiredField IsRequired="True" />
                                </ValidationSettings>
                            </PropertiesComboBox>
                            <Settings AutoFilterCondition="Contains" />
                        </dx:GridViewDataComboBoxColumn>
                        <dx:GridViewDataTextColumn Caption="TIPO SANGUINEO" FieldName="TIPOSANGUINEO"
                            VisibleIndex="22">
                            <Settings AutoFilterCondition="Contains" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="CODIGO POSTAL" FieldName="CODIGOPOSTAL"
                            VisibleIndex="17">
                            <Settings AutoFilterCondition="Contains" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn VisibleIndex="35">
                            <EditFormSettings Visible="False" />
                            <DataItemTemplate>
                                <dx:ASPxHyperLink ID="ASPxHyperLink1" runat="server" EnableTheming="True"
                                    Text="Adjuntar Firma" Theme="BlackGlass">
                                    <ClientSideEvents Click="function(s, e) {
	popupFirmas.Show();
}" />
                                </dx:ASPxHyperLink>
                            </DataItemTemplate>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataCheckColumn Caption="ESTADO" FieldName="ESTADO"
                            VisibleIndex="33">
                        </dx:GridViewDataCheckColumn>
                        <dx:GridViewDataDateColumn Caption="FECHA DE INGRESO" FieldName="FECHA_INGRESO"
                            VisibleIndex="27">
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataDateColumn Caption="FECHA DE BAJA" FieldName="FECHA_BAJA"
                            VisibleIndex="32">
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataComboBoxColumn Caption="TIPO DE EMPLEADO"
                            FieldName="TIPO_PERSONAL" VisibleIndex="26">
                            <PropertiesComboBox IncrementalFilteringMode="Contains" DisplayFormatString="d">
                                <Items>
                                    <dx:ListEditItem Text="ADMINISTRATIVO" Value="1" />
                                    <dx:ListEditItem Text="OPERATIVO" Value="2" />
                                </Items>
                                <ValidationSettings ErrorTextPosition="Bottom" SetFocusOnError="True">
                                    <RequiredField IsRequired="True" />
                                </ValidationSettings>
                            </PropertiesComboBox>
                            <Settings AutoFilterCondition="Contains" />
                        </dx:GridViewDataComboBoxColumn>
                    </Columns>
                    <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True"
                        AllowSelectSingleRowOnly="True" ConfirmDelete="True" />
                    <SettingsEditing Mode="PopupEditForm">
                    </SettingsEditing>
                    <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowGroupedColumns="True"
                        ShowHeaderFilterButton="True" ShowTitlePanel="True" />
                    <SettingsPopup>
                        <EditForm Height="500px" HorizontalAlign="WindowCenter" Modal="True"
                            VerticalAlign="WindowCenter" Width="700px" />
                    </SettingsPopup>
                    <Styles>
                        <Header HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
                        </Header>
                        <Cell HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
                        </Cell>
                    </Styles>
                    <StylesPopup>
                        <EditForm>
                            <Header HorizontalAlign="Center" VerticalAlign="Middle">
                            </Header>
                        </EditForm>
                    </StylesPopup>
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="EmpleadosDatos" runat="server"
                    ConnectionString="<%$ ConnectionStrings:SIFICA %>"
                    InsertCommand="EMPLEADOS_INSERTAR" InsertCommandType="StoredProcedure"
                    SelectCommand="EMPLEADOS_MOSTRAR_TODOS" SelectCommandType="StoredProcedure"
                    UpdateCommand="EMPLEADOS_MODIFICAR" UpdateCommandType="StoredProcedure" DeleteCommand="EMPLEADOS_ELIMINAR" DeleteCommandType="StoredProcedure">
                    <DeleteParameters>
                        <asp:Parameter Name="ID_EMPLEADO" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="NOMBRE" Type="String" />
                        <asp:Parameter Name="SEGUNDO_NOMBRE" Type="String" />
                        <asp:Parameter Name="APELLIDO_PATERNO" Type="String" />
                        <asp:Parameter Name="APELLIDO_MATERNO" Type="String" />
                        <asp:Parameter Name="DEPARTAMENTO" Type="Int32" />
                        <asp:Parameter Name="PUESTO" Type="Int32" />
                        <asp:Parameter Name="FECHA_NACIMIENTO" Type="DateTime" />
                        <asp:Parameter Name="CURP" Type="String" />
                        <asp:Parameter Name="NSS" Type="String" />
                        <asp:Parameter Name="RFC" Type="String" />
                        <asp:Parameter Name="TELEFONO_CASA" Type="String" />
                        <asp:Parameter Name="TELEFONO_MOVIL" Type="String" />
                        <asp:Parameter Name="DOMICILIO" Type="String" />
                        <asp:Parameter Name="EDO_CIVIL" Type="String" />
                        <asp:Parameter Name="LUGAR_NACIMIENTO" Type="String" />
                        <asp:Parameter Name="CORREO_ELECTRONICO" Type="String" />
                        <asp:Parameter Name="COMPAÑIA" Type="String" />
                        <asp:Parameter Name="SEXO" Type="Int32" />
                        <asp:Parameter Name="TIPOSANGUINEO" Type="String" />
                        <asp:Parameter Name="CODIGOPOSTAL" Type="Int32" />
                        <asp:Parameter Name="FECHA_INGRESO" Type="DateTime" />
                        <asp:Parameter Name="TIPO_PERSONAL" Type="Int32" />
                        <asp:Parameter Name="FECHA_BAJA" Type="DateTime" />
                        <asp:Parameter Name="ESTADO" Type="Boolean" />
                        <asp:Parameter Name="SALARIO_DIARIO" Type="Decimal" />
                        <asp:Parameter Name="CUENTA_BANCARIA" Type="String" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:SessionParameter Name="COMPAÑIA" SessionField="Compañia" Type="Int32" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="ID_EMPLEADO" Type="Int32" />
                        <asp:Parameter Name="NOMBRE" Type="String" />
                        <asp:Parameter Name="SEGUNDO_NOMBRE" Type="String" />
                        <asp:Parameter Name="APELLIDO_PATERNO" Type="String" />
                        <asp:Parameter Name="APELLIDO_MATERNO" Type="String" />
                        <asp:Parameter Name="DEPARTAMENTO" Type="Int32" />
                        <asp:Parameter Name="PUESTO" Type="Int32" />
                        <asp:Parameter Name="FECHA_NACIMIENTO" Type="DateTime" />
                        <asp:Parameter Name="CURP" Type="String" />
                        <asp:Parameter Name="NSS" Type="String" />
                        <asp:Parameter Name="RFC" Type="String" />
                        <asp:Parameter Name="TELEFONO_CASA" Type="String" />
                        <asp:Parameter Name="TELEFONO_MOVIL" Type="String" />
                        <asp:Parameter Name="DOMICILIO" Type="String" />
                        <asp:Parameter Name="EDO_CIVIL" Type="String" />
                        <asp:Parameter Name="LUGAR_NACIMIENTO" Type="String" />
                        <asp:Parameter Name="CORREO_ELECTRONICO" Type="String" />
                        <asp:Parameter Name="COMPAÑIA" Type="String" />
                        <asp:Parameter Name="SEXO" Type="Int32" />
                        <asp:Parameter Name="TIPOSANGUINEO" Type="String" />
                        <asp:Parameter Name="CODIGOPOSTAL" Type="Int32" />
                        <asp:Parameter Name="FECHA_INGRESO" Type="DateTime" />
                        <asp:Parameter Name="TIPO_PERSONAL" Type="Int32" />
                        <asp:Parameter Name="FECHA_BAJA" Type="DateTime" />
                        <asp:Parameter Name="ESTADO" Type="Boolean" />
                        <asp:Parameter Name="SALARIO_DIARIO" Type="Decimal" />
                        <asp:Parameter Name="CUENTA_BANCARIA" Type="String" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="Compañias" runat="server"
                    ConnectionString="<%$ ConnectionStrings:SIFICA %>"
                    SelectCommand="COMPAÑIAS_MOSTRAR_ID" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="ID_COMPAÑIA" SessionField="Compañia" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="DEPARTAMENTOS" runat="server"
                    ConnectionString="<%$ ConnectionStrings:SIFICA %>"
                    SelectCommand="DEPARTAMENTOS_MOSTRAR_ID" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="ID_COMPAÑIA" SessionField="Compañia" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="PuestosTodos" runat="server"
                    ConnectionString="<%$ ConnectionStrings:SIFICA %>"
                    InsertCommand="PUESTOS_INSERTAR" InsertCommandType="StoredProcedure"
                    SelectCommand="PUESTOS_MOSTRAR_COMPAÑIAS" SelectCommandType="StoredProcedure"
                    UpdateCommand="PUESTOS_ACTUALIZAR" UpdateCommandType="StoredProcedure">
                    <InsertParameters>
                        <asp:Parameter Name="ID_DEPARTAMENTO" Type="Int32" />
                        <asp:Parameter Name="PUESTO" Type="String" />
                        <asp:Parameter Name="CREO" Type="String" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:SessionParameter Name="ID_COMPAÑIA" SessionField="Compañia" Type="Int32" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="ID_PUESTO" Type="Int32" />
                        <asp:Parameter Name="PUESTO" Type="String" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <dx:ASPxPopupControl ID="popupFotos" runat="server"
                    ClientInstanceName="popupFotos" HeaderText="Seleccione la Fotografia"
                    Modal="True" PopupHorizontalAlign="WindowCenter"
                    PopupVerticalAlign="WindowCenter" Theme="BlackGlass" Width="400px"
                    AllowDragging="True" AllowResize="True" CloseAnimationType="Slide"
                    EnableCallbackAnimation="True">
                    <ContentCollection>
                        <dx:PopupControlContentControl runat="server">
                            <table style="width: 100%;">
                                <tr>
                                    <td align="center" valign="middle">
                                        <dx:ASPxCallbackPanel ID="cp" runat="server" ClientInstanceName="cp"
                                            OnCallback="cp_Callback" Theme="BlackGlass" Width="100%">
                                            <PanelCollection>
                                                <dx:PanelContent runat="server">
                                                    <dx:ASPxImage ID="imgFoto" runat="server" Width="100px">
                                                    </dx:ASPxImage>
                                                    <dx:ASPxUploadControl ID="Subir" runat="server" ClientInstanceName="Subir"
                                                        EnableTheming="True" FileUploadMode="OnPageLoad"
                                                        OnFileUploadComplete="Subir_FileUploadComplete" ShowProgressPanel="True"
                                                        ShowUploadButton="True" Theme="BlackGlass" UploadMode="Auto" Width="280px">
                                                        <ClientSideEvents FileUploadComplete="function(s, e) {
	grdEmpleados.Refresh();
cp.PerformCallback(e.callbackData);
}" />
                                                        <TextBoxStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                    </dx:ASPxUploadControl>
                                                </dx:PanelContent>
                                            </PanelCollection>
                                        </dx:ASPxCallbackPanel>
                                    </td>
                                </tr>
                            </table>
                        </dx:PopupControlContentControl>
                    </ContentCollection>
                </dx:ASPxPopupControl>
                <br />
                <dx:ASPxPopupControl ID="popupFirmas" runat="server"
                    ClientInstanceName="popupFirmas" HeaderText="Seleccione la Firma"
                    Modal="True" PopupHorizontalAlign="WindowCenter"
                    PopupVerticalAlign="WindowCenter" Theme="BlackGlass" Width="300px">
                    <ContentCollection>
                        <dx:PopupControlContentControl runat="server">
                            <dx:ASPxUploadControl ID="SubirFirma" runat="server" ClientInstanceName="SubirFirma"
                                EnableTheming="True" FileUploadMode="OnPageLoad"
                                OnFileUploadComplete="Subirfirma_FileUploadComplete" ShowProgressPanel="True"
                                ShowUploadButton="True" Theme="BlackGlass" UploadMode="Auto" Width="280px">
                                <ClientSideEvents FileUploadComplete="function(s, e) {
	grdEmpleados.Refresh();
}" />
                                <ClientSideEvents FileUploadComplete="function(s, e) {
	grdEmpleados.Refresh();
}"></ClientSideEvents>

                                <TextBoxStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            </dx:ASPxUploadControl>
                        </dx:PopupControlContentControl>
                    </ContentCollection>
                </dx:ASPxPopupControl>
            </td>
        </tr>
    </table>
</asp:Content>
