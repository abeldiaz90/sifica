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
    public partial class PronosticosVenta : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ASPxButton2_Click(object sender, EventArgs e)
        {
            this.ASPxGridViewExporter1.WriteXlsxToResponse();
            //this.cboMes.Items.FindByValue(DateTime.Now.Month).Selected = true; ;
            //this.popupReporte.ShowOnPageLoad = true;
        }

        protected void MonthEdit2_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void btnGenerar_Click(object sender, EventArgs e)
        {
            try
            {
                //this.ReportViewer1.ProcessingMode = ProcessingMode.Local;
                //LocalReport report = new LocalReport();
                //report.EnableExternalImages = true;
                //report.ReportPath = "FlujoEfectivo.rdlc";

                //DataTable ds = DatosPronosticoVentas();


                //ReportDataSource dsMain = new ReportDataSource();
                //dsMain.Name = "PronosticoVentas";
                //dsMain.Value = ds;

                //DataTable dslogo = ObtenerLogoEmpresa();
                //ReportDataSource logo = new ReportDataSource();
                //logo.Name = "logo";
                //logo.Value = dslogo;


                //report.DataSources.Clear();
                //report.DataSources.Add(dsMain);
                //report.DataSources.Add(logo);


                //report.Refresh();
                //this.ReportViewer1.Visible = true;
                //this.ReportViewer1.LocalReport.ReportPath = Server.MapPath("FlujoEfectivo.rdlc");
                //this.ReportViewer1.LocalReport.DataSources.Clear();

                //this.ReportViewer1.LocalReport.DataSources.Add(dsMain);
                //this.ReportViewer1.LocalReport.DataSources.Add(logo);

                //ReportParameter p1 = new ReportParameter("MES", this.cboMes.SelectedItem.Text.ToString().ToUpper());
                //ReportParameter p2 = new ReportParameter("AÑO", this.cboAño.SelectedItem.Text.ToString());
                ////ReportParameter p3 = new ReportParameter("Cuenta", this.cboCuenta.SelectedItem.GetValue("CUENTA").ToString());


                //this.ReportViewer1.LocalReport.SetParameters(new ReportParameter[] { p1, p2 });

                //this.ReportViewer1.DocumentMapCollapsed = true;
                //this.ReportViewer1.ShowPrintButton = true;
                //this.ReportViewer1.LocalReport.Refresh();

     

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

        //public DataTable DatosPronosticoVentas()
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
        //        com.CommandText = "PRONOSTICO_VENTAS_REPORTE";
        //        com.Parameters.AddWithValue("@MES",this.cboMes.SelectedItem.Value.ToString());
        //        com.Parameters.AddWithValue("@AÑO", this.cboAño.SelectedItem.Value.ToString());
        //        com.CommandTimeout = 0;
        //        com.ExecuteNonQuery();
        //        SqlDataAdapter Datos = new SqlDataAdapter(com);
        //        Datos.Fill(Requsicion);
        //        con.Close();
        //    }
        //    catch (Exception ex) { ex.ToString(); }
        //    return Requsicion;
        //}


    }
}