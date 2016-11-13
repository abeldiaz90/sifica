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
    public partial class SolicitudEgresos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ASPxButton2_Click(object sender, EventArgs e)
        {
            try
            {
                SIFICADataContext db = new SIFICADataContext();
                this.cboConcepto.DataBind();
                Int32 Proyecto = 0;
                if (string.IsNullOrEmpty(this.cboProyecto.Text))
                {
                    Proyecto = 0;
                }
                else
                {
                    Proyecto = Int32.Parse(this.cboProyecto.SelectedItem.Value.ToString());
                }


                if (this.cboMoneda.SelectedIndex == 0)
                {
                    db.EGRESOS_INSERTAR(Decimal.Parse(this.txtMonto.Text), this.cboMoneda.SelectedItem.Text.ToString(), Int32.Parse(this.cboConcepto.SelectedItem.Value.ToString()), 0, "", this.fechaSolicitud.Date, Solicitante(), Autorizador(), RecibidoPor(), this.cboBeneficiario.SelectedItem.Text, Int32.Parse(Session["Compañia"].ToString()), 0, Proyecto, null, null, 1, this.txtObservaciones.Text);
                    db.SubmitChanges();
                }
                else if (this.cboMoneda.SelectedIndex == 1)
                {
                    db.EGRESOS_INSERTAR(0, this.cboMoneda.SelectedItem.Text.ToString(), Int32.Parse(this.cboConcepto.SelectedItem.Value.ToString()), 0, "", this.fechaSolicitud.Date, Solicitante(), Autorizador(), RecibidoPor(), this.cboBeneficiario.SelectedItem.Text, Int32.Parse(Session["Compañia"].ToString()), Decimal.Parse(this.txtMonto.Text), Proyecto, null, null, 1, this.txtObservaciones.Text);
                    db.SubmitChanges();
                }
                ImprimirHoja();
                Limpiarhojas();

            }
            catch (Exception ex) { ex.ToString(); }
        }

        public void Limpiarhojas()
        {
            this.cboBeneficiario.SelectedIndex = -1;
            this.cboMoneda.SelectedIndex = -1;
            this.cboProyecto.SelectedIndex = -1;
            this.cboConcepto.SelectedIndex = -1;
            this.txtObservaciones.Text = string.Empty;
            this.txtMonto.Text = string.Empty;
        }

        public void ImprimirHoja()
        {
            try
            {
                this.popupDetalle.ShowOnPageLoad = true;
                this.ReportViewer1.ProcessingMode = ProcessingMode.Local;
                LocalReport report = new LocalReport();
                report.EnableExternalImages = true;
                report.ReportPath = "SolicitudChequesOTransferencias.rdlc";

                SIFICADataContext db = new SIFICADataContext();
                var query = db.EGRESOS_OBTENER_FOLIO_SOLICITUD(this.User.Identity.Name.ToString());
                Int32 ID_EGRESO = 0;
                foreach (var qu in query)
                {
                    ID_EGRESO = qu.Column1.Value;
                }

                DataTable ds = ObtenerDatosSolicitud(ID_EGRESO);
                DataTable dslogo = ObtenerLogoEmpresa();


                ReportDataSource dsMain = new ReportDataSource();
                dsMain.Name = "EgresosObtenerDatos";
                dsMain.Value = ds;

                ReportDataSource logo = new ReportDataSource();
                logo.Name = "ObtenerLogoEmpresa";
                logo.Value = dslogo;


                report.DataSources.Clear();
                report.DataSources.Add(dsMain);
                report.DataSources.Add(logo);


                report.Refresh();

                ReportParameter p1 = new ReportParameter();
                if (ds.Rows[0]["MONEDA"].ToString() == "MXN")
                {
                    p1 = new ReportParameter("letras", enletras(ds.Rows[0]["IMPORTE"].ToString()));
                }
                else if (ds.Rows[0]["MONEDA"].ToString() == "USD")
                {
                    p1 = new ReportParameter("letras", enletras(ds.Rows[0]["IMPORTE_USD"].ToString()));
                }
                this.ReportViewer1.Visible = true;
                this.ReportViewer1.LocalReport.ReportPath = Server.MapPath("SolicitudChequesOTransferencias.rdlc");
                this.ReportViewer1.LocalReport.DataSources.Clear();
                this.ReportViewer1.LocalReport.DataSources.Add(dsMain);
                this.ReportViewer1.LocalReport.DataSources.Add(logo);


                this.ReportViewer1.LocalReport.SetParameters(new ReportParameter[] { p1 });

                this.ReportViewer1.DocumentMapCollapsed = true;
                this.ReportViewer1.ShowPrintButton = true;
                this.ReportViewer1.LocalReport.Refresh();

            }
            catch (Exception ex) { ex.ToString(); }
        }

        public DataTable ObtenerDatosSolicitud(Int32 Solicitud)
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
                com.CommandText = "EGRESO_OBTENER_DATOS";
                com.Parameters.AddWithValue("@ID_EGRESO", Solicitud);
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

        public string enletras(string num)
        {

            string res, dec = "";

            Int64 entero;

            int decimales;

            double nro;

            try
            {
                nro = Convert.ToDouble(num);
            }

            catch
            {
                return "";
            }

            entero = Convert.ToInt64(Math.Truncate(nro));
            decimales = Convert.ToInt32(Math.Round((nro - entero) * 100, 2));

            SIFICADataContext db = new SIFICADataContext();
            var query = db.EGRESOS_OBTENER_FOLIO_SOLICITUD(this.User.Identity.Name.ToString());
            Int32 ID_EGRESO = 0;
            foreach (var qu in query)
            {
                ID_EGRESO = qu.Column1.Value;
            }


            DataTable ds = ObtenerDatosSolicitud(ID_EGRESO);
            if (ds.Rows[0]["MONEDA"].ToString() == "MXN")
            {
                if (decimales > 0 && decimales < 10)
                {
                    dec = " PESOS 00" + decimales.ToString() + "/100 MONEDA NACIONAL";
                }
                else { dec = " PESOS " + decimales.ToString() + "/100 MONEDA NACIONAL"; }
            }
            else if (ds.Rows[0]["MONEDA"].ToString() == "USD")
            {
                if (decimales > 0 && decimales < 10)
                {
                    dec = " DOLARES 00" + decimales.ToString() + "/100 USD";
                }
                else { dec = " DOLARES " + decimales.ToString() + "/100 USD"; }
            }

            res = toText(Convert.ToDouble(entero)) + dec;

            return res;

        }

        private string toText(double value)
        {
            string Num2Text = "";
            value = Math.Truncate(value);
            if (value == 0) Num2Text = "CERO";

            else if (value == 1) Num2Text = "UNO";

            else if (value == 2) Num2Text = "DOS";

            else if (value == 3) Num2Text = "TRES";

            else if (value == 4) Num2Text = "CUATRO";

            else if (value == 5) Num2Text = "CINCO";

            else if (value == 6) Num2Text = "SEIS";

            else if (value == 7) Num2Text = "SIETE";

            else if (value == 8) Num2Text = "OCHO";

            else if (value == 9) Num2Text = "NUEVE";

            else if (value == 10) Num2Text = "DIEZ";

            else if (value == 11) Num2Text = "ONCE";

            else if (value == 12) Num2Text = "DOCE";

            else if (value == 13) Num2Text = "TRECE";

            else if (value == 14) Num2Text = "CATORCE";

            else if (value == 15) Num2Text = "QUINCE";

            else if (value < 20) Num2Text = "DIECI" + toText(value - 10);

            else if (value == 20) Num2Text = "VEINTE";

            else if (value < 30) Num2Text = "VEINTI" + toText(value - 20);

            else if (value == 30) Num2Text = "TREINTA";

            else if (value == 40) Num2Text = "CUARENTA";

            else if (value == 50) Num2Text = "CINCUENTA";

            else if (value == 60) Num2Text = "SESENTA";

            else if (value == 70) Num2Text = "SETENTA";

            else if (value == 80) Num2Text = "OCHENTA";

            else if (value == 90) Num2Text = "NOVENTA";

            else if (value < 100) Num2Text = toText(Math.Truncate(value / 10) * 10) + " Y " + toText(value % 10);

            else if (value == 100) Num2Text = "CIEN";

            else if (value < 200) Num2Text = "CIENTO " + toText(value - 100);

            else if ((value == 200) || (value == 300) || (value == 400) || (value == 600) || (value == 800)) Num2Text = toText(Math.Truncate(value / 100)) + "CIENTOS";

            else if (value == 500) Num2Text = "QUINIENTOS";

            else if (value == 700) Num2Text = "SETECIENTOS";

            else if (value == 900) Num2Text = "NOVECIENTOS";

            else if (value < 1000) Num2Text = toText(Math.Truncate(value / 100) * 100) + " " + toText(value % 100);

            else if (value == 1000) Num2Text = "MIL";

            else if (value < 2000) Num2Text = "MIL " + toText(value % 1000);

            else if (value < 1000000)
            {

                Num2Text = toText(Math.Truncate(value / 1000)) + " MIL";

                if ((value % 1000) > 0) Num2Text = Num2Text + " " + toText(value % 1000);

            }

            else if (value == 1000000) Num2Text = "UN MILLON";

            else if (value < 2000000) Num2Text = "UN MILLON " + toText(value % 1000000);

            else if (value < 1000000000000)
            {

                Num2Text = toText(Math.Truncate(value / 1000000)) + " MILLONES ";

                if ((value - Math.Truncate(value / 1000000) * 1000000) > 0) Num2Text = Num2Text + " " + toText(value - Math.Truncate(value / 1000000) * 1000000);

            }

            else if (value == 1000000000000) Num2Text = "UN BILLON";

            else if (value < 2000000000000) Num2Text = "UN BILLON " + toText(value - Math.Truncate(value / 1000000000000) * 1000000000000);

            else
            {

                Num2Text = toText(Math.Truncate(value / 1000000000000)) + " BILLONES";

                if ((value - Math.Truncate(value / 1000000000000) * 1000000000000) > 0) Num2Text = Num2Text + " " + toText(value - Math.Truncate(value / 1000000000000) * 1000000000000);

            }

            return Num2Text;

        }

        public Int32 Solicitante()
        {
            Int32 Numero = 0;
            SIFICADataContext db = new SIFICADataContext();
            var query = db.EMPLEADO_OBTENER_NOMBRE_USUARIO(this.User.Identity.Name.ToString());
            foreach (var datos in query)
            {
                Numero = datos.ID_EMPLEADO;
            }
            return Numero;
        }


        public Int32 Autorizador()
        {
            Int32 Numero = 0;
            SIFICADataContext db = new SIFICADataContext();
            var query = db.APROBADOR_TRANSACCIONES_OBTENER_ID();
            foreach (var Datos in query)
            {
                Numero = Datos.ID_EMPLEADO.Value;
            }
            return Numero;
        }

        public Int32 RecibidoPor()
        {
            Int32 Numero = 0;
            SIFICADataContext db = new SIFICADataContext();
            var query = db.TRANSACCIONES_RECIBIDO_OBTENER_ID();
            foreach (var Datos in query)
            {
                Numero = Datos.ID_EMPLEADO.Value;
            }
            return Numero;
        }
    }
}