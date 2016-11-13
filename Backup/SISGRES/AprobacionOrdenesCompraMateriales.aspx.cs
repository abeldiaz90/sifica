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
using System.Net;
using System.Net.Mail;
using System.IO;
using System.Net.Mime;

namespace SISGRES
{
    public partial class AprobacionOrdenesCompraMateriales : System.Web.UI.Page
    {
        SIFICADataContext db = new SIFICADataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            this.grdAprobaciones.DataBind();
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
                com.CommandText = "ORDENES_COMPRA_MATERIALES_VER_DETALLE_PROOVEDOR_REQUISICION";
                com.Parameters.AddWithValue("@ID_REQUISICION", this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_REQUISICION").ToString());
                com.Parameters.AddWithValue("@ID_PROOVEDOR", this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_PROOVEDOR").ToString());
                com.CommandTimeout = 0;
                com.ExecuteNonQuery();
                SqlDataAdapter Datos = new SqlDataAdapter(com);
                Datos.Fill(Requsicion);
                con.Close();
            }
            catch (Exception ex) { ex.ToString(); }
            return Requsicion;
        }
        public DataTable DatosRequisicionMaterialesFolioA()
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
                com.CommandText = "ORDENES_COMPRA_MATERIALES_VER_DETALLE_PROOVEDOR_REQUISICION_FOLIO_A";
                com.Parameters.AddWithValue("@ID_REQUISICION", this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_REQUISICION").ToString());
                com.Parameters.AddWithValue("@ID_PROOVEDOR", this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_PROOVEDOR").ToString());
                com.CommandTimeout = 0;
                com.ExecuteNonQuery();
                SqlDataAdapter Datos = new SqlDataAdapter(com);
                Datos.Fill(Requsicion);
                con.Close();
            }
            catch (Exception ex) { ex.ToString(); }
            return Requsicion;
        }

        public DataTable DatosRequisicionMaterialesAprobadas()
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
                com.CommandText = "ORDENES_COMPRA_MATERIALES_APROBADAS";
                com.Parameters.AddWithValue("@ID_REQUISICION", this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_REQUISICION").ToString());
                com.Parameters.AddWithValue("@ID_PROOVEDOR", this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_PROOVEDOR").ToString());
                com.CommandTimeout = 0;
                com.ExecuteNonQuery();
                SqlDataAdapter Datos = new SqlDataAdapter(com);
                Datos.Fill(Requsicion);
                con.Close();
            }
            catch (Exception ex) { ex.ToString(); }
            return Requsicion;
        }

        protected void ASPxButton2_Click1(object sender, EventArgs e)
        {
            Label1.Text = "1";
            popupComentarios.ShowOnPageLoad = true;
        }

