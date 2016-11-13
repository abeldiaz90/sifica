<%@ Page Title="Almacenes" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Almacenes.aspx.cs" Inherits="SISGRES.Almacenes" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <dx:ASPxPanel ID="ASPxPanel1" runat="server" Width="100%">
    <PanelCollection>
        <dx:PanelContent runat="server">
            <table style="width: 100%;">
                <tr>
                    <td>
                        <dx:ASPxGridView ID="grdAlmacenes" runat="server" AutoGenerateColumns="False" 
                            EnableTheming="True" Theme="Youthful" Width="100%" 
                            DataSourceID="ALMACENESDATOS" KeyFieldName="ID_ALMACEN" 
                            EnableCallbackAnimation="True" EnablePagingCallbackAnimation="True">

<Settings ShowFilterRow="True" ShowGroupPanel="True"></Settings>

                            <Columns>
                                <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" 
                                    ShowInCustomizationForm="True" ShowNewButton="True" 
                                    ShowNewButtonInHeader="True" ShowUpdateButton="True" VisibleIndex="0">
                                </dx:GridViewCommandColumn>
                                <dx:GridViewDataTextColumn Caption="CLAVE" FieldName="ID_ALMACEN" 
                                    ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="1">
                                    <EditFormSettings Visible="False" />
<EditFormSettings Visible="False"></EditFormSettings>

                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True" />
                                    <CellStyle HorizontalAlign="Center" VerticalAlign="Middle">
                                    </CellStyle>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="ALMACEN" FieldName="DESCRIPCION" 
                                    ShowInCustomizationForm="True" VisibleIndex="2">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="UBICACIÓN" FieldName="UBICACION" 
                                    ShowInCustomizationForm="True" VisibleIndex="3">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataComboBoxColumn Caption="COMPAÑIA" FieldName="ID_COMPAÑIA" 
                                    ShowInCustomizationForm="True" VisibleIndex="6">
                                    <PropertiesComboBox DataSourceID="Compañias" TextField="COMPAÑIA" 
                                        ValueField="ID_COMPAÑIA">
                                    </PropertiesComboBox>
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True" />
                                </dx:GridViewDataComboBoxColumn>
                                <dx:GridViewDataComboBoxColumn Caption="RESPONSABLE" FieldName="RESPONSABLE" 
                                    ShowInCustomizationForm="True" VisibleIndex="5">
                                    <PropertiesComboBox DataSourceID="Empleados" 
                                        IncrementalFilteringMode="Contains" TextField="NOMBRE" ValueField="ID_EMPLEADO">
                                    </PropertiesComboBox>
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True" />
                                </dx:GridViewDataComboBoxColumn>
                            </Columns>
                            <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" 
                                AllowSelectSingleRowOnly="True" ConfirmDelete="True" />
                            <Settings ShowFilterRow="True" ShowGroupPanel="True" />

                            <Styles>
                                <Cell HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
                                </Cell>
                            </Styles>
                        </dx:ASPxGridView>
                        <asp:SqlDataSource ID="ALMACENESDATOS" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
                            InsertCommand="ALMACEN_INSERTAR" InsertCommandType="StoredProcedure" 
                            SelectCommand="ALMACEN_MOSTRAR_TODOS" SelectCommandType="StoredProcedure" 
                            UpdateCommand="ALMACENES_MODIFICAR" UpdateCommandType="StoredProcedure">
                            <InsertParameters>
                                <asp:Parameter Name="DESCRIPCION" Type="String" />
                                <asp:Parameter Name="UBICACION" Type="String" />
                                <asp:Parameter Name="RESPONSABLE" Type="String" />
                                <asp:Parameter Name="ID_COMPAÑIA" Type="Int32" />
                            </InsertParameters>
                            <SelectParameters>
                              <asp:SessionParameter Name="ID_COMPAÑIA" SessionField="Compañia" Type="Int32" />
                            </SelectParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="ID_ALMACEN" Type="Int32" />
                                <asp:Parameter Name="DESCRIPCION" Type="String" />
                                <asp:Parameter Name="UBICACION" Type="String" />
                                <asp:Parameter Name="RESPONSABLE" Type="String" />
                            </UpdateParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="Compañias" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
                            SelectCommand="COMPAÑIAS_MOSTRAR_ID" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                              <asp:SessionParameter Name="ID_COMPAÑIA" SessionField="Compañia" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="Empleados" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
                            SelectCommand="EMPLEADOS_MOSTRAR_ID_COMPAÑIA" 
                            SelectCommandType="StoredProcedure">
                            <SelectParameters>
                              <asp:SessionParameter Name="ID_COMPAÑIA" SessionField="Compañia" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
            </table>
        </dx:PanelContent>
    </PanelCollection>
</dx:ASPxPanel>
</asp:Content>
