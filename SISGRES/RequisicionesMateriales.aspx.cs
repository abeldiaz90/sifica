using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web;
using Microsoft.Reporting.WebForms;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace SISGRES
{
    public partial class RequisicionesMateriales : System.Web.UI.Page
    {

        protected void Page_Init(object sender, EventArgs e)
        {

        }

        protected void grdHerramientas_HtmlDataCellPrepared(object sender, DevExpress.Web.ASPxGridViewTableDataCellEventArgs e)
        {

            //if (e.DataColumn.Name == "Cantidad")
            //{
            //    ASPxTextBox textBox = grdMateriales.FindRowCellTemplateControl(e.VisibleIndex, e.DataColumn, "txtCantidad") as ASPxTextBox;
            //    textBox.Text = Convert.ToString(e.CellValue);
            //}
        }

        protected void txText_Init(object sender, EventArgs e)
        {
            DevExpress.Web.ASPxTextBox textBox = sender as DevExpress.Web.ASPxTextBox;
            DevExpress.Web.GridViewDataItemTemplateContainer container = textBox.NamingContainer as DevExpress.Web.GridViewDataItemTemplateContainer;
            textBox.JSProperties["cpHFKey"] = String.Format("{0}_{1}", container.Column.FieldName, container.KeyValue);
        }



        protected void ASPxButton1_Click(object sender, EventArgs e)
        {
            Response.Redirect("RequisicionesMateriales.aspx");
        }

        protected void btnEnviarAprobación_Click(object sender, EventArgs e)
        {
            try
            {
                SIFICADataContext db = new SIFICADataContext();
                db.REQUISICIONES_MATERIALES_INSERTAR(this.User.Identity.Name.ToString(), this.txtJustificacion.Text,"",null);
                db.SubmitChanges();

                var query = db.REQUISICIONES_MATERIALES_OBTENER_ID(this.User.Identity.Name.ToString());
                Int32 Id = 0;

                foreach (var r in query)
                {
                    Id = Int32.Parse(r.ID_REQUISICION.ToString());
                }

                for (int i = 0; i <= this.grdMateriales.VisibleRowCount -1; i++)
                {
                    DevExpress.Web.ASPxTextBox txtCantidad = ((DevExpress.Web.ASPxTextBox)grdMateriales.FindRowCellTemplateControl(i, grdMateriales.Columns["Cantidad"] as DevExpress.Web.GridViewDataTextColumn, "txtCantidad"));
                    if (!String.IsNullOrEmpty(txtCantidad.Text))
                    {
                        db.REQUISICIONES_MATERIALES_DETALLES_INSERTAR(Id, Int32.Parse(this.grdMateriales.GetRowValues(i, "ID_MATERIAL").ToString()), Int32.Parse(txtCantidad.Text));
                        db.SubmitChanges();
                        this.ASPxPopupControl1.ShowOnPageLoad = true;
                        this.popupJustificante.ShowOnPageLoad = false;
                    }


                }
            }
            catch (Exception ex) { ex.ToString(); }
        }

        protected void imgExportar_Click(object sender, ImageClickEventArgs e)
        {
            this.ASPxGridViewExporter1.WritePdfToResponse();
        }

        protected void imgExcel_Click(object sender, ImageClickEventArgs e)
        {
            this.ASPxGridViewExporter1.WriteXlsToResponse();
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
                com.CommandText = "REQUISICIONES_PREVISUALIZAR";
                com.Parameters.AddWithValue("@USUARIO", this.User.Identity.Name.ToString());
                com.CommandTimeout = 0;
                com.ExecuteNonQuery();
                SqlDataAdapter Datos = new SqlDataAdapter(com);
                Datos.Fill(Requsicion);
                con.Close();
            }
            catch (Exception ex) { ex.ToString(); }
            return Requsicion;
        }

        public DataTable TablaCantidades()
        {
            DataTable Datos = new DataTable();
            Datos.Clear();
            Datos.Columns.Add("ID_DETALLE_REQUISICION");
            Datos.Columns.Add("ID_REQUISICION");
            Datos.Columns.Add("ID_MATERIAL");
            Datos.Columns.Add("CANTIDAD");
            string[] fields = new string[] { "ID_UNIDAD" };

            Int32 Partida = 0;
            for (int i = 0; i <= this.grdMateriales.VisibleRowCount - 1; i++)
            {
                DevExpress.Web.ASPxTextBox txtCantidad = ((DevExpress.Web.ASPxTextBox)grdMateriales.FindRowCellTemplateControl(i, grdMateriales.Columns["Cantidad"] as DevExpress.Web.GridViewDataTextColumn, "txtCantidad"));
                if (!String.IsNullOrEmpty(txtCantidad.Text))
                {
                    Partida = Partida + 1;
                    //string[] text = GetDisplayText(grdHerramientas, i, fields);
                    DataRow _ravi = Datos.NewRow();
                    _ravi["ID_DETALLE_REQUISICION"] = Partida;
                    _ravi["ID_REQUISICION"] = txtCantidad.Text;
                    _ravi["ID_MATERIAL"] = Unidad(this.grdMateriales.GetRowValues(i, "ID_UNIDAD").ToString());
                    _ravi["CANTIDAD"] = this.grdMateriales.GetRowValues(i, "MATERIAL").ToString();

                    Datos.Rows.Add(_ravi);
                }
            }
            return Datos;
        }

        public String Unidad(String ID_UNIDAD)
        {
            DataTable Requis = new DataTable();
            String Unidad = "";
            try
            {
                SqlConnection con = new SqlConnection();
                con.ConnectionString = ConfigurationManager.ConnectionStrings["SIFICA"].ToString();
                con.Open();
                SqlCommand com = new SqlCommand();
                com.Connection = con;
                com.CommandType = CommandType.StoredProcedure;
                com.CommandText = "HERRAMIENTAS_MOSTRAR_DESCRIPCION";
                com.Parameters.AddWithValue("@ID_UNIDAD", ID_UNIDAD);
                com.CommandTimeout = 0;
                com.ExecuteNonQuery();
                SqlDataAdapter Datos = new SqlDataAdapter(com);
                Datos.Fill(Requis);
                Unidad = Requis.Rows[0][0].ToString();
                con.Close();
            }
            catch (Exception ex) { ex.ToString(); }
            return Unidad;
        }

        protected void imgVer_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                this.popupRequisicion.ShowOnPageLoad = true;
                this.ReportViewer1.ProcessingMode = ProcessingMode.Local;
                LocalReport report = new LocalReport();
                report.EnableExternalImages = true;
                report.ReportPath = "VistaPreviaRequisicionMateriales.rdlc";

                DataTable ds = DatosRequisicionMateriales();
                DataTable Cantidades = TablaCantidades();
                // Create a report data source for the sales order data
                ReportParameter p1 = new ReportParameter("Justificacion", this.txtJustificacion.Text);
                //ReportParameter p2 = new ReportParameter("Fecha", this.FechaViaje.Text);
                //ReportParameter p3 = new ReportParameter("Color", this.txtColor.Text);
                //ReportParameter p4 = new ReportParameter("placa", this.txtPlacas.Text);
                //ReportParameter p5 = new ReportParameter("modelo", this.txtModelo.Text);
                //ReportParameter p6 = new ReportParameter("Descripcion", this.txtTipoVehiculo.Text);
                //ReportParameter p7 = new ReportParameter("Observaciones", this.txtObservaciones.Text);
                //ReportParameter p8 = new ReportParameter("Aprobo", this.txtAprobo.Text);

                ReportDataSource dsMain = new ReportDataSource();
                dsMain.Name = "DatosEnacabezado";
                dsMain.Value = ds;

                ReportDataSource Canti = new ReportDataSource();
                Canti.Name = "DatosCantidades";
                Canti.Value = Cantidades;


                report.DataSources.Clear();
                report.DataSources.Add(dsMain);
                report.DataSources.Add(Canti);


                report.Refresh();
                this.ReportViewer1.Visible = true;
                this.ReportViewer1.LocalReport.ReportPath = Server.MapPath("VistaPreviaRequisicionMateriales.rdlc");
                this.ReportViewer1.LocalReport.DataSources.Clear();

                this.ReportViewer1.LocalReport.DataSources.Add(dsMain);
                this.ReportViewer1.LocalReport.DataSources.Add(Canti);

                this.ReportViewer1.LocalReport.SetParameters(new ReportParameter[] { p1 });

                this.ReportViewer1.DocumentMapCollapsed = true;
                this.ReportViewer1.ShowPrintButton = true;
                this.ReportViewer1.LocalReport.Refresh();

            }
            catch (Exception ex) { ex.ToString(); }
        }

        protected void ASPxButton2_Click(object sender, EventArgs e)
        {
            try
            {
                grdMateriales.FilterExpression = string.Empty;
                this.popupRequisicion.ShowOnPageLoad = true;
                this.ReportViewer1.ProcessingMode = ProcessingMode.Local;
                LocalReport report = new LocalReport();
                report.EnableExternalImages = true;
                report.ReportPath = "VistaPreviaRequisicionMateriales.rdlc";

                DataTable ds = DatosRequisicionMateriales();
                DataTable Cantidades = TablaCantidades();
                // Create a report data source for the sales order data
                ReportParameter p1 = new ReportParameter("Justificacion", this.txtJustificacion.Text);
                //ReportParameter p2 = new ReportParameter("Fecha", this.FechaViaje.Text);
                //ReportParameter p3 = new ReportParameter("Color", this.txtColor.Text);
                //ReportParameter p4 = new ReportParameter("placa", this.txtPlacas.Text);
                //ReportParameter p5 = new ReportParameter("modelo", this.txtModelo.Text);
                //ReportParameter p6 = new ReportParameter("Descripcion", this.txtTipoVehiculo.Text);
                //ReportParameter p7 = new ReportParameter("Observaciones", this.txtObservaciones.Text);
                //ReportParameter p8 = new ReportParameter("Aprobo", this.txtAprobo.Text);

                ReportDataSource dsMain = new ReportDataSource();
                dsMain.Name = "DatosEnacabezado";
                dsMain.Value = ds;

                ReportDataSource Canti = new ReportDataSource();
                Canti.Name = "DatosCantidades";
                Canti.Value = Cantidades;


                report.DataSources.Clear();
                report.DataSources.Add(dsMain);
                report.DataSources.Add(Canti);


                report.Refresh();
                this.ReportViewer1.Visible = true;
                this.ReportViewer1.LocalReport.ReportPath = Server.MapPath("VistaPreviaRequisicionMateriales.rdlc");
                this.ReportViewer1.LocalReport.DataSources.Clear();

                this.ReportViewer1.LocalReport.DataSources.Add(dsMain);
                this.ReportViewer1.LocalReport.DataSources.Add(Canti);

                this.ReportViewer1.LocalReport.SetParameters(new ReportParameter[] { p1 });

                this.ReportViewer1.DocumentMapCollapsed = true;
                this.ReportViewer1.ShowPrintButton = true;
                this.ReportViewer1.LocalReport.Refresh();

            }
            catch (Exception ex) { ex.ToString(); }
        }

    

    
    }
}