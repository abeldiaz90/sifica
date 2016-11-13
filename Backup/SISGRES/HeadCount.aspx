<%@ Page Title="HeadCount" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="HeadCount.aspx.cs" Inherits="SISGRES.HeadCount" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <dx:ASPxGridView ID="grdEmpleados" runat="server" AutoGenerateColumns="False" 
        DataSourceID="EmpleadosDatos" EnableTheming="True" KeyFieldName="ID_EMPLEADO" 
        Theme="BlackGlass" Width="100%">
        <Columns>
            <dx:GridViewCommandColumn ShowEditButton="True" ShowNewButtonInHeader="True" 
                VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn Caption="NUMERO DE EMPLEADO" FieldName="ID_EMPLEADO" 
                ReadOnly="True" VisibleIndex="1">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="NOMBRE" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="SEGUNDO NOMBRE" FieldName="SEGUNDO_NOMBRE" 
                VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="APELLIDO PATERNO" 
                FieldName="APELLIDO_PATERNO" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="APELLIDO MATERNO" 
                FieldName="APELLIDO_MATERNO" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="COMPAÑIA" FieldName="COMPAÑIA" 
                Visible="False" VisibleIndex="6">
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" 
            AllowSelectSingleRowOnly="True" ConfirmDelete="True" />
        <Settings ShowFilterRow="True" />
        <SettingsDetail AllowOnlyOneMasterRowExpanded="True" ExportMode="Expanded" 
            ShowDetailRow="True" />
        <Styles>
            <Header HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </Header>
            <Cell HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </Cell>
        </Styles>
        <Templates>
            <DetailRow>
                <table style="width:100%;">
                    <tr>
                        <td>
                            <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="DEPARTAMENTO:">
                            </dx:ASPxLabel>
                        </td>
                        <td>
                            <dx:ASPxLabel ID="ASPxLabel4" runat="server" Text="PUESTO:">
                            </dx:ASPxLabel>
                        </td>
                        <td>
                            <dx:ASPxLabel ID="ASPxLabel6" runat="server" Text="FECHA DE NACIMIENTO">
                            </dx:ASPxLabel>
                        </td>
                        <td>
                            <dx:ASPxLabel ID="ASPxLabel7" runat="server" Text="CURP:">
                            </dx:ASPxLabel>
                        </td>
                        <td>
                            <dx:ASPxLabel ID="ASPxLabel8" runat="server" Text="NSS:">
                            </dx:ASPxLabel>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <dx:ASPxLabel ID="ASPxLabel5" runat="server" Text="RFC:">
                            </dx:ASPxLabel>
                        </td>
                        <td>
                            <dx:ASPxLabel ID="ASPxLabel9" runat="server" Text="TELEFONO DE CASA:">
                            </dx:ASPxLabel>
                        </td>
                        <td>
                            <dx:ASPxLabel ID="ASPxLabel10" runat="server" Text="CELULAR:">
                            </dx:ASPxLabel>
                        </td>
                        <td>
                            <dx:ASPxLabel ID="ASPxLabel11" runat="server" Text="ASPxLabel">
                            </dx:ASPxLabel>
                        </td>
                        <td>
                            <dx:ASPxLabel ID="ASPxLabel12" runat="server" Text="ASPxLabel">
                            </dx:ASPxLabel>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                    </tr>
                </table>
            </DetailRow>
        </Templates>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="EmpleadosDatos" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
        InsertCommand="EMPLEADOS_INSERTAR2" InsertCommandType="StoredProcedure" 
        SelectCommand="EMPLEADOS_CONSULTAR2" SelectCommandType="StoredProcedure" 
        UpdateCommand="EMPLEADOS_MODIFICAR2" UpdateCommandType="StoredProcedure">
        <InsertParameters>
            <asp:Parameter Name="NOMBRE" Type="String" />
            <asp:Parameter Name="SEGUNDO_NOMBRE" Type="String" />
            <asp:Parameter Name="APELLIDO_PATERNO" Type="String" />
            <asp:Parameter Name="APELLIDO_MATERNO" Type="String" />
            <asp:Parameter Name="COMPAÑIA" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:SessionParameter Name="COMPAÑIA" SessionField="Compañia" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="COMPAÑIA" Type="Int32" />
            <asp:Parameter Name="NOMBRE" Type="String" />
            <asp:Parameter Name="SEGUNDO_NOMBRE" Type="String" />
            <asp:Parameter Name="APELLIDO_PATERNO" Type="String" />
            <asp:Parameter Name="APELLIDO_MATERNO" Type="String" />
            <asp:Parameter Name="ID_EMPLEADO" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
