<%@ Page Title="Catalogo de Usuarios" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Usuarios.aspx.cs" Inherits="SISGRES.Usuarios" EnableEventValidation="true" %>

<%@ Register Assembly="DevExpress.Web.v14.2, Version=14.2.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>


<%@ Register Assembly="DevExpress.Web.ASPxTreeList.v14.2, Version=14.2.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxTreeList" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <script>

        function PopupUsuario() {
            $('#PopupUsuario').modal({
                show: true
                //,
                //backdrop: 'static'
            });
        }
    </script>

    <div class="page-header">
        <h1>Usuarios</h1>
    </div>
    <dx:ASPxButton ID="btnUsuarios" runat="server" Text="Catalogo de Usuarios" OnClick="btnUsuarios_Click" CssClass="btn btn-primary">
    </dx:ASPxButton>
    <dx:ASPxPopupControl ID="popupUsuarios" runat="server" AllowDragging="True" AllowResize="True" AutoUpdatePosition="True" CloseAnimationType="Slide" CloseOnEscape="True" HeaderText="Usuarios Dados de Alta" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Theme="Aqua" Width="700px">

        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="UsuariosDatos" EnableTheming="True" Theme="Glass" EnableCallbackAnimation="True" EnablePagingCallbackAnimation="True" OnAfterPerformCallback="ASPxGridView1_AfterPerformCallback" Width="100%" KeyFieldName="ID_USUARIO">
                    <Columns>
                        <dx:GridViewCommandColumn ShowClearFilterButton="True" ShowDeleteButton="True" ShowEditButton="True" ShowInCustomizationForm="True" VisibleIndex="0">
                        </dx:GridViewCommandColumn>
                        <dx:GridViewDataTextColumn FieldName="ID_USUARIO" ReadOnly="True" ShowInCustomizationForm="True" Visible="False" VisibleIndex="1">
                            <EditFormSettings Visible="False" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="USUARIO" FieldName="USUARIO" ShowInCustomizationForm="True" VisibleIndex="2">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="CONTRASEÑA" FieldName="PASSWORD" ShowInCustomizationForm="True" VisibleIndex="3">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataComboBoxColumn Caption="ROL" FieldName="ID_ROL" ShowInCustomizationForm="True" VisibleIndex="5">
                            <PropertiesComboBox DataSourceID="Roles" TextField="ROL" ValueField="ID_ROL">
                            </PropertiesComboBox>
                        </dx:GridViewDataComboBoxColumn>
                        <dx:GridViewDataComboBoxColumn Caption="EMPLEADO" FieldName="ID_EMPLEADO" ShowInCustomizationForm="True" VisibleIndex="4">
                            <PropertiesComboBox DataSourceID="Empleados" TextField="NOMBRE" ValueField="ID_EMPLEADO">
                            </PropertiesComboBox>
                            <EditFormSettings Visible="False" />
                        </dx:GridViewDataComboBoxColumn>
                    </Columns>
                    <SettingsBehavior AllowFocusedRow="True" ConfirmDelete="True" />
                    <Settings ShowGroupPanel="True" ShowFilterRow="True" />
                    <SettingsSearchPanel Visible="True" />
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="UsuariosDatos" runat="server" ConnectionString="<%$ ConnectionStrings:SIFICA %>" DeleteCommand="USUARIOS_ELIMINAR" DeleteCommandType="StoredProcedure" InsertCommand="USUARIOS_INSERTAR" InsertCommandType="StoredProcedure" SelectCommand="USUARIOS_MOSTRAR_TODOS" SelectCommandType="StoredProcedure" UpdateCommand="USUARIOS_MODIFICAR" UpdateCommandType="StoredProcedure">
                    <DeleteParameters>
                        <asp:Parameter Name="ID_USUARIO" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="ID_EMPLEADO" Type="Int32" />
                        <asp:Parameter Name="USUARIO" Type="String" />
                        <asp:Parameter Name="PASSWORD" Type="String" />
                        <asp:Parameter Name="ID_ROL" Type="Int32" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:SessionParameter Name="ID_COMPAÑIA" SessionField="Compañia" Type="Int32" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="ID_USUARIO" Type="Int32" />
                        <asp:Parameter Name="ID_EMPLEADO" Type="Int32" />
                        <asp:Parameter Name="USUARIO" Type="String" />
                        <asp:Parameter Name="PASSWORD" Type="String" />
                        <asp:Parameter Name="ID_ROL" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </dx:PopupControlContentControl>
        </ContentCollection>

    </dx:ASPxPopupControl>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="panel panel-default">
                <!-- Default panel contents -->
                <div class="panel-heading">Alta de Usuarios</div>
                <div class="panel-body">
                    <p>
                        <form>
                            <div class="form-group">
                                <dx:ASPxComboBox ID="cboUsuarios" runat="server" Caption="Seleccione el Empleado" DataSourceID="Empleados" HorizontalAlign="Center" TextField="NOMBRE" ValueField="ID_EMPLEADO" OnSelectedIndexChanged="cboUsuarios_SelectedIndexChanged" CssClass="form-control" Theme="Metropolis" Width="300px" AutoPostBack="True" AutoResizeWithContainer="True">
                                    <CaptionSettings HorizontalAlign="Left" Position="Top" />
                                    <ValidationSettings ErrorTextPosition="Bottom" SetFocusOnError="True" ValidationGroup="Usuarios">
                                        <RequiredField IsRequired="True" />
                                    </ValidationSettings>
                                    <CaptionStyle Font-Names="Arial" Font-Size="Small">
                                    </CaptionStyle>
                                </dx:ASPxComboBox>
                            </div>

                            <div class="form-group">
                                <dx:ASPxComboBox ID="cboRoles" runat="server" Caption="Seleccione el Rol" DataSourceID="Roles" HorizontalAlign="Center" TextField="ROL" ValueField="ID_ROL" OnSelectedIndexChanged="cboUsuarios_SelectedIndexChanged" CssClass="form-control" Theme="Metropolis" Width="300px" AutoResizeWithContainer="True">
                                    <CaptionSettings HorizontalAlign="Left" Position="Top" />
                                    <ValidationSettings ErrorTextPosition="Bottom" SetFocusOnError="True" ValidationGroup="Usuarios">
                                        <RequiredField IsRequired="True" />
                                    </ValidationSettings>
                                    <CaptionStyle Font-Names="Arial" Font-Size="Small">
                                    </CaptionStyle>
                                </dx:ASPxComboBox>
                            </div>

                            <div class="form-group">
                                <label for="txtUsuario">Usuario</label>
                                <dx:ASPxTextBox ID="txtUsuario" runat="server" Width="100%" NullText="Usuario" CssClass="form-control">
                                    <ValidationSettings SetFocusOnError="True" ValidationGroup="Usuarios">
                                        <RequiredField IsRequired="True" />
                                    </ValidationSettings>
                                </dx:ASPxTextBox>
                            </div>
                            <%--    <div class="form-group">
                        <label for="exampleInputEmail1">Email address</label>
                        <input type="email" class="form-control" id="exampleInputEmail1" placeholder="Email">
                    </div>--%>
                            <div class="form-group">
                                <label for="txtPassword">Password</label>
                                <dx:ASPxTextBox ID="txtPassword" runat="server" Width="100%" NullText="Password" CssClass="form-control" Password="true" ClientInstanceName="txtPassword">
                                    <ValidationSettings ErrorTextPosition="Bottom" SetFocusOnError="True" ValidationGroup="Usuarios">
                                        <RequiredField IsRequired="True" />
                                    </ValidationSettings>
                                </dx:ASPxTextBox>
                            </div>
                            <div class="form-group">
                                <label for="txtPasswordConfirm">Confirmar Password</label>
                                <dx:ASPxTextBox ID="txtPasswordConfirm" runat="server" Width="100%" NullText="Password" CssClass="form-control" Password="true">
                                    <ClientSideEvents Validation="function(s, e) {
	var originalPasswd = txtPassword.GetText();
    var currentPasswd = s.GetText();
    e.isValid = (originalPasswd  == currentPasswd);
}" />
                                    <ValidationSettings ErrorTextPosition="Bottom" SetFocusOnError="True" ValidationGroup="Usuarios">
                                        <RequiredField IsRequired="True" />
                                    </ValidationSettings>
                                </dx:ASPxTextBox>
                            </div>
                            <dx:ASPxButton ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn btn-default" OnClick="btnGuardar_Click" ValidationGroup="Usuarios"></dx:ASPxButton>
                            <dx:ASPxButton ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-danger"></dx:ASPxButton>

                        </form>
                        <p>
                        </p>
                        <p>
                        </p>
                        <p>
                        </p>
                        <p>
                        </p>
                        <p>
                        </p>
                        <p>
                        </p>
                        <p>
                        </p>
                        <p>
                        </p>
                        <p>
                        </p>
                        <p>
                        </p>
                        <p>
                        </p>
                        <p>
                        </p>
                    </p>
                </div>

                <!-- Table -->
                <table class="table">
                    <caption>
                        ...
                    </caption>
                </table>
            </div>
            <asp:SqlDataSource ID="Empleados" runat="server"
                ConnectionString="<%$ ConnectionStrings:SIFICA %>"
                SelectCommand="EMPLEADOS_MOSTRAR_ID_COMPAÑIA"
                SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:SessionParameter Name="ID_COMPAÑIA" SessionField="Compañia" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="Roles" runat="server"
                ConnectionString="<%$ ConnectionStrings:SIFICA %>"
                SelectCommand="ROLES_MOSTRAR_TODOS" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            <div class="modal fade" id="PopupUsuario" tabindex="-1" role="dialog" aria-labelledby="PopupUsuarioLabel">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h4 class="modal-title" id="PopupUsuarioLabel">Operacion Realizada Exitosamente</h4>
                        </div>
                        <div class="modal-body">
                            <div class="alert alert-success" role="alert">Los datos del usuario se cargaron correctamente</div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">
                                Close
                            </button>


                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>

    </asp:UpdatePanel>
</asp:Content>
