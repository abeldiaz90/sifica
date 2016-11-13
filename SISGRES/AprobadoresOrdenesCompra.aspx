<%@ Page Title="Aprobadores de Ordenes de Compra" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="AprobadoresOrdenesCompra.aspx.cs" Inherits="SISGRES.AprobadoresOrdenesCompra" %>

<%@ Register Assembly="DevExpress.Web.v14.2, Version=14.2.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <div class="page-header">
        <h1>Aprobadores de Ordenes de Compra</h1>
    </div>
    <dx:ASPxGridView ID="grdAprobadores" runat="server" AutoGenerateColumns="False" DataSourceID="DatosAprobadoresRequisicion" KeyFieldName="ID_EMPLEADO" Width="100%" EnableTheming="True" Theme="Office2003Blue">
        <Columns>
            <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="NOMBRE" VisibleIndex="2" Caption="NOMBRE" Width="150px">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="SEGUNDO NOMBRE" FieldName="SEGUNDO_NOMBRE" VisibleIndex="3" Width="150px">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="APELLIDO PATERNO" FieldName="APELLIDO_PATERNO" VisibleIndex="4" Width="150px">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="APELLIDO_MATERNO" VisibleIndex="5" Caption="APELLIDO MATERNO" Width="150px">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CORREO_ELECTRONICO" VisibleIndex="6" Caption="EMAIL" Width="150px">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataCheckColumn FieldName="ESTADO" VisibleIndex="7" Caption="HABILITADO" Width="100px">
            </dx:GridViewDataCheckColumn>
            <dx:GridViewDataComboBoxColumn FieldName="ID_EMPLEADO" Visible="False" VisibleIndex="1">
                <PropertiesComboBox DataSourceID="EmpleadosNombre" TextField="NOMBRE" ValueField="ID_EMPLEADO">
                </PropertiesComboBox>
                <EditFormSettings Visible="True" />
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataTextColumn FieldName="ID" Visible="False" VisibleIndex="8">
            </dx:GridViewDataTextColumn>
        </Columns>
        <Settings ShowFilterRow="True" ShowGroupPanel="True" />
        <SettingsSearchPanel Visible="True" />
        <Styles>
            <Header HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </Header>
            <Cell HorizontalAlign="Center" VerticalAlign="Middle">
            </Cell>
        </Styles>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="DatosAprobadoresRequisicion" runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>" DeleteCommand="APROBADORES_OC_ELIMINAR" DeleteCommandType="StoredProcedure" InsertCommand="APROBADORES_OC_INSERTAR" InsertCommandType="StoredProcedure" SelectCommand="APROBADORES_OC_CONSULTAR_TODOS" SelectCommandType="StoredProcedure" UpdateCommand="APROBADORES_OC_MODIFICAR" UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="ID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="ID_EMPLEADO" Type="Int32" />
            <asp:Parameter Name="ESTADO" Type="Boolean" />
        </InsertParameters>
        <SelectParameters>
            <asp:SessionParameter Name="ID_COMPAÑIA" SessionField="Compañia" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="ID" Type="Int32" />
            <asp:Parameter Name="ID_EMPLEADO" Type="Int32" />
            <asp:Parameter Name="ESTADO" Type="Boolean" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="EmpleadosNombre" runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>" SelectCommand="EMPLEADOS_NOMBRE" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
</asp:Content>
