<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Percepciones.aspx.cs" Inherits="SISGRES.Percepciones" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <dx:ASPxGridView ID="grdPercepciones" runat="server" 
        AutoGenerateColumns="False" DataSourceID="PercepcionesDatos" 
        EnableTheming="True" KeyboardSupport="True" KeyFieldName="ID_PERCEPCION" 
        Theme="Youthful" Width="100%">
        <Columns>
            <dx:GridViewCommandColumn 
                ShowClearFilterButton="True" ShowDeleteButton="True" ShowEditButton="True" 
                ShowNewButtonInHeader="True" VisibleIndex="0" Width="100px">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="ID_PERCEPCION" ReadOnly="True" 
                Visible="False" VisibleIndex="1">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="PERCEPCION" FieldName="PERCEPCION" 
                VisibleIndex="2">
                <Settings AutoFilterCondition="Contains" />
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
    <asp:SqlDataSource ID="PercepcionesDatos" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
        DeleteCommand="PERCEPCIONES_ELIMINAR" DeleteCommandType="StoredProcedure" 
        InsertCommand="PERCEPCIONES_INSERTAR" InsertCommandType="StoredProcedure" 
        SelectCommand="PERCEPCIONES_CONSULTAR" SelectCommandType="StoredProcedure" 
        UpdateCommand="PERCEPCIONES_MODIFICAR" UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="ID_PERCEPCION" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="PERCEPCION" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="ID_PERCEPCION" Type="Int32" />
            <asp:Parameter Name="PERCEPCION" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
