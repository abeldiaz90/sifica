using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Microsoft.Reporting.WebForms;
using System.Data.SqlClient;
using System.Configuration;

namespace SISGRES
{
    public partial class AprobacionSolicitudesEgreso : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //this.cbosolicitudCheque.DisplayFormatString = "{3:C2}";
        }

        protected void ASPxButton2_Click(object sender, EventArgs e)
        {

        }

        protected void ASPxButton2_Click1(object sender, EventArgs e)
        {

        }

        protected void cboTipoTransaccion_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                if (this.cboTipoTransaccion.SelectedItem.Value.ToString() == "1")
                {
                    this.ASPxLabel9.Text = "NUMERO DE CHEQUE:";
                }
                else if (this.cboTipoTransaccion.SelectedItem.Value.ToString() == "2")
                {
                    this.ASPxLabel9.Text = "FOLIO DE TRANSFERENCIA:";
                }
                this.txtFolioTransaccion.Focus();
            }
            catch (Exception ex) { ex.ToString(); }
        }

        protected void cboEstado_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cboEstado.SelectedIndex == 0)
            {
                this.cboCuentaBancaria.DataBind();
                this.cboCuentaBancaria.ReadOnly = false;
                this.cboTipoTransaccion.ReadOnly = false;
                this.txtFolioTransaccion.ReadOnly = false;
            }
            else if (cboEstado.SelectedIndex == 1)
            {
                this.cboCuentaBancaria.ReadOnly = true;
                this.cboTipoTransaccion.ReadOnly = true;
                this.txtFolioTransaccion.ReadOnly = true;
            }
            this.cboCuentaBancaria.Focus();
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                if (this.cboEstado.SelectedIndex == 0)
                {
                    SIFICADataContext db = new SIFICADataContext();
                    db.EGRESOS_MODIFICAR_STATUS(Int32.Parse(this.cbosolicitudCheque.SelectedItem.Value.ToString()), 2, Int32.Parse(this.cboTipoTransaccion.SelectedItem.Value.ToString()), this.txtFolioTransaccion.Text, Int32.Parse(this.cboCuentaBancaria.SelectedItem.Value.ToString()), this.fechaPago.Date);
                    db.SubmitChanges();
                    this.pnlSolicitudes.Visible = false;
                }
                else if (this.cboEstado.SelectedIndex == 1)
                {
                    SIFICADataContext db = new SIFICADataContext();
                    db.EGRESOS_MODIFICAR_STATUS(Int32.Parse(this.cbosolicitudCheque.SelectedItem.Value.ToString()), 3, null, null, null, null);
                    db.SubmitChanges();
                    this.pnlSolicitudes.Visible = false;
                }
                this.cbosolicitudCheque.DataBind();
            }
            catch (Exception ex) { ex.ToString(); }
        }

        protected void cbosolicitudCheque_SelectedIndexChanged(object sender, EventArgs e)
        {
            Buscar();
        }

        public void Buscar() 
        {

            this.pnlSolicitudes.Visible = true;
            SIFICADataContext db = new SIFICADataContext();
            var query = db.EGRESO_OBTENER_DATOS(Int32.Parse(this.cbosolicitudCheque.SelectedItem.Value.ToString()));

            foreach (var q in query)
            {
                this.cboMoneda.Items.FindByText(q.MONEDA).Selected = true;
                this.cboBeneficiario.DataBind();
                this.cboBeneficiario.Items.FindByText(q.BENEFICIARIO.ToString()).Selected = true;
                this.cboProyecto.DataBind();
                this.cboProyecto.Items.FindByValue(q.ID_PROYECTO.ToString()).Selected = true;
                this.cboConcepto.DataBind();
                this.cboConcepto.Items.FindByText(q.CONCEPTO.ToString()).Selected = true;
                this.fechaSolicitud.Date = q.FECHA_OPERACION.Value;
                this.fechaPago.Date = q.FECHA_OPERACION.Value;

                if (q.MONEDA.ToString() == "MXN")
                {
                    this.txtMonto.Text = q.IMPORTE.Value.ToString();
                }
                else if (q.MONEDA.ToString() == "USD")
                {
                    this.txtMonto.Text = q.IMPORTE_USD.Value.ToString();
                }

                if (q.ESTADO == 2)
                {
                    this.cboCuentaBancaria.DataBind();
                    this.cboCuentaBancaria.Items.FindByValue(q.ID_CUENTA.ToString()).Selected = true;
                    this.cboCuentaBancaria.ReadOnly = true;
                    this.cboEstado.Items.FindByValue("1").Selected = true;
                    this.cboEstado.ReadOnly = true;
                    this.cboTipoTransaccion.Items.FindByValue(q.TIPO.Value.ToString()).Selected = true;
                    this.cboTipoTransaccion.ReadOnly = true;
                    this.txtFolioTransaccion.Text = q.FOLIO;
                    this.txtFolioTransaccion.ReadOnly = true;
                    this.btnGuardar.Visible = false;
                }
                else if (q.ESTADO == 1)
                {
                    this.cboCuentaBancaria.DataBind();
                    this.cboCuentaBancaria.SelectedIndex = -1;
                    this.cboEstado.ReadOnly = false;
                    this.txtFolioTransaccion.Text = string.Empty;
                    this.txtFolioTransaccion.ReadOnly = true;
                    this.cboEstado.SelectedIndex = -1;
                    this.cboTipoTransaccion.SelectedIndex = -1;
                    this.btnGuardar.Visible = true;
                }
                else if (q.ESTADO == 3)
                {
                    //this.cboCuentaBancaria.DataBind();
                    //this.cboCuentaBancaria.Items.FindByValue(q.ID_CUENTA.ToString()).Selected = true;
                    this.cboCuentaBancaria.ReadOnly = true;
                    this.cboEstado.Items.FindByValue("2").Selected = true;
                    this.cboEstado.ReadOnly = true;
                    this.cboTipoTransaccion.ReadOnly = true;
                    //this.cboTipoTransaccion.Items.FindByValue(q.TIPO.Value.ToString()).Selected = true;
                    //this.txtFolioTransaccion.Text = q.FOLIO;
                    this.btnGuardar.Visible = false;
                }


            }
        }

        protected void imgEditar_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                this.imgEditar.Visible = false;
                this.imgGuardar.Visible = true;
                this.imgCancelar.Visible = true;
                this.cboProyecto.ReadOnly = false;
                this.cboMoneda.ReadOnly = false;
                this.cboBeneficiario.ReadOnly = false;
                this.txtMonto.ReadOnly = false;
                this.cboConcepto.ReadOnly = false;
            }
            catch (Exception ex) { ex.ToString(); }

        }

        protected void imgGuardar_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                this.imgEditar.Visible = true;
                this.imgGuardar.Visible = false;
                this.imgCancelar.Visible = false;
                this.cboProyecto.ReadOnly = true;
                this.cboMoneda.ReadOnly = true;
                this.cboBeneficiario.ReadOnly = true;
                this.txtMonto.ReadOnly = true;
                this.cboConcepto.ReadOnly = true;
                SIFICADataContext db = new SIFICADataContext();
                db.EGRESOS_MODIFICAR_SOLICITUDES(Int32.Parse(this.cbosolicitudCheque.SelectedItem.Value.ToString()), Int32.Parse(this.cboProyecto.SelectedItem.Value.ToString()), this.cboMoneda.SelectedItem.Text, this.cboBeneficiario.Text, Decimal.Parse(this.txtMonto.Text), Int32.Parse(this.cboConcepto.SelectedItem.Value.ToString()));
                db.SubmitChanges();
                Buscar();
            }
            catch (Exception ex) { ex.ToString(); }
        }

        protected void imgCancelar_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                this.imgEditar.Visible = true;
                this.imgGuardar.Visible = false;
                this.imgCancelar.Visible = false;
                this.cboProyecto.ReadOnly = true;
                this.cboMoneda.ReadOnly = true;
                this.cboBeneficiario.ReadOnly = true;
                this.txtMonto.ReadOnly = true;
                this.cboConcepto.ReadOnly = true;
                Buscar();
            }
            catch (Exception ex) { ex.ToString(); }
        }

        protected void imgReporte_Click(object sender, ImageClickEventArgs e)
        {

        }

        protected void imgReporte_Click1(object sender, ImageClickEventArgs e)
        {
            this.popupSolicitudes.ShowOnPageLoad = true;

        }

     

        protected void ASPxButton2_Click3(object sender, EventArgs e)
        {
            this.popupSolicitudes.Maximized = true;
            this.popupSolicitudes.ShowOnPageLoad = true;
            this.grdSolicitudes.Visible = true;
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

                //SIFICADataContext db = new SIFICADataContext();
                //var query = db.EGRESOS_OBTENER_FOLIO_SOLICITUD(this.User.Identity.Name.ToString());
                //Int32 ID_EGRESO = 0;
                //foreach (var qu in query)
                //{
                //    ID_EGRESO = qu.Column1.Value;
                //}

                DataTable ds = ObtenerDatosSolicitud(Int32.Parse(this.grdSolicitudes.GetRowValues(this.grdSolicitudes.FocusedRowIndex, "ID_EGRESO").ToString()));
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

        protected void imgReporte_Click2(object sender, ImageClickEventArgs e)
        {
            this.popupDetalle.ShowOnPageLoad = true;
            ImprimirHoja();
        }




    }
}