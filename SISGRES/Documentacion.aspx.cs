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
    public partial class Documentacion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void lnkRequisicion_Click(object sender, EventArgs e)
        {
            GenerarDocumentoRequisicion(Int32.Parse(this.grdRequisiciones.GetRowValues(this.grdRequisiciones.FocusedRowIndex, "ID_REQUEST").ToString()));
        }

        public void GenerarDocumentoRequisicion(Int32 IdRequisicion)
        {
            try
            {
                this.popupRequisicion.ShowOnPageLoad = true;

                this.ReportViewer1.ProcessingMode = ProcessingMode.Local;
                LocalReport report = new LocalReport();
                report.EnableExternalImages = true;
                report.ReportPath = "Requisicion.rdlc";

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
                this.ReportViewer1.LocalReport.ReportPath = Server.MapPath("Requisicion.rdlc");
                this.ReportViewer1.LocalReport.DataSources.Clear();
                this.ReportViewer1.LocalReport.DataSources.Add(dsMain);
                this.ReportViewer1.LocalReport.DataSources.Add(logo);

                this.ReportViewer1.DocumentMapCollapsed = true;
                this.ReportViewer1.ShowPrintButton = true;
                this.ReportViewer1.LocalReport.Refresh();
            }
            catch (Exception ex) { ex.ToString(); }
        }

        public void GenerarDocumentoOC(Int32 IdRequisicion) 
        {
            try
            {
                this.popupRequisicion.ShowOnPageLoad = true;
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
                com.CommandText = "REQUISICION_OBTENER_LOGO_EMPRESA";
                com.Parameters.AddWithValue("@ID_REQUISICION", Int32.Parse(this.grdRequisiciones.GetRowValues(this.grdRequisiciones.FocusedRowIndex, "ID_REQUEST").ToString()));
                com.CommandTimeout = 0;
                com.ExecuteNonQuery();
                SqlDataAdapter Datos = new SqlDataAdapter(com);
                Datos.Fill(Requsicion);
                con.Close();
            }
            catch (Exception ex) { ex.ToString(); }
            return Requsicion;
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            this.popupCancelaciones.ShowOnPageLoad = true;
        }

        protected void btnOk_Click(object sender, EventArgs e)
        {
            try
            {
                SIFICADataContext db = new SIFICADataContext();
                db.CANCELACIONES(Int32.Parse(this.grdRequisiciones.GetRowValues(this.grdRequisiciones.FocusedRowIndex, "ID_REQUEST").ToString()));
                db.SubmitChanges();
                EnviarCorreoRequisitor(Int32.Parse(this.grdRequisiciones.GetRowValues(this.grdRequisiciones.FocusedRowIndex, "ID_REQUEST").ToString()));
                this.grdRequisiciones.DataBind();
            }
            catch (Exception ex) { ex.ToString(); }
        }

        public void EnviarCorreoRequisitor(Int32 IdRequisicion)
        {
            SIFICADataContext db = new SIFICADataContext();
            String NombreDeUsuario = "";
            String CorreoElectronico = "";
            var NombreUsuario = db.EMPLEADO_OBTENER_NOMBRE_USUARIO(this.User.Identity.Name.ToString());
            foreach (var Nombre in NombreUsuario)
            {
                NombreDeUsuario = Nombre.NOMBRE.ToString();
                CorreoElectronico = Nombre.CORREO_ELECTRONICO.ToString();
            }
            ConstruirEmailRequisitor(IdRequisicion, NombreDeUsuario, CorreoElectronico);
        }

        public void ConstruirEmailRequisitor(Int32 IdRequisicion, string NombreUsuario, string Destinatarios)
        {
            String Cuerpo = "<html><h1>!Estimado: <b>" + NombreUsuario + "</b> Su Requisición y/o orden de compra con numero de folio <b>: " + IdRequisicion.ToString() + "</b> ha sido Cancelada! </h1></html>";
            MailMessage msg = new MailMessage();
            msg.From = new MailAddress("sifica@musebe.com.mx","SIFICA", System.Text.Encoding.UTF8);
            //msg.From = new MailAddress("Notificaciones@akaaljinspection.com.mx", "SIFICA", System.Text.Encoding.UTF8);
            msg.Subject = "CANCELACIÓN DE REQUISICIÓN U ORDEN DE COMPRA";
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
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            this.popupCancelaciones.ShowOnPageLoad = false;
        }

        protected void lnkOrdenCompra_Click(object sender, EventArgs e)
        {
            GenerarDocumentoOC(Int32.Parse(this.grdRequisiciones.GetRowValues(this.grdRequisiciones.FocusedRowIndex, "ID_REQUEST").ToString()));
        }



    }
}