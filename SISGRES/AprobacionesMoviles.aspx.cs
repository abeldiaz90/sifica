using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SISGRES
{
    public partial class AprobacionesMoviles : System.Web.UI.Page
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

                    if (Data.ESTADO == 1)
                    {
                        //SIFICADataContext Datos = new SIFICADataContext();
                        db.APROBACION_RECHAZO_REQUISICION(3, Int32.Parse(Request.QueryString["ID_EMPLEADO"]), Int32.Parse(Request.QueryString["ID_REQUEST"]));
                        db.SubmitChanges();
                        EnvioCorreoRequisitor(2, Int32.Parse(Request.QueryString["ID_REQUEST"].ToString()), 3);
                        EnviarCorreoAprobadores(2, Int32.Parse(Request.QueryString["ID_REQUEST"].ToString()));
                        this.lblRequest.Text = "!La Requisición ha sido Aprobada!";
                    }
                    else if (Data.ESTADO == 2)
                    {
                        this.lblRequest.Text = "Esta Requisicion ya fue Rechazada por " + Data.NOMBRE + " El dia " + Data.FECHA_APROBACION_RECHAZO_REQUEST;
                    }
                    else if (Data.ESTADO == 3)
                    {
                        this.lblRequest.Text = "Esta Requisicion ya fue Aprobada por " + Data.NOMBRE + " El dia " + Data.FECHA_APROBACION_RECHAZO_REQUEST;
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


            var q = db.OBTENER_APROBADORES_REQUISICION(2);

            String Destinatarios = "";
            foreach (var r in q)
            {
                Destinatarios = r.DESTINATARIOS;
            }
            String Cuerpo = "";
            if (Estado == 2)
            {
                EstadoTexto = "RECHAZADA";
                Cuerpo = "<html><h1>LA REQUISICIÓN CON NUMERO DE FOLIO: <b>" + Folio.ToString() + "</b> HA SIDO: <b>" + EstadoTexto + "</b> por: <b>" + NombreAprobador + "</b></h1></html>";
            }
            else if (Estado == 3)
            {
                EstadoTexto = "APROBADA";
                Cuerpo = "<html><h1>LA REQUISICIÓN CON NUMERO DE FOLIO: <b>" + Folio.ToString() + "</b> HA SIDO: <b>" + EstadoTexto + "</b> por: <b>" + NombreAprobador + "</b></h1> <p><h2>Se ha generado la orden de compra con numero de Folio: <b>" + OC + "</b> verifique que los precios sean correctos.<h2></html>";
            }


            MailMessage msg = new MailMessage();
            msg.From = new MailAddress("sifica@musebe.com.mx","SIFICA", System.Text.Encoding.UTF8);
            msg.Subject = "REQUISICIÓN " + EstadoTexto;
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
            //client.UseDefaultCredentials = true;
            client.Credentials = login;

            try
            {
                client.Send(msg);

                //ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(),
                //        "err_msg",
                //        "alert('!La Requisicion se proceso exitosamente y se ha generado la orden de compra misma que debera ser aporbada o rechazada!');",
                //        true);
                return;
            }
            catch (System.Net.Mail.SmtpException ex)
            {
                //Response.Write("Hubo un error no fue posible aprobarse la requisicion");
                //ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(),
                //       "err_msg",
                //       "alert('!Hubo un problema y no fue posible enviar el correo!');",
                //       true);
                return;
            }

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

            var q = db.APROBADORES_OC_ACTIVOS();
            foreach (var r in q)
            {
                ConstruirEmailAprobadores(IdRequisicion, Int32.Parse(r.ID_EMPLEADO.ToString()), NombreDeUsuario, r.CORREO_ELECTRONICO);
            }
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(),
             "err_msg",
             "alert('!La Orden de compra fue creada exitosamente y enviada por correo electrónico para aprobación!');",
             true);
            return;


        }
        public void ConstruirEmailAprobadores(Int32 IdRequisicion, Int32 Aprobador, string NombreUsuario, string Destinatarios)
        {
            DataTable Datos = CuerpoMensaje(IdRequisicion);
            String Cuerpo = "<html><h1>SE HA GENERADO UNA NUEVA ORDEN DE COMPRA PARA SU APROBACIÓN CON NUMERO DE FOLIO: " + IdRequisicion.ToString() + " EL SOLICITANTE DE LA COMPRA ES: <b>" + NombreUsuario + "</b></h1> <p>A continuación se muestran las partidas de esta solicitud.<p><b>Justificante:</b>" + Datos.Rows[0]["JUSTIFICACION_REQUISICION"].ToString() + "<p><b>Lugar de Entrega:</b>" + Datos.Rows[0]["LUGAR_ENTREGA"].ToString() + "<p><b>Fecha de Entrega:</b>" + Datos.Rows[0]["FECHA_ENTREGA"].ToString();
            Cuerpo = Cuerpo + "<p><table border='1' align='center'><TR><TD align='center'>DESCRIPCIÓN</TD><TD align='center'>UNIDAD DE MEDIDA</TD><TD align='center'>CANTIDAD</TD><TD align='center'>PRECIO UNITARIO</TD><TD align='center'>IMPORTE</TD></TR>";

            for (int i = 0; i <= Datos.Rows.Count - 1; i++)
            {
                Cuerpo = Cuerpo + "<TR><TD align='center'>" + Datos.Rows[i]["ITEM"].ToString() + "</TD><TD align='center'>" + Datos.Rows[i]["UNIDAD"].ToString() + "</TD><TD align='center'>" + Datos.Rows[i]["CANTIDAD"].ToString() + "</TD><TD align='center'>" + String.Format(new CultureInfo("es-MX"), "{0:C}", Datos.Rows[i]["PRECIO"].ToString()) + "</TD><TD align='center'>" + String.Format(new CultureInfo("es-MX"), "{0:C}", Datos.Rows[i]["IMPORTE_PARCIAL"].ToString()) + "</TD></TR>";
            }

            Cuerpo = Cuerpo + "</table><p><a href='" + System.Configuration.ConfigurationManager.AppSettings["Sitio"].ToString() + "AprobacionesOCMoviles.aspx?ID_REQUEST=" + IdRequisicion.ToString() + "&ID_EMPLEADO=" + Aprobador.ToString() + "'> APROBAR </a>    " + "&nbsp;<a href='" + System.Configuration.ConfigurationManager.AppSettings["Sitio"].ToString() + "RechazarOCMoviles.aspx?ID_REQUEST=" + IdRequisicion.ToString() + "&ID_EMPLEADO=" + Aprobador.ToString() + "'> RECHAZAR </a></html>";
            MailMessage msg = new MailMessage();
            msg.From = new MailAddress("sifica@musebe.com.mx","SIFICA", System.Text.Encoding.UTF8);
            //msg.From = new MailAddress("Notificaciones@akaaljinspection.com.mx", "SIFICA", System.Text.Encoding.UTF8);
            msg.Subject = "APROBACIÓN DE ORDEN DE COMPRA";
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
        public DataTable CuerpoMensaje(Int32 ID)
        {
            DataTable Cuerpo = new DataTable();
            try
            {
                SqlConnection con = new SqlConnection();
                con.ConnectionString = ConfigurationManager.ConnectionStrings["SIFICA"].ToString();
                con.Open();
                SqlCommand com = new SqlCommand();
                com.Connection = con;
                com.CommandType = CommandType.StoredProcedure;
                com.CommandText = "OC_OR_ID_2";
                com.Parameters.AddWithValue("@ID", ID);
                com.CommandTimeout = 0;
                com.ExecuteNonQuery();
                SqlDataAdapter Datos = new SqlDataAdapter(com);
                Datos.Fill(Cuerpo);
                con.Close();
            }
            catch (Exception ex) { ex.ToString(); }
            return Cuerpo;
        }

    }
}