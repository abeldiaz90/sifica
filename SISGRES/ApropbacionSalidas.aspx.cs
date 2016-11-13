using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SISGRES
{
    public partial class ApropbacionSalidas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnDetalle_Click(object sender, EventArgs e)
        {
            GenerarDocumentoRequisicion(Int32.Parse(this.grdSolicitudes.GetRowValues(this.grdSolicitudes.FocusedRowIndex, "ID_SALIDA").ToString()));
        }

        public void GenerarDocumentoRequisicion(Int32 IdRequisicion)
        {
            try
            {
                this.ASPxPopupControl1.ShowOnPageLoad = true;

                this.ReportViewer1.ProcessingMode = ProcessingMode.Local;
                LocalReport report = new LocalReport();
                report.EnableExternalImages = true;
                report.ReportPath = "SalidaAlmacen.rdlc";

                DataTable ds = DatosSalida(IdRequisicion);
                DataTable dslogo = ObtenerLogoEmpresa();

                ReportDataSource dsMain = new ReportDataSource();
                dsMain.Name = "SALIDAS_REPORTE";
                dsMain.Value = ds;

                ReportDataSource logo = new ReportDataSource();
                logo.Name = "ObtenerLogoEmpresa";
                logo.Value = dslogo;


                report.DataSources.Clear();
                report.DataSources.Add(dsMain);
                report.DataSources.Add(logo);
                report.Refresh();

                this.ReportViewer1.Visible = true;
                this.ReportViewer1.LocalReport.ReportPath = Server.MapPath("SalidaAlmacen.rdlc");
                this.ReportViewer1.LocalReport.DataSources.Clear();
                this.ReportViewer1.LocalReport.DataSources.Add(dsMain);
                this.ReportViewer1.LocalReport.DataSources.Add(logo);

                this.ReportViewer1.DocumentMapCollapsed = true;
                this.ReportViewer1.ShowPrintButton = true;
                this.ReportViewer1.LocalReport.Refresh();
            }
            catch (Exception ex) { ex.ToString(); }
        }

        public DataTable DatosSalida(Int32 IdSalida)
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
                com.CommandText = "SALIDAS_REPORTE";
                com.Parameters.AddWithValue("@id_Salida", IdSalida);
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
                com.CommandText = "OBTENER_LOGO_COMPAÑIA_POR_USUARIO";
                com.Parameters.AddWithValue("@usuario", this.Page.User.Identity.Name.ToString());
                com.CommandTimeout = 0;
                com.ExecuteNonQuery();
                SqlDataAdapter Datos = new SqlDataAdapter(com);
                Datos.Fill(Requsicion);
                con.Close();
            }
            catch (Exception ex) { ex.ToString(); }
            return Requsicion;
        }

        protected void btnAprobar_Click(object sender, EventArgs e)
        {
            try
            {
                SIFICADataContext db = new SIFICADataContext();
                db.SOLICITUDES_SALIDA_APROBAR(Int32.Parse(this.grdSolicitudes.GetRowValues(this.grdSolicitudes.FocusedRowIndex, "ID_SALIDA").ToString()));
                this.grdSolicitudes.DataBind();
            }
            catch (Exception ex) { ex.ToString(); }
        }
    }
}