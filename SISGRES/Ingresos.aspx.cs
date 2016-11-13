using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SISGRES
{
    public partial class Ingresos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void cboOrigen_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cboOrigen.SelectedIndex == 0)
            {
                this.lblAcreedor.Visible = true;
                this.cboAcreedor.Visible = true;
                this.lblCliente.Visible = false;
                this.cboCliente.Visible = false;
            }
            else if (cboOrigen.SelectedIndex == 1)
            {
                this.lblAcreedor.Visible = false;
                this.cboAcreedor.Visible = false;
                this.lblCliente.Visible = true;
                this.cboCliente.Visible = true;
            }
            else if (cboOrigen.SelectedIndex == 2)
            {
                this.lblAcreedor.Visible = false;
                this.cboAcreedor.Visible = false;
                this.lblCliente.Visible = true;
                this.cboCliente.Visible = true;
            }

        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                SIFICADataContext db = new SIFICADataContext();
                if (this.cboCliente.IsVisible())
                {
                    db.INGRESOS_INSERTAR(this.fechaOperacion.Date, Int32.Parse(this.cboOrigen.SelectedItem.Value.ToString()), Int32.Parse(this.cboDocumento.SelectedItem.Value.ToString()), Decimal.Parse(this.txtImporte.Text),Int32.Parse(this.cboConcepto.SelectedItem.Value.ToString()), Int32.Parse(this.cboCliente.SelectedItem.Value.ToString()), null, this.cbomoneda.SelectedItem.Value.ToString(), Int32.Parse(this.cboCuentaBancaria.SelectedItem.Value.ToString()), this.txtFolio.Text,null,this.txtObservaciones.Text);
                    db.SubmitChanges();
                }
                else if (!this.cboCliente.IsVisible())
                {
                    db.INGRESOS_INSERTAR(this.fechaOperacion.Date, Int32.Parse(this.cboOrigen.SelectedItem.Value.ToString()), Int32.Parse(this.cboDocumento.SelectedItem.Value.ToString()), Decimal.Parse(this.txtImporte.Text), Int32.Parse(this.cboConcepto.SelectedItem.Value.ToString()), null, Int32.Parse(this.cboAcreedor.SelectedItem.Value.ToString()), this.cbomoneda.SelectedItem.Value.ToString(), Int32.Parse(this.cboCuentaBancaria.SelectedItem.Value.ToString()), this.txtFolio.Text, null,this.txtObservaciones.Text);
                    db.SubmitChanges();
                }
                LimpiarCampos();
            }
            catch (Exception ex) { ex.ToString(); }
        }

        public void LimpiarCampos()
        {
            try
            {
                this.cboCliente.SelectedIndex = -1;
                this.cboAcreedor.SelectedIndex = -1;
                this.cboCuentaBancaria.SelectedIndex = -1;
                this.cboDocumento.SelectedIndex = -1;
                this.cbomoneda.SelectedIndex = -1;
                this.cboOrigen.SelectedIndex = -1;
                this.cboConcepto.SelectedIndex = -1;
                this.fechaOperacion.Text = string.Empty;
                this.cboConcepto.Text = string.Empty;
                this.txtFolio.Text = string.Empty;
                this.txtImporte.Text = string.Empty;
                this.txtObservaciones.Text = string.Empty;
            }
            catch (Exception ex) { ex.ToString(); }
        }
    }
}