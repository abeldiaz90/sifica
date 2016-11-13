<%@ Page Title="Aprobadores de requisiciones" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="AprobadoresRequisiciones.aspx.cs" Inherits="SISGRES.AprobadoresRequisiciones" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
       <div class="page-header">
        <h1>Aprobadores de Requisiciones</h1>
    </div>
    <dx:ASPxGridView ID="grdAprobadores" runat="server" AutoGenerateColumns="False" DataSourceID="DatosAprobadoresRequisicion" KeyFieldName="ID" Width="100%" EnableTheming="True" Theme="Office2003Blue">
        <Columns>
            <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0" Width="100px">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="ID" VisibleIndex="1" Width="100px" ReadOnly="True" Visible="False">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="NOMBRE" VisibleIndex="4">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="SEGUNDO NOMBRE" FieldName="SEGUNDO_NOMBRE" VisibleIndex="5">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="APELLIDO_PATERNO" VisibleIndex="6" Caption="APELLIDO PATERNO">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="APELLIDO_MATERNO" VisibleIndex="7" Caption="APELLIDO MATERNO">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="CORREO ELECTRONICO" FieldName="CORREO_ELECTRONICO" VisibleIndex="8">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataCheckColumn FieldName="ESTADO" VisibleIndex="9" Width="100px">
            </dx:GridViewDataCheckColumn>
            <dx:GridViewDataComboBoxColumn FieldName="ID_EMPLEADO" Visible="False" VisibleIndex="3" Width="100px">
                <PropertiesComboBox DataSourceID="EmpleadosNombre" TextField="NOMBRE" ValueField="ID_EMPLEADO">
                </PropertiesComboBox>
                <EditFormSettings Visible="True" />
            </dx:GridViewDataComboBoxColumn>
        </Columns>
        <Settings ShowFilterRow="True" ShowGroupPanel="True" />
        <SettingsSearchPanel Visible="True" />
        <Styles>
            <Header HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </Header>
            <Cell HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </Cell>
        </Styles>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="DatosAprobadoresRequisicion" runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>" DeleteCommand="APROBADORES_REQUISICIONES_ELIMINAR" DeleteCommandType="StoredProcedure" InsertCommand="APROBADORES_REQUISICIONES_INSERTAR" InsertCommandType="StoredProcedure" SelectCommand="APROBADORES_REQUISICIONES_CONSULTAR_TODOS" SelectCommandType="StoredProcedure" UpdateCommand="APROBADORES_REQUISICIONES_MODIFICAR" UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="ID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="ID_EMPLEADO" Type="Int32" />
            <asp:Parameter Name="ESTADO" Type="Boolean" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="ID" Type="Int32" />
            <asp:Parameter Name="ID_EMPLEADO" Type="Int32" />
            <asp:Parameter Name="ESTADO" Type="Boolean" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="EmpleadosNombre" runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>" SelectCommand="EMPLEADOS_NOMBRE" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
</asp:Content>
