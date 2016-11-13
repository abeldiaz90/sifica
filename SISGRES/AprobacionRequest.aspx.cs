using Microsoft.Reporting.WebForms;
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
    public partial class AprobacionRequest : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public void AprobarRechazar(Int32 Opcion, Int32 Id_Request)
        {
            try
            {
                SIFICADataContext db = new SIFICADataContext();
                var Validacion = db.APROBADORES_REQUISICIONES_OBTENER_ID(this.Page.User.Identity.Name.ToString()).Count();
                if (Validacion >= 1)
                {
                    Int32 Id_Empleado = 0;
                    var Id = db.APROBADORES_REQUISICIONES_OBTENER_ID(this.Page.User.Identity.Name.ToString());
                    foreach (var i in Id)
                    {
                        Id_Empleado = Int32.Parse(i.ID_EMPLEADO.ToString());
                    }
                    db.APROBACION_RECHAZO_REQUISICION(Opcion, Id_Empleado, Id_Request);
                    db.SubmitChanges();
                    EnvioCorreoRequisitor(2, Id_Request, Opcion);
                    EnviarCorreoAprobadores(2, Id_Request);
                    this.grdAprobaciones.DataBind();
                }

            }
            catch (Exception ex) { ex.ToString(); }
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
                com.CommandText = "OC_OR_ID";
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

        protected void btnAprobar_Click(object sender, EventArgs e)
        {
            Int32 Id_Requisicion = Int32.Parse(this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_REQUEST").ToString());
            AprobarRechazar(3, Id_Requisicion);
        }

        protected void btnRechazar_Click(object sender, EventArgs e)
        {
            Int32 Id_Requisicion = Int32.Parse(this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_REQUEST").ToString());
            AprobarRechazar(2, Id_Requisicion);

        }

        protected void btnAbrir_Click(object sender, EventArgs e)
        {
            GenerarDocumentoRequisicion(Int32.Parse(this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_REQUEST").ToString()));
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
                com.Parameters.AddWithValue("@ID_REQUISICION", Int32.Parse(this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_REQUEST").ToString()));
                com.CommandTimeout = 0;
                com.ExecuteNonQuery();
                SqlDataAdapter Datos = new SqlDataAdapter(com);
                Datos.Fill(Requsicion);
                con.Close();
            }
            catch (Exception ex) { ex.ToString(); }
            return Requsicion;
        }
        //public void EnviarCorreoAprobadoresOC(Int32 NivelAprobacion, Int32 IdRequisicion)
        //{
        //    SIFICADataContext db = new SIFICADataContext();

        //    String NombreDeUsuario = "";
        //    String CorreoElectronico = "";
        //    var NombreUsuario = db.EMPLEADO_OBTENER_NOMBRE_USUARIO(this.User.Identity.Name.ToString());
        //    foreach (var Nombre in NombreUsuario)
        //    {
        //        NombreDeUsuario = Nombre.NOMBRE;
        //        CorreoElectronico = Nombre.CORREO_ELECTRONICO;
        //    }


        //    var q = db.OBTENER_APROBADORES_REQUISICION(2);

        //    String Destinatarios = "";
        //    foreach (var r in q)
        //    {
        //        Destinatarios = r.DESTINATARIOS;
        //    }

        //    String Cuerpo = "<html><h1>LA REQUISICIÓN CON NUMERO DE FOLIO: " + IdRequisicion.ToString() + " HA SIDO GENERADA POR: " + NombreDeUsuario + "</h1> <p>SE ENVIA PARA SU REVISION Y APROBACION. <a href='http://sifica-001-site6.smarterasp.net/AprobacionesRequisicionesMateriales.aspx'> HAGA CLICK PARA INGRESAR AL MODULO DE COMPRAS PARA REALIZAR LA APROBACION </a>";
        //    Cuerpo = Cuerpo + "<p><table border='1' align='center'><TR><TD align='center'>PARTIDA</TD><TD align='center'>CLAVE DEL MATERIAL</TD><TD align='center'>DESCRIPCIÓN</TD><TD align='center'>UNIDAD DE MEDIDA</TD><TD align='center'>CANTIDAD</TD><TD align='center'>PRECIO UNITARIO</TD><TD align='center'>IMPORTE</TD></TR>";


        //    for (int i = 0; i <= this.ASPxGridView1.VisibleRowCount - 1; i++)
        //    {
        //        Cuerpo = Cuerpo + "<TR><TD align='center'>" + this.ASPxGridView1.GetRowValues(i, "CONTEO").ToString() + "</TD><TD align='center'>" + this.ASPxGridView1.GetRowValues(i, "ID_ITEM").ToString() + "</TD><TD align='center'>" + this.ASPxGridView1.GetRowValues(i, "DESCRIPCION").ToString() + "</TD><TD align='center'>" + this.ASPxGridView1.GetRowValues(i, "UNIDAD").ToString() + "</TD><TD align='center'>" + this.ASPxGridView1.GetRowValues(i, "CANTIDAD").ToString() + "</TD><TD align='center'>" + String.Format(new CultureInfo("es-MX"), "{0:C}", this.ASPxGridView1.GetRowValues(i, "COSTO_UNITARIO").ToString()) + "</TD><TD align='center'>" + String.Format(new CultureInfo("es-MX"), "{0:C}", this.ASPxGridView1.GetRowValues(i, "IMPORTE").ToString()) + "</TD></TR>";
        //    }

        //    Cuerpo = Cuerpo + "</table></html>";
        //    MailMessage msg = new MailMessage();
        //    msg.From = new MailAddress("sifica@musebe.com.mx","SIFICA", System.Text.Encoding.UTF8);
        //    msg.Subject = "APROBACIÓN DE REQUISICIÓN";
        //    msg.To.Add(FormatMultipleEmailAddresses(Destinatarios));
        //    msg.CC.Add(CorreoElectronico);
        //    msg.SubjectEncoding = System.Text.Encoding.UTF8;
        //    msg.Body = Cuerpo;
        //    msg.BodyEncoding = System.Text.Encoding.UTF8;
        //    msg.IsBodyHtml = true;

        //    SmtpClient client = new SmtpClient();
        //    client.Host = "mail.musebe.com.mx";
        //    client.Port = 26;
        //    NetworkCredential login = new NetworkCredential("sifica@mineralesdelmayab.com", "Imperio90");
        //    client.EnableSsl = false;
        //    client.UseDefaultCredentials = true;
        //    client.Credentials = login;

        //    try
        //    {
        //        client.Send(msg);
        //        ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(),
        //                "err_msg",
        //                "alert('!La Requisición fue creada exitosamente y enviada por correo electrónico para aprobación!');",
        //                true);
        //        return;
        //    }
        //    catch (System.Net.Mail.SmtpException ex)
        //    {
        //        ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(),
        //               "err_msg",
        //               "alert('!Hubo un problema y no fue posible enviar el correo!');",
        //               true);
        //        return;
        //    }

        //}


        public void EnvioCorreoRequisitor(Int32 NivelAprobacion, Int32 IdRequisicion, Int32 Estado)
        {
            SIFICADataContext db = new SIFICADataContext();

            String NombreDeUsuario = "";
            String NombreAprobador = "";
            String CorreoElectronico = "";
            String Folio = "";
            String EstadoTexto = "";
            String OC = "";
            var DatosRequisicion = db.REQUICIONES_OR_ID(Int32.Parse(IdRequisicion.ToString()));
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

                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(),
                        "err_msg",
                        "alert('!La Requisicion se proceso exitosamente y se ha generado la orden de compra misma que debera ser aporbada o rechazada!');",
                        true);
                return;
            }
            catch (System.Net.Mail.SmtpException ex)
            {
                Response.Write("Hubo un error no fue posible aprobarse la requisicion");
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(),
                       "err_msg",
                       "alert('!Hubo un problema y no fue posible enviar el correo!');",
                       true);
                return;
            }

        }


        //public void EnvioCorreoRequisitor(Int32 NivelAprobacion, Int32 IdRequisicion, Int32 Estado)
        //{
        //    SIFICADataContext db = new SIFICADataContext();

        //    String NombreDeUsuario = "";
        //    String NombreAprobador = "";
        //    String CorreoElectronicoRequisitor = "";
        //    String CorreoElectronicoAprobador= "";
        //    String Folio = "";
        //    String EstadoTexto = "";
        //    String OC="";
        //    var DatosRequisicion = db.REQUICIONES_OR_ID(Int32.Parse(this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_REQUEST").ToString()));
        //    foreach (var Datos in DatosRequisicion)
        //    {
        //        NombreDeUsuario = Datos.REQUISITOR;
        //        NombreAprobador = Datos.APROBADOR_RECHAZADOR_REQUISICION;
        //        CorreoElectronicoRequisitor = Datos.CORREO_REQUISITOR;
        //        CorreoElectronicoAprobador = Datos.CORREO_APROBADOR_REQUISICION;
        //        Folio = Datos.FOLIO;
        //        OC = Datos.FOLIO_OC;
        //    }


        //    //var q = db.OBTENER_APROBADORES_REQUISICION(2);

        //    //String Destinatarios = "";
        //    //foreach (var r in q)
        //    //{
        //    //    Destinatarios = r.DESTINATARIOS;
        //    //}
        //    String Cuerpo = "";
        //    if (Estado == 2)
        //    {
        //        EstadoTexto = "RECHAZADA";
        //        Cuerpo = "<html><h1>LA REQUISICIÓN CON NUMERO DE FOLIO: " + Folio.ToString() + " HA SIDO: <b>" + EstadoTexto + "</b> por: " + NombreAprobador + "</h1></html>";
        //    }
        //    else if (Estado == 3) { EstadoTexto = "APROBADA";
        //    Cuerpo = "<html><h1>LA REQUISICIÓN CON NUMERO DE FOLIO: " + Folio.ToString() + " HA SIDO: <b>" + EstadoTexto + "</b> por: " + NombreAprobador + "</h1> <p><h2>Se ha generado la orden de compra con numero de Folio: <b>" + OC + "</b> verifique que los precios sean correctos.<h2></html>";
        //    }


        //    //Cuerpo = Cuerpo + "<p><table border='1' align='center'><TR><TD align='center'>PARTIDA</TD><TD align='center'>CLAVE DEL MATERIAL</TD><TD align='center'>DESCRIPCIÓN</TD><TD align='center'>UNIDAD DE MEDIDA</TD><TD align='center'>CANTIDAD</TD><TD align='center'>PRECIO UNITARIO</TD><TD align='center'>IMPORTE</TD></TR>";


        //    //for (int i = 0; i <= this.ASPxGridView1.VisibleRowCount - 1; i++)
        //    //{
        //    //    Cuerpo = Cuerpo + "<TR><TD align='center'>" + this.ASPxGridView1.GetRowValues(i, "CONTEO").ToString() + "</TD><TD align='center'>" + this.ASPxGridView1.GetRowValues(i, "ID_ITEM").ToString() + "</TD><TD align='center'>" + this.ASPxGridView1.GetRowValues(i, "DESCRIPCION").ToString() + "</TD><TD align='center'>" + this.ASPxGridView1.GetRowValues(i, "UNIDAD").ToString() + "</TD><TD align='center'>" + this.ASPxGridView1.GetRowValues(i, "CANTIDAD").ToString() + "</TD><TD align='center'>" + String.Format(new CultureInfo("es-MX"), "{0:C}", this.ASPxGridView1.GetRowValues(i, "COSTO_UNITARIO").ToString()) + "</TD><TD align='center'>" + String.Format(new CultureInfo("es-MX"), "{0:C}", this.ASPxGridView1.GetRowValues(i, "IMPORTE").ToString()) + "</TD></TR>";
        //    //}

        //    //Cuerpo = Cuerpo + "</table></html>";

        //    MailMessage msg = new MailMessage();
        //    msg.From = new MailAddress("sifica@musebe.com.mx","SIFICA", System.Text.Encoding.UTF8);
        //    msg.Subject = "REQUISICIÓN " + EstadoTexto;
        //    msg.To.Add(FormatMultipleEmailAddresses(CorreoElectronicoRequisitor));
        //    msg.CC.Add(CorreoElectronicoAprobador);
        //    msg.SubjectEncoding = System.Text.Encoding.UTF8;
        //    msg.Body = Cuerpo;
        //    msg.BodyEncoding = System.Text.Encoding.UTF8;
        //    msg.IsBodyHtml = true;

        //    SmtpClient client = new SmtpClient();
        //    client.Host = "mail.musebe.com.mx";
        //    client.Port = 587;
        //    NetworkCredential login = new NetworkCredential("sifica@musebe.com.mx", "Imperio90_");
        //    client.EnableSsl = false;
        //    client.UseDefaultCredentials = true;
        //    client.Credentials = login;

        //    try
        //    {
        //        client.Send(msg);
        //        ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(),
        //                "err_msg",
        //                "alert('!La Requisicion se proceso exitosamente y se ha generado la orden de compra misma que debera ser aporbada o rechazada!');",
        //                true);
        //        return;
        //    }
        //    catch (System.Net.Mail.SmtpException ex)
        //    {
        //        ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(),
        //               "err_msg",
        //               "alert('!Hubo un problema y no fue posible enviar el correo!');",
        //               true);
        //        return;
        //    }

        //}

        private string FormatMultipleEmailAddresses(string emailAddresses)
        {
            var delimiters = new[] { ',', ';' };

            var addresses = emailAddresses.Split(delimiters, StringSplitOptions.RemoveEmptyEntries);

            return string.Join(",", addresses);
        }


    }
}