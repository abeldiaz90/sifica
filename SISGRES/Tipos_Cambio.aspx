<%@ Page Title="Tipos de Cambio" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Tipos_Cambio.aspx.cs" Inherits="SISGRES.Tipos_Cambio" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <table style="width:100%;">
        <tr>
            <td>
                <dx:ASPxGridView ID="grdTiposCambio" runat="server" AutoGenerateColumns="False" 
                    DataSourceID="TiposDeCambio" EnableTheming="True" KeyFieldName="ID_TIPO_CAMBIO" 
                    Theme="BlackGlass" Width="100%">
                    <Columns>
                        <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" 
                            ShowNewButtonInHeader="True" VisibleIndex="0">
                        </dx:GridViewCommandColumn>
                        <dx:GridViewDataTextColumn FieldName="ID_TIPO_CAMBIO" ReadOnly="True" 
                            Visible="False" VisibleIndex="1">
                            <EditFormSettings Visible="False" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="IMPORTE_COMPRA" VisibleIndex="2" 
                            Caption="TIPO DE CAMBIO COMPRA">
                            <PropertiesTextEdit DisplayFormatString="c6">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="TIPO DE CAMBIO VENTA" 
                            FieldName="IMPORTE_VENTA" VisibleIndex="3">
                            <PropertiesTextEdit DisplayFormatString="c6">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataDateColumn FieldName="FECHA" VisibleIndex="4">
                        </dx:GridViewDataDateColumn>
                    </Columns>
                    <Settings ShowFilterRow="True" ShowGroupPanel="True" />
                    <Styles>
                        <Cell HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
                        </Cell>
                        <Header HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
                        </Header>
                    </Styles>
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="TiposDeCambio" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
                    DeleteCommand="TIPOS_CAMBIO_ELIMINAR" DeleteCommandType="StoredProcedure" 
                    InsertCommand="TIPOS_CAMBIO_INSERTAR" InsertCommandType="StoredProcedure" 
                    SelectCommand="TIPOS_CAMBIO_CONSULTAR" SelectCommandType="StoredProcedure" 
                    UpdateCommand="TIPOS_CAMBIO_MODIFICAR" UpdateCommandType="StoredProcedure">
                    <DeleteParameters>
                        <asp:Parameter Name="ID_TIPO_CAMBIO" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="FECHA" Type="DateTime" />
                        <asp:Parameter Name="IMPORTE_VENTA" Type="Decimal" />
                        <asp:Parameter Name="IMPORTE_COMPRA" Type="Decimal" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="FECHA" Type="DateTime" />
                        <asp:Parameter Name="IMPORTE_COMPRA" Type="Decimal" />
                        <asp:Parameter Name="IMPORTE_VENTA" Type="Decimal" />
                        <asp:Parameter Name="ID_TIPO_CAMBIO" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        </table>
</asp:Content>
