using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SISGRES
{
    public partial class AprobacionOC : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public void AprobarRechazar(Int32 Opcion, Int32 Id_Request)
        {
            try
            {
                SIFICADataContext db = new SIFICADataContext();
                var Validacion = db.APROBADORES_OC_OBTENER_ID(this.Page.User.Identity.Name.ToString()).Count();
                if (Validacion >= 1)
                {
                    Int32 Id_Empleado = 0;
                    var Id = db.APROBADORES_OC_OBTENER_ID(this.Page.User.Identity.Name.ToString());
                    foreach (var i in Id)
                    {
                        Id_Empleado = Int32.Parse(i.ID_EMPLEADO.ToString());
                    }
                    db.APROBACION_RECHAZO_OC(Opcion, Id_Empleado, Id_Request);
                    db.SubmitChanges();
                    EnvioCorreoRequisitor(2, Id_Request, Opcion);
                    this.grdAprobaciones.DataBind();
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Alerta", "Alerta()", true);
                }

            }
            catch (Exception ex) { ex.ToString(); }
        }

        protected void btnAprobar_Click(object sender, EventArgs e)
        {
            Int32 Id_Requisicion = Int32.Parse(this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_REQUEST").ToString());
            AprobarRechazar(5, Id_Requisicion);
        }

        public void EnvioCorreoRequisitor(Int32 NivelAprobacion, Int32 IdRequisicion, Int32 Estado)
        {
            SIFICADataContext db = new SIFICADataContext();

            String NombreDeUsuario = "";
            String NombreAprobador = "";
            String CorreoElectronicoRequisitor = "";
            String CorreoElectronicoAprobadorRequisicion = "";
            String Folio = "";
            String EstadoTexto = "";
            String OC = "";
            var DatosRequisicion = db.REQUICIONES_OR_ID(Int32.Parse(this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_REQUEST").ToString()));
            foreach (var Datos in DatosRequisicion)
            {
                NombreDeUsuario = Datos.REQUISITOR;
                NombreAprobador = Datos.APROBADOR_RECHAZADOR_REQUISICION;
                CorreoElectronicoRequisitor = Datos.CORREO_REQUISITOR;
                CorreoElectronicoAprobadorRequisicion = Datos.CORREO_APROBADOR_REQUISICION;
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
                Cuerpo = "<html><h1>LA ORDEN DE COMPRA CON NUMERO DE FOLIO: " + OC + " HA SIDO: <b>" + EstadoTexto + "</b> por: " + NombreAprobador + "</h1></html>";
            }
            else if (Estado == 5)
            {
                EstadoTexto = "APROBADA";
                Cuerpo = "<html><h1>LA ORDEN DE COMPRA CON NUMERO DE FOLIO: " + OC + " HA SIDO: <b>" + EstadoTexto + "</b> por: " + NombreAprobador + "</h1></html>";
            }



            MailMessage msg = new MailMessage();
            msg.From = new MailAddress("sifica@musebe.com.mx","SIFICA", System.Text.Encoding.UTF8);
            msg.Subject = "ORDEN DE COMPRA " + EstadoTexto;
            msg.To.Add(FormatMultipleEmailAddresses(CorreoElectronicoRequisitor));
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
            client.UseDefaultCredentials = true;
            client.Credentials = login;

            try
            {
                client.Send(msg);
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(),
                        "err_msg",
                        "alert('!La Ordén de Compra se proceso exitosamente, tan pronto recepcione estos elementos se agregaran al inventario!');",
                        true);
                return;
            }
            catch (System.Net.Mail.SmtpException ex)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(),
                       "err_msg",
                       "alert('!Hubo un problema y no fue posible enviar el correo!');",
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

        protected void btnRechazar_Click(object sender, EventArgs e)
        {
            Int32 Id_Requisicion = Int32.Parse(this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_REQUEST").ToString());
            AprobarRechazar(4, Id_Requisicion);
        }

        protected void btnAbrir_Click(object sender, EventArgs e)
        {
            try
            {
                GenerarDocumentoOrdenCompra(Int32.Parse(this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_REQUEST").ToString()));
            }
            catch (Exception ex) { ex.ToString(); }
        }

        public void GenerarDocumentoOrdenCompra(Int32 IdRequisicion)
        {
            try
            {
                this.popupOrdenCompra.ShowOnPageLoad = true;
                this.ReportViewer1.ProcessingMode = ProcessingMode.Local;
                LocalReport report = new LocalReport();
                report.EnableExternalImages = true;
                report.ReportPath = "OrdenCompra.rdlc";

                DataTable ds = DatosRequisicion(IdRequisicion);
                DataTable dslogo = ObtenerLogoEmpresa();

                ReportDataSource dsMain = new ReportDataSource();
                dsMain.Name = "DatosRequisicionesCompras";
                dsMain.Value = ds;

                ReportDataSource logo = new ReportDataSource();
                logo.Name = "ObtenerLogoEmpresa";
                logo.Value = dslogo;


                report.DataSources.Clear();
                report.DataSources.Add(dsMain);
                report.DataSources.Add(logo);
                report.Refresh();

                this.ReportViewer1.Visible = true;
                this.ReportViewer1.LocalReport.ReportPath = Server.MapPath("OrdenCompra.rdlc");
                this.ReportViewer1.LocalReport.DataSources.Clear();
                this.ReportViewer1.LocalReport.DataSources.Add(dsMain);
                this.ReportViewer1.LocalReport.DataSources.Add(logo);

                this.ReportViewer1.DocumentMapCollapsed = true;
                this.ReportViewer1.ShowPrintButton = true;
                this.ReportViewer1.LocalReport.Refresh();
            }
            catch (Exception ex) { ex.ToString(); }
        }

        public DataTable DatosRequisicion(Int32 IdRequisicion)
        {
            DataTable Requsicion = new DataTable();
            try
            {
                SqlConnection con = new SqlConnection();
                con.ConnectionString = ConfigurationManager.ConnectionStrings["SIFICA"].ToString();
                con.Open();
                SqlCommand com = new SqlCommand();
                com.Connection = con;
                com.CommandType = CommandType.StoredProcedure;
                com.CommandText = "REQUICIONES_OR_ID";
                com.Parameters.AddWithValue("@ID_REQUEST", IdRequisicion);
                com.CommandTimeout = 0;
                com.ExecuteNonQuery();
                SqlDataAdapter Datos = new SqlDataAdapter(com);
                Datos.Fill(Requsicion);
                con.Close();
            }
            catch (Exception ex) { ex.ToString(); }
            return Requsicion;
        }
        public DataTable ObtenerLogoEmpresa()
        {
            DataTable Requsicion = new DataTable();
            try
            {
                SqlConnection con = new SqlConnection();
                con.ConnectionString = ConfigurationManager.ConnectionStrings["SIFICA"].ToString();
                con.Open();
                SqlCommand com = new SqlCommand();
                com.Connection = con;
                com.CommandType = CommandType.StoredProcedure;
                com.CommandText = "OBTENER_LOGO_COMPAÑIA_POR_USUARIO";
                com.Parameters.AddWithValue("@usuario", this.Page.User.Identity.Name.ToString()); com.CommandTimeout = 0;
                com.ExecuteNonQuery();
                SqlDataAdapter Datos = new SqlDataAdapter(com);
                Datos.Fill(Requsicion);
                con.Close();
            }
            catch (Exception ex) { ex.ToString(); }
            return Requsicion;
        }

    }
}