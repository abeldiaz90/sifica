using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SISGRES
{
    public partial class SolicitudSalida : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void lnkAgregar_Click(object sender, EventArgs e)
        {
            try
            {
                if ((this.txtCantidad.Text != string.Empty && Decimal.Parse(this.txtCantidad.Text) > 0) && this.txtItem.Text != string.Empty)
                {
                    SIFICADataContext db = new SIFICADataContext();
                    int Total = 0;
                    var conteo = db.INVENTARIO_ACTUAL_ITEM_CONTEO(this.txtItem.Text);
                    foreach (var Cuantos in conteo)
                    {
                        Total = int.Parse(Cuantos.CANTIDAD.ToString());
                        this.lblConteo.Text = Total.ToString() + " Disponibles ";
                        //this.txtCantidad.MaskSettings.Mask
                    }
                    if (Total >= 1 && Decimal.Parse(this.txtCantidad.Text) <= Total)
                    {
                        db.SALIDAS_INSERTAR_USUARIO(this.txtItem.Text, Decimal.Parse(this.txtCantidad.Text), this.Page.User.Identity.Name.ToString(), this.chkDevolver.Checked);
                        Limpiar();
                        this.grdSalidas.DataBind();
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "NoPuedesAgregar", "NoPuedesAgregar();", true);
                    }
                }
            }
            catch (Exception ex) { ex.ToString(); }

        }
        public void Limpiar()
        {
            try
            {
               
                this.txtItem.Text = string.Empty;
                this.txtCantidad.Text = string.Empty;
                this.txtItem.Text = string.Empty;                
                this.grdSalidas.DataBind();
                this.chkDevolver.Checked = false;      

            }
            catch (Exception ex) { ex.ToString(); }
        }

        protected void btnEnviarRequisicion_Click(object sender, EventArgs e)
        {
            SIFICADataContext db = new SIFICADataContext();
            db.SALIDAS_PRE_APROBAR(Int32.Parse(this.cboCtroCosto.SelectedItem.Value.ToString()), this.Page.User.Identity.Name.ToString());
            db.SubmitChanges();
     
            var query = db.SALIDAS_SOLICITUD_OBTENER_ID(this.User.Identity.Name.ToString());
            Int32 Id = 0;

            foreach (var r in query)
            {
                Id = Int32.Parse(r.ID_SALIDA.ToString());
            }


            EnviarCorreoAprobadores(2, Id);
            this.cboCtroCosto.SelectedIndex = -1;
            this.cboCtroCosto.Text = string.Empty;   
            Limpiar();

        }

        public void EnviarCorreoAprobadores(Int32 NivelAprobacion, Int32 IdRequisicion)
        {
            SIFICADataContext db = new SIFICADataContext();
            String NombreDeUsuario = "";
            var NombreUsuario = db.EMPLEADO_OBTENER_NOMBRE_USUARIO(this.User.Identity.Name.ToString());
            foreach (var Nombre in NombreUsuario)
            {
                NombreDeUsuario = Nombre.NOMBRE;
            }

            var q = db.APROBADORES_SALIDAS_CORREOS();
            foreach (var r in q)
            {
                ConstruirEmailAprobadores(IdRequisicion, Int32.Parse(r.ID_EMPLEADO.ToString()), NombreDeUsuario, r.CORREO_ELECTRONICO);
            }
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(),
             "err_msg",
             "alert('!La Solicitud fue generada exitosamente y enviada por correo electrónico para aprobación!');",
             true);
            return;
        }

        public void ConstruirEmailAprobadores(Int32 IdRequisicion, Int32 Aprobador, string NombreUsuario, string Destinatarios)
        {
            String Cuerpo = "<html><h1>SE HA GENERADO UNA NUEVA SOLICITUD DE SALIDA DE MATERIALES DE ALMACEN CON NUMERO DE FOLIO: " + IdRequisicion.ToString() + " LA CUAL FUE GENERADA POR: <b>" + NombreUsuario + "</b></h1> <p>A continuación se muestran las partidas de esta solicitud.<p><b>Justificante:</b>" + this.txtJustificacion.Text + "<p>";
            Cuerpo = Cuerpo + "<p><table border='1' align='center'><TR><TD align='center'>ITEM</TD><TD align='center'>CANTIDAD</TD><TD align='center'>SE DEVOLVERA</TD></TR>";

            for (int i = 0; i <= this.grdSalidas.VisibleRowCount - 1; i++)
            {
                Cuerpo = Cuerpo + "<TR><TD align='center'>" + this.grdSalidas.GetRowValues(i, "ITEM").ToString() + "</TD><TD align='center'>" + this.grdSalidas.GetRowValues(i, "CANTIDAD").ToString() + "</TD><TD align='center'>" + this.grdSalidas.GetRowValues(i, "DEVOLVER").ToString() + "</TD></TR>";
            }

            Cuerpo = Cuerpo + "</table><p><a href='" + System.Configuration.ConfigurationManager.AppSettings["Sitio"].ToString() + "AprobacionesSalidasMoviles.aspx?ID_REQUEST=" + IdRequisicion.ToString() + "&ID_EMPLEADO=" + Aprobador.ToString() + "'> APROBAR </a>    " + "&nbsp;<a href='" + System.Configuration.ConfigurationManager.AppSettings["Sitio"].ToString() + "RechazarSalidasMoviles.aspx?ID_REQUEST=" + IdRequisicion.ToString() + "&ID_EMPLEADO=" + Aprobador.ToString() + "'> RECHAZAR </a></html>";
            MailMessage msg = new MailMessage();
            msg.From = new MailAddress("sifica@musebe.com.mx","SIFICA", System.Text.Encoding.UTF8);
            //msg.From = new MailAddress("Notificaciones@akaaljinspection.com.mx", "SIFICA", System.Text.Encoding.UTF8);
            msg.Subject = "APROBACIÓN DE SALIDA DE MATERIALES";
            msg.To.Add(FormatMultipleEmailAddresses(Destinatarios));
            //msg.CC.Add(CorreoElectronico);
            msg.SubjectEncoding = System.Text.Encoding.UTF8;
            msg.Body = Cuerpo;
            msg.BodyEncoding = System.Text.Encoding.UTF8;
            msg.IsBodyHtml = true;


            SmtpClient client = new SmtpClient();
            client.Host = "mail.musebe.com.mx";
            client.Port = 587;
            NetworkCredential login = new NetworkCredential("sifica@musebe.com.mx", "Imperio90_");
            client.EnableSsl = false;
            //client.UseDefaultCredentials = true;
            client.Credentials = login;

            try
            {
                client.Send(msg);
            }
            catch (System.Net.Mail.SmtpException ex)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(),
                       "err_msg",
                       "alert('" + ex.Message.ToString() + "');",
                       true);
                return;
            }
        }

        private string FormatMultipleEmailAddresses(string emailAddresses)
        {
            var delimiters = new[] { ',', ';' };

            var addresses = emailAddresses.Split(delimiters, StringSplitOptions.RemoveEmptyEntries);

            return string.Join(",", addresses);
        }

        protected void ASPxButton3_Click(object sender, EventArgs e)
        {

        }
    }
}