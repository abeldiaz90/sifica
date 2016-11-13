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
    public partial class Nomina : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void PeriodoInicial_DateChanged(object sender, EventArgs e)
        {

        }

        protected void PeriodoFinal_DateChanged(object sender, EventArgs e)
        {
            InicializarValores(this.PeriodoInicial.Date, this.PeriodoFinal.Date);
        }

        public void InicializarValores(DateTime PeriodoInicial, DateTime PeriodoFinal)
        {
            this.Calendario.SelectedDates.Clear();
            this.PeriodoInicial.Date = PeriodoInicial;
            this.PeriodoFinal.Date = PeriodoFinal;            
            this.Calendario.MinDate = PeriodoInicial;
            this.Calendario.MaxDate = PeriodoFinal;
        }

        protected void cboOpciones_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (this.cboOpciones.SelectedIndex == 0)
            {
                this.pnlNuevaNomina.Visible = true;
                this.pnlHistorico.Visible = false;
            }
            else if (this.cboOpciones.SelectedIndex == 1)
            {
                this.pnlNuevaNomina.Visible = false;
                this.pnlHistorico.Visible = true;
                this.grdHistorico.DataBind();
            }
            this.cboOpciones.SelectedIndex = -1;
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                this.grdHistorico.DataBind();
                Int32 Nomina = Int32.Parse(this.grdHistorico.GetRowValues(this.grdHistorico.FocusedRowIndex, "ID_NOMINA").ToString());
              
                
                SIFICADataContext db = new SIFICADataContext();
               
                this.grdEmpleados.DataSource = db.EMPLEADOS_MOSTRAR_NOMINA(Int32.Parse(Session["Compañia"].ToString()), Nomina, Int32.Parse(this.cboTipoNomina.SelectedItem.Value.ToString()));
                this.grdEmpleados.DataBind();
             
                //Int32 NumeroNomina = 0;
                //var query = db.NOMINA_CONSULTAR_PERIODO(this.PeriodoInicial.Date, this.PeriodoFinal.Date, Int32.Parse(Session["Compañia"].ToString()));
                //var query = db.NOMINA_CONSULTAR_ID_NOMINA(Int32.Parse(this.grdHistorico.GetRowValues(this.grdHistorico.FocusedRowIndex, "ID_NOMINA").ToString()));
                //foreach (var i in query)
                //{
                //    NumeroNomina = i.ID_NOMINA;
                //}

                List<DateTime> selectedDateList = Calendario.SelectedDates.ToList();

                //db.NOMINA_ELIMINAR_DETALLE(Nomina, Int32.Parse(this.grdEmpleados.GetRowValues(this.grdEmpleados.FocusedRowIndex, "ID_EMPLEADO").ToString()));
                db.NOMINA_ELIMINAR_DETALLE(Nomina, Int32.Parse(Session["ID_EMPLEADO"].ToString()));

                for (Int32 i = 0; i <= Calendario.SelectedDates.Count() - 1; i++)
                {
                    db.NOMINA_INSERTAR_DETALLE(Nomina, Int32.Parse(Session["ID_EMPLEADO"].ToString()), selectedDateList[i]);
                    db.SubmitChanges();
                }
                this.popupCalendario.ShowOnPageLoad = false;
                this.grdEmpleados.DataSource = db.EMPLEADOS_MOSTRAR_NOMINA(Int32.Parse(Session["Compañia"].ToString()), Nomina, Int32.Parse(this.cboTipoNomina.SelectedItem.Value.ToString()));
                this.grdEmpleados.DataBind();

            }
            catch (Exception ex) { ex.ToString(); }
        }

        protected void ASPxButton2_Click(object sender, EventArgs e)
        {
            SIFICADataContext db = new SIFICADataContext();
            db.NOMINA_INSERTAR(this.PeriodoInicial.Date, this.PeriodoFinal.Date, Int32.Parse(this.cboTipoNomina.SelectedItem.Value.ToString()), Int32.Parse(Session["Compañia"].ToString()));
            db.SubmitChanges();
            //ObtenerNumeroNomina();
            //LlenarGrid();
            this.pnlNuevaNomina.Visible = false;
            this.pnlHistorico.Visible = true;
            this.grdHistorico.DataBind();
        }

        public void LlenarGrid()
        {          
            SIFICADataContext db = new SIFICADataContext();           
            var query = db.NOMINA_CONSULTAR_ID_NOMINA(Int32.Parse(this.grdHistorico.GetRowValues(this.grdHistorico.FocusedRowIndex, "ID_NOMINA").ToString()));
            //var query = db.NOMINA_CONSULTAR_PERIODO(this.PeriodoInicial.Date, this.PeriodoFinal.Date, Int32.Parse(Session["Compañia"].ToString()));
            Int32 NumeroNomina = 0;
            foreach (var i in query)
            {
                this.lblNomina.Text = "NOMINA NUMERO: " + i.ID_NOMINA.ToString();
                this.cboTipoNomina.Items.FindByValue(i.ID_TIPO.ToString()).Selected = true;

                NumeroNomina = i.ID_NOMINA;
            }

            this.grdEmpleados.DataSource = db.EMPLEADOS_MOSTRAR_NOMINA(Int32.Parse(Session["Compañia"].ToString()), NumeroNomina, Int32.Parse(this.cboTipoNomina.SelectedItem.Value.ToString()));
            this.grdEmpleados.DataBind();
        }

        public void ObtenerNumeroNomina()
        {
            SIFICADataContext db = new SIFICADataContext();
            var query = db.NOMINA_CONSULTAR_PERIODO(this.PeriodoInicial.Date, this.PeriodoFinal.Date, Int32.Parse(Session["Compañia"].ToString()));
            foreach (var i in query)
            {
                this.lblNomina.Text = "NOMINA NUMERO: " + i.ID_NOMINA.ToString();
            }

        }

        protected void btnDiasLaborados_Click(object sender, EventArgs e)
        {
            try
            {
                this.grdHistorico.DataBind();
                this.grdPercepciones.DataBind();
                InicializarValores(this.PeriodoInicial.Date, this.PeriodoFinal.Date);        

                SIFICADataContext db = new SIFICADataContext();
                ////Int32 Nomina = 0;
                ////var query = db.NOMINA_CONSULTAR_ID_NOMINA(Int32.Parse(this.grdHistorico.GetRowValues(this.grdHistorico.FocusedRowIndex, "ID_NOMINA").ToString()));
                ////////var query = db.NOMINA_CONSULTAR_PERIODO(this.PeriodoInicial.Date, this.PeriodoFinal.Date, Int32.Parse(Session["Compañia"].ToString()));
                ////foreach (var i in query)
                ////{
                ////    Nomina = i.ID_NOMINA;
                ////}

                var con = db.NOMINA_DIAS_LABORADOS(Int32.Parse(this.grdHistorico.GetRowValues(this.grdHistorico.FocusedRowIndex, "ID_NOMINA").ToString()), Int32.Parse(this.grdEmpleados.GetRowValues(this.grdEmpleados.FocusedRowIndex, "ID_EMPLEADO").ToString()));
                foreach (var m in con)
                {
                    DateTime Fecha = m.FECHA.Value;
                    this.Calendario.SelectedDates.Add(Fecha);
                }

                
                Session["ID_EMPLEADO"] = Int32.Parse(this.grdEmpleados.GetRowValues(this.grdEmpleados.FocusedRowIndex, "ID_EMPLEADO").ToString());


                this.grdEmpleados.DataSource = db.EMPLEADOS_MOSTRAR_NOMINA(Int32.Parse(Session["Compañia"].ToString()), Int32.Parse(Session["Nomina"].ToString()), Int32.Parse(this.cboTipoNomina.SelectedItem.Value.ToString()));
                this.grdEmpleados.DataBind();

                this.popupCalendario.ShowOnPageLoad = true;
            }
            catch (Exception ex) { ex.ToString(); }

        }

        protected void btnConsultar_Click(object sender, EventArgs e)
        {
            try
            {
                Session["Nomina"] = this.grdHistorico.GetRowValues(this.grdHistorico.FocusedRowIndex, "ID_NOMINA").ToString();
                InicializarValores(Convert.ToDateTime(this.grdHistorico.GetRowValues(this.grdHistorico.FocusedRowIndex, "PERIODO_INICIAL").ToString()), Convert.ToDateTime(this.grdHistorico.GetRowValues(this.grdHistorico.FocusedRowIndex, "PERIODO_FINAL").ToString()));
                LlenarGrid();                
                this.pnlHistorico.Visible = false;
                this.pnlNuevaNomina.Visible = true;
            }
            catch (Exception ex) { ex.ToString(); }
        }

        protected void grdHistorico_AfterPerformCallback(object sender, DevExpress.Web.ASPxGridViewAfterPerformCallbackEventArgs e)
        {

        }

        protected void grdEmpleados_AfterPerformCallback(object sender, DevExpress.Web.ASPxGridViewAfterPerformCallbackEventArgs e)
        {
            SIFICADataContext db = new SIFICADataContext();
            this.grdEmpleados.DataSource = db.EMPLEADOS_MOSTRAR_NOMINA(Int32.Parse(Session["Compañia"].ToString()), Int32.Parse(Session["Nomina"].ToString()), Int32.Parse(this.cboTipoNomina.SelectedItem.Value.ToString()));
            this.grdEmpleados.DataBind();
        }

        protected void btnPrinter_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                this.ReportViewer1.ProcessingMode = ProcessingMode.Local;
                LocalReport report = new LocalReport();
                report.EnableExternalImages = true;
                report.ReportPath = "ReporteNomina.rdlc";

                DataTable ds = DatosNomina();


                ReportDataSource dsMain = new ReportDataSource();
                dsMain.Name = "NominaDatos";
                dsMain.Value = ds;

                DataTable dslogo = ObtenerLogoEmpresa();
                ReportDataSource logo = new ReportDataSource();
                logo.Name = "ObtenerLogoEmpresa";
                logo.Value = dslogo;


                report.DataSources.Clear();
                report.DataSources.Add(dsMain);
                report.DataSources.Add(logo);


                report.Refresh();
                this.ReportViewer1.Visible = true;
                this.ReportViewer1.LocalReport.ReportPath = Server.MapPath("ReporteNomina.rdlc");
                this.ReportViewer1.LocalReport.DataSources.Clear();

                this.ReportViewer1.LocalReport.DataSources.Add(dsMain);
                this.ReportViewer1.LocalReport.DataSources.Add(logo);

                ReportParameter p1 = new ReportParameter("PeriodoInicial", DateTime.Parse(this.grdHistorico.GetRowValues(this.grdHistorico.FocusedRowIndex, "PERIODO_INICIAL").ToString()).ToShortDateString());
                ReportParameter p2 = new ReportParameter("PeriodoFinal", DateTime.Parse(this.grdHistorico.GetRowValues(this.grdHistorico.FocusedRowIndex, "PERIODO_FINAL").ToString()).ToShortDateString());
                //ReportParameter p3 = new ReportParameter("Cuenta", this.cboCuenta.SelectedItem.GetValue("CUENTA").ToString());


                this.ReportViewer1.LocalReport.SetParameters(new ReportParameter[] { p1, p2 });

                this.ReportViewer1.DocumentMapCollapsed = true;
                this.ReportViewer1.ShowPrintButton = true;
                this.ReportViewer1.LocalReport.Refresh();
                this.popupNomina.Maximized = true;
                this.popupNomina.ShowOnPageLoad = true;


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

        public DataTable DatosNomina()
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
                com.CommandText = "EMPLEADOS_MOSTRAR_NOMINA";
                com.Parameters.AddWithValue("@ID_COMPAÑIA", Int32.Parse(Session["Compañia"].ToString()));
                com.Parameters.AddWithValue("@ID_NOMINA", Int32.Parse(this.grdHistorico.GetRowValues(this.grdHistorico.FocusedRowIndex, "ID_NOMINA").ToString()));
                com.Parameters.AddWithValue("@TIPO_PERSONAL", Int32.Parse(this.grdHistorico.GetRowValues(this.grdHistorico.FocusedRowIndex, "ID_TIPO").ToString()));
                com.CommandTimeout = 0;
                com.ExecuteNonQuery();
                SqlDataAdapter Datos = new SqlDataAdapter(com);
                Datos.Fill(Requsicion);
                con.Close();
            }
            catch (Exception ex) { ex.ToString(); }
            return Requsicion;
        }

        protected void btnConsultar_Click1(object sender, EventArgs e)
        {
            try
            {
                this.ReportViewer1.ProcessingMode = ProcessingMode.Local;
                LocalReport report = new LocalReport();
                report.EnableExternalImages = true;
                report.ReportPath = "ReporteNominaFirma.rdlc";

                DataTable ds = DatosNomina();


                ReportDataSource dsMain = new ReportDataSource();
                dsMain.Name = "NominaDatos";
                dsMain.Value = ds;

                DataTable dslogo = ObtenerLogoEmpresa();
                ReportDataSource logo = new ReportDataSource();
                logo.Name = "ObtenerLogoEmpresa";
                logo.Value = dslogo;


                report.DataSources.Clear();
                report.DataSources.Add(dsMain);
                report.DataSources.Add(logo);


                report.Refresh();
                this.ReportViewer1.Visible = true;
                this.ReportViewer1.LocalReport.ReportPath = Server.MapPath("ReporteNominaFirma.rdlc");
                this.ReportViewer1.LocalReport.DataSources.Clear();

                this.ReportViewer1.LocalReport.DataSources.Add(dsMain);
                this.ReportViewer1.LocalReport.DataSources.Add(logo);

                ReportParameter p1 = new ReportParameter("PeriodoInicial", DateTime.Parse(this.grdHistorico.GetRowValues(this.grdHistorico.FocusedRowIndex, "PERIODO_INICIAL").ToString()).ToShortDateString());
                ReportParameter p2 = new ReportParameter("PeriodoFinal", DateTime.Parse(this.grdHistorico.GetRowValues(this.grdHistorico.FocusedRowIndex, "PERIODO_FINAL").ToString()).ToShortDateString());
                //ReportParameter p3 = new ReportParameter("Cuenta", this.cboCuenta.SelectedItem.GetValue("CUENTA").ToString());


                this.ReportViewer1.LocalReport.SetParameters(new ReportParameter[] { p1, p2 });

                this.ReportViewer1.DocumentMapCollapsed = true;
                this.ReportViewer1.ShowPrintButton = true;
                this.ReportViewer1.LocalReport.Refresh();

                this.popupNomina.Maximized = true;
                this.popupNomina.ShowOnPageLoad = true;

            }
            catch (Exception ex) { ex.ToString(); }

        }


    }
}