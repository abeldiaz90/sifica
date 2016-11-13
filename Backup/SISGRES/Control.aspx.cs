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
    public partial class Control : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
         

        }

        protected void cboCuenta_SelectedIndexChanged(object sender, EventArgs e)
        {
            LlenarReporte();
        }

        public void LlenarReporte()
        {
            try
            {
                this.ReportViewer1.ProcessingMode = ProcessingMode.Local;
                LocalReport report = new LocalReport();
                report.EnableExternalImages = true;
                report.ReportPath = "ReporteControl.rdlc";

                DataTable ds = DatosRequisicionMateriales();


                ReportDataSource dsMain = new ReportDataSource();
                dsMain.Name = "ReporteControl";
                dsMain.Value = ds;

                DataTable dslogo = ObtenerLogoEmpresa();
                ReportDataSource logo = new ReportDataSource();
                logo.Name = "Imagen";
                logo.Value = dslogo;


                report.DataSources.Clear();
                report.DataSources.Add(dsMain);
                report.DataSources.Add(logo);


                report.Refresh();
                this.ReportViewer1.Visible = true;
                this.ReportViewer1.LocalReport.ReportPath = Server.MapPath("ReporteControl.rdlc");
                this.ReportViewer1.LocalReport.DataSources.Clear();

                this.ReportViewer1.LocalReport.DataSources.Add(dsMain);
                this.ReportViewer1.LocalReport.DataSources.Add(logo);

                ReportParameter p1 = new ReportParameter("Banco", this.cboCuenta.SelectedItem.GetValue("BANCO").ToString());
                ReportParameter p2 = new ReportParameter("Moneda", this.cboCuenta.SelectedItem.GetValue("MONEDA").ToString());
                ReportParameter p3 = new ReportParameter("Cuenta", this.cboCuenta.SelectedItem.GetValue("CUENTA").ToString());


                this.ReportViewer1.LocalReport.SetParameters(new ReportParameter[] { p1, p2, p3 });

                this.ReportViewer1.DocumentMapCollapsed = true;
                this.ReportViewer1.ShowPrintButton = true;
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
                com.CommandText = "EMPRESAS_OBTENER_LOGO";
                com.Parameters.AddWithValue("@ID_COMPAÑIA", Int32.Parse(Session["Compañia"].ToString()));
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
                com.CommandText = "REPORTE_CONTROL";
                com.Parameters.AddWithValue("@CUENTA", Int32.Parse(this.cboCuenta.SelectedItem.Value.ToString()));
                com.Parameters.AddWithValue("@FECHA", this.PeriodoFinal.Date);
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
            LlenarReporte();
        }


    }
}