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
    public partial class AprobacionesOCMoviles : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string v = Request.QueryString["ID_REQUEST"];
            if (v != null)
            {
                SIFICADataContext db = new SIFICADataContext();
                var query = db.REQUEST_CONSULTA_ESTADO(Int32.Parse(v));
                string Estado = "";
                foreach (var Data in query)
                {

                    if (Data.ESTADO == 3)
                    {
                        //SIFICADataContext Datos = new SIFICADataContext();
                        db.APROBACION_RECHAZO_OC(5, Int32.Parse(Request.QueryString["ID_EMPLEADO"]), Int32.Parse(Request.QueryString["ID_REQUEST"]));
                        db.SubmitChanges();
                        EnvioCorreoRequisitor(2, Int32.Parse(Request.QueryString["ID_REQUEST"].ToString()), 5);
                        this.lblRequest.Text = "!La Orden de Compra ha sido Aprobada!";
                    }
                    else if (Data.ESTADO == 4)
                    {
                        this.lblRequest.Text = "Esta Orden de Compra ya fue Rechazada por " + Data.NOMBRE + " El dia " + Data.FECHA_APROBACION_RECHAZO_REQUEST;
                    }
                    else if (Data.ESTADO == 5)
                    {
                        this.lblRequest.Text = "Esta Orden de Compra ya fue Aprobada por " + Data.NOMBRE + " El dia " + Data.FECHA_APROBACION_RECHAZO_REQUEST;
                    }
                }
            }
        }
        public void EnvioCorreoRequisitor(Int32 NivelAprobacion, Int32 IdRequisicion, Int32 Estado)
        {
            SIFICADataContext db = new SIFICADataContext();

            String NombreDeUsuario = "";
            String NombreAprobador = "";
            String CorreoElectronico = "";
            String Folio = "";
            String EstadoTexto = "";
            String OC = "";
            var DatosRequisicion = db.REQUICIONES_OR_ID(Int32.Parse(Request.QueryString["ID_REQUEST"].ToString()));
            foreach (var Datos in DatosRequisicion)
            {
                NombreDeUsuario = Datos.REQUISITOR;
                NombreAprobador = Datos.APROBADOR_RECHAZADOR_REQUISICION;
                CorreoElectronico = Datos.CORREO_REQUISITOR;
                Folio = Datos.FOLIO;
                OC = Datos.FOLIO_OC;
            }


            var q = db.OBTENER_APROBADORES_OC(2);

            String Destinatarios = "";
            foreach (var r in q)
            {
                Destinatarios = r.DESTINATARIOS;
            }
            String Cuerpo = "";
            if (Estado == 4)
            {
                EstadoTexto = "RECHAZADA";
                Cuerpo = "<html><h1>LA ORDÉN DE COMPRA CON NUMERO DE FOLIO: <b>" + OC.ToString() + "</b> HA SIDO: <b>" + EstadoTexto + "</b> por: <b>" + NombreAprobador + "</b></h1></html>";
            }
            else if (Estado == 5)
            {
                EstadoTexto = "APROBADA";
                Cuerpo = "<html><h1>LA ORDÉN DE COMPRA  CON NUMERO DE FOLIO: <b>" + OC.ToString() + "</b> HA SIDO: <b>" + EstadoTexto + "</b> por: <b>" + NombreAprobador + "</b></h1></html>";
            }


            MailMessage msg = new MailMessage();
            msg.From = new MailAddress("sifica@musebe.com.mx","SIFICA", System.Text.Encoding.UTF8);
            msg.Subject = "ORDEN DE COMPRA " + EstadoTexto;
            msg.To.Add(FormatMultipleEmailAddresses(CorreoElectronico));
            msg.CC.Add(FormatMultipleEmailAddresses(Destinatarios));
            msg.SubjectEncoding = System.Text.Encoding.UTF8;
            msg.Body = Cuerpo;
            msg.BodyEncoding = System.Text.Encoding.UTF8;
            msg.IsBodyHtml = true;

            SmtpClient client = new SmtpClient();
            client.Host = "mail.musebe.com.mx";
            client.Port = 587;
            NetworkCredential login = new NetworkCredential("sifica@musebe.com.mx", "Imperio90_");
            client.EnableSsl = false;

            client.Credentials = login;

            try
            {
                client.Send(msg);


                return;
            }
            catch (System.Net.Mail.SmtpException ex)
            {

                return;
            }

        }

        private string FormatMultipleEmailAddresses(string emailAddresses)
        {
            var delimiters = new[] { ',', ';' };

            var addresses = emailAddresses.Split(delimiters, StringSplitOptions.RemoveEmptyEntries);

            return string.Join(",", addresses);
        }

    }
}