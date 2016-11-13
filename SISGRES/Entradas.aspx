<%@ Page Title="Entradas a almacen" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Entradas.aspx.cs" Inherits="SISGRES.Entradas" %>

<%@ Register Assembly="DevExpress.Web.v14.2, Version=14.2.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <div class="page-header">
        <h1>Entradas a Almacen</h1>
    </div>
    <div class="panel panel-default">
        <div class="panel-body">
            <dx:ASPxRadioButtonList ID="rdbEntradas" runat="server" OnSelectedIndexChanged="rdbEntradas_SelectedIndexChanged" RepeatDirection="Horizontal" AutoPostBack="True" Font-Size="Large" Width="100%">
                <Items>
                    <dx:ListEditItem Text="Orden de Compra" Value="Orden de Compra" />
                    <dx:ListEditItem Text="Devoluciones" Value="Devoluciones" />
                </Items>
            </dx:ASPxRadioButtonList>
        </div>
    </div>

    <dx:ASPxRoundPanel ID="pnlOrdenesCompras" runat="server" HeaderText="Entradas Por Ordenes de Compras" Theme="Glass" Width="100%" Visible="False">
        <PanelCollection>
            <dx:PanelContent runat="server">
                <table style="width: 100%;">
                    <tr>
                        <td align="center" valign="middle">
                            <dx:ASPxComboBox ID="cboOC" runat="server" AutoPostBack="True" AutoResizeWithContainer="True" BackColor="White" Caption="Seleccione la Orden de Compra:" DataSourceID="OrdenesCompra" EnableTheming="True" ForeColor="Black" TextField="FOLIO_OC" Theme="Glass" ValueField="ID" OnSelectedIndexChanged="cboOC_SelectedIndexChanged">
                                <CaptionSettings HorizontalAlign="Center" Position="Top" VerticalAlign="Top" />
                                <ValidationSettings SetFocusOnError="True" ValidationGroup="Recepcionar">
                                    <RequiredField IsRequired="True" />
                                </ValidationSettings>
                            </dx:ASPxComboBox>
                            <asp:SqlDataSource ID="OrdenesCompra" runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>" SelectCommand="ENTRADAS_ALMACEN_CONSULTAR_TODAS" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                        </td>
                        <td align="center" valign="middle">
                            <dx:ASPxTextBox ID="txtRequisitor" runat="server" Caption="Requisitor:" ForeColor="Black" Width="170px" ReadOnly="True">
                                <CaptionSettings HorizontalAlign="Center" Position="Top" />
                                <CaptionCellStyle BackColor="White">
                                </CaptionCellStyle>
                            </dx:ASPxTextBox>
                        </td>
                        <td align="center" valign="middle">
                            <dx:ASPxTextBox ID="txtAprobadorRequest" runat="server" BackColor="White" Caption="Aprobador Requisición" ForeColor="Black" Width="170px" ReadOnly="True">
                                <CaptionSettings HorizontalAlign="Center" Position="Top" VerticalAlign="Top" />
                            </dx:ASPxTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" valign="middle">
                            <dx:ASPxTextBox ID="txtAprobadorOc" runat="server" Caption="Aprobador OC" ReadOnly="True" Width="170px">
                                <CaptionSettings HorizontalAlign="Center" Position="Top" />
                            </dx:ASPxTextBox>
                        </td>
                        <td align="center" valign="middle">
                            <dx:ASPxTextBox ID="txtProveedor" runat="server" Caption="Proveedor" ReadOnly="True" Width="170px">
                                <CaptionSettings HorizontalAlign="Center" Position="Top" />
                            </dx:ASPxTextBox>
                        </td>
                        <td align="center" valign="middle">&nbsp;</td>
                    </tr>
                </table>
                <dx:ASPxGridView ID="grdCompras" runat="server" AutoGenerateColumns="False" DataSourceID="ComprasDatos" EnableTheming="True" Theme="Office2003Blue" Width="100%">
                    <TotalSummary>
                        <dx:ASPxSummaryItem DisplayFormat="C2" FieldName="IMPORTE" ShowInColumn="IMPORTE" ShowInGroupFooterColumn="IMPORTE" SummaryType="Sum" ValueDisplayFormat="C2" />
                    </TotalSummary>
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="CANTIDAD" ShowInCustomizationForm="True" VisibleIndex="2">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="PRECIO" ShowInCustomizationForm="True" VisibleIndex="4">
                            <PropertiesTextEdit DisplayFormatString="C2">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="IMPORTE" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="5">
                            <PropertiesTextEdit DisplayFormatString="C2">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="DESCRIPCIÓN" FieldName="DESCRIPCION" ShowInCustomizationForm="True" VisibleIndex="3">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="FOLIO DE ORDEN DE COMPRA" FieldName="FOLIO_OC" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="1">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="FOLIO DE REQUISICIÓN" FieldName="FOLIO_REQUISICION" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="0">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <Settings ShowFooter="True" />
                    <Styles>
                        <Header HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
                        </Header>
                        <Cell HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
                        </Cell>
                    </Styles>
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="ComprasDatos" runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>" SelectCommand="ENTRADAS_ALMACEN_CONSULTAR" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="cboOC" Name="ID" PropertyName="Value" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <dx:ASPxButton ID="btnRecepcionar" runat="server" CssClass="btn btn-success" OnClick="ASPxButton2_Click" Text="Recepcionar" ValidationGroup="Recepcionar">
                </dx:ASPxButton>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxRoundPanel>
    <dx:ASPxRoundPanel ID="pnlDevoluciones" runat="server" HeaderText="Devoluciones" Theme="Glass" Visible="False" Width="100%">
        <PanelCollection>
            <dx:PanelContent runat="server">
                <dx:ASPxGridView ID="grdSalidas" runat="server" AutoGenerateColumns="False" DataSourceID="SALIDAS_DEVOLUCIONES_TODAS" EnableTheming="True" Theme="Glass" Width="100%">
                    <Columns>
                        <dx:GridViewCommandColumn ShowClearFilterButton="True" ShowInCustomizationForm="True" VisibleIndex="0">
                        </dx:GridViewCommandColumn>
                        <dx:GridViewDataTextColumn Caption="FOLIO" FieldName="ID_SALIDA" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="1">
                            <EditFormSettings Visible="False" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" ShowInCustomizationForm="True" Visible="False" VisibleIndex="2">
                            <EditFormSettings Visible="False" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataDateColumn Caption="FECHA DE ENTREGA" FieldName="FECHA_SALIDA" ShowInCustomizationForm="True" VisibleIndex="3">
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataTextColumn FieldName="CODIGO" ShowInCustomizationForm="True" VisibleIndex="4">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="SOLICITANTE" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="5">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataCheckColumn Caption="SE DEBE DEVOLVER" FieldName="DEVOLVER" ShowInCustomizationForm="True" VisibleIndex="9">
                        </dx:GridViewDataCheckColumn>
                        <dx:GridViewDataTextColumn FieldName="ITEM" ShowInCustomizationForm="True" VisibleIndex="6">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="DESCRIPCION" ShowInCustomizationForm="True" VisibleIndex="7">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CANTIDAD" ShowInCustomizationForm="True" VisibleIndex="8">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn ShowInCustomizationForm="True" VisibleIndex="10">
                            <DataItemTemplate>
                                <asp:LinkButton ID="lnkDevolver" runat="server" OnClick="lnkDevolver_Click">Devolver</asp:LinkButton>
                            </DataItemTemplate>
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" />
                    <Settings ShowFilterRow="True" ShowGroupPanel="True" />
                    <SettingsSearchPanel Visible="True" />
                    <Styles>
                        <Cell HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
                        </Cell>
                    </Styles>
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="SALIDAS_DEVOLUCIONES_TODAS" runat="server" ConnectionString="<%$ ConnectionStrings:PARTIDAS %>" SelectCommand="SALIDAS_DEVOLUCIONES_TODAS" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                <asp:SqlDataSource ID="Empleados" runat="server"
                    ConnectionString="<%$ ConnectionStrings:SIFICA %>"
                    SelectCommand="EMPLEADOS_MOSTRAR_ID_COMPAÑIA"
                    SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="ID_COMPAÑIA" SessionField="Compañia" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <br />
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxRoundPanel>
</asp:Content>
