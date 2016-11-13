<%@ Page Title="Items" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Items.aspx.cs" Inherits="SISGRES.Items" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <dx:ASPxGridView ID="grdItems" runat="server" AutoGenerateColumns="False" DataSourceID="ITEMSDATOS" KeyFieldName="ID_ITEM" EnableTheming="True" Theme="Glass" Width="100%">
        <Columns>
            <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0" Width="100px">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="ID_ITEM" ReadOnly="True" Visible="False" VisibleIndex="1">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="DESCRIPCION" VisibleIndex="2" Caption="DESCRIPCIÓN" Width="300px">
                <CellStyle HorizontalAlign="Justify" VerticalAlign="Top" Wrap="True">
                </CellStyle>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="NUMERO DE PARTE" FieldName="NUMBER_PART" VisibleIndex="6" Width="100px">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataCheckColumn Caption="ESTADO" FieldName="ESTADO" VisibleIndex="10" Width="100px">
            </dx:GridViewDataCheckColumn>
            <dx:GridViewDataTextColumn Caption="COMPAÑIA" FieldName="ID_COMPAÑIA" VisibleIndex="9" Visible="False">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataComboBoxColumn Caption="GIRO" FieldName="ID_GIRO" VisibleIndex="5" Width="100px">
                <PropertiesComboBox DataSourceID="GIROS" TextField="GIRO" ValueField="ID_GIRO">
                    <ValidationSettings>
                        <RequiredField IsRequired="True" />
                    </ValidationSettings>
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn Caption="CLASIFICACIÓN" FieldName="ID_CATEGORIA" VisibleIndex="4" Width="100px">
                <PropertiesComboBox DataSourceID="CLASIFICACION" TextField="CLASIFICACION" ValueField="ID_CLASIFICACION">
                    <ValidationSettings>
                        <RequiredField IsRequired="True" />
                    </ValidationSettings>
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn Caption="UNIDAD DE MEDIDA" FieldName="ID_UNIDAD" VisibleIndex="3" Width="100px">
                <PropertiesComboBox DataSourceID="UNIDADES_MEDIDA" TextField="UNIDAD" ValueField="ID_UNIDAD">
                    <ValidationSettings ErrorTextPosition="Bottom">
                        <RequiredField IsRequired="True" />
                    </ValidationSettings>
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataTextColumn Caption="STOCK MINIMO" FieldName="MIN" VisibleIndex="7">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="STOCK MAXIMO" FieldName="MAX" VisibleIndex="8">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataCheckColumn Caption="INVENTARIABLE" FieldName="INVENTARIABLE" VisibleIndex="11">
            </dx:GridViewDataCheckColumn>
        </Columns>
        <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" ConfirmDelete="True" />
        <Settings ShowFilterRow="True" ShowGroupPanel="True" />
        <SettingsSearchPanel Visible="True" />
        <Styles>
            <Header HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </Header>
            <Cell HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True">
            </Cell>
        </Styles>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="ITEMSDATOS" runat="server" ConnectionString="<%$ ConnectionStrings:PARTIDAS %>" DeleteCommand="ITEMS_ELIMINAR" DeleteCommandType="StoredProcedure" InsertCommand="ITEMS_INSERTAR" InsertCommandType="StoredProcedure" SelectCommand="ITEMS_CONSULTAR_TODOS" SelectCommandType="StoredProcedure" UpdateCommand="ITEMS_MODIFICAR" UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="ID_ITEM" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="DESCRIPCION" Type="String" />
            <asp:Parameter Name="ID_UNIDAD" Type="Int32" />
            <asp:Parameter Name="ID_CATEGORIA" Type="Int32" />
            <asp:Parameter Name="ID_GIRO" Type="Int32" />
            <asp:Parameter Name="NUMBER_PART" Type="String" />
            <asp:Parameter Name="ESTADO" Type="Boolean" />
               <asp:SessionParameter Name="ID_COMPAÑIA" SessionField="Compañia" Type="Int32" />
            <asp:Parameter Name="MIN" Type="Decimal" />
            <asp:Parameter Name="MAX" Type="Decimal" />
            <asp:Parameter Name="INVENTARIABLE" Type="Boolean" />
        </InsertParameters>
        <SelectParameters>
            <asp:SessionParameter Name="ID_COMPAÑIA" SessionField="Compañia" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="ID_ITEM" Type="Int32" />
            <asp:Parameter Name="DESCRIPCION" Type="String" />
            <asp:Parameter Name="ID_UNIDAD" Type="Int32" />
            <asp:Parameter Name="ID_CATEGORIA" Type="Int32" />
            <asp:Parameter Name="ID_GIRO" Type="Int32" />
            <asp:Parameter Name="NUMBER_PART" Type="String" />
            <asp:Parameter Name="ESTADO" Type="Boolean" />
            <asp:Parameter Name="MIN" Type="Decimal" />
            <asp:Parameter Name="MAX" Type="Decimal" />
            <asp:Parameter Name="INVENTARIABLE" Type="Boolean" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="GIROS" runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>" SelectCommand="GIROS_MOSTRAR_TODOS" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <asp:SqlDataSource ID="UNIDADES_MEDIDA" runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>" SelectCommand="UNIDADESMEDIDA_MOSTRAR_TODOS" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <asp:SqlDataSource ID="CLASIFICACION" runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>" SelectCommand="CLASIFICACIONES_CONSULTAR_TODAS_ACTIVAS" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
</asp:Content>
