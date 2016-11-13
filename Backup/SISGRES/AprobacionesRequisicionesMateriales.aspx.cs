using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Net.Mail;
using System.Net;

namespace SISGRES
{
    public partial class AprobacionesRequisicionesMateriales : System.Web.UI.Page
    {
        SIFICADataContext db = new SIFICADataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            grdAprobaciones.DataBind();
            if (this.grdAprobaciones.VisibleRowCount > 0)
            {
                this.ASPxButton2.Visible = true;
                this.ASPxButton3.Visible = true;
            }
            else
            {
                this.ASPxButton2.Visible = false;
                this.ASPxButton3.Visible = false;
            }
        }

        protected void lnkDetalle_Click(object sender, EventArgs e)
        {
            try
            {
                this.popupReporte.ShowOnPageLoad = true;

                this.ReportViewer1.ProcessingMode = ProcessingMode.Local;
                LocalReport report = new LocalReport();
                report.EnableExternalImages = true;
                report.ReportPath = "RequisicionMateriales.rdlc";

                DataTable ds = DatosRequisicionMateriales();
                DataTable dslogo = ObtenerLogoEmpresa();


                ReportDataSource dsMain = new ReportDataSource();
                dsMain.Name = "RequisicionesMaterialesDetalle";
                dsMain.Value = ds;

                ReportDataSource logo = new ReportDataSource();
                logo.Name = "ObtenerLogoEmpresa";
                logo.Value = dslogo;


                report.DataSources.Clear();
                report.DataSources.Add(dsMain);
                report.DataSources.Add(logo);


                report.Refresh();
                this.ReportViewer1.Visible = true;
                this.ReportViewer1.LocalReport.ReportPath = Server.MapPath("RequisicionMateriales.rdlc");
                this.ReportViewer1.LocalReport.DataSources.Clear();
                this.ReportViewer1.LocalReport.DataSources.Add(dsMain);
                this.ReportViewer1.LocalReport.DataSources.Add(logo);


                this.ReportViewer1.DocumentMapCollapsed = true;
                this.ReportViewer1.ShowPrintButton = true;
                this.ReportViewer1.LocalReport.Refresh();

            }
            catch (Exception ex) { ex.ToString(); }
        }

