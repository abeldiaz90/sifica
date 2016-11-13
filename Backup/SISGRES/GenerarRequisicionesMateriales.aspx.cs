using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Net.Mail;
using System.Net;
using Microsoft.Reporting.WebForms;
using System.Data.SqlClient;
using System.Configuration;

namespace SISGRES
{
    public partial class GenerarRequisicionesMateriales : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.txtItem.Style["text-align"] = "center";
                //Session["TablaDatos"] = null;
            }

        }

        protected void Agregar_Click(object sender, EventArgs e)
        {
            try
            {
                if (Double.Parse(this.txtCantidad.Text) > 0)
                {
                    SIFICADataContext db = new SIFICADataContext();
                    db.REQUISICION_MATERIALES_NUEVA_REQUISICION(this.txtItem.Text, float.Parse(this.txtCantidad.Text), this.User.Identity.Name.ToString());
                    db.SubmitChanges();
                    //if (Session["TablaDatos"] == null)
                    //{
                    //    DataTable TablaMateriales = new DataTable();

                    //    DataColumn column = new DataColumn();
                    //    column.ColumnName = "ID_PARTIDA";
                    //    column.DataType = System.Type.GetType("System.Int32");
                    //    column.AutoIncrement = true;
                    //    column.AutoIncrementSeed = 1;
                    //    column.AutoIncrementStep = 1;



                    //    TablaMateriales.Columns.Add(column);
                    //    TablaMateriales.Columns.Add("ID_MATERIAL", typeof(string));
                    //    TablaMateriales.Columns.Add("MATERIAL", typeof(string));
                    //    TablaMateriales.Columns.Add("UNIDAD", typeof(string));
                    //    TablaMateriales.Columns.Add("CANTIDAD", typeof(string));

                    //    DataRow row = TablaMateriales.NewRow();
                    //    SIFICADataContext db = new SIFICADataContext();
                    //    var query = db.MATERIALES_BUSCAR_ELEMENTOS_POR_DESCRIPCION(this.txtItem.Text);


                    //    foreach (var q in query)
                    //    {
                    //        //row["ID_PARTIDA"] = q.ID_MATERIAL;
                    //        row["ID_MATERIAL"] = q.ID_MATERIAL;
                    //        row["MATERIAL"] = q.MATERIAL;
                    //        row["UNIDAD"] = q.UNIDAD;
                    //        row["CANTIDAD"] = this.txtCantidad.Text;
                    //    }



                    //    TablaMateriales.Rows.Add(row);
                    //    Session["TablaDatos"] = TablaMateriales;


                    //}
                    //else
                    //{
                    //    DataTable TablaMateriales = (DataTable)Session["TablaDatos"];


                    //    SIFICADataContext db = new SIFICADataContext();
                    //    var query = db.MATERIALES_BUSCAR_ELEMENTOS_POR_DESCRIPCION(this.txtItem.Text);


                    //    foreach (var q in query)
                    //    {
                    //        DataRow[] Valida = TablaMateriales.Select("ID_MATERIAL=" + q.ID_MATERIAL);
                    //        if (Valida.Length >= 1)
                    //        {

                    //        }
                    //        else
                    //        {
                    //            DataRow row = TablaMateriales.NewRow();
                    //            //row["ID_PARTIDA"] = q.ID_MATERIAL;
                    //            row["ID_MATERIAL"] = q.ID_MATERIAL;
                    //            row["MATERIAL"] = q.MATERIAL;
                    //            row["UNIDAD"] = q.UNIDAD;
                    //            row["CANTIDAD"] = this.txtCantidad.Text;
                    //            TablaMateriales.Rows.Add(row);
                    //            Session["TablaDatos"] = TablaMateriales;
                    //        }
                    //    }
                    //}
                    this.ASPxGridView1.DataSource = db.REQUISICION_MATERIALES_CONSULTAR_USUARIO(this.User.Identity.Name.ToString());
                    this.ASPxGridView1.DataBind();
                    this.txtCantidad.Text = string.Empty;
                    this.txtItem.Text = string.Empty;
                }
            }

            catch (Exception ex) { ex.ToString(); }
        }

        protected void btnEnviarRequisicion_Click(object sender, EventArgs e)
        {
            this.popupEnvioRequisicion.ShowOnPageLoad = true;
        }

        public void EnviarCorreo(Int32 NivelAprobacion)
        {
            SIFICADataContext db = new SIFICADataContext();
            var query = db.REQUISICIONES_MATERIALES_OBTENER_ID(this.User.Identity.Name.ToString());
            Int32 Id = 0;


            foreach (var r in query)
            {
                Id = Int32.Parse(r.ID_REQUISICION.ToString());
            }


            String NombreDeUsuario = "";
            String CorreoElectronico = "";
            var NombreUsuario = db.EMPLEADO_OBTENER_NOMBRE_USUARIO(this.User.Identity.Name.ToString());
            foreach (var Nombre in NombreUsuario)
            {
                NombreDeUsuario = Nombre.NOMBRE;
                CorreoElectronico = Nombre.CORREO_ELECTRONICO;
            }


            var q = db.OBTENER_DESTINATARIOS(2);

            String Destinatarios = "";
            foreach (var r in q)
            {
                Destinatarios = r.DESTINATARIOS;
            }

            String Cuerpo = "LA REQUISICION DE MATERIALES CON NUMERO DE FOLIO: " + Id.ToString() + " HA SIDO GENERADA POR: " + NombreDeUsuario + " <p>SE ENVIA PARA SU REVISION Y APROBACION. <a href='http://sifica-001-site1.smarterasp.net/AprobacionesRequisicionesMateriales.aspx'> HAGA CLICK PARA INGRESAR AL MODULO DE COMPRAS PARA REALIZAR LA APROBACION </a>";
            Cuerpo = Cuerpo + "<html><p><table border='1' align='center'><TR><TD align='center'>PARTIDA</TD><TD align='center'>CLAVE DEL MATERIAL</TD><TD align='center'>DESCRIPCIÓN</TD><TD align='center'>UNIDAD DE MEDIDA</TD><TD align='center'>CANTIDAD</TD></TR>";

            for (int i = 0; i <= this.ASPxGridView1.VisibleRowCount - 1; i++)
            {
                Cuerpo = Cuerpo + "<TR><TD align='center'>" + this.ASPxGridView1.GetRowValues(i, "ID_PARTIDA").ToString() + "</TD><TD align='center'>" + this.ASPxGridView1.GetRowValues(i, "ID_MATERIAL").ToString() + "</TD><TD align='center'>" + this.ASPxGridView1.GetRowValues(i, "MATERIAL").ToString() + "</TD><TD align='center'>" + this.ASPxGridView1.GetRowValues(i, "UNIDAD").ToString() + "</TD><TD align='center'>" + this.ASPxGridView1.GetRowValues(i, "CANTIDAD").ToString() + "</TD></TR>";

            }

            Cuerpo = Cuerpo + "</table></html>";
            MailMessage msg = new MailMessage();
            msg.From = new MailAddress("sifica@mineralesdelmayab.com", "SIFICA - Minerales del Mayab", System.Text.Encoding.UTF8);
            msg.Subject = "Aprobación de Requisición";
            msg.To.Add(FormatMultipleEmailAddresses(Destinatarios));
            msg.CC.Add(CorreoElectronico);
            msg.SubjectEncoding = System.Text.Encoding.UTF8;
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
            try
            {
                SIFICADataContext db = new SIFICADataContext();
                db.REQUISICIONES_MATERIALES_INSERTAR(this.User.Identity.Name.ToString(), this.cboProyectos.Text, this.txtLugarEntrega.Text, this.FechaEntrega.Date);
                db.SubmitChanges();

                var query = db.REQUISICIONES_MATERIALES_OBTENER_ID(this.User.Identity.Name.ToString());
                Int32 Id = 0;

                foreach (var r in query)
                {
                    Id = Int32.Parse(r.ID_REQUISICION.ToString());
                }

                for (int i = 0; i <= this.ASPxGridView1.VisibleRowCount - 1; i++)
                {
                    db.REQUISICIONES_MATERIALES_DETALLES_INSERTAR(Id, Int32.Parse(this.ASPxGridView1.GetRowValues(i, "ID_MATERIAL").ToString()), Decimal.Parse(this.ASPxGridView1.GetRowValues(i, "CANTIDAD").ToString()));
                    db.SubmitChanges();
                }

                this.popupEnvioRequisicion.ShowOnPageLoad = false;
                EnviarCorreo(2);


                SIFICADataContext DB = new SIFICADataContext();
                DB.REQUISICIONES_LIMPIAR_PARTIDAS(this.User.Identity.Name.ToString());
                DB.SubmitChanges();

                this.ASPxGridView1.DataSource = DB.REQUISICION_MATERIALES_CONSULTAR_USUARIO(this.User.Identity.Name.ToString());
                this.ASPxGridView1.DataBind();
                this.txtCantidad.Text = string.Empty;
                this.txtItem.Text = string.Empty;

                Limpiar();

            }
            catch (Exception ex) { ex.ToString(); }
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
            this.ASPxGridView1.DataSource = db.REQUISICION_MATERIALES_CONSULTAR_USUARIO(this.User.Identity.Name.ToString());
            this.ASPxGridView1.DataBind();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            EnviarCorreo(2);
        }

        protected void ASPxButton3_Click(object sender, EventArgs e)
        {
            SIFICADataContext DB = new SIFICADataContext();
            DB.REQUISICIONES_LIMPIAR_PARTIDAS(this.User.Identity.Name.ToString());
            DB.SubmitChanges();

            this.ASPxGridView1.DataSource = DB.REQUISICION_MATERIALES_CONSULTAR_USUARIO(this.User.Identity.Name.ToString());
            this.ASPxGridView1.DataBind();
            this.txtCantidad.Text = string.Empty;
            this.txtItem.Text = string.Empty;
        }

        public void Limpiar()
        {
            try
            {
                //Session["TablaDatos"] = null;
                this.ASPxGridView1.DataBind();
                this.txtLugarEntrega.Text = string.Empty;
                this.cboProyectos.SelectedIndex = 0;
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
                this.txtItem.Text = this.ASPxGridView1.GetRowValues(this.ASPxGridView1.FocusedRowIndex, "MATERIAL").ToString();
                this.txtCantidad.Text = this.ASPxGridView1.GetRowValues(this.ASPxGridView1.FocusedRowIndex, "CANTIDAD").ToString();
                this.imgGuardar.Visible = true;
            }
            catch (Exception ex) { ex.ToString(); }
        }

        protected void lnkEliminar_Click(object sender, EventArgs e)
        {
            try
            {
                SIFICADataContext db = new SIFICADataContext();
                db.REQUISICION_MATERIALES_ELIMINA_PARTIDAS(Int32.Parse(this.ASPxGridView1.GetRowValues(this.ASPxGridView1.FocusedRowIndex, "ID_PARTIDA").ToString()));
                db.SubmitChanges();

                this.ASPxGridView1.DataSource = db.REQUISICION_MATERIALES_CONSULTAR_USUARIO(this.User.Identity.Name.ToString());
                this.ASPxGridView1.DataBind();
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

        protected void imgGuardar_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                if (Double.Parse(this.txtCantidad.Text) > 0)
                {
                    this.imgGuardar.Visible = false;
                    SIFICADataContext DB = new SIFICADataContext();
                    DB.REQUISICIONES_MATERIALES_ACTUALIZA_PARTIDAS(Int32.Parse(this.ASPxGridView1.GetRowValues(this.ASPxGridView1.FocusedRowIndex,"ID_PARTIDA").ToString()),this.txtItem.Text,float.Parse(this.txtCantidad.Text));
                    DB.SubmitChanges();

                    this.ASPxGridView1.DataSource = DB.REQUISICION_MATERIALES_CONSULTAR_USUARIO(this.User.Identity.Name.ToString());
                    this.ASPxGridView1.DataBind();
                    this.txtCantidad.Text = string.Empty;
                    this.txtItem.Text = string.Empty;
                    

                    //DataTable Datos = (DataTable)(Session["TablaDatos"]);
                    //DataRow[] customerRow = Datos.Select("ID_PARTIDA = '" + this.ASPxGridView1.GetRowValues(this.ASPxGridView1.FocusedRowIndex, "ID_PARTIDA").ToString() + "'");

                    //customerRow[0]["MATERIAL"] = this.txtItem.Text;
                    //customerRow[0]["CANTIDAD"] = this.txtCantidad.Text;

                    //Session["TablaDatos"] = Datos;

                    //this.ASPxGridView1.DataSource = (DataTable)(Session["TablaDatos"]);
                    //this.ASPxGridView1.DataBind();

                    //this.txtItem.Text = string.Empty;
                    //this.txtCantidad.Text = string.Empty;
                    //this.imgGuardar.Visible = false;
                }
            }
            catch (Exception ex) { ex.ToString(); }
        }

        protected void ASPxMenu1_ItemClick(object source, DevExpress.Web.MenuItemEventArgs e)
        {
            if (e.Item.Name == "Catalogo")
            {
                this.popupRequisiciones.ShowOnPageLoad = true;
            }
            else if (e.Item.Name == "Historial")
            {
                SIFICADataContext db = new SIFICADataContext();
                this.grdAprobaciones.DataSource = db.REQUISICIONES_MATERIALES_MOSTRAR_POR_USUARIO(this.User.Identity.Name.ToString());
                this.grdAprobaciones.DataBind();
                this.popupHistorialRequisiciones.ShowOnPageLoad = true;
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
                com.CommandText = "REQUISICIONES_MATERIALES_MOSTRAR_A_DETALLE_USUARIO";
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

        protected void grdAprobaciones_AfterPerformCallback(object sender, DevExpress.Web.ASPxGridViewAfterPerformCallbackEventArgs e)
        {
            SIFICADataContext db = new SIFICADataContext();
            this.grdAprobaciones.DataSource = db.REQUISICIONES_MATERIALES_MOSTRAR_POR_USUARIO(this.User.Identity.Name.ToString());
            this.grdAprobaciones.DataBind();
        }
    }
}