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

namespace SISGRES
{
    public partial class CuadroComparativo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void cboRequisicion_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.grdRequisicionesPartidas.DataBind();
        }

        protected void btnCapturarCotizacion_Click(object sender, EventArgs e)
        {
            popupCotizaciones.ShowOnPageLoad = true;
            Session["ID_PARTIDA"] = this.grdRequisicionesPartidas.GetRowValues(this.grdRequisicionesPartidas.FocusedRowIndex, "ID_DETALLE_REQUISICION").ToString();
            this.grdRequisicionesPartidas.DataBind();
        }
        
        protected void grdRequisicionesPartidas_DetailRowExpandedChanged1(object sender, DevExpress.Web.ASPxGridViewDetailRowEventArgs e)
        {
            try
            {
                this.grdRequisicionesPartidas.FocusedRowIndex = e.VisibleIndex;
                Session["ID_PARTIDA"] = this.grdRequisicionesPartidas.GetRowValues(this.grdRequisicionesPartidas.FocusedRowIndex, "ID_DETALLE_REQUISICION").ToString();
                this.grdRequisicionesPartidas.DataBind();
            }
            catch (Exception ex) { ex.ToString(); }
        }

        protected void btnComparativo_Click(object sender, EventArgs e)
        {
            try
            {
                this.popupReporte.ShowOnPageLoad = true;

                this.ReportViewer1.ProcessingMode = ProcessingMode.Local;
                LocalReport report = new LocalReport();
                report.EnableExternalImages = true;
                report.ReportPath = "ComparativoPrecios.rdlc";


                DataTable dslogo = ObtenerLogoEmpresa();
                DataTable ds = DatosRequisicionMateriales();

                ReportDataSource logo = new ReportDataSource();
                logo.Name = "ObtenerLogoEmpresa";
                logo.Value = dslogo;

                ReportDataSource dsMain = new ReportDataSource();
                dsMain.Name = "ComparativoMateriales";
                dsMain.Value = ds;


                report.DataSources.Clear();
                report.DataSources.Add(dsMain);
                report.DataSources.Add(logo);

                report.Refresh();
                this.ReportViewer1.Visible = true;
                this.ReportViewer1.LocalReport.ReportPath = Server.MapPath("ComparativoPrecios.rdlc");
                this.ReportViewer1.LocalReport.DataSources.Clear();
                this.ReportViewer1.LocalReport.DataSources.Add(dsMain);
                this.ReportViewer1.LocalReport.DataSources.Add(logo);

                //this.ReportViewer1.LocalReport.SetParameters(new ReportParameter[] { p1, p2, p3, p4, p5, p6, p7, p8 });

                this.ReportViewer1.DocumentMapCollapsed = true;
                this.ReportViewer1.LocalReport.Refresh();

            }
            catch (Exception ex) { ex.ToString(); }
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
                com.Parameters.AddWithValue("@ID_REQUISICION", Int32.Parse(this.cboRequisicion.SelectedItem.Value.ToString()));
                com.CommandTimeout = 0;
                com.ExecuteNonQuery();
                SqlDataAdapter Datos = new SqlDataAdapter(com);
                Datos.Fill(Requsicion);
                con.Close();
            }
            catch (Exception ex) { ex.ToString(); }
            return Requsicion;
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
                com.CommandText = "REPORTE_COMAPARTIVO_MATERIALES";
                com.Parameters.AddWithValue("@ID_REQUISICION", this.cboRequisicion.SelectedItem.Value.ToString());
                com.CommandTimeout = 0;
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