        public DataTable DatosRequisicionMateriales()
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
                com.CommandText = "REQUISICIONES_MATERIALES_MOSTRAR_A_DETALLE";
                com.Parameters.AddWithValue("@ID_REQUISICION", this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_REQUISICION").ToString());
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
                com.Parameters.AddWithValue("@ID_REQUISICION", Int32.Parse(this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_REQUISICION").ToString()));
                com.CommandTimeout = 0;
                com.ExecuteNonQuery();
                SqlDataAdapter Datos = new SqlDataAdapter(com);
                Datos.Fill(Requsicion);
                con.Close();
            }
            catch (Exception ex) { ex.ToString(); }
            return Requsicion;
        }

        protected void ASPxButton2_Click(object sender, EventArgs e)
        {
            try
            {
                for (int i = 0; i <= this.grdAprobaciones.VisibleRowCount - 1; i++)
                {
                    if (grdAprobaciones.Selection.IsRowSelected(i))
                    {
                        db.REQUSICION_APROBACION_MATERIALES(Int32.Parse(this.grdAprobaciones.GetRowValues(i, "ID_REQUISICION").ToString()), this.User.Identity.Name.ToString(), this.txtComentarios.Text);
                        db.SubmitChanges();
                        this.popupComentarios.ShowOnPageLoad = false;
                        EnviarCorreoAprobacion(this.grdAprobaciones.GetRowValues(i, "ID_REQUISICION").ToString());
                    }
                }
                Response.Redirect("AprobacionesRequisicionesMateriales.aspx");
            }
            catch (Exception ex) { ex.ToString(); }
        }

        protected void ASPxButton3_Click(object sender, EventArgs e)
        {
            try
            {
                for (int i = 0; i <= this.grdAprobaciones.VisibleRowCount - 1; i++)
                {
                    if (grdAprobaciones.Selection.IsRowSelected(i))
                    {
                        SIFICADataContext db = new SIFICADataContext();
                        db.REQUSICION_RECHAZO_MATERIALES(Int32.Parse(this.grdAprobaciones.GetRowValues(i, "ID_REQUISICION").ToString()), this.User.Identity.Name.ToString(), this.txtComentarios.Text);
                        db.SubmitChanges();
                        this.popupComentarios.ShowOnPageLoad = false;
                        EnviarCorreoRechazo(this.grdAprobaciones.GetRowValues(i, "ID_REQUISICION").ToString());
                    }
                }
                Response.Redirect("AprobacionesRequisicionesMateriales.aspx");
            }
            catch (Exception ex) { ex.ToString(); }
        }

        public void EnviarCorreoAprobacion(String ID_REQUISICION)
        {

            var q = db.OBTENER_DESTINATARIOS(3);

            String Destinatarios = "";
            foreach (var r in q)
            {
                Destinatarios = r.DESTINATARIOS;
            }


            String NombreDeUsuarioQueEstaAprobando = "";
            String CorreoElectronicoUsuarioQueEstaAprobando = "";
            var NombreUsuario = db.EMPLEADO_OBTENER_NOMBRE_USUARIO(this.User.Identity.Name.ToString());
            foreach (var Nombre in NombreUsuario)
            {
                NombreDeUsuarioQueEstaAprobando = Nombre.NOMBRE;
                CorreoElectronicoUsuarioQueEstaAprobando = Nombre.CORREO_ELECTRONICO;
            }


            String UsuarioCreador = "";
            String CorreoElectronicoUsuarioCreador = "";
            var DatosCreador = db.REQUISICIONES_MATERIALES_OBTENER_NOMBRE_CREADOR(Int32.Parse(this.grdAprobaciones.GetRowValues(grdAprobaciones.FocusedRowIndex, "ID_REQUISICION").ToString()));
            foreach (var NombreCrea in DatosCreador)
            {
                UsuarioCreador = NombreCrea.NOMBRE;
                CorreoElectronicoUsuarioCreador = NombreCrea.CORREO_ELECTRONICO;
            }

            String UsuariosConCopia = CorreoElectronicoUsuarioQueEstaAprobando + ";" + CorreoElectronicoUsuarioCreador;


            MailMessage msg = new MailMessage();
            msg.From = new MailAddress("sifica@mineralesdelmayab.com", "SIFICA - Minerales del Mayab", System.Text.Encoding.UTF8);
            msg.Subject = "REQUISICION DE MATERIALES APROBADA";
            msg.To.Add(FormatMultipleEmailAddresses(Destinatarios));
            msg.CC.Add(FormatMultipleEmailAddresses(UsuariosConCopia));
            msg.SubjectEncoding = System.Text.Encoding.UTF8;
            String Cuerpo = "LA REQUISICION DE MATERIALES CON NUMERO DE FOLIO: " + ID_REQUISICION + " HA SIDO APROBADA POR: " + NombreDeUsuarioQueEstaAprobando + " DEBERA CAPTURAR LOS PRECIOS UNITARIOS Y ADJUNTAR LAS COTIZACIONES PARA GENERAR LA ORDEN DE COMPRA. <a href='http://sifica-001-site1.smarterasp.net/OrdenesComprasMateriales.aspx'> !HAGA CLICK AQUI PARA INGRESAR AL MODULO DE COMPRAS PARA GENERAR LA ORDEN DE COMPRA! </a><p>COMENTARIOS: " + this.txtComentarios.Text;
            

            DataTable Partidas = ObtenerPartidasRequisicion();

            Cuerpo = Cuerpo + "<html><p><table border='1' align='center'><TR><TD align='center'>PARTIDA</TD><TD align='center'>MATERIAL</TD><TD align='center'>NUMERO DE PARTE</TD><TD align='center'>UNIDAD DE MEDIDA</TD><TD align='center'>CANTIDAD</TD></TR>";

            for (int i = 0; i <= Partidas.Rows.Count - 1; i++)
            {
                Cuerpo = Cuerpo + "<TR><TD align='center'>" + Partidas.Rows[i]["PARTIDA"].ToString() + "</TD><TD align='center'>" + Partidas.Rows[i]["MATERIAL"].ToString() + "</TD><TD align='center'>" + Partidas.Rows[i]["NUMBER_PART"].ToString() + "</TD><TD align='center'>" + Partidas.Rows[i]["UNIDAD"].ToString() + "</TD><TD align='center'>" + Partidas.Rows[i]["CANTIDAD"].ToString() + "</TD></TR>";
            }

            Cuerpo = Cuerpo + "</table></html>";
            msg.Body = Cuerpo;
            msg.BodyEncoding = System.Text.Encoding.UTF8;
            msg.IsBodyHtml = true;

            SmtpClient client = new SmtpClient();
            client.Host = "mail.mineralesdelmayab.com";
            client.Port = 26;
            NetworkCredential login = new NetworkCredential("sifica@mineralesdelmayab.com", "Imperio90");
            client.EnableSsl = false;
            client.UseDefaultCredentials = true;
            client.Credentials = login;

            try
            {
                client.Send(msg);
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(),
                        "err_msg",
                        "alert('!Los usuarios han sido notificados via correo electrónico!');",
                        true);
                return;
            }
            catch (System.Net.Mail.SmtpException ex)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(),
                       "err_msg",
                       "alert('!Hubo un problema y no fue posible notificar a los usuarios!');",
                       true);
                return;
            }

        }


        public DataTable ObtenerPartidasRequisicion() 
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
                com.CommandText = "OBTENER_PARTIDAS_REQUISICION_MATERIALES";
                com.Parameters.AddWithValue("@ID_REQUISICION", Int32.Parse(this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_REQUISICION").ToString()));
                com.CommandTimeout = 0;
                com.ExecuteNonQuery();
                SqlDataAdapter Datos = new SqlDataAdapter(com);
                Datos.Fill(Requsicion);
                con.Close();
            }
            catch (Exception ex) { ex.ToString(); }
            return Requsicion;
        }

        public void EnviarCorreoRechazo(String ID_REQUISICION)
        {

            String NombreDeUsuarioQueEstaAprobando = "";
            String CorreoElectronicoUsuarioQueEstaAprobando = "";
            var NombreUsuario = db.EMPLEADO_OBTENER_NOMBRE_USUARIO(this.User.Identity.Name.ToString());
            foreach (var Nombre in NombreUsuario)
            {
                NombreDeUsuarioQueEstaAprobando = Nombre.NOMBRE;
                CorreoElectronicoUsuarioQueEstaAprobando = Nombre.CORREO_ELECTRONICO;
            }


            String UsuarioCreador = "";
            String CorreoElectronicoUsuarioCreador = "";
            var DatosCreador = db.REQUISICIONES_MATERIALES_OBTENER_NOMBRE_CREADOR(Int32.Parse(this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_REQUISICION").ToString()));
            foreach (var NombreCrea in DatosCreador)
            {
                UsuarioCreador = NombreCrea.NOMBRE;
                CorreoElectronicoUsuarioCreador = NombreCrea.CORREO_ELECTRONICO;
            }

            MailMessage msg = new MailMessage();
            msg.From = new MailAddress("sifica@mineralesdelmayab.com", "SIFICA - Minerales del Mayab", System.Text.Encoding.UTF8);
            msg.Subject = "REQUISICION DE MATERIALES RECHAZADA";
            msg.To.Add(CorreoElectronicoUsuarioCreador);
            msg.CC.Add(CorreoElectronicoUsuarioQueEstaAprobando);
            msg.SubjectEncoding = System.Text.Encoding.UTF8;
            msg.Body = "La Requisición de Materiales con Numero de Folio: " + ID_REQUISICION + " ha sido Rechazada por el aprobador: " + NombreDeUsuarioQueEstaAprobando + " por las siguientes razones: " + this.txtComentarios.Text;
            msg.BodyEncoding = System.Text.Encoding.UTF8;
            msg.IsBodyHtml = true;

            SmtpClient client = new SmtpClient();
            client.Host = "mail.mineralesdelmayab.com";
            client.Port = 26;
            NetworkCredential login = new NetworkCredential("sifica@mineralesdelmayab.com", "Imperio90");
            client.EnableSsl = false;
            client.UseDefaultCredentials = true;
            client.Credentials = login;

            try
            {
                client.Send(msg);
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(),
                        "err_msg",
                        "alert('!Los usuarios han sido notificados via correo electrónico!');",
                        true);
                return;
            }
            catch (System.Net.Mail.SmtpException ex)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(),
                       "err_msg",
                       "alert('!Hubo un problema y no fue posible notificar a los usuarios!');",
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
    }
}