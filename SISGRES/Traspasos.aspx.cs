using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SISGRES
{
    public partial class Traspasos : System.Web.UI.Page
    {
        SIFICADataContext db = new SIFICADataContext();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void cboCuentaOrigen_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(this.cboCuentaOrigen.Text) && !String.IsNullOrEmpty(this.cboCuentaDestino.Text))
            {
                if (this.cboCuentaOrigen.SelectedItem.Value.ToString() != this.cboCuentaDestino.SelectedItem.Value.ToString())
                {
                    LlenarCamposOrigen(this.cboCuentaOrigen.SelectedItem.Value.ToString());
                    this.pnlTransferencia.Visible = true;
                    this.btnTransferir.Enabled = true;
                    if (this.txtMoneda.Text != this.txtMonedaDestino.Text)
                    {
                        this.cboTipoCambio.Visible = true;
                    }
                    else if (this.txtMoneda.Text == this.txtMonedaDestino.Text)
                    {
                        this.cboTipoCambio.Visible = false;
                    }
                }
                else
                {
                    this.popupMensajeria.ShowOnPageLoad = true;
                    this.lblMensaje.Text = "!LA CUENTA ORIGEN NO PUEDE SER LA MISMA CUENTA DESTINO!";
                    this.cboCuentaOrigen.SelectedIndex = -1;
                    this.txtBancoOrigen.Text = string.Empty;
                    this.txtMoneda.Text = string.Empty;
                    this.txtSaldoActual.Text = string.Empty;
                    this.btnTransferir.Enabled = false;
                }
            }
            else { LlenarCamposOrigen(this.cboCuentaOrigen.SelectedItem.Value.ToString()); }
        }

        public void LlenarCamposOrigen(String Cuenta)
        {
            try
            {
                SIFICADataContext db = new SIFICADataContext();
                var Saldos = db.CUENTAS_BANCARIAS_OBTENER_SALDOS(Int32.Parse(Cuenta));
                foreach (var Datos in Saldos)
                {
                    this.txtBancoOrigen.Text = Datos.BANCO;
                    this.txtMoneda.Text = Datos.MONEDA;
                    this.txtSaldoActual.Text = Datos.SALDO.ToString();
                    if (Convert.ToDecimal(this.txtSaldoActual.Text) < 0)
                    {
                        this.txtSaldoActual.ForeColor = System.Drawing.Color.Red;
                        this.txtSaldoActual.Text = Datos.SALDO.ToString();
                    }
                    else if (Convert.ToDecimal(this.txtSaldoActual.Text) > 0)
                    {
                        this.txtSaldoActual.ForeColor = System.Drawing.Color.Blue;
                        this.txtSaldoActual.Text = Datos.SALDO.ToString();
                    }
                }
            }
            catch (Exception ex) { ex.ToString(); }
        }

        public void LlenarCamposDestino(String Cuenta)
        {
            try
            {
                SIFICADataContext db = new SIFICADataContext();
                var Saldos = db.CUENTAS_BANCARIAS_OBTENER_SALDOS(Int32.Parse(Cuenta));
                foreach (var Datos in Saldos)
                {
                    this.txtBancoDestino.Text = Datos.BANCO;
                    this.txtMonedaDestino.Text = Datos.MONEDA;
                    this.txtSaldoDestino.Text = Datos.SALDO.ToString();

                    if (Convert.ToDecimal(this.txtSaldoDestino.Text) < 0)
                    {
                        this.txtSaldoDestino.ForeColor = System.Drawing.Color.Red;
                        this.txtSaldoDestino.Text = Datos.SALDO.ToString();
                    }
                    else if (Convert.ToDecimal(this.txtSaldoDestino.Text) > 0)
                    {
                        this.txtSaldoDestino.ForeColor = System.Drawing.Color.Blue;
                        this.txtSaldoDestino.Text = Datos.SALDO.ToString();
                    }
                }
            }
            catch (Exception ex) { ex.ToString(); }
        }

        protected void cboCuentaDestino_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(this.cboCuentaOrigen.Text) && !String.IsNullOrEmpty(this.cboCuentaDestino.Text))
            {
                if (this.cboCuentaOrigen.SelectedItem.Value.ToString() != this.cboCuentaDestino.SelectedItem.Value.ToString())
                {
                    LlenarCamposDestino(this.cboCuentaDestino.SelectedItem.Value.ToString());
                    this.pnlTransferencia.Visible = true;
                    this.btnTransferir.Enabled = true;
                    if (this.txtMoneda.Text != this.txtMonedaDestino.Text)
                    {
                        this.cboTipoCambio.Visible = true;
                    }
                    else if (this.txtMoneda.Text == this.txtMonedaDestino.Text)
                    {
                        this.cboTipoCambio.Visible = false;
                    }
                }
                else
                {
                    this.popupMensajeria.ShowOnPageLoad = true;
                    this.lblMensaje.Text = "!LA CUENTA ORIGEN NO PUEDE SER LA MISMA CUENTA DESTINO!";
                    this.cboCuentaDestino.SelectedIndex = -1;
                    this.txtBancoDestino.Text = string.Empty;
                    this.txtMonedaDestino.Text = string.Empty;
                    this.txtSaldoDestino.Text = string.Empty;
                    this.btnTransferir.Enabled = false;
                }
            }
            else { LlenarCamposDestino(this.cboCuentaDestino.SelectedItem.Value.ToString()); }


        }

        protected void btnTransferir_Click(object sender, EventArgs e)
        {
            try
            {
                if (ValidarMontos())
                {

                }
            }
            catch (Exception ex) { ex.ToString(); }
        }


        public Boolean ValidarMontos()
        {
            Boolean Bandera = false;
            if (Convert.ToDecimal(this.txtTotalMonedaOrigen.Text) >= Convert.ToDecimal(this.txtMoneda.Text))
            {
                Bandera = true;
            }
            else { Bandera = false; }
            return Bandera;
        }

        protected void cboTipoCambio_SelectedIndexChanged(object sender, EventArgs e)
        {
            Calcular();
        }

        //public void ConversionMonedas()
        //{
        //    try
        //    {
        //        if (!string.IsNullOrEmpty(this.cboMonedaOrigen.Text) && !string.IsNullOrEmpty(this.cboTipoCambio.Text))
        //        {
        //            //cuando la Cuenta origen son Pesos y se va a transferir en Dolares a una cuenta destino en dolares.
        //            if ((this.txtMoneda.Text == "MXN") && (this.cboMonedaOrigen.SelectedItem.Text == "USD") && (this.txtMonedaDestino.Text == "USD"))
        //            {
        //                this.txtTotalMonedaOrigen.Text = Convert.ToString(Convert.ToDecimal(this.txtImporteTransferido.Text) * Convert.ToDecimal(this.cboTipoCambio.SelectedItem.Text));
        //                this.txtTotalMonedaDestino.Text = txtImporteTransferido.Text;
        //            }
        //            //Cuando la cuenta de origen son Dolares y se van a transferir Pesos a una cuenta en pesos
        //            else if ((this.txtMoneda.Text == "USD") && (this.cboMonedaOrigen.SelectedItem.Text == "MXN") && (this.txtMonedaDestino.Text == "MXN"))
        //            {
        //                this.txtTotalMonedaOrigen.Text = Convert.ToString(Convert.ToDecimal(this.txtImporteTransferido.Text) / Convert.ToDecimal(this.cboTipoCambio.SelectedItem.Text));
        //                this.txtTotalMonedaDestino.Text = txtImporteTransferido.Text;
        //            }
        //        }
        //    }
        //    catch (Exception ex) { ex.ToString(); }
        //}

        protected void cboMoneda_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (this.cboMonedaOrigen.Text != this.cboMonedaDestino.Text)
            {
                this.lblTipoCambio.Visible = true;
                this.cboTipoCambio.Visible = true;

            }
            else
            {
                this.lblTipoCambio.Visible = false;
                this.cboTipoCambio.Visible = false;
                //Calcular();
            }
            Calcular();
        }


        public void Calcular()
        {

            if (this.cboMonedaOrigen.Text == "MXN" && this.cboMonedaDestino.Text == "USD")
            {
                this.cboTipoCambio.DataSource = db.TIPOS_CAMBIO_CONSULTAR();
                this.cboTipoCambio.DataBind();
                this.cboTipoCambio.TextField = "IMPORTE_COMPRA";
                this.cboTipoCambio.ValueField = "ID_TIPO_CAMBIO";
                this.cboTipoCambio.TextFormatString = "{2}";
                if (!string.IsNullOrEmpty(this.cboTipoCambio.Text))
                {
                    this.txtTotalMonedaDestino.Text = Convert.ToString(Convert.ToDouble(this.txtImporteTransferido.Text) / Convert.ToDouble(this.cboTipoCambio.Text)).ToString();
                    this.txtTotalMonedaOrigen.Text = Convert.ToString(Convert.ToDouble(this.txtTotalMonedaDestino.Text) * Convert.ToDouble(this.cboTipoCambio.Text)).ToString();
                }
            }
            else if (this.cboMonedaOrigen.Text == "USD" && this.cboMonedaDestino.Text == "MXN")
            {
                this.cboTipoCambio.DataSource = db.TIPOS_CAMBIO_CONSULTAR();
                this.cboTipoCambio.DataBind();
                this.cboTipoCambio.TextField = "IMPORTE_VENTA";
                this.cboTipoCambio.ValueField = "ID_TIPO_CAMBIO";
                this.cboTipoCambio.TextFormatString = "{1}";
                if (!string.IsNullOrEmpty(this.cboTipoCambio.Text))
                {
                    this.txtTotalMonedaDestino.Text = Convert.ToString(Convert.ToDouble(this.txtImporteTransferido.Text) * Convert.ToDouble(this.cboTipoCambio.Text)).ToString();
                    this.txtTotalMonedaOrigen.Text = Convert.ToString(Convert.ToDouble(this.txtTotalMonedaDestino.Text) / Convert.ToDouble(this.cboTipoCambio.Text)).ToString();
                }
            }
            else if (this.cboMonedaOrigen.Text == "USD" && this.cboMonedaDestino.Text == "USD")
            {
                this.txtTotalMonedaDestino.Text = this.txtImporteTransferido.Text;
                this.txtTotalMonedaOrigen.Text = this.txtImporteTransferido.Text;
            }
            else if (this.cboMonedaOrigen.Text == "MXN" && this.cboMonedaDestino.Text == "MXN")
            {
                this.txtTotalMonedaDestino.Text = this.txtImporteTransferido.Text;
                this.txtTotalMonedaOrigen.Text = this.txtImporteTransferido.Text;
            }
        }

        protected void cboMonedaDestino_SelectedIndexChanged(object sender, EventArgs e)
        {
            // ConversionMonedas();
            if (this.cboMonedaOrigen.Text != this.cboMonedaDestino.Text)
            {
                this.lblTipoCambio.Visible = true;
                this.cboTipoCambio.Visible = true;
            }
            else
            {
                this.lblTipoCambio.Visible = false;
                this.cboTipoCambio.Visible = false;
            }
            Calcular();
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

        protected void ASPxButton2_Click(object sender, EventArgs e)
        {
            try
            {
                if ((this.cboMonedaOrigen.Text == "MXN" && this.txtMoneda.Text == "MXN") && (this.cboMonedaDestino.Text == "MXN" && this.txtMonedaDestino.Text == "MXN"))
                {
                    db.EGRESOS_INSERTAR(Decimal.Parse(this.txtImporteTransferido.Text), this.cboMonedaOrigen.Text, null, 2, this.txtFolioTransaccion.Text, this.fechTransferencia.Date, Solicitante(), Autorizador(), RecibidoPor(), null, Int32.Parse(Session["Compañia"].ToString()), null, null, Int32.Parse(this.cboCuentaOrigen.SelectedItem.Value.ToString()), Int32.Parse(this.cboCuentaDestino.Value.ToString()), 2,this.txtObservaciones.Text);
                    db.INGRESOS_INSERTAR(this.fechTransferencia.Date, 4, 2, Decimal.Parse(this.txtImporteTransferido.Text), 42, null, null, this.cboMonedaDestino.Text, Int32.Parse(this.cboCuentaDestino.SelectedItem.Value.ToString()), this.txtFolioTransaccion.Text, Int32.Parse(this.cboCuentaOrigen.SelectedItem.Value.ToString()), this.txtObservaciones.Text);
                }
                else if ((this.cboMonedaOrigen.Text == "USD" && this.txtMoneda.Text == "USD") && (this.cboMonedaDestino.Text == "USD" && this.txtMonedaDestino.Text == "USD"))
                {
                    db.EGRESOS_INSERTAR(null, this.cboMonedaOrigen.Text, null, 2, this.txtFolioTransaccion.Text, this.fechTransferencia.Date, Solicitante(), Autorizador(), RecibidoPor(), null, Int32.Parse(Session["Compañia"].ToString()), Decimal.Parse(this.txtImporteTransferido.Text), null, Int32.Parse(this.cboCuentaOrigen.SelectedItem.Value.ToString()), Int32.Parse(this.cboCuentaDestino.Value.ToString()), 2,this.txtObservaciones.Text);
                    db.INGRESOS_INSERTAR(this.fechTransferencia.Date, 4, 2, Decimal.Parse(this.txtImporteTransferido.Text), 42, null, null, this.cboMonedaDestino.Text, Int32.Parse(this.cboCuentaDestino.SelectedItem.Value.ToString()), this.txtFolioTransaccion.Text, Int32.Parse(this.cboCuentaOrigen.SelectedItem.Value.ToString()), this.txtObservaciones.Text);
                }
                else if ((this.cboMonedaOrigen.Text == "USD" && this.txtMoneda.Text == "USD") && (this.cboMonedaDestino.Text == "MXN" && this.txtMonedaDestino.Text == "MXN"))
                {
                    db.EGRESOS_INSERTAR(null, this.cboMonedaOrigen.Text, null, 2, this.txtFolioTransaccion.Text, this.fechTransferencia.Date, Solicitante(), Autorizador(), RecibidoPor(), null, Int32.Parse(Session["Compañia"].ToString()), Decimal.Parse(this.txtImporteTransferido.Text), null, Int32.Parse(this.cboCuentaOrigen.SelectedItem.Value.ToString()), Int32.Parse(this.cboCuentaDestino.Value.ToString()), 2, this.txtObservaciones.Text);
                    db.INGRESOS_INSERTAR(this.fechTransferencia.Date, 4, 2, Decimal.Parse(this.txtTotalMonedaDestino.Text), 42, null, null, this.cboMonedaDestino.Text, Int32.Parse(this.cboCuentaDestino.SelectedItem.Value.ToString()), this.txtFolioTransaccion.Text, Int32.Parse(this.cboCuentaOrigen.SelectedItem.Value.ToString()), this.txtObservaciones.Text);
                }
                else if ((this.cboMonedaOrigen.Text == "MXN" && this.txtMoneda.Text == "MXN") && (this.cboMonedaDestino.Text == "USD" && this.txtMonedaDestino.Text == "USD"))
                {
                    db.EGRESOS_INSERTAR(Decimal.Parse(this.txtImporteTransferido.Text), this.cboMonedaOrigen.Text, null, 2, this.txtFolioTransaccion.Text, this.fechTransferencia.Date, Solicitante(), Autorizador(), RecibidoPor(), null, Int32.Parse(Session["Compañia"].ToString()), null, null, Int32.Parse(this.cboCuentaOrigen.SelectedItem.Value.ToString()), Int32.Parse(this.cboCuentaDestino.Value.ToString()), 2, this.txtObservaciones.Text);
                    db.INGRESOS_INSERTAR(this.fechTransferencia.Date, 4, 2, Decimal.Parse(this.txtTotalMonedaDestino.Text), 42, null, null, this.cboMonedaDestino.Text, Int32.Parse(this.cboCuentaDestino.SelectedItem.Value.ToString()), this.txtFolioTransaccion.Text, Int32.Parse(this.cboCuentaOrigen.SelectedItem.Value.ToString()), this.txtObservaciones.Text);
                }
                Limpiar();
                this.lblMensaje.Text = "LA TRANSFERENCIA HA QUEDADO REGISTRADA";
                this.popupMensajeria.ShowOnPageLoad = true;

            }
            catch (Exception ex) { ex.ToString(); }
        }

        protected void txtImporteTransferido_TextChanged(object sender, EventArgs e)
        {
            Calcular();
        }

        public void Limpiar()
        {
            this.fechTransferencia.Text = string.Empty;
            this.txtImporteTransferido.Text = string.Empty;
            this.cboMonedaOrigen.SelectedIndex = -1;
            this.cboTipoCambio.SelectedIndex = -1;
            this.cboMonedaDestino.SelectedIndex = -1;
            this.txtTotalMonedaDestino.Text = string.Empty;
            this.txtTotalMonedaOrigen.Text = string.Empty;
            this.cboCuentaOrigen.SelectedIndex = -1;
            this.cboCuentaDestino.SelectedIndex = -1;
            this.txtFolioTransaccion.Text = string.Empty;
            this.txtBancoOrigen.Text = string.Empty;
            this.txtMoneda.Text = string.Empty;
            this.txtSaldoActual.Text = string.Empty;
            this.txtMonedaDestino.Text = string.Empty;
            this.txtSaldoDestino.Text = string.Empty;
        }

    }
}