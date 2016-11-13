<%@ Page Title="Cuentas Bancarias" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true"
    CodeBehind="CuentasBancarias.aspx.cs" Inherits="SISGRES.CuentasBancarias" %>

<%@ Register Assembly="DevExpress.Web.v14.2, Version=14.2.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <dx:ASPxGridView ID="grdCuentasBancarias" runat="server" AutoGenerateColumns="False"
        Caption="CUENTAS BANCARIAS" ClientInstanceName="grdCuentasBancarias" DataSourceID="CuentasBancariasDatos"
        EnableTheming="True" KeyFieldName="ID_CUENTA" Theme="Youthful" 
    Width="100%" EnableCallbackAnimation="True" 
    EnablePagingCallbackAnimation="True">
        <Columns>
            <dx:GridViewCommandColumn SelectAllCheckboxMode="Page" ShowClearFilterButton="True"
                ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="True" 
                VisibleIndex="0" ShowNewButton="True">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="ID_CUENTA" ReadOnly="True" Visible="False"
                VisibleIndex="1">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="NUMERO DE CUENTA" FieldName="CUENTA" VisibleIndex="2">
                <Settings AutoFilterCondition="Contains" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="SALDO INICIAL" FieldName="SALDO_INICIAL" VisibleIndex="7">
                <PropertiesTextEdit DisplayFormatString="c2">
                    <MaskSettings IncludeLiterals="DecimalSymbol" 
                        Mask="$&lt;0..999999999g&gt;.&lt;00..99&gt;" />
                </PropertiesTextEdit>
                <Settings AutoFilterCondition="Contains" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataComboBoxColumn Caption="BANCO" FieldName="ID_BANCO" VisibleIndex="4">
                <PropertiesComboBox DataSourceID="Bancos" ImageUrlField="URLLOGO" IncrementalFilteringMode="Contains"
                    TextField="BANCO" ValueField="ID_BANCO">
                    <ItemImage Height="48px" Width="48px">
                    </ItemImage>
                </PropertiesComboBox>
                <Settings AutoFilterCondition="Contains" />
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn Caption="COMPAÑIA" FieldName="ID_COMPAÑIA" VisibleIndex="6">
                <PropertiesComboBox IncrementalFilteringMode="Contains" DataSourceID="Compañia" 
                    TextField="COMPAÑIA" ValueField="ID_COMPAÑIA">
                </PropertiesComboBox>
                <Settings AutoFilterCondition="Contains" />
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn Caption="MONEDA" FieldName="MONEDA" 
                VisibleIndex="9">
                <PropertiesComboBox>
                    <Items>
                        <dx:ListEditItem Text="MXN" Value="MXN" />
                        <dx:ListEditItem Text="USD" Value="USD" />
                    </Items>
                </PropertiesComboBox>
                <Settings AutoFilterCondition="Contains" />
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataDateColumn Caption="FECHA DEL SALDO INICIAL" FieldName="FECHA" 
                VisibleIndex="10">
            </dx:GridViewDataDateColumn>
        </Columns>
        <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" 
            AllowSelectSingleRowOnly="True" ConfirmDelete="True" />
        <Settings ShowFilterRow="True" ShowGroupPanel="True" />
        <Styles>
            <Cell HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </Cell>
            <Header HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </Header>
        </Styles>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="CuentasBancariasDatos" runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>"
        DeleteCommand="CUENTAS_BANCARIAS_ELIMINAR" DeleteCommandType="StoredProcedure"
        InsertCommand="CUENTAS_BANCARIAS_INSERTAR" InsertCommandType="StoredProcedure"
        SelectCommand="CUENTAS_BANCARIAS_CONSULTAR" SelectCommandType="StoredProcedure"
        UpdateCommand="CUENTAS_BANCARIAS_MODIFICAR" UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="ID_CUENTA" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="CUENTA" Type="String" />
            <asp:Parameter Name="ID_BANCO" Type="Int32" />
            <asp:SessionParameter Name="ID_COMPAÑIA" SessionField="Compañia" Type="Int32" />
            <asp:Parameter Name="SALDO_INICIAL" Type="Decimal" />
            <asp:Parameter Name="MONEDA" Type="String" />
            <asp:Parameter Name="FECHA" Type="DateTime" />
        </InsertParameters>
        <SelectParameters>
            <asp:SessionParameter Name="ID_COMPAÑIA" SessionField="Compañia" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="ID_CUENTA" Type="Int32" />
            <asp:Parameter Name="CUENTA" Type="String" />
            <asp:Parameter Name="ID_BANCO" Type="Int32" />
            <asp:SessionParameter Name="ID_COMPAÑIA" SessionField="Compañia" Type="Int32" />
            <asp:Parameter Name="SALDO_INICIAL" Type="Decimal" />
            <asp:Parameter Name="MONEDA" Type="String" />
            <asp:Parameter Name="FECHA" Type="DateTime" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="Bancos" runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>"
        SelectCommand="SELECT [URLLOGO], [BANCO], [ID_BANCO] FROM [BANCOS] ORDER BY [BANCO]">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="Compañia" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
        SelectCommand="COMPAÑIAS_MOSTRAR_ID" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="ID_COMPAÑIA" SessionField="Compañia" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
