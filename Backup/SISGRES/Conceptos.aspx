<%@ Page Title="Catalogo de Conceptos" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Conceptos.aspx.cs" Inherits="SISGRES.Conceptos" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="CONCEPTOSDATOS" EnableTheming="True" KeyFieldName="ID_CONCEPTO" 
        Theme="Youthful" Width="100%" EnableCallbackAnimation="True" 
        EnablePagingCallbackAnimation="True">
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" ShowDeleteButton="True" 
                ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0" 
                Width="100px">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="ID_CONCEPTO" ReadOnly="True" 
                Visible="False" VisibleIndex="1">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="CONCEPTO" FieldName="CONCEPTO" 
                VisibleIndex="2">
                <Settings AllowAutoFilter="True" AllowAutoFilterTextInputTimer="False" 
                    AutoFilterCondition="Contains" />
            </dx:GridViewDataTextColumn>
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
    <asp:SqlDataSource ID="CONCEPTOSDATOS" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
        DeleteCommand="CONCEPTOS_ELIMINAR" DeleteCommandType="StoredProcedure" 
        InsertCommand="CONCEPTOS_INSERTAR" InsertCommandType="StoredProcedure" 
        SelectCommand="CONCEPTOS_CONSULTAR" SelectCommandType="StoredProcedure" 
        UpdateCommand="CONCEPTOS_MODIFICAR" UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="ID_CONCEPTO" Type="Int32" />
            <asp:Parameter Name="CONCEPTO" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="CONCEPTO" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="ID_CONCEPTO" Type="Int32" />
            <asp:Parameter Name="CONCEPTO" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
