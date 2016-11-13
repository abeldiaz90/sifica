<%@ Page Title="Catalogo de Roles" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Roles.aspx.cs" Inherits="SISGRES.Roles" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<%@ Register assembly="DevExpress.Web.ASPxTreeList.v14.2, Version=14.2.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxTreeList" tagprefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
     <div class="page-header">
        <h1>Roles</h1>
    </div>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:SqlDataSource ID="RolesDatos" runat="server" 
                ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
                DeleteCommand="ROLES_ELIMINAR" DeleteCommandType="StoredProcedure" 
                InsertCommand="ROLES_INSERTAR" InsertCommandType="StoredProcedure" 
                SelectCommand="ROLES_MOSTRAR_TODOS" SelectCommandType="StoredProcedure" 
                UpdateCommand="ROLES_MODIFICAR" UpdateCommandType="StoredProcedure">
                <DeleteParameters>
                    <asp:Parameter Name="ID_ROL" Type="String" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="ROL" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="ID_ROL" Type="Int32" />
                    <asp:Parameter Name="ROL" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <dx:ASPxGridView ID="grdRoles" runat="server" AutoGenerateColumns="False" 
                DataSourceID="RolesDatos" EnableTheming="True" KeyFieldName="ID_ROL" 
                Theme="Youthful" Width="100%" EnableCallbackAnimation="True" 
                EnablePagingCallbackAnimation="True">
                <Columns>
                    <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" 
                        ShowNewButtonInHeader="True" VisibleIndex="0" ShowClearFilterButton="True">
                    </dx:GridViewCommandColumn>
                    <dx:GridViewDataTextColumn FieldName="ID_ROL" ReadOnly="True" Visible="False" 
                        VisibleIndex="1">
            <EditFormSettings Visible="False" />
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="ROL" VisibleIndex="2">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="PERMISOS" Visible="False" 
                        VisibleIndex="3">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn VisibleIndex="4">
                        <EditFormSettings Visible="False" />
                        <dataitemtemplate>
                            <asp:ImageButton ID="imgPermisos" runat="server" ImageAlign="Middle" 
                                ImageUrl="~/Logos/key.png" onclick="imgPermisos_Click" Width="32px" />
                        </dataitemtemplate>
                    </dx:GridViewDataTextColumn>
                </Columns>
    <SettingsBehavior AllowFocusedRow="True" 
        AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" ConfirmDelete="True" />
                <Settings ShowFilterRow="True" />
                <styles>
                    <cell horizontalalign="Center" verticalalign="Middle" wrap="True">
                    </cell>
                    <header horizontalalign="Center" verticalalign="Middle" wrap="True">
                    </header>
                </styles>
            </dx:ASPxGridView>
            <dx:ASPxPopupControl ID="popupPermisos" runat="server" HeaderText="" 
                Modal="True" PopupHorizontalAlign="WindowCenter" 
                PopupVerticalAlign="WindowCenter" ShowPageScrollbarWhenModal="True" 
                Theme="Youthful" Width="700px">
                <contentcollection>
                    <dx:PopupControlContentControl runat="server">
                        <dx:ASPxTreeList ID="ASPxTreeList1" runat="server" AutoGenerateColumns="False" 
                            DataSourceID="MenuPermisos" EnableTheming="True" Height="100%" 
                            KeyFieldName="Id" ParentFieldName="ParentId" Theme="Youthful" Width="100%">
                            <Columns>
                                <dx:TreeListTextColumn FieldName="Name" ShowInCustomizationForm="True" 
                                    VisibleIndex="0">
                                </dx:TreeListTextColumn>
                                <dx:TreeListTextColumn FieldName="ToolTip" ShowInCustomizationForm="True" 
                                    Visible="False" VisibleIndex="1">
                                </dx:TreeListTextColumn>
                                <dx:TreeListTextColumn FieldName="NavigateUrl" ShowInCustomizationForm="True" 
                                    Visible="False" VisibleIndex="2">
                                </dx:TreeListTextColumn>
                                <dx:TreeListTextColumn FieldName="ImageUrlField" ShowInCustomizationForm="True" 
                                    Visible="False" VisibleIndex="3">
                                </dx:TreeListTextColumn>
                                <dx:TreeListCommandColumn ShowInCustomizationForm="True" VisibleIndex="4">
                                </dx:TreeListCommandColumn>
                            </Columns>
                            <SettingsBehavior AllowFocusedNode="True" AutoExpandAllNodes="True" />
                            <settingsbehavior allowfocusednode="True" autoexpandallnodes="True" />
                            <settingspager mode="ShowPager" pagesize="20" position="TopAndBottom">
                            </settingspager>
                            <SettingsSelection Enabled="True" />
                            <SettingsEditing AllowNodeDragDrop="True" />
                            <SettingsDataSecurity AllowDelete="False" AllowEdit="False" 
            AllowInsert="False" />
                            <settingsselection enabled="True" />
                            <settingsediting allownodedragdrop="True" />
                            <settingsdatasecurity allowdelete="False" allowedit="False" 
                                allowinsert="False" />
                        </dx:ASPxTreeList>
                        <asp:SqlDataSource ID="MenuPermisos" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:SIFICA %>" 
                            SelectCommand="OBTENER_MENU_COMPLETO" SelectCommandType="StoredProcedure">
                        </asp:SqlDataSource>
                        <dx:ASPxButton ID="ASPxButton2" runat="server" OnClick="ASPxButton2_Click" 
                            Text="Guardar Permisos" Theme="Mulberry">
                        </dx:ASPxButton>
                    </dx:PopupControlContentControl>
                </contentcollection>
            </dx:ASPxPopupControl>
            <br />
        </ContentTemplate>
    </asp:UpdatePanel>
    <br />
</asp:Content>
