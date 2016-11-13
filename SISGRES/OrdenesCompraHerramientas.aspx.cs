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
    public partial class OrdenesCompraHerramientas : System.Web.UI.Page
    {
        SIFICADataContext db = new SIFICADataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            this.grdAprobaciones.DataBind();
        }

        protected void lnkDetalle_Click(object sender, EventArgs e)
        {
            try
            {
                Session["ID_REQUISICION"] = this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_REQUISICION").ToString();
                this.grdDetallesOrdenes.DataBind();
                this.popupDetalle.ShowOnPageLoad = true;

                SIFICADataContext db = new SIFICADataContext();
                var query = db.ORDENES_COMPRAS_HERRAMIENTAS_OBTENER_DATOS_ADICIONALES(Int32.Parse(Session["ID_REQUISICION"].ToString()));
                this.txtConditionesEntrega.Text = string.Empty;
                this.txtConidicionesPago.Text = string.Empty;
                this.txtTimeEntrega.Text = string.Empty;
                this.cboMoneda.SelectedIndex = -1;
                foreach (var i in query)
                {
                    this.cboMoneda.Items.FindByText(i.MONEDA).Selected = true;
                    this.txtConidicionesPago.Text = i.CONDICIONESPAGO;
                    this.txtConditionesEntrega.Text = i.CONDICIONESENTREGA;
                    this.txtTimeEntrega.Text = i.TIEMPOENTREGA;
                }
            }
            catch (Exception ex) { ex.ToString(); }
        }

        public DataTable DatosRequisicionHerramientas()
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
                com.CommandText = "REQUISICIONES_HERRAMIENTAS_MOSTRAR_A_DETALLE";
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

        protected void ASPxButton2_Click(object sender, EventArgs e)
        {
            try
            {
                for (int i = 0; i <= this.grdAprobaciones.VisibleRowCount - 1; i++)
                {
                    if (grdAprobaciones.Selection.IsRowSelected(i))
                    {
                        SIFICADataContext db = new SIFICADataContext();
                        db.REQUSICION_APROBACION_HERRAMIENTAS(Int32.Parse(this.grdAprobaciones.GetRowValues(i, "ID_REQUISICION").ToString()), this.User.Identity.Name.ToString(), "");
                        db.SubmitChanges();
                    }
                }
                this.grdAprobaciones.DataBind();
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
                        db.REQUSICION_RECHAZO_HERRAMIENTAS(Int32.Parse(this.grdAprobaciones.GetRowValues(i, "ID_REQUISICION").ToString()), this.User.Identity.Name.ToString(), "");
                        db.SubmitChanges();
                    }
                }
                this.grdAprobaciones.DataBind();
            }
            catch (Exception ex) { ex.ToString(); }
        }

        protected void ASPxButton2_Click1(object sender, EventArgs e)
        {
            try
            {
                if (this.cboFolio.SelectedItem.Text == "B")
                {
                    for (int i = 0; i <= this.grdProvedoresCotizaciones.VisibleRowCount - 1; i++)
                    {
                        SIFICADataContext DB = new SIFICADataContext();
                        DB.ORDEN_DE_COMPRA_HERRAMIENTAS_ENVIAR_APROBACION(Int32.Parse(Session["ID_REQUISICION"].ToString()), this.User.Identity.Name.ToString(), this.txtComentario.Text, this.cboMoneda.SelectedItem.Text, this.txtConidicionesPago.Text, this.txtConditionesEntrega.Text, this.txtTimeEntrega.Text, Int32.Parse(this.grdProvedoresCotizaciones.GetRowValues(i, "ID_PROOVEDOR").ToString()), this.txtCotizacion.Text, DB.ORDEN_DE_COMPRA_MATERIALES_ENVIAR_APROBACION(Int32.Parse(Session["ID_REQUISICION"].ToString()), this.User.Identity.Name.ToString(), this.txtComentario.Text, this.cboMoneda.SelectedItem.Text, this.txtConidicionesPago.Text, this.txtConditionesEntrega.Text, this.txtTimeEntrega.Text, Int32.Parse(this.grdProvedoresCotizaciones.GetRowValues(i, "ID_PROOVEDOR").ToString()), this.txtCotizacion.Text, float.Parse(this.cboAplicaIVA.SelectedItem.Value.ToString())));
                        DB.SubmitChanges();

                        var OrdenCompra = DB.OBTENER_NUMERO_DE_COMPRA_HERRAMIENTAS(Int32.Parse(Session["ID_REQUISICION"].ToString()), this.User.Identity.Name.ToString());
                        foreach (var J in OrdenCompra)
                        {
                            db.REQUISICIONES_HERRAMIENTAS_ASIGNA_ORDEN_COMPRA(Int32.Parse(Session["ID_REQUISICION"].ToString()), Int32.Parse(this.grdProvedoresCotizaciones.GetRowValues(i, "ID_PROOVEDOR").ToString()), J.ID_ORDEN_COMPRA);
                            DB.SubmitChanges();
                            EnviarCorreo(Session["ID_REQUISICION"].ToString(), Int32.Parse(J.ID_ORDEN_COMPRA.ToString()));
                        }
                    }
                }
                else
                {
                    for (int i = 0; i <= this.grdProvedoresCotizaciones.VisibleRowCount - 1; i++)
                    {
                        SIFICADataContext DB = new SIFICADataContext();
                        DB.ORDEN_DE_COMPRA_HERRAMIENTAS_ENVIAR_APROBACION_FOLIO_A(Int32.Parse(Session["ID_REQUISICION"].ToString()), this.User.Identity.Name.ToString(), this.txtComentario.Text, this.cboMoneda.SelectedItem.Text, this.txtConidicionesPago.Text, this.txtConditionesEntrega.Text, this.txtTimeEntrega.Text, Int32.Parse(this.grdProvedoresCotizaciones.GetRowValues(i, "ID_PROOVEDOR").ToString()), this.txtCotizacion.Text, DB.ORDEN_DE_COMPRA_MATERIALES_ENVIAR_APROBACION(Int32.Parse(Session["ID_REQUISICION"].ToString()), this.User.Identity.Name.ToString(), this.txtComentario.Text, this.cboMoneda.SelectedItem.Text, this.txtConidicionesPago.Text, this.txtConditionesEntrega.Text, this.txtTimeEntrega.Text, Int32.Parse(this.grdProvedoresCotizaciones.GetRowValues(i, "ID_PROOVEDOR").ToString()), this.txtCotizacion.Text, float.Parse(this.cboAplicaIVA.SelectedItem.Value.ToString())));
                        DB.SubmitChanges();

                        var OrdenCompra = DB.OBTENER_NUMERO_DE_COMPRA_HERRAMIENTAS_FOLIO_A(Int32.Parse(Session["ID_REQUISICION"].ToString()), this.User.Identity.Name.ToString());
                        foreach (var J in OrdenCompra)
                        {
                            db.REQUISICIONES_HERRAMIENTAS_ASIGNA_ORDEN_COMPRA_FOLIO_A(Int32.Parse(Session["ID_REQUISICION"].ToString()), Int32.Parse(this.grdProvedoresCotizaciones.GetRowValues(i, "ID_PROOVEDOR").ToString()), J.ID_ORDEN_COMPRA);
                            DB.SubmitChanges();
                            EnviarCorreo(Session["ID_REQUISICION"].ToString(), Int32.Parse(J.ID_ORDEN_COMPRA.ToString()));
                        }
                    }
                }

                Response.Redirect("OrdenesCompraHerramientas.aspx");
            }
            catch (Exception ex) { ex.ToString(); }
        }


        public void EnviarCorreo(String ID_REQUISICION, Int32 ORDEN_COMPRA)
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
            var DatosCreador = db.REQUISICIONES_HERRAMIENTAS_OBTENER_NOMBRE_CREADOR(Int32.Parse(Session["ID_REQUISICION"].ToString()));
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


            MailMessage msg = new MailMessage();
            msg.From = new MailAddress("sifica@musebe.com.mx","Imperio90_1 - Minerales del Mayab", System.Text.Encoding.UTF8);
            msg.Subject = "ORDEN DE COMPRA ENVIADA A APROBACION";
            msg.To.Add(FormatMultipleEmailAddresses(Destinatarios));
            //msg.CC.Add(FormatMultipleEmailAddresses(UsuariosConCopia));
            msg.SubjectEncoding = System.Text.Encoding.UTF8;

            String Cuerpo = "LA ORDEN DE COMPRA DE HERRAMIENTAS CON NUMERO DE FOLIO :  " + ORDEN_COMPRA + " HA SIDO GENERADA POR: " + NombreDeUsuarioQueEstaAprobando + "  PARA SU REVISION Y APROBACION. LA ORDEN DE COMPRA GENERADA CORRESPONDE A LA REQUISICION DE HERRAMIENTAS: " + ID_REQUISICION + "<p> COMENTARIOS: " + this.txtComentario.Text + "</br><p>HAGA CLICK AQUI PARA: <a href=''>APROBAR</a>,       <a href=''>RETORNAR</a> ,           <a href=''>CANCELAR LA ORDEN DE COMPRA</a> ,      <a href='http://sifica-001-site1.smarterasp.net/AprobacionOrdenesCompraHerramientas.aspx'>IR AL SISTEMA</a>";
            DataTable OrdenCompra = new DataTable();
            if (this.cboFolio.SelectedItem.Text == "A")
            {
                OrdenCompra = ObtenerDetalleOrdenCompraFolioA(ORDEN_COMPRA);
            }
            else if (this.cboFolio.SelectedItem.Text == "B")
            {
                OrdenCompra = ObtenerDetalleOrdenCompra(ORDEN_COMPRA);
            }

            Cuerpo = Cuerpo + "<html><p><table border='1' align='center'><TR><TD align='center'>ORDEN DE COMPRA</TD><TD align='center'>HERRAMIENTA</TD><TD align='center'>PROVEEDOR</TD><TD align='center'>REQUISICION</TD><TD align='center'>IMPORTE</TD><TD>MONEDA</TD></TR>";

            for (int i = 0; i <= OrdenCompra.Rows.Count - 1; i++)
            {
                Cuerpo = Cuerpo + "<TR><TD align='center'>" + OrdenCompra.Rows[i]["id_orden_compra"].ToString() + "</TD><TD align='center'>" + OrdenCompra.Rows[i]["herramienta"].ToString() + "</TD><TD align='center'>" + OrdenCompra.Rows[i]["proovedor"].ToString() + "</TD><TD align='center'>" + OrdenCompra.Rows[i]["id_requisicion"].ToString() + "</TD><TD align='center'>" + "$ " + OrdenCompra.Rows[i]["TOTAL"].ToString() + "</TD><TD Align='center'>" + OrdenCompra.Rows[i]["moneda"].ToString() + "</TD></TR>";
            }

            Cuerpo = Cuerpo + "</table></html>";
            msg.Body = Cuerpo;
            msg.BodyEncoding = System.Text.Encoding.UTF8;
            msg.IsBodyHtml = true;

            SmtpClient client = new SmtpClient();
            client.Host = "mail.musebe.com.mx";
            client.Port = 587;
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



        public DataTable ObtenerDetalleOrdenCompra(Int32 OrdenCompra)
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
                com.CommandText = "ORDEN_COMPRA_HERRAMIENTAS_DETALLE_CORREO";
                com.Parameters.AddWithValue("@ID_ORDEN_COMPRA", OrdenCompra);
                com.CommandTimeout = 0;
                com.ExecuteNonQuery();
                SqlDataAdapter Datos = new SqlDataAdapter(com);
                Datos.Fill(Requsicion);
                con.Close();
            }
            catch (Exception ex) { ex.ToString(); }
            return Requsicion;
        }

        public DataTable ObtenerDetalleOrdenCompraFolioA(Int32 OrdenCompra)
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
                com.CommandText = "ORDEN_COMPRA_HERRAMIENTAS_DETALLE_CORREO_FOLIO_A";
                com.Parameters.AddWithValue("@ID_ORDEN_COMPRA", OrdenCompra);
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

        }

        protected void Subir_FileUploadComplete(object sender, DevExpress.Web.FileUploadCompleteEventArgs e)
        {
            try
            {
                String RutaFisica = "";
                if (e.UploadedFile.FileContent != null)
                {
                    string filename = DateTime.Now.Year.ToString() + "" + DateTime.Now.Month.ToString() + "" + DateTime.Now.Day.ToString() + "" + DateTime.Now.Hour.ToString() + "" + DateTime.Now.Minute.ToString() + "" + DateTime.Now.Second.ToString() + "." + e.UploadedFile.FileName.ToString().Split('.')[1].ToString();
                    RutaFisica = "~\\Documentos\\" + filename;
                    string targetPath = Server.MapPath("Documentos/" + filename);
                    e.UploadedFile.SaveAs(targetPath);
                    SIFICADataContext db = new SIFICADataContext();
                    db.DOCUMENTOS_COTIZACIONES_ORDENES_DE_COMPRA_HERRAMIENTAS_INSERTAR(Int32.Parse(Session["ID_REQUISICION"].ToString()), Int32.Parse(this.grdProvedoresCotizaciones.GetRowValues(this.grdProvedoresCotizaciones.FocusedRowIndex, "ID_PROOVEDOR").ToString()), RutaFisica);
                    db.SubmitChanges();
                }

            }
            catch (Exception ex) { ex.ToString(); }
        }

        protected void ASPxButton4_Click(object sender, EventArgs e)
        {
            popupEnvioAprobacion.ShowOnPageLoad = true;
        }
    }
}