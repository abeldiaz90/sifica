<%@ Page Title="Aprobadores De Salidas de Almacen" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="AprobadoresSalidasItems.aspx.cs" Inherits="SISGRES.AprobadoresSalidasItems" %>

<%@ Register Assembly="DevExpress.Web.v14.2, Version=14.2.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <dx:ASPxGridView ID="grdAprobadores" runat="server" AutoGenerateColumns="False" DataSourceID="AprobadoreSalidasDatos" KeyFieldName="ID_APROBADOR" Theme="Glass" Width="100%">
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="ID_APROBADOR" ReadOnly="True" Visible="False" VisibleIndex="1">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataCheckColumn FieldName="ESTADO" VisibleIndex="5">
                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True" />
            </dx:GridViewDataCheckColumn>
            <dx:GridViewDataTextColumn FieldName="CORREO_ELECTRONICO" VisibleIndex="4" Caption="CORREO ELECTRONICO">
                <EditFormSettings Visible="False" />
                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataComboBoxColumn FieldName="ID_EMPLEADO" Visible="False" VisibleIndex="2">
                <PropertiesComboBox DataSourceID="Empleados" TextField="NOMBRE" ValueField="ID_EMPLEADO">
                </PropertiesComboBox>
                <EditFormSettings Visible="True" />
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn Caption="EMPLEADO APROBADOR" FieldName="NOMBRE" ReadOnly="True" VisibleIndex="3">
                <PropertiesComboBox DataSourceID="Empleados" TextField="NOMBRE" ValueField="ID_EMPLEADO">
                </PropertiesComboBox>
                <EditFormSettings Visible="False" />
                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True" />
            </dx:GridViewDataComboBoxColumn>
        </Columns>
        <SettingsBehavior ConfirmDelete="True" />
        <Settings ShowFilterRow="True" />
        <SettingsSearchPanel Visible="True" />
        <Styles>
            <Cell HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </Cell>
        </Styles>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="AprobadoreSalidasDatos" runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>" DeleteCommand="APROBADORES_SALIDAS_ELIMINAR" DeleteCommandType="StoredProcedure" InsertCommand="APROBADORES_SALIDAS_INSERTAR" InsertCommandType="StoredProcedure" SelectCommand="APROBADORES_SALIDAS_CONSULTAR" SelectCommandType="StoredProcedure" UpdateCommand="APROBADORES_SALIDAS_MODIFICAR" UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="ID_EMPLEADO" Type="Int32" />
            <asp:Parameter Name="ESTADO" Type="Boolean" />
            <asp:Parameter Name="ID_APROBADOR" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="ID_EMPLEADO" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="ID_EMPLEADO" Type="Int32" />
            <asp:Parameter Name="ESTADO" Type="Boolean" />
            <asp:Parameter Name="ID_APROBADOR" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="Empleados" runat="server"
        ConnectionString="<%$ ConnectionStrings:SIFICA %>"
        SelectCommand="EMPLEADOS_MOSTRAR_ID_COMPAÑIA"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="ID_COMPAÑIA" SessionField="Compañia" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
