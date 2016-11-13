<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Salarios.aspx.cs" Inherits="SISGRES.Salarios" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <dx:ASPxGridView ID="grdEmpleados" runat="server" AutoGenerateColumns="False" 
        DataSourceID="EMPLEADOS_SALARIOS" EnableTheming="True" 
        KeyFieldName="ID_EMPLEADO" Theme="BlackGlass" Width="100%">
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" ShowEditButton="True" 
                VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn Caption="NUMERO DE EMPLEADO" FieldName="ID_EMPLEADO" 
                ReadOnly="True" VisibleIndex="1">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="NOMBRE" ReadOnly="True" VisibleIndex="2">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="SEGUNDO NOMBRE" FieldName="SEGUNDO_NOMBRE" 
                ReadOnly="True" VisibleIndex="3">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="APELLIDO PATERNO" 
                FieldName="APELLIDO_PATERNO" ReadOnly="True" VisibleIndex="4">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="APELLIDO MATERNO" 
                FieldName="APELLIDO_MATERNO" ReadOnly="True" VisibleIndex="5">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="SUELDO DIARIO" FieldName="SALARIO_DIARIO" 
                VisibleIndex="25">
                <PropertiesTextEdit DisplayFormatString="c2">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataComboBoxColumn Caption="PUESTO" FieldName="PUESTO" 
                ReadOnly="True" ShowInCustomizationForm="False" VisibleIndex="26">
                <PropertiesComboBox DataSourceID="Puestos" IncrementalFilteringMode="Contains" 
                    TextField="PUESTO" ValueField="ID_PUESTO">
                </PropertiesComboBox>
                <EditFormSettings Visible="False" />
            </dx:GridViewDataComboBoxColumn>
        </Columns>
        <SettingsEditing Mode="Inline">
        </SettingsEditing>
        <Settings ShowFilterRow="True" ShowGroupPanel="True" />
        <Styles>
            <Cell HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </Cell>
            <Header HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </Header>
        </Styles>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="EMPLEADOS_SALARIOS" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
        SelectCommand="EMPLEADOS_MOSTRAR_TODOS" SelectCommandType="StoredProcedure" 
        UpdateCommand="SALARIOS_MODIFICAR" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="COMPAÑIA" SessionField="Compañia" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="ID_EMPLEADO" Type="Int32" />
            <asp:Parameter Name="SALARIO_DIARIO" Type="Decimal" />
            <asp:Parameter Name="ACTUALIZADO_POR" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="Puestos" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
        SelectCommand="PUESTOS_MOSTRAR_COMPAÑIAS" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="ID_COMPAÑIA" SessionField="Compañia" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
