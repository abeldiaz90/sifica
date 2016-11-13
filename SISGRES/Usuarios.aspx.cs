using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using DevExpress.Web.ASPxTreeList;
using System.Data.SqlClient;

namespace SISGRES
{
    public partial class Usuarios : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void cboUsuarios_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            { 
                SIFICADataContext db = new SIFICADataContext();
                

                var contar = db.USUARIOS_CONSULTAR_ID(Int32.Parse(this.cboUsuarios.SelectedItem.Value.ToString())).Count();
                if (contar >= 1) 
                {
                    Limpiar();
                    var query = db.USUARIOS_CONSULTAR_ID(Int32.Parse(this.cboUsuarios.SelectedItem.Value.ToString()));
                    foreach (var datos in query)
                    { 

                        this.txtUsuario.Text = datos.USUARIO;
                        this.txtPassword.Text = datos.PASSWORD;
                        this.txtPasswordConfirm.Text = datos.PASSWORD;
                        this.cboRoles.Items.FindByValue(datos.ID_ROL.ToString()).Selected = true;
                    }
                }
               
            }
            catch (Exception ex) { ex.ToString(); }
        }

        public void Limpiar() 
        {
            this.cboRoles.SelectedIndex = -1;
            this.txtUsuario.Text = string.Empty;
            this.txtPassword.Text = string.Empty;
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                SIFICADataContext DB = new SIFICADataContext();
                DB.USUARIOS_INSERTAR(Int32.Parse(this.cboUsuarios.SelectedItem.Value.ToString()), this.txtUsuario.Text, this.txtPassword.Text, Int32.Parse(this.cboRoles.SelectedItem.Value.ToString()));
                ScriptManager.RegisterStartupScript(this, this.GetType(), "PopupUsuario", "PopupUsuario();", true);
                Limpiar();
                this.ASPxGridView1.DataBind();
            }
            catch (Exception ex)
            {

            }
        }

        protected void btnUsuarios_Click(object sender, EventArgs e)
        {
            this.popupUsuarios.ShowOnPageLoad = true;
            this.ASPxGridView1.DataBind();
        }

        protected void ASPxGridView1_AfterPerformCallback(object sender, DevExpress.Web.ASPxGridViewAfterPerformCallbackEventArgs e)
        {
            this.ASPxGridView1.DataBind();
        }





    }
}