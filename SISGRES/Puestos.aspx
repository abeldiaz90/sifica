<%@ Page Title="Puestos" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Puestos.aspx.cs" Inherits="SISGRES.Puestos" %>

<%@ Register Assembly="DevExpress.Web.v14.2, Version=14.2.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <div class="page-header">
        <h1>Puestos</h1>
    </div>
    <table style="width: 100%;">
        <tr>
            <td align="center">
                <asp:SqlDataSource ID="DEPARTAMENTOS" runat="server"
                    ConnectionString="<%$ ConnectionStrings:SIFICA %>"
                    SelectCommand="DEPARTAMENTOS_MOSTRAR_ID" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="ID_COMPAÑIA" SessionField="Compañia" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td align="center">
                <dx:ASPxGridView ID="grd" runat="server" AutoGenerateColumns="False"
                    DataSourceID="PuestosDatos" EnableTheming="True" KeyFieldName="ID_PUESTO"
                    Theme="Youthful" Width="100%">
                    <Columns>
                        <dx:GridViewCommandColumn ShowClearFilterButton="True" ShowDeleteButton="True"
                            ShowEditButton="True" ShowNewButton="True" ShowNewButtonInHeader="True"
                            ShowUpdateButton="True" VisibleIndex="0" Width="20%">
                        </dx:GridViewCommandColumn>
                        <dx:GridViewDataTextColumn Caption="CLAVE" FieldName="ID_PUESTO"
                            ReadOnly="True" VisibleIndex="1" Visible="False">
                            <EditFormSettings Visible="False" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="PUESTO" VisibleIndex="2" Width="50%">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CREO" Visible="False" VisibleIndex="5">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataDateColumn FieldName="FECHA_CREACION" Visible="False"
                            VisibleIndex="6">
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataComboBoxColumn Caption="DEPARTAMENTO"
                            FieldName="ID_DEPARTAMENTO" VisibleIndex="4" Width="50%">
                            <PropertiesComboBox DataSourceID="DEPARTAMENTOS" TextField="DEPARTAMENTO"
                                ValueField="ID_DEPARTAMENTO">
                            </PropertiesComboBox>
                        </dx:GridViewDataComboBoxColumn>
                    </Columns>
                    <SettingsBehavior AllowDragDrop="False" AllowFocusedRow="True"
                        AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" />
                    <Settings ShowFilterRow="True" ShowGroupPanel="True" />
                    <Styles>
                        <Header HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
                        </Header>
                        <Cell HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
                        </Cell>
                    </Styles>
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="PuestosDatos" runat="server"
                    ConnectionString="<%$ ConnectionStrings:SIFICA %>"
                    InsertCommand="PUESTOS_INSERTAR" InsertCommandType="StoredProcedure"
                    SelectCommand="PUESTOS_MOSTRAR_COMPAÑIAS" SelectCommandType="StoredProcedure"
                    UpdateCommand="PUESTOS_ACTUALIZAR" UpdateCommandType="StoredProcedure" DeleteCommand="PUESTOS_ELIMINAR" DeleteCommandType="StoredProcedure">
                    <DeleteParameters>
                        <asp:Parameter Name="ID_PUESTO" Type="Int32" />
                    </DeleteParameters>
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
                        <asp:Parameter Name="ID_DEPARTAMENTO" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td align="center">&nbsp;</td>
            <td align="center">&nbsp;</td>
        </tr>
    </table>
</asp:Content>
