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
    public partial class Salidas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                this.txtItem.Focus();
                this.txtItem.Style["text-align"] = "center";
                if (!Page.IsPostBack)
                {
                    //SIFICADataContext db = new SIFICADataContext();
                    //var q = db.REQUISICION_TEMPORALES_CONSULTAR_USUARIO(Int32.Parse(Session["Compañia"].ToString()), this.User.Identity.Name.ToString());
                    //if (q.Count() >= 1)
                    //{
                    //    PopupAlerta.ShowOnPageLoad = true;
                    //}


                }
            }
            catch (Exception ex) { ex.ToString(); }

        }

        protected void Agregar_Click(object sender, EventArgs e)
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
                        db.SALIDAS_INSERTAR(this.txtItem.Text, Decimal.Parse(this.txtCantidad.Text), this.Page.User.Identity.Name.ToString(), this.chkDevolucion.Checked);
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
        //public void MostrarItemsRequisicion()
        //{
        //    SIFICADataContext db = new SIFICADataContext();
        //    this.ASPxGridView1.DataSource = db.REQUISICION_TEMPORALES_CONSULTAR_USUARIO(Int32.Parse(Session["Compañia"].ToString()), this.User.Identity.Name.ToString());
        //    this.ASPxGridView1.DataBind();
        //    this.txtCantidad.Text = string.Empty;
        //    this.txtItem.Text = string.Empty;
        //    this.txtPrecioUnitario.Text = string.Empty;
        //}

        protected void btnEnviarRequisicion_Click(object sender, EventArgs e)
        {
            this.popupSalidas.ShowOnPageLoad = true;
            //this.popupEnvioRequisicion.ShowOnPageLoad = true;
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "EnvioRequisicion", "EnvioRequisicion();", true);
        }

        public void EnviarCorreoAprobadores(Int32 NivelAprobacion, Int32 IdRequisicion)
        {
            SIFICADataContext db = new SIFICADataContext();

            String NombreDeUsuario = "";
            String CorreoElectronico = "";
            var NombreUsuario = db.EMPLEADO_OBTENER_NOMBRE_USUARIO(this.User.Identity.Name.ToString());
            foreach (var Nombre in NombreUsuario)
            {
                NombreDeUsuario = Nombre.NOMBRE;
                CorreoElectronico = Nombre.CORREO_ELECTRONICO;
            }


            var q = db.OBTENER_APROBADORES_REQUISICION(2);

            String Destinatarios = "";
            foreach (var r in q)
            {
                Destinatarios = r.DESTINATARIOS;
            }

            String Cuerpo = "<html><h1>LA REQUISICIÓN CON NUMERO DE FOLIO: " + IdRequisicion.ToString() + " HA SIDO GENERADA POR: " + NombreDeUsuario + "</h1> <p>SE ENVIA PARA SU REVISION Y APROBACION. <a href='http://sifica-001-site6.smarterasp.net/AprobacionesRequisicionesMateriales.aspx'> HAGA CLICK PARA INGRESAR AL MODULO DE COMPRAS PARA REALIZAR LA APROBACION </a>";
            Cuerpo = Cuerpo + "<p><table border='1' align='center'><TR><TD align='center'>PARTIDA</TD><TD align='center'>CLAVE DEL MATERIAL</TD><TD align='center'>DESCRIPCIÓN</TD><TD align='center'>UNIDAD DE MEDIDA</TD><TD align='center'>CANTIDAD</TD><TD align='center'>PRECIO UNITARIO</TD><TD align='center'>IMPORTE</TD></TR>";


            for (int i = 0; i <= this.grdSalidas.VisibleRowCount - 1; i++)
            {
                Cuerpo = Cuerpo + "<TR><TD align='center'>" + this.grdSalidas.GetRowValues(i, "CONTEO").ToString() + "</TD><TD align='center'>" + this.grdSalidas.GetRowValues(i, "ID_ITEM").ToString() + "</TD><TD align='center'>" + this.grdSalidas.GetRowValues(i, "DESCRIPCION").ToString() + "</TD><TD align='center'>" + this.grdSalidas.GetRowValues(i, "UNIDAD").ToString() + "</TD><TD align='center'>" + this.grdSalidas.GetRowValues(i, "CANTIDAD").ToString() + "</TD><TD align='center'>" + String.Format(new CultureInfo("es-MX"), "{0:C}", this.grdSalidas.GetRowValues(i, "COSTO_UNITARIO").ToString()) + "</TD><TD align='center'>" + String.Format(new CultureInfo("es-MX"), "{0:C}", this.grdSalidas.GetRowValues(i, "IMPORTE").ToString()) + "</TD></TR>";
            }

            Cuerpo = Cuerpo + "</table></html>";
            MailMessage msg = new MailMessage();
            msg.From = new MailAddress("sifica@musebe.com.mx","SIFICA", System.Text.Encoding.UTF8);
            msg.Subject = "APROBACIÓN DE REQUISICIÓN";
            msg.To.Add(FormatMultipleEmailAddresses(Destinatarios));
            msg.CC.Add(CorreoElectronico);
            msg.SubjectEncoding = System.Text.Encoding.UTF8;
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
                        "alert('!La Requisición fue creada exitosamente y enviada por correo electrónico para aprobación!');",
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

        protected void ASPxButton2_Click(object sender, EventArgs e)
        {
            //try
            //{
            //    SIFICADataContext db = new SIFICADataContext();
            //    db.REQUISICIONES_MATERIALES_INSERTAR(this.User.Identity.Name.ToString(), this.cboProyectos.Text, this.txtLugarEntrega.Text, this.FechaEntrega.Date);
            //    db.SubmitChanges();

            //    var query = db.REQUISICIONES_MATERIALES_OBTENER_ID(this.User.Identity.Name.ToString());
            //    Int32 Id = 0;

            //    foreach (var r in query)
            //    {
            //        Id = Int32.Parse(r.ID_REQUISICION.ToString());
            //    }

            //    for (int i = 0; i <= this.ASPxGridView1.VisibleRowCount - 1; i++)
            //    {
            //        db.REQUISICIONES_MATERIALES_DETALLES_INSERTAR(Id, Int32.Parse(this.ASPxGridView1.GetRowValues(i, "ID_MATERIAL").ToString()), Decimal.Parse(this.ASPxGridView1.GetRowValues(i, "CANTIDAD").ToString()));
            //        db.SubmitChanges();
            //    }

            //    this.popupEnvioRequisicion.ShowOnPageLoad = false;
            //    EnviarCorreo(2, Id);


            //    SIFICADataContext DB = new SIFICADataContext();
            //    DB.REQUISICIONES_LIMPIAR_PARTIDAS(this.User.Identity.Name.ToString(), Int32.Parse(Session["Compañia"].ToString()));
            //    DB.SubmitChanges();

            //    this.ASPxGridView1.DataSource = DB.REQUISICION_TEMPORALES_CONSULTAR_USUARIO(Int32.Parse(Session["Compañia"].ToString()), this.User.Identity.Name.ToString());
            //    this.ASPxGridView1.DataBind();
            //    this.txtCantidad.Text = string.Empty;
            //    this.txtItem.Text = string.Empty;

            //    Limpiar();

            //}
            //catch (Exception ex) { ex.ToString(); }
        }

        private string FormatMultipleEmailAddresses(string emailAddresses)
        {
            var delimiters = new[] { ',', ';' };

            var addresses = emailAddresses.Split(delimiters, StringSplitOptions.RemoveEmptyEntries);

            return string.Join(",", addresses);
        }

        protected void ASPxGridView1_AfterPerformCallback(object sender, DevExpress.Web.ASPxGridViewAfterPerformCallbackEventArgs e)
        {
            //SIFICADataContext db = new SIFICADataContext();
            //this.ASPxGridView1.DataSource = db.REQUISICION_TEMPORALES_CONSULTAR_USUARIO(Int32.Parse(Session["Compañia"].ToString()), this.User.Identity.Name.ToString());
            //this.ASPxGridView1.DataBind();
        }



        protected void ASPxButton3_Click(object sender, EventArgs e)
        {
            CancelarSolicitudRequisicion();
            this.grdSalidas.DataBind();
        }


        public void CancelarSolicitudRequisicion()
        {
            try
            {
                Limpiar();
                this.cboCtroCosto.SelectedIndex = -1;
                this.cboCtroCosto.Text = string.Empty;
                this.cboEmpleados.SelectedIndex = -1;
                this.cboEmpleados.Text = string.Empty;

                SIFICADataContext DB = new SIFICADataContext();
                DB.SALIDAS_CANCELAR();
                DB.SubmitChanges();




            }
            catch (Exception ex) { ex.ToString(); }
        }
        public void Limpiar()
        {
            try
            {
                //Session["TablaDatos"] = null;
                this.txtItem.Text = string.Empty;
                this.txtCantidad.Text = string.Empty;
                this.txtItem.Text = string.Empty;
                this.grdSalidas.DataBind();
                this.chkDevolucion.Checked = false;
                //this.txtJustificacion.Value = string.Empty;
                ////this.cboProyectos.SelectedIndex = 0;
                //this.FechaEntrega.Text = "";
            }
            catch (Exception ex) { ex.ToString(); }
        }

        protected void lnkModificar_Click(object sender, EventArgs e)
        {
            //try
            //{
            //    this.txtItem.Text = string.Empty;
            //    this.txtCantidad.Text = string.Empty;
            //    this.txtPrecioUnitario.Text = string.Empty;
            //    this.txtItem.Text = this.ASPxGridView1.GetRowValues(this.ASPxGridView1.FocusedRowIndex, "DESCRIPCION").ToString();
            //    this.txtCantidad.Text = this.ASPxGridView1.GetRowValues(this.ASPxGridView1.FocusedRowIndex, "CANTIDAD").ToString();
            //    this.txtPrecioUnitario.Text = this.ASPxGridView1.GetRowValues(this.ASPxGridView1.FocusedRowIndex, "COSTO_UNITARIO").ToString();
            //    //this.Agregar.Enabled = false;
            //    //this.imgGuardar.Visible = true;
            //}
            //catch (Exception ex) { ex.ToString(); }
        }

        protected void lnkEliminar_Click(object sender, EventArgs e)
        {
            try
            {
                SIFICADataContext db = new SIFICADataContext();
                db.REQUISICION_TEMPORAL_ELIMINA_PARTIDAS(Int32.Parse(this.grdSalidas.GetRowValues(this.grdSalidas.FocusedRowIndex, "ID_PARTIDA").ToString()));
                db.SubmitChanges();

                this.grdSalidas.DataSource = db.REQUISICION_TEMPORALES_CONSULTAR_USUARIO(Int32.Parse(Session["Compañia"].ToString()), this.User.Identity.Name.ToString());
                this.grdSalidas.DataBind();
                this.txtCantidad.Text = string.Empty;
                this.txtItem.Text = string.Empty;

                //DataTable Datos = (DataTable)(Session["TablaDatos"]);
                //DataRow[] customerRow = Datos.Select("ID_PARTIDA = '" + this.ASPxGridView1.GetRowValues(this.ASPxGridView1.FocusedRowIndex, "ID_PARTIDA").ToString() + "'");

                //Datos.Rows.Remove(customerRow[0]);

                //Session["TablaDatos"] = Datos;

                //this.ASPxGridView1.DataSource = (DataTable)(Session["TablaDatos"]);
                //this.ASPxGridView1.DataBind();

                //this.txtItem.Text = string.Empty;
                //this.txtCantidad.Text = string.Empty;

            }
            catch (Exception ex) { ex.ToString(); }

        }

        //protected void imgGuardar_Click(object sender, ImageClickEventArgs e)
        //{
        //    try
        //    {
        //        if (Double.Parse(this.txtCantidad.Text) > 0)
        //        {
        //            this.imgGuardar.Visible = false;
        //            this.Agregar.Enabled = true;
        //            SIFICADataContext DB = new SIFICADataContext();
        //            DB.REQUISICIONES_MATERIALES_ACTUALIZA_PARTIDAS(Int32.Parse(this.ASPxGridView1.GetRowValues(this.ASPxGridView1.FocusedRowIndex, "ID_PARTIDA").ToString()), this.txtItem.Text, float.Parse(this.txtCantidad.Text));
        //            DB.SubmitChanges();
        //            MostrarItemsRequisicion();
        //        }
        //    }
        //    catch (Exception ex) { ex.ToString(); }
        //}

        protected void ASPxMenu1_ItemClick(object source, DevExpress.Web.MenuItemEventArgs e)
        {
            //if (e.Item.Name == "Catalogo")
            //{
            //    this.popupRequisiciones.ShowOnPageLoad = true;
            //}
            //else if (e.Item.Name == "Historial")
            //{
            //    SIFICADataContext db = new SIFICADataContext();
            //    this.grdAprobaciones.DataSource = db.REQUISICIONES_MATERIALES_MOSTRAR_POR_USUARIO(this.User.Identity.Name.ToString());
            //    this.grdAprobaciones.DataBind();
            //    this.popupHistorialRequisiciones.ShowOnPageLoad = true;
            //}
        }

        //protected void lnkDetalle_Click(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        this.popupReporte.ShowOnPageLoad = true;

        //        this.ReportViewer1.ProcessingMode = ProcessingMode.Local;
        //        LocalReport report = new LocalReport();
        //        report.EnableExternalImages = true;
        //        report.ReportPath = "RequisicionMateriales.rdlc";

        //        DataTable ds = DatosRequisicionMateriales();
        //        DataTable dslogo = ObtenerLogoEmpresa();

        //        ReportDataSource dsMain = new ReportDataSource();
        //        dsMain.Name = "RequisicionesMaterialesDetalle";
        //        dsMain.Value = ds;

        //        ReportDataSource logo = new ReportDataSource();
        //        logo.Name = "ObtenerLogoEmpresa";
        //        logo.Value = dslogo;


        //        report.DataSources.Clear();
        //        report.DataSources.Add(dsMain);
        //        report.DataSources.Add(logo);
        //        report.Refresh();

        //        this.ReportViewer1.Visible = true;
        //        this.ReportViewer1.LocalReport.ReportPath = Server.MapPath("RequisicionMateriales.rdlc");
        //        this.ReportViewer1.LocalReport.DataSources.Clear();
        //        this.ReportViewer1.LocalReport.DataSources.Add(dsMain);
        //        this.ReportViewer1.LocalReport.DataSources.Add(logo);

        //        this.ReportViewer1.DocumentMapCollapsed = true;
        //        this.ReportViewer1.ShowPrintButton = true;
        //        this.ReportViewer1.LocalReport.Refresh();
        //    }
        //    catch (Exception ex) { ex.ToString(); }
        //}

        //public DataTable DatosRequisicionMateriales()
        //{
        //DataTable Requsicion = new DataTable();
        //try
        //{
        //    SqlConnection con = new SqlConnection();
        //    con.ConnectionString = ConfigurationManager.ConnectionStrings["SIFICA"].ToString();
        //    con.Open();
        //    SqlCommand com = new SqlCommand();
        //    com.Connection = con;
        //    com.CommandType = CommandType.StoredProcedure;
        //    com.CommandText = "REQUISICIONES_MATERIALES_MOSTRAR_A_DETALLE_USUARIO";
        //    com.Parameters.AddWithValue("@ID_REQUISICION", this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_REQUISICION").ToString());
        //    com.CommandTimeout = 0;
        //    com.ExecuteNonQuery();
        //    SqlDataAdapter Datos = new SqlDataAdapter(com);
        //    Datos.Fill(Requsicion);
        //    con.Close();
        //}
        //catch (Exception ex) { ex.ToString(); }
        //return Requsicion;
        //}

        //public DataTable ObtenerLogoEmpresa()
        //{
        //    DataTable Requsicion = new DataTable();
        //    try
        //    {
        //        SqlConnection con = new SqlConnection();
        //        con.ConnectionString = ConfigurationManager.ConnectionStrings["SIFICA"].ToString();
        //        con.Open();
        //        SqlCommand com = new SqlCommand();
        //        com.Connection = con;
        //        com.CommandType = CommandType.StoredProcedure;
        //        com.CommandText = "REQUISICION_OBTENER_LOGO_EMPRESA";
        //        com.Parameters.AddWithValue("@ID_REQUISICION", Int32.Parse(this.grdAprobaciones.GetRowValues(this.grdAprobaciones.FocusedRowIndex, "ID_REQUISICION").ToString()));
        //        com.CommandTimeout = 0;
        //        com.ExecuteNonQuery();
        //        SqlDataAdapter Datos = new SqlDataAdapter(com);
        //        Datos.Fill(Requsicion);
        //        con.Close();
        //    }
        //    catch (Exception ex) { ex.ToString(); }
        //    return Requsicion;
        //}

        protected void grdAprobaciones_AfterPerformCallback(object sender, DevExpress.Web.ASPxGridViewAfterPerformCallbackEventArgs e)
        {
            //SIFICADataContext db = new SIFICADataContext();
            //this.grdAprobaciones.DataSource = db.REQUISICIONES_MATERIALES_MOSTRAR_POR_USUARIO(this.User.Identity.Name.ToString());
            //this.grdAprobaciones.DataBind();
        }

        protected void btnEditar_Click(object sender, EventArgs e)
        {
            try
            {
                //MostrarItemsRequisicion();
                //this.PopupAlerta.ShowOnPageLoad = false;
            }
            catch (Exception ex) { ex.ToString(); }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            CancelarSolicitudRequisicion();
        }

        protected void btnEnviarAprobacion_Click(object sender, EventArgs e)
        {
            //try
            //{
            //    SIFICADataContext db = new SIFICADataContext();
            //    db.REQUISICIONES_INSERTAR(this.User.Identity.Name.ToString(), this.txtJustificacion.Value, this.txtlugarEntrega.Text, System.DateTime.Now, Int32.Parse(this.cboCtroCosto.SelectedItem.Value.ToString()), "", Int32.Parse(Session["Compañia"].ToString()));
            //    db.SubmitChanges();

            //    var query = db.REQUISICIONES_OBTENER_ID(this.User.Identity.Name.ToString(), Int32.Parse(Session["Compañia"].ToString()));
            //    Int32 Id = 0;

            //    foreach (var r in query)
            //    {
            //        Id = Int32.Parse(r.ID_REQUISICION.ToString());
            //    }

            //    //for (int i = 0; i <= this.ASPxGridView1.VisibleRowCount - 1; i++)
            //    //{
            //    //    db.REQUISICIONES_MATERIALES_DETALLES_INSERTAR(Id, Int32.Parse(this.ASPxGridView1.GetRowValues(i, "ID_MATERIAL").ToString()), Decimal.Parse(this.ASPxGridView1.GetRowValues(i, "CANTIDAD").ToString()));
            //    //    db.SubmitChanges();
            //    //}

            //    //ScriptManager.RegisterStartupScript(this, this.GetType(), "EnvioRequisicion", "CierreEnvio();", true);
            //    ////this.popupEnvioRequisicion.ShowOnPageLoad = false;
            //    EnviarCorreoAprobadores(2, Id);


            //    SIFICADataContext DB = new SIFICADataContext();
            //    //DB.REQUISICIONES_LIMPIAR_PARTIDAS(this.User.Identity.Name.ToString(), Int32.Parse(Session["Compañia"].ToString()));
            //    //DB.SubmitChanges();

            //    this.ASPxGridView1.DataSource = DB.REQUISICION_TEMPORALES_CONSULTAR_USUARIO(Int32.Parse(Session["Compañia"].ToString()), this.User.Identity.Name.ToString());
            //    this.ASPxGridView1.DataBind();
            //    this.txtCantidad.Text = string.Empty;
            //    this.txtItem.Text = string.Empty;

            //    Limpiar();

            //}
            //catch (Exception ex) { ex.ToString(); }
        }

        protected void btnGuardarItem_Click(object sender, EventArgs e)
        {
            //SIFICADataContext db = new SIFICADataContext();
            //db.ITEMS_INSERTAR(this.txtDescripcionItem.Value, Int32.Parse(cboUnidadMedia.SelectedItem.Value.ToString()), Int32.Parse(cboClasificacion.SelectedItem.Value.ToString()), Int32.Parse(this.cboGiro.SelectedItem.Value.ToString()), this.txtNumeroParte.Text, true, Int32.Parse(Session["Compañia"].ToString()));
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "popupAddItemClose", "popupAddItemClose();", true);

        }

        protected void btnSalida_Click(object sender, EventArgs e)
        {
            SIFICADataContext db = new SIFICADataContext();
            db.SALIDAS_APROBAR(Int32.Parse(this.cboEmpleados.SelectedItem.Value.ToString()), Int32.Parse(this.cboCtroCosto.SelectedItem.Value.ToString()), this.Page.User.Identity.Name.ToString());
            db.SubmitChanges();
            Limpiar();
            this.cboCtroCosto.SelectedIndex = -1;
            this.cboCtroCosto.Text = string.Empty;
            this.cboEmpleados.SelectedIndex = -1;
            this.cboEmpleados.Text = string.Empty;
            this.popupSalidas.ShowOnPageLoad = false;
        }
    }
}