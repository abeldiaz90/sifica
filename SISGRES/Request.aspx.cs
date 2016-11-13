using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SISGRES
{
    public partial class Request : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                this.FechaEntrega.MinDate = System.DateTime.Today;
                this.txtItem.Style["text-align"] = "center";
                this.txtItem.Focus();
                string consecutivofolio = "";
                SIFICADataContext db = new SIFICADataContext();
                var consecutivo = db.OBTENER_CONSECUTIVO_REQUISICION();
                foreach (var folio in consecutivo)
                {
                    consecutivofolio = folio.MAXIMO.ToString();
                }
                this.lblConsecutivo.Text = consecutivofolio;
                if (!Page.IsPostBack)
                {

                    var q = db.REQUISICION_TEMPORALES_CONSULTAR_USUARIO(Int32.Parse(Session["Compañia"].ToString()), this.User.Identity.Name.ToString());
                    if (q.Count() >= 1)
                    {
                        PopupAlerta.ShowOnPageLoad = true;
                    }



                }
            }
            catch (Exception ex) { ex.ToString(); }

        }

        protected void Agregar_Click(object sender, EventArgs e)
        {
            try
            {
                if (ValidarExistenciaItem(this.txtItem.Text))
                {
                    if (Double.Parse(this.txtCantidad.Text) > 0 && this.txtItem.Text != string.Empty)
                    {
                        SIFICADataContext db = new SIFICADataContext();
                        db.REQUISICION_TEMPORALES_NUEVA_REQUISICION(this.txtItem.Text, float.Parse(this.txtCantidad.Text), Decimal.Parse(this.txtPrecioUnitario.Text), this.User.Identity.Name.ToString(), Int32.Parse(Session["Compañia"].ToString()));
                        db.SubmitChanges();

                        MostrarItemsRequisicion();

                    }
                }
                else
                {
                    this.cboUnidadMedia.SelectedIndex = -1;
                    this.cboUnidadMedia.Text = string.Empty;
                    this.cboClasificacion.SelectedIndex = -1;
                    this.cboUnidadMedia.Text = string.Empty;
                    this.cboGiro.SelectedIndex = -1;
                    this.cboGiro.Text = string.Empty;
                    this.txtNumeroParte.Text = string.Empty;
                    this.txtMaximo.Text = string.Empty;
                    this.txtMinimo.Text = string.Empty;
                    //lblItem.Text = "";
                    //lblItem.Visible = false;
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "popupAddIteOpen", "popupAddItemOpen();", true); this.txtDescripcionItem.Value = this.txtItem.Text;
                }
            }

            catch (Exception ex) { ex.ToString(); }
        }

        public Boolean ValidarExistenciaItem(String Texto)
        {
            Boolean Bandera = false;
            try
            {
                SIFICADataContext DB = new SIFICADataContext();
                var q = DB.ITEMS_VALIDAR_EXISTENCIA(this.txtItem.Text);
                if (q.Count() < 1)
                {
                    Bandera = false;
                }
                else { Bandera = true; }
            }
            catch (Exception ex)
            {
                ex.ToString();
            }
            return Bandera;
        }
        public void MostrarItemsRequisicion()
        {
            SIFICADataContext db = new SIFICADataContext();
            this.ASPxGridView1.DataSource = db.REQUISICION_TEMPORALES_CONSULTAR_USUARIO(Int32.Parse(Session["Compañia"].ToString()), this.User.Identity.Name.ToString());
            this.ASPxGridView1.DataBind();
            this.txtCantidad.Text = string.Empty;
            this.txtItem.Text = string.Empty;
            this.txtPrecioUnitario.Text = string.Empty;
        }

        protected void btnEnviarRequisicion_Click(object sender, EventArgs e)
        {
            //this.popupEnvioRequisicion.ShowOnPageLoad = true;
            this.cboProveedor.DataBind();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "EnvioRequisicion", "EnvioRequisicion();", true);
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

            var q = db.APROBADORES_REQUISICION();
            foreach (var r in q)
            {
                ConstruirEmailAprobadores(IdRequisicion, Int32.Parse(r.ID_EMPLEADO.ToString()), NombreDeUsuario, r.CORREO_ELECTRONICO);
            }
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(),
             "err_msg",
             "alert('!La Requisición fue creada exitosamente y enviada por correo electrónico para aprobación!');",
             true);
            return;


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
        public void ConstruirEmailAprobadores(Int32 IdRequisicion, Int32 Aprobador, string NombreUsuario, string Destinatarios)
        {
            String Cuerpo = "<html><h1>LA REQUISICIÓN CON NUMERO DE FOLIO: " + IdRequisicion.ToString() + " HA SIDO GENERADA POR: <b>" + NombreUsuario + "</b></h1> <p>A continuación se muestran las partidas de esta solicitud.<p><b>Justificante:</b>" + this.txtJustificacion.Value + "<p><b>Lugar de Entrega:</b>" + this.txtlugarEntrega.Text + "<p><b>Fecha de Entrega:</b>" + this.FechaEntrega.Date;
            Cuerpo = Cuerpo + "<p><table border='1' align='center'><TR><TD align='center'>PARTIDA</TD><TD align='center'>CLAVE DEL MATERIAL</TD><TD align='center'>DESCRIPCIÓN</TD><TD align='center'>UNIDAD DE MEDIDA</TD><TD align='center'>CANTIDAD</TD><TD align='center'>PRECIO UNITARIO</TD><TD align='center'>IMPORTE</TD></TR>";

            for (int i = 0; i <= this.ASPxGridView1.VisibleRowCount - 1; i++)
            {
                Cuerpo = Cuerpo + "<TR><TD align='center'>" + this.ASPxGridView1.GetRowValues(i, "CONTEO").ToString() + "</TD><TD align='center'>" + this.ASPxGridView1.GetRowValues(i, "ID_ITEM").ToString() + "</TD><TD align='center'>" + this.ASPxGridView1.GetRowValues(i, "DESCRIPCION").ToString() + "</TD><TD align='center'>" + this.ASPxGridView1.GetRowValues(i, "UNIDAD").ToString() + "</TD><TD align='center'>" + this.ASPxGridView1.GetRowValues(i, "CANTIDAD").ToString() + "</TD><TD align='center'>" + String.Format(new CultureInfo("es-MX"), "{0:C}", this.ASPxGridView1.GetRowValues(i, "COSTO_UNITARIO").ToString()) + "</TD><TD align='center'>" + String.Format(new CultureInfo("es-MX"), "{0:C}", this.ASPxGridView1.GetRowValues(i, "IMPORTE").ToString()) + "</TD></TR>";
            }

            Cuerpo = Cuerpo + "</table><p><a href='" + System.Configuration.ConfigurationManager.AppSettings["Sitio"].ToString() + "AprobacionesMoviles.aspx?ID_REQUEST=" + IdRequisicion.ToString() + "&ID_EMPLEADO=" + Aprobador.ToString() + "'> APROBAR </a>    " + "&nbsp;<a href='" + System.Configuration.ConfigurationManager.AppSettings["Sitio"].ToString() + "RechazarMoviles.aspx?ID_REQUEST=" + IdRequisicion.ToString() + "&ID_EMPLEADO=" + Aprobador.ToString() + "'> RECHAZAR </a></html>";
            MailMessage msg = new MailMessage();
            msg.From = new MailAddress("sifica@musebe.com.mx","SIFICA", System.Text.Encoding.UTF8);
            //msg.From = new MailAddress("Notificaciones@akaaljinspection.com.mx", "SIFICA", System.Text.Encoding.UTF8);
            msg.Subject = "APROBACIÓN DE REQUISICIÓN";
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
        public void ConstruirEmailRequisitor(Int32 IdRequisicion, string NombreUsuario, string Destinatarios)
        {
            String Cuerpo = "<html><h1>!Estimado: <b>" + NombreUsuario + "</b> Su Requisición con numero de folio <b>: " + IdRequisicion.ToString() + "</b> ha sido enviada a Aprobación! </h1>" + "<h2> Tan pronto se halla aprobado se le notificara via correo electronico, puede accesar de igual forma al sistema para ver el status de la misma!</h2></html>";
            MailMessage msg = new MailMessage();
            msg.From = new MailAddress("sifica@musebe.com.mx","SIFICA", System.Text.Encoding.UTF8);
            //msg.From = new MailAddress("Notificaciones@akaaljinspection.com.mx", "SIFICA", System.Text.Encoding.UTF8);
            msg.Subject = "REQUISICIÓN EN APROBACIÓN";
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
        protected void ASPxGridView1_AfterPerformCallback(object sender, DevExpress.Web.ASPxGridViewAfterPerformCallbackEventArgs e)
        {
            SIFICADataContext db = new SIFICADataContext();
            this.ASPxGridView1.DataSource = db.REQUISICION_TEMPORALES_CONSULTAR_USUARIO(Int32.Parse(Session["Compañia"].ToString()), this.User.Identity.Name.ToString());
            this.ASPxGridView1.DataBind();
        }
        protected void ASPxButton3_Click(object sender, EventArgs e)
        {
            CancelarSolicitudRequisicion();
        }
        public void CancelarSolicitudRequisicion()
        {
            try
            {
                SIFICADataContext DB = new SIFICADataContext();
                DB.REQUISICIONES_LIMPIAR_PARTIDAS(this.User.Identity.Name.ToString(), Int32.Parse(Session["Compañia"].ToString()));
                DB.SubmitChanges();

                this.ASPxGridView1.DataSource = DB.REQUISICION_TEMPORALES_CONSULTAR_USUARIO(Int32.Parse(Session["Compañia"].ToString()), this.User.Identity.Name.ToString());
                this.ASPxGridView1.DataBind();
                this.txtCantidad.Text = string.Empty;
                this.txtItem.Text = string.Empty;

                this.PopupAlerta.ShowOnPageLoad = false;
            }
            catch (Exception ex) { ex.ToString(); }
        }
        public void Limpiar()
        {
            try
            {
                this.ASPxGridView1.DataBind();
                this.txtJustificacion.Value = string.Empty;
                this.FechaEntrega.Text = "";
            }
            catch (Exception ex) { ex.ToString(); }
        }
        protected void lnkModificar_Click(object sender, EventArgs e)
        {
            try
            {
                this.txtItem.Text = string.Empty;
                this.txtCantidad.Text = string.Empty;
                this.txtPrecioUnitario.Text = string.Empty;
                this.txtItem.Text = this.ASPxGridView1.GetRowValues(this.ASPxGridView1.FocusedRowIndex, "DESCRIPCION").ToString();
                this.txtCantidad.Text = this.ASPxGridView1.GetRowValues(this.ASPxGridView1.FocusedRowIndex, "CANTIDAD").ToString();
                this.txtPrecioUnitario.Text = this.ASPxGridView1.GetRowValues(this.ASPxGridView1.FocusedRowIndex, "COSTO_UNITARIO").ToString();
            }
            catch (Exception ex) { ex.ToString(); }
        }
        protected void lnkEliminar_Click(object sender, EventArgs e)
        {
            try
            {
                SIFICADataContext db = new SIFICADataContext();
                db.REQUISICION_TEMPORAL_ELIMINA_PARTIDAS(Int32.Parse(this.ASPxGridView1.GetRowValues(this.ASPxGridView1.FocusedRowIndex, "ID_PARTIDA").ToString()));
                db.SubmitChanges();

                this.ASPxGridView1.DataSource = db.REQUISICION_TEMPORALES_CONSULTAR_USUARIO(Int32.Parse(Session["Compañia"].ToString()), this.User.Identity.Name.ToString());
                this.ASPxGridView1.DataBind();
                this.txtCantidad.Text = string.Empty;
                this.txtItem.Text = string.Empty;
            }
            catch (Exception ex) { ex.ToString(); }

        }
        public void GenerarDocumentoRequisicion(Int32 IdRequisicion)
        {
            try
            {
                this.ReportViewer1.ProcessingMode = ProcessingMode.Local;
                LocalReport report = new LocalReport();
                report.EnableExternalImages = true;
                report.ReportPath = "Requisicion.rdlc";

                DataTable ds = DatosRequisicion(IdRequisicion);
                DataTable dslogo = ObtenerLogoEmpresa(IdRequisicion);

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
        public DataTable ObtenerLogoEmpresa(Int32 ID_REQUISICION)
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
                com.Parameters.AddWithValue("@ID_REQUISICION", ID_REQUISICION);
                com.CommandTimeout = 0;
                com.ExecuteNonQuery();
                SqlDataAdapter Datos = new SqlDataAdapter(com);
                Datos.Fill(Requsicion);
                con.Close();
            }
            catch (Exception ex) { ex.ToString(); }
            return Requsicion;
        }
        protected void grdAprobaciones_AfterPerformCallback(object sender, DevExpress.Web.ASPxGridViewAfterPerformCallbackEventArgs e)
        {
            ConsultarMisRequisiciones();
        }

        protected void btnEditar_Click(object sender, EventArgs e)
        {
            try
            {
                MostrarItemsRequisicion();
                this.PopupAlerta.ShowOnPageLoad = false;
            }
            catch (Exception ex) { ex.ToString(); }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            CancelarSolicitudRequisicion();
        }

        protected void btnEnviarAprobacion_Click(object sender, EventArgs e)
        {
            try
            {
                SIFICADataContext db = new SIFICADataContext();
                db.REQUISICIONES_INSERTAR(this.User.Identity.Name.ToString(), this.txtJustificacion.Value, this.txtlugarEntrega.Text, this.FechaEntrega.Date, Int32.Parse(this.cboCtroCosto.SelectedItem.Value.ToString()), this.fileCotizacion.FileName.ToString(), Int32.Parse(Session["Compañia"].ToString()), Int32.Parse(this.cboProveedor.SelectedItem.Value.ToString()));
                db.SubmitChanges();

                var query = db.REQUISICIONES_OBTENER_ID(this.User.Identity.Name.ToString(), Int32.Parse(Session["Compañia"].ToString()));
                Int32 Id = 0;

                foreach (var r in query)
                {
                    Id = Int32.Parse(r.ID_REQUISICION.ToString());
                }

                if (this.fileCotizacion.HasFile)
                {
                    string targetPath = Server.MapPath("Cotizaciones/" + this.fileCotizacion.FileName.ToString());
                    if (File.Exists(targetPath))
                    {
                        File.Delete(targetPath);
                    }
                    this.fileCotizacion.PostedFile.SaveAs(targetPath);
                }
                EnviarCorreoAprobadores(2, Id);
                EnviarCorreoRequisitor(Id);


                SIFICADataContext DB = new SIFICADataContext();


                this.ASPxGridView1.DataSource = DB.REQUISICION_TEMPORALES_CONSULTAR_USUARIO(Int32.Parse(Session["Compañia"].ToString()), this.User.Identity.Name.ToString());
                this.ASPxGridView1.DataBind();
                this.txtCantidad.Text = string.Empty;
                this.txtItem.Text = string.Empty;
                this.txtlugarEntrega.Text = string.Empty;
                this.cboCtroCosto.SelectedIndex = -1;
                this.cboProveedor.SelectedIndex = -1;

                Limpiar();

            }
            catch (Exception ex) { ex.ToString(); }
        }

        protected void btnGuardarItem_Click(object sender, EventArgs e)
        {
            SIFICADataContext db = new SIFICADataContext();
            db.ITEMS_INSERTAR(this.txtDescripcionItem.Value, Int32.Parse(cboUnidadMedia.SelectedItem.Value.ToString()), Int32.Parse(cboClasificacion.SelectedItem.Value.ToString()), Int32.Parse(this.cboGiro.SelectedItem.Value.ToString()), this.txtNumeroParte.Text, true, Int32.Parse(Session["Compañia"].ToString()), Decimal.Parse(this.txtMaximo.Text), decimal.Parse(this.txtMinimo.Text),this.chkInventariable.Checked);
            //lblItem.Text = "Item Agregado";
            //lblItem.Visible = true;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "popupAddItemClose", "popupAddItemClose();", false);
        }

        //protected void lnkDetalle_Click(object sender, EventArgs e)
        //{
        //    GenerarDocumentoRequisicion(Int32.Parse(this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_REQUEST").ToString()));
        //    this.popupReporte.ShowOnPageLoad = true;
        //}

        //protected void lnkOtros_Click(object sender, EventArgs e)
        //{
        //    try
        //    {

        //    }
        //    catch (Exception ex) { ex.ToString(); }
        //}

        protected void btnMisRequisiciones_Click(object sender, EventArgs e)
        {

            ConsultarMisRequisiciones();
            this.popupHistorialRequisiciones.ShowOnPageLoad = true;
        }

        public void ConsultarMisRequisiciones()
        {
            try
            {
                SIFICADataContext db = new SIFICADataContext();
                this.grdAprobaciones.DataSource = db.REQUICIONES_OR_TODOS_DATOS_USUARIO(this.Page.User.Identity.Name.ToString());
                this.grdAprobaciones.DataBind();
            }
            catch (Exception ex) { ex.ToString(); }
        }

        protected void btnAbrir_Click(object sender, EventArgs e)
        {
            GenerarDocumentoRequisicion(Int32.Parse(this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_REQUEST").ToString()));
            this.popupReporte.ShowOnPageLoad = true;
        }

        //protected void lnkRefrescarLista_Click(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        this.cboProveedor.DataBind();
        //    }
        //    catch (Exception ex) { ex.ToString(); }
        //}

        //protected void grdProveedores_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        //{
        //    this.cboProveedor.DataBind();
        //}

        //protected void grdProveedores_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        //{
        //    this.cboProveedor.DataBind();
        //}
    }
}