        public void EnviarCorreo(String ID_REQUISICION, String ID_COMPRA)
        {

            //el aprobador de compras(jorge ayala)
            var q = db.OBTENER_DESTINATARIOS(4);

            String Destinatarios = "";
            foreach (var r in q)
            {
                Destinatarios = r.DESTINATARIOS;
            }


            //el comprador
            String NombreDeUsuarioQueEstaAprobando = "";
            String CorreoElectronicoUsuarioQueEstaAprobando = "";
            var NombreUsuario = db.EMPLEADO_OBTENER_NOMBRE_USUARIO(this.User.Identity.Name.ToString());
            foreach (var Nombre in NombreUsuario)
            {
                NombreDeUsuarioQueEstaAprobando = Nombre.NOMBRE;
                CorreoElectronicoUsuarioQueEstaAprobando = Nombre.CORREO_ELECTRONICO;
            }

            //el requisitor
            String UsuarioCreador = "";
            String CorreoElectronicoUsuarioCreador = "";
            var DatosCreador = db.REQUISICIONES_MATERIALES_OBTENER_NOMBRE_CREADOR(Int32.Parse(this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_REQUISICION").ToString()));
            foreach (var NombreCrea in DatosCreador)
            {
                UsuarioCreador = NombreCrea.NOMBRE;
                CorreoElectronicoUsuarioCreador = NombreCrea.CORREO_ELECTRONICO;
            }


            //el Que Aprobo la requisición
            //el aprobador de compras(jorge ayala)
            var AprobadorCompras = db.OBTENER_DESTINATARIOS(2);

            String AprobadorRequisicion = "";
            foreach (var a in AprobadorCompras)
            {
                AprobadorRequisicion = a.DESTINATARIOS;
            }

            String UsuariosConCopia = CorreoElectronicoUsuarioQueEstaAprobando + ";" + CorreoElectronicoUsuarioCreador + ";" + AprobadorRequisicion;

            LocalReport report = new LocalReport();
            report.EnableExternalImages = true;
            DataTable ds = new DataTable();
            ReportDataSource dsMain = new ReportDataSource();

            if (this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "FOLIO").ToString() == "A")
            {     
                report.ReportPath = "OrdenCompraMateriales.rdlc";
                ds = DatosRequisicionMaterialesFolioA();
                dsMain.Name = "DetallesOrdenesComprasFolioA";
                dsMain.Value = ds;
            }
            else if (this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "FOLIO").ToString() == "B")
            {
                report.ReportPath = "OrdenCompraMaterialesFolioB.rdlc";
                ds = DatosRequisicionMateriales();                
                dsMain.Name = "OrdenesComprasDetalladas";
                dsMain.Value = ds;
            } 
            
           
            DataTable dslogo = ObtenerLogoEmpresa();
            DataTable dsFirma = ObtenerFirmaAprobadorCompra();


            

            ReportDataSource logo = new ReportDataSource();
            logo.Name = "ObtenerLogoEmpresa";
            logo.Value = dslogo;


            ReportDataSource Firma = new ReportDataSource();
            Firma.Name = "ObtenerFirmaAprobadorCompra";
            Firma.Value = dsFirma;


            report.DataSources.Clear();
            report.DataSources.Add(dsMain);
            report.DataSources.Add(logo);
            report.DataSources.Add(Firma);

            report.Refresh();
            ReportParameter p1 = new ReportParameter("Letras", enletras(ds.Rows[0]["TOTAL"].ToString()));
            report.SetParameters(new ReportParameter[] { p1 });
            report.Refresh();
            string reportType = "PDF";
            string mimeType;
            string encoding;
            string fileNameExtension;

            string deviceInfo =
                "<DeviceInfo>" +
                "  <OutputFormat>PDF</OutputFormat>" +
                "  <PageWidth>21.59cm</PageWidth>" +
                "  <PageHeight>27.94cm</PageHeight>" +
                "  <MarginTop>0cm</MarginTop>" +
                "  <MarginLeft>0cm</MarginLeft>" +
                "  <MarginRight>0cm</MarginRight>" +
                "  <MarginBottom>0cm</MarginBottom>" +
                "</DeviceInfo>";

            Warning[] warnings;
            string[] streams;
            byte[] renderedBytes;


            renderedBytes = report.Render(
                reportType,
                deviceInfo,
                out mimeType,
                out encoding,
                out fileNameExtension,
                out streams,
                out warnings);

            string filename = Path.Combine(Path.GetTempPath(), "OrdenDeCompra.pdf");


            using (var fs = new FileStream(filename, FileMode.Create))
            {
                fs.Write(renderedBytes, 0, renderedBytes.Length);
                fs.Close();
            }

            // Create  the file attachment for this e-mail message.
            Attachment data = new Attachment(filename, MediaTypeNames.Application.Octet);
            // Add time stamp information for the file.
            System.Net.Mime.ContentDisposition disposition = data.ContentDisposition;
            disposition.CreationDate = System.IO.File.GetCreationTime(filename);
            disposition.ModificationDate = System.IO.File.GetLastWriteTime(filename);
            disposition.ReadDate = System.IO.File.GetLastAccessTime(filename);
            // Add the file attachment to this e-mail message.




            MailMessage msg = new MailMessage();
            msg.From = new MailAddress("sifica@mineralesdelmayab.com", "SIFICA - Minerales del Mayab", System.Text.Encoding.UTF8);
            msg.Subject = "ORDEN DE COMPRA APROBADA";
            msg.To.Add(FormatMultipleEmailAddresses(Destinatarios));
            msg.CC.Add(FormatMultipleEmailAddresses(UsuariosConCopia));
            msg.SubjectEncoding = System.Text.Encoding.UTF8;
            msg.Body = "LA ORDEN DE COMPRA DE MATERIALES CON NUMERO DE FOLIO:  " + ID_COMPRA + " HA SIDO APROBADA POR:  " + NombreDeUsuarioQueEstaAprobando + "<p>COMENTARIOS : " + this.txtComentarios.Text;
            msg.BodyEncoding = System.Text.Encoding.UTF8;
            msg.Attachments.Add(data);
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

        public void EnviarCorreoRetorno(String ID_REQUISICION, String ID_COMPRA)
        {

            //el aprobador de compras(jorge ayala)
            var q = db.OBTENER_DESTINATARIOS(4);

            String Destinatarios = "";
            foreach (var r in q)
            {
                Destinatarios = r.DESTINATARIOS;
            }


            //el comprador
            String NombreDeUsuarioQueEstaAprobando = "";
            String CorreoElectronicoUsuarioQueEstaAprobando = "";
            var NombreUsuario = db.EMPLEADO_OBTENER_NOMBRE_USUARIO(this.User.Identity.Name.ToString());
            foreach (var Nombre in NombreUsuario)
            {
                NombreDeUsuarioQueEstaAprobando = Nombre.NOMBRE;
                CorreoElectronicoUsuarioQueEstaAprobando = Nombre.CORREO_ELECTRONICO;
            }

            //el requisitor
            String UsuarioCreador = "";
            String CorreoElectronicoUsuarioCreador = "";
            var DatosCreador = db.REQUISICIONES_MATERIALES_OBTENER_NOMBRE_CREADOR(Int32.Parse(this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_REQUISICION").ToString()));
            foreach (var NombreCrea in DatosCreador)
            {
                UsuarioCreador = NombreCrea.NOMBRE;
                CorreoElectronicoUsuarioCreador = NombreCrea.CORREO_ELECTRONICO;
            }


            //el Que Aprobo la requisición
            //el aprobador de compras(jorge ayala)
            var AprobadorCompras = db.OBTENER_DESTINATARIOS(2);

            String AprobadorRequisicion = "";
            foreach (var a in AprobadorCompras)
            {
                AprobadorRequisicion = a.DESTINATARIOS;
            }

            String UsuariosConCopia = CorreoElectronicoUsuarioQueEstaAprobando + ";" + CorreoElectronicoUsuarioCreador + ";" + AprobadorRequisicion;


            LocalReport report = new LocalReport();
            report.EnableExternalImages = true;
            report.ReportPath = "OrdenCompraMateriales.rdlc";

            DataTable ds = DatosRequisicionMateriales();
            DataTable dslogo = ObtenerLogoEmpresa();
            DataTable dsFirma = ObtenerFirmaAprobadorCompra();


            ReportDataSource dsMain = new ReportDataSource();
            dsMain.Name = "OrdenesComprasDetalladas";
            dsMain.Value = ds;

            ReportDataSource logo = new ReportDataSource();
            logo.Name = "ObtenerLogoEmpresa";
            logo.Value = dslogo;


            ReportDataSource Firma = new ReportDataSource();
            Firma.Name = "ObtenerFirmaAprobadorCompra";
            Firma.Value = dsFirma;


            report.DataSources.Clear();
            report.DataSources.Add(dsMain);
            report.DataSources.Add(logo);
            report.DataSources.Add(Firma);

            report.Refresh();
            ReportParameter p1 = new ReportParameter("Letras", enletras(ds.Rows[0]["TOTAL"].ToString()));
            report.SetParameters(new ReportParameter[] { p1 });
            report.Refresh();
            string reportType = "PDF";
            string mimeType;
            string encoding;
            string fileNameExtension;

            string deviceInfo =
                "<DeviceInfo>" +
                "  <OutputFormat>PDF</OutputFormat>" +
                "  <PageWidth>21cm</PageWidth>" +
                "  <PageHeight>29.7cm</PageHeight>" +
                "  <MarginTop>0cm</MarginTop>" +
                "  <MarginLeft>0cm</MarginLeft>" +
                "  <MarginRight>0cm</MarginRight>" +
                "  <MarginBottom>0cm</MarginBottom>" +
                "</DeviceInfo>";

            Warning[] warnings;
            string[] streams;
            byte[] renderedBytes;


            renderedBytes = report.Render(
                reportType,
                deviceInfo,
                out mimeType,
                out encoding,
                out fileNameExtension,
                out streams,
                out warnings);

            string filename = Path.Combine(Path.GetTempPath(), "OrdenDeCompra.pdf");


            using (var fs = new FileStream(filename, FileMode.Create))
            {
                fs.Write(renderedBytes, 0, renderedBytes.Length);
                fs.Close();
            }

            // Create  the file attachment for this e-mail message.
            Attachment data = new Attachment(filename, MediaTypeNames.Application.Octet);
            // Add time stamp information for the file.
            System.Net.Mime.ContentDisposition disposition = data.ContentDisposition;
            disposition.CreationDate = System.IO.File.GetCreationTime(filename);
            disposition.ModificationDate = System.IO.File.GetLastWriteTime(filename);
            disposition.ReadDate = System.IO.File.GetLastAccessTime(filename);
            // Add the file attachment to this e-mail message.




            MailMessage msg = new MailMessage();
            msg.From = new MailAddress("sifica@mineralesdelmayab.com", "SIFICA - Minerales del Mayab", System.Text.Encoding.UTF8);
            msg.Subject = "ORDEN DE COMPRA RETORNADA";
            msg.To.Add(FormatMultipleEmailAddresses(Destinatarios));
            msg.CC.Add(FormatMultipleEmailAddresses(UsuariosConCopia));
            msg.SubjectEncoding = System.Text.Encoding.UTF8;
            msg.Body = "LA ORDEN DE COMPRA DE MATERIALES CON NUMERO DE FOLIO:  " + ID_COMPRA + " HA SIDO RETORNADA POR:  " + NombreDeUsuarioQueEstaAprobando + "<p>COMENTARIOS : " + this.txtComentarios.Text;
            msg.BodyEncoding = System.Text.Encoding.UTF8;
            //msg.Attachments.Add(data);
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

        public void EnviarCorreoCancela(String ID_REQUISICION, String ID_COMPRA)
        {

            //el aprobador de compras(jorge ayala)
            var q = db.OBTENER_DESTINATARIOS(4);

            String Destinatarios = "";
            foreach (var r in q)
            {
                Destinatarios = r.DESTINATARIOS;
            }


            //el comprador
            String NombreDeUsuarioQueEstaAprobando = "";
            String CorreoElectronicoUsuarioQueEstaAprobando = "";
            var NombreUsuario = db.EMPLEADO_OBTENER_NOMBRE_USUARIO(this.User.Identity.Name.ToString());
            foreach (var Nombre in NombreUsuario)
            {
                NombreDeUsuarioQueEstaAprobando = Nombre.NOMBRE;
                CorreoElectronicoUsuarioQueEstaAprobando = Nombre.CORREO_ELECTRONICO;
            }

            //el requisitor
            String UsuarioCreador = "";
            String CorreoElectronicoUsuarioCreador = "";
            var DatosCreador = db.REQUISICIONES_MATERIALES_OBTENER_NOMBRE_CREADOR(Int32.Parse(this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_REQUISICION").ToString()));
            foreach (var NombreCrea in DatosCreador)
            {
                UsuarioCreador = NombreCrea.NOMBRE;
                CorreoElectronicoUsuarioCreador = NombreCrea.CORREO_ELECTRONICO;
            }


            //el Que Aprobo la requisición
            //el aprobador de compras(jorge ayala)
            var AprobadorCompras = db.OBTENER_DESTINATARIOS(2);

            String AprobadorRequisicion = "";
            foreach (var a in AprobadorCompras)
            {
                AprobadorRequisicion = a.DESTINATARIOS;
            }

            String UsuariosConCopia = CorreoElectronicoUsuarioQueEstaAprobando + ";" + CorreoElectronicoUsuarioCreador + ";" + AprobadorRequisicion;


            LocalReport report = new LocalReport();
            report.EnableExternalImages = true;
            report.ReportPath = "OrdenCompraMateriales.rdlc";

            DataTable ds = DatosRequisicionMateriales();
            DataTable dslogo = ObtenerLogoEmpresa();
            DataTable dsFirma = ObtenerFirmaAprobadorCompra();


            ReportDataSource dsMain = new ReportDataSource();
            dsMain.Name = "OrdenesComprasDetalladas";
            dsMain.Value = ds;

            ReportDataSource logo = new ReportDataSource();
            logo.Name = "ObtenerLogoEmpresa";
            logo.Value = dslogo;


            ReportDataSource Firma = new ReportDataSource();
            Firma.Name = "ObtenerFirmaAprobadorCompra";
            Firma.Value = dsFirma;


            report.DataSources.Clear();
            report.DataSources.Add(dsMain);
            report.DataSources.Add(logo);
            report.DataSources.Add(Firma);

            report.Refresh();
            ReportParameter p1 = new ReportParameter("Letras", enletras(ds.Rows[0]["TOTAL"].ToString()));
            report.SetParameters(new ReportParameter[] { p1 });
            report.Refresh();
            string reportType = "PDF";
            string mimeType;
            string encoding;
            string fileNameExtension;

            string deviceInfo =
                "<DeviceInfo>" +
                "  <OutputFormat>PDF</OutputFormat>" +
                "  <PageWidth>21cm</PageWidth>" +
                "  <PageHeight>29.7cm</PageHeight>" +
                "  <MarginTop>0cm</MarginTop>" +
                "  <MarginLeft>0cm</MarginLeft>" +
                "  <MarginRight>0cm</MarginRight>" +
                "  <MarginBottom>0cm</MarginBottom>" +
                "</DeviceInfo>";

            Warning[] warnings;
            string[] streams;
            byte[] renderedBytes;


            renderedBytes = report.Render(
                reportType,
                deviceInfo,
                out mimeType,
                out encoding,
                out fileNameExtension,
                out streams,
                out warnings);

            string filename = Path.Combine(Path.GetTempPath(), "OrdenDeCompra.pdf");


            using (var fs = new FileStream(filename, FileMode.Create))
            {
                fs.Write(renderedBytes, 0, renderedBytes.Length);
                fs.Close();
            }

            // Create  the file attachment for this e-mail message.
            Attachment data = new Attachment(filename, MediaTypeNames.Application.Octet);
            // Add time stamp information for the file.
            System.Net.Mime.ContentDisposition disposition = data.ContentDisposition;
            disposition.CreationDate = System.IO.File.GetCreationTime(filename);
            disposition.ModificationDate = System.IO.File.GetLastWriteTime(filename);
            disposition.ReadDate = System.IO.File.GetLastAccessTime(filename);
            // Add the file attachment to this e-mail message.




            MailMessage msg = new MailMessage();
            msg.From = new MailAddress("sifica@mineralesdelmayab.com", "SIFICA - Minerales del Mayab", System.Text.Encoding.UTF8);
            msg.Subject = "ORDEN DE COMPRA CANCELADA";
            msg.To.Add(FormatMultipleEmailAddresses(Destinatarios));
            msg.CC.Add(FormatMultipleEmailAddresses(UsuariosConCopia));
            msg.SubjectEncoding = System.Text.Encoding.UTF8;
            msg.Body = "LA ORDEN DE COMPRA DE MATERIALES CON NUMERO DE FOLIO:  " + ID_COMPRA + " HA SIDO CANCELADA POR:  " + NombreDeUsuarioQueEstaAprobando + "<p>COMENTARIOS : " + this.txtComentarios.Text;
            msg.BodyEncoding = System.Text.Encoding.UTF8;
            //msg.Attachments.Add(data);
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


        public DataTable ObtenerFirmaAprobadorCompra()
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
                com.CommandText = "OBTENER_FIRMA_APROBADOR_COMPRA";
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

        private string FormatMultipleEmailAddresses(string emailAddresses)
        {
            var delimiters = new[] { ',', ';' };

            var addresses = emailAddresses.Split(delimiters, StringSplitOptions.RemoveEmptyEntries);

            return string.Join(",", addresses);
        }

        protected void ASPxButton5_Click(object sender, EventArgs e)
        {
            Label1.Text = "2";
            this.popupComentarios.ShowOnPageLoad = true;
        }

        protected void lnkDetalle_Click1(object sender, EventArgs e)
        {
            if (this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "FOLIO").ToString() == "A") 
            {
                ReporteFolioA();
            }
            else if (this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "FOLIO").ToString() == "B") 
            {
                ReporteFolioB();
            } 
        }

        public void ReporteFolioA()
        {
            try
            {

                this.popupDetalle.ShowOnPageLoad = true;
                this.ReportViewer1.ProcessingMode = ProcessingMode.Local;
                LocalReport report = new LocalReport();
                report.EnableExternalImages = true;
                report.ReportPath = "OrdenCompraMateriales.rdlc";

                DataTable ds = DatosRequisicionMaterialesFolioA();
                DataTable dslogo = ObtenerLogoEmpresa();
                DataTable dsFirma = ObtenerFirmaAprobadorCompra();

                ReportDataSource dsMain = new ReportDataSource();
                dsMain.Name = "DetallesOrdenesComprasFolioA";
                dsMain.Value = ds;

                ReportDataSource logo = new ReportDataSource();
                logo.Name = "ObtenerLogoEmpresa";
                logo.Value = dslogo;

                ReportDataSource Firma = new ReportDataSource();
                Firma.Name = "ObtenerFirmaAprobadorCompra";
                Firma.Value = dsFirma;

                report.DataSources.Clear();
                report.DataSources.Add(dsMain);
                report.DataSources.Add(logo);
                report.DataSources.Add(Firma);

                report.Refresh();
                ReportParameter p1 = new ReportParameter("Letras", enletras(ds.Rows[0]["TOTAL"].ToString()));
                this.ReportViewer1.Visible = true;
                this.ReportViewer1.LocalReport.ReportPath = Server.MapPath("OrdenCompraMateriales.rdlc");
                this.ReportViewer1.LocalReport.DataSources.Clear();
                this.ReportViewer1.LocalReport.DataSources.Add(dsMain);
                this.ReportViewer1.LocalReport.DataSources.Add(logo);
                this.ReportViewer1.LocalReport.DataSources.Add(Firma);

                this.ReportViewer1.LocalReport.SetParameters(new ReportParameter[] { p1 });

                this.ReportViewer1.DocumentMapCollapsed = true;
                this.ReportViewer1.ShowPrintButton = true;
                this.ReportViewer1.LocalReport.Refresh();

            }
            catch (Exception ex) { ex.ToString(); }
        }

        public void ReporteFolioB()
        {
            try
            {

                this.popupDetalle.ShowOnPageLoad = true;
                this.ReportViewer1.ProcessingMode = ProcessingMode.Local;
                LocalReport report = new LocalReport();
                report.EnableExternalImages = true;
                report.ReportPath = "OrdenCompraMaterialesFolioB.rdlc";

                DataTable ds = DatosRequisicionMateriales();
                DataTable dslogo = ObtenerLogoEmpresa();
                DataTable dsFirma = ObtenerFirmaAprobadorCompra();

                ReportDataSource dsMain = new ReportDataSource();
                dsMain.Name = "OrdenesComprasDetalladas";
                dsMain.Value = ds;

                ReportDataSource logo = new ReportDataSource();
                logo.Name = "ObtenerLogoEmpresa";
                logo.Value = dslogo;

                ReportDataSource Firma = new ReportDataSource();
                Firma.Name = "ObtenerFirmaAprobadorCompra";
                Firma.Value = dsFirma;

                report.DataSources.Clear();
                report.DataSources.Add(dsMain);
                report.DataSources.Add(logo);
                report.DataSources.Add(Firma);

                report.Refresh();
                ReportParameter p1 = new ReportParameter("Letras", enletras(ds.Rows[0]["TOTAL"].ToString()));
                this.ReportViewer1.Visible = true;
                this.ReportViewer1.LocalReport.ReportPath = Server.MapPath("OrdenCompraMaterialesFolioB.rdlc");
                this.ReportViewer1.LocalReport.DataSources.Clear();
                this.ReportViewer1.LocalReport.DataSources.Add(dsMain);
                this.ReportViewer1.LocalReport.DataSources.Add(logo);
                this.ReportViewer1.LocalReport.DataSources.Add(Firma);

                this.ReportViewer1.LocalReport.SetParameters(new ReportParameter[] { p1 });

                this.ReportViewer1.DocumentMapCollapsed = true;
                this.ReportViewer1.ShowPrintButton = true;
                this.ReportViewer1.LocalReport.Refresh();

            }
            catch (Exception ex) { ex.ToString(); }
        }

        public string enletras(string num)
        {

            string res, dec = "";

            Int64 entero;

            int decimales;

            double nro;

            try
            {
                nro = Convert.ToDouble(num);
            }

            catch
            {
                return "";
            }

            entero = Convert.ToInt64(Math.Truncate(nro));

            decimales = Convert.ToInt32(Math.Round((nro - entero) * 100, 2));

            DataTable ds = DatosRequisicionMateriales();
            if (ds.Rows[0]["MONEDA"].ToString() == "MXN")
            {
                if (decimales > 0 && decimales < 10)
                {
                    dec = " PESOS 0" + decimales.ToString() + "/100 MONEDA NACIONAL";
                }
                else { dec = " PESOS " + decimales.ToString() + "/100 MONEDA NACIONAL"; }
            }
            else if (ds.Rows[0]["MONEDA"].ToString() == "USD")
            {
                if (decimales > 0 && decimales < 10)
                {
                    dec = " DOLARES 0" + decimales.ToString() + "/100 USD";
                }
                else { dec = " DOLARES " + decimales.ToString() + "/100 USD"; }
            }

            res = toText(Convert.ToDouble(entero)) + dec;

            return res;

        }

        private string toText(double value)
        {
            string Num2Text = "";
            value = Math.Truncate(value);
            if (value == 0) Num2Text = "CERO";

            else if (value == 1) Num2Text = "UNO";

            else if (value == 2) Num2Text = "DOS";

            else if (value == 3) Num2Text = "TRES";

            else if (value == 4) Num2Text = "CUATRO";

            else if (value == 5) Num2Text = "CINCO";

            else if (value == 6) Num2Text = "SEIS";

            else if (value == 7) Num2Text = "SIETE";

            else if (value == 8) Num2Text = "OCHO";

            else if (value == 9) Num2Text = "NUEVE";

            else if (value == 10) Num2Text = "DIEZ";

            else if (value == 11) Num2Text = "ONCE";

            else if (value == 12) Num2Text = "DOCE";

            else if (value == 13) Num2Text = "TRECE";

            else if (value == 14) Num2Text = "CATORCE";

            else if (value == 15) Num2Text = "QUINCE";

            else if (value < 20) Num2Text = "DIECI" + toText(value - 10);

            else if (value == 20) Num2Text = "VEINTE";

            else if (value < 30) Num2Text = "VEINTI" + toText(value - 20);

            else if (value == 30) Num2Text = "TREINTA";

            else if (value == 40) Num2Text = "CUARENTA";

            else if (value == 50) Num2Text = "CINCUENTA";

            else if (value == 60) Num2Text = "SESENTA";

            else if (value == 70) Num2Text = "SETENTA";

            else if (value == 80) Num2Text = "OCHENTA";

            else if (value == 90) Num2Text = "NOVENTA";

            else if (value < 100) Num2Text = toText(Math.Truncate(value / 10) * 10) + " Y " + toText(value % 10);

            else if (value == 100) Num2Text = "CIEN";

            else if (value < 200) Num2Text = "CIENTO " + toText(value - 100);

            else if ((value == 200) || (value == 300) || (value == 400) || (value == 600) || (value == 800)) Num2Text = toText(Math.Truncate(value / 100)) + "CIENTOS";

            else if (value == 500) Num2Text = "QUINIENTOS";

            else if (value == 700) Num2Text = "SETECIENTOS";

            else if (value == 900) Num2Text = "NOVECIENTOS";

            else if (value < 1000) Num2Text = toText(Math.Truncate(value / 100) * 100) + " " + toText(value % 100);

            else if (value == 1000) Num2Text = "MIL";

            else if (value < 2000) Num2Text = "MIL " + toText(value % 1000);

            else if (value < 1000000)
            {

                Num2Text = toText(Math.Truncate(value / 1000)) + " MIL";

                if ((value % 1000) > 0) Num2Text = Num2Text + " " + toText(value % 1000);

            }

            else if (value == 1000000) Num2Text = "UN MILLON";

            else if (value < 2000000) Num2Text = "UN MILLON " + toText(value % 1000000);

            else if (value < 1000000000000)
            {

                Num2Text = toText(Math.Truncate(value / 1000000)) + " MILLONES ";

                if ((value - Math.Truncate(value / 1000000) * 1000000) > 0) Num2Text = Num2Text + " " + toText(value - Math.Truncate(value / 1000000) * 1000000);

            }

            else if (value == 1000000000000) Num2Text = "UN BILLON";

            else if (value < 2000000000000) Num2Text = "UN BILLON " + toText(value - Math.Truncate(value / 1000000000000) * 1000000000000);

            else
            {

                Num2Text = toText(Math.Truncate(value / 1000000000000)) + " BILLONES";

                if ((value - Math.Truncate(value / 1000000000000) * 1000000000000) > 0) Num2Text = Num2Text + " " + toText(value - Math.Truncate(value / 1000000000000) * 1000000000000);

            }

            return Num2Text;

        }

        protected void btnProcesar_Click(object sender, EventArgs e)
        {
            try
            {
                if (this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "FOLIO").ToString() == "A")
                {
                    if (this.Label1.Text == "1")
                    {
                        SIFICADataContext DB = new SIFICADataContext();
                        DB.APROBAR_ORDEN_COMPRA_MATERIALES_FOLIO_A(Int32.Parse(this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_REQUISICION").ToString()), Int32.Parse(this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_PROOVEDOR").ToString()), this.User.Identity.Name.ToString(), this.txtComentarios.Text, Int32.Parse(this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_ORDEN_COMPRA").ToString()));
                        DB.SubmitChanges();
                        EnviarCorreo(this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_REQUISICION").ToString(), this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_ORDEN_COMPRA").ToString());
                        this.popupDetalle.ShowOnPageLoad = false;
                        this.popupComentarios.ShowOnPageLoad = false;
                        this.grdAprobaciones.DataBind();
                    }
                    else if (this.Label1.Text == "2")
                    {
                        SIFICADataContext DB = new SIFICADataContext();
                        DB.RETORNAR_ORDEN_COMPRA_MATERIALES_FOLIO_A(Int32.Parse(this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_REQUISICION").ToString()), Int32.Parse(this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_PROOVEDOR").ToString()), this.User.Identity.Name.ToString(), this.txtComentarios.Text, Int32.Parse(this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_ORDEN_COMPRA").ToString()));
                        DB.SubmitChanges();
                        EnviarCorreoRetorno(this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_REQUISICION").ToString(), this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_ORDEN_COMPRA").ToString());
                        this.popupDetalle.ShowOnPageLoad = false;
                        this.popupComentarios.ShowOnPageLoad = false;
                        this.grdAprobaciones.DataBind();
                    }
                    else if (this.Label1.Text == "3")
                    {
                        SIFICADataContext DB = new SIFICADataContext();
                        DB.CANCELAR_ORDEN_COMPRA_MATERIALES_FOLIO_A(Int32.Parse(this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_REQUISICION").ToString()), Int32.Parse(this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_ORDEN_COMPRA").ToString()));
                        DB.SubmitChanges();
                        EnviarCorreoCancela(this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_REQUISICION").ToString(), this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_ORDEN_COMPRA").ToString());
                        this.popupDetalle.ShowOnPageLoad = false;
                        this.popupComentarios.ShowOnPageLoad = false;
                        this.grdAprobaciones.DataBind();
                    }
                }
                else if (this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "FOLIO").ToString() == "B")
                {
                    if (this.Label1.Text == "1")
                    {
                        SIFICADataContext DB = new SIFICADataContext();
                        DB.APROBAR_ORDEN_COMPRA_MATERIALES(Int32.Parse(this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_REQUISICION").ToString()), Int32.Parse(this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_PROOVEDOR").ToString()), this.User.Identity.Name.ToString(), this.txtComentarios.Text, Int32.Parse(this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_ORDEN_COMPRA").ToString()));
                        DB.SubmitChanges();
                        EnviarCorreo(this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_REQUISICION").ToString(), this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_ORDEN_COMPRA").ToString());
                        this.popupDetalle.ShowOnPageLoad = false;
                        this.popupComentarios.ShowOnPageLoad = false;
                        this.grdAprobaciones.DataBind();
                    }
                    else if (this.Label1.Text == "2")
                    {
                        SIFICADataContext DB = new SIFICADataContext();
                        DB.RETORNAR_ORDEN_COMPRA_MATERIALES(Int32.Parse(this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_REQUISICION").ToString()), Int32.Parse(this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_PROOVEDOR").ToString()), this.User.Identity.Name.ToString(), this.txtComentarios.Text, Int32.Parse(this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_ORDEN_COMPRA").ToString()));
                        DB.SubmitChanges();
                        EnviarCorreoRetorno(this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_REQUISICION").ToString(), this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_ORDEN_COMPRA").ToString());
                        this.popupDetalle.ShowOnPageLoad = false;
                        this.popupComentarios.ShowOnPageLoad = false;
                        this.grdAprobaciones.DataBind();
                    }
                    else if (this.Label1.Text == "3")
                    {
                        SIFICADataContext DB = new SIFICADataContext();
                        DB.CANCELAR_ORDEN_COMPRA_MATERIALES(Int32.Parse(this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_REQUISICION").ToString()), Int32.Parse(this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_ORDEN_COMPRA").ToString()));
                        DB.SubmitChanges();
                        EnviarCorreoCancela(this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_REQUISICION").ToString(), this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_ORDEN_COMPRA").ToString());
                        this.popupDetalle.ShowOnPageLoad = false;
                        this.popupComentarios.ShowOnPageLoad = false;
                        this.grdAprobaciones.DataBind();
                    }
                } 
              
                Response.Redirect("AprobacionOrdenesCompraMateriales.aspx");
            }
            catch (Exception ex) { ex.ToString(); }
        }

        protected void btnRechazar_Click(object sender, EventArgs e)
        {
            Label1.Text = "3";
            this.popupComentarios.ShowOnPageLoad = true;
        }

        protected void mnuOpciones_ItemClick(object source, DevExpress.Web.MenuItemEventArgs e)
        {
            if(e.Item.Name=="Pendientes")
            {          
                this.grdAprobaciones.DataSourceID = "AprobacionesRequisicionesHerramientasDatos";
                this.grdAprobaciones.DataBind();                
            }
            else if (e.Item.Name == "Todas") 
            {
                this.grdAprobaciones.DataSourceID = "OrdenesCompraTodas";
                this.grdAprobaciones.DataBind();
            }
        }
    }
}