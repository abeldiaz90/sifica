<%@ Page Title="Departamentos" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Departamentos.aspx.cs" Inherits="SISGRES.Departamentos" %>

<%@ Register Assembly="DevExpress.Web.v14.2, Version=14.2.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <div class="page-header">
        <h1>Departamentos</h1>
    </div>
    <dx:ASPxGridView ID="grdDepartamentos" runat="server"
        AutoGenerateColumns="False" ClientInstanceName="grdDepartamentos"
        DataSourceID="DEPARTAMENTOSDATOS" EnableTheming="True" KeyboardSupport="True"
        KeyFieldName="ID_DEPARTAMENTO" Theme="Youthful" Width="100%">
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" ShowDeleteButton="True"
                ShowEditButton="True" ShowNewButton="True" ShowNewButtonInHeader="True"
                ShowUpdateButton="True" VisibleIndex="0" Width="20%">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn Caption="CLAVE" FieldName="ID_DEPARTAMENTO"
                ReadOnly="True" VisibleIndex="1" Visible="False">
                <Settings AutoFilterCondition="Contains" />
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="DEPARTAMENTO" VisibleIndex="2" Width="50%">
                <Settings AutoFilterCondition="Contains" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CREO" Visible="False" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="FECHA_CREACION" Visible="False"
                VisibleIndex="6">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataComboBoxColumn Caption="COMPAÑIA" FieldName="ID_COMPAÑIA"
                VisibleIndex="4" Width="50%">
                <PropertiesComboBox DataSourceID="Compañias" TextField="COMPAÑIA"
                    ValueField="ID_COMPAÑIA">
                </PropertiesComboBox>
                <Settings AutoFilterCondition="Contains" />
            </dx:GridViewDataComboBoxColumn>
        </Columns>
        <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True"
            AllowSelectSingleRowOnly="True" ConfirmDelete="True" />
        <Settings ShowFilterRow="True" ShowGroupPanel="True" />
        <Styles>
            <Header HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </Header>
            <Cell HorizontalAlign="Center" VerticalAlign="Middle">
            </Cell>
        </Styles>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="DEPARTAMENTOSDATOS" runat="server"
        ConnectionString="<%$ ConnectionStrings:SIFICA %>"
        InsertCommand="DEPARTAMENTOS_INSERTAR" InsertCommandType="StoredProcedure"
        SelectCommand="DEPARTAMENTOS_MOSTRAR_ID" SelectCommandType="StoredProcedure"
        UpdateCommand="DEPARTAMENTOS_MODIFICAR" UpdateCommandType="StoredProcedure" DeleteCommand="DEPARTAMENTOS_ELIMINAR" DeleteCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="ID_DEPARTAMENTO" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="DEPARTAMENTO" Type="String" />
            <asp:Parameter Name="ID_COMPAÑIA" Type="Int32" />
            <asp:Parameter Name="CREO" Type="String" />
        </InsertParameters>
        <SelectParameters>
            <asp:SessionParameter Name="ID_COMPAÑIA" SessionField="Compañia" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="ID_DEPARTAMENTO" Type="Int32" />
            <asp:Parameter Name="DEPARTAMENTO" Type="String" />
            <asp:Parameter Name="ID_COMPAÑIA" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="Compañias" runat="server"
        ConnectionString="<%$ ConnectionStrings:SIFICA %>"
        SelectCommand="COMPAÑIAS_MOSTRAR_ID" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="ID_COMPAÑIA" SessionField="Compañia" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
