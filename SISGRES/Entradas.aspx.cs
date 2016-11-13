using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SISGRES
{
    public partial class Entradas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ASPxButton2_Click(object sender, EventArgs e)
        {
            try
            {
                SIFICADataContext db = new SIFICADataContext();
                db.ENTRADAS_RECEPCIONAR(Int32.Parse(this.cboOC.SelectedItem.Value.ToString()));
                this.cboOC.Items.Clear();
                this.cboOC.DataBind();
                this.grdCompras.DataBind();
            }
            catch (Exception ex) { ex.ToString(); }
        }

        protected void rdbEntradas_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                if (this.rdbEntradas.SelectedIndex == 0)
                {
                    this.pnlOrdenesCompras.Visible = true;
                    this.pnlDevoluciones.Visible = false;
                }
                else if (this.rdbEntradas.SelectedIndex == 1)
                {
                    this.pnlDevoluciones.Visible = true;
                    this.pnlOrdenesCompras.Visible = false;
                }
            }
            catch (Exception ex) { ex.ToString(); }
        }

        protected void cboOC_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                Limpiar();
                SIFICADataContext db = new SIFICADataContext();
                var query=db.OC_OR_ID(Int32.Parse(this.cboOC.SelectedItem.Value.ToString()));
                foreach (var datos in query) 
                {
                    this.txtRequisitor.Text = datos.REQUISITOR;
                    this.txtAprobadorRequest.Text = datos.APROBADOR_RECHAZADOR_REQUISICION;
                    this.txtAprobadorOc.Text = datos.APROBADOR_RECHAZADOR_OC;
                    this.txtProveedor.Text = datos.PROOVEDOR;
                }
            }
            catch (Exception ex) { ex.ToString(); }
        }


        public void Limpiar() 
        {
            this.txtRequisitor.Text = string.Empty;
            this.txtAprobadorRequest.Text = string.Empty;
            this.txtAprobadorOc.Text = string.Empty;
            this.txtProveedor.Text = string.Empty;
        }
 
    

        protected void lnkDevolver_Click(object sender, EventArgs e)
        {
            try
            {
                SIFICADataContext db = new SIFICADataContext();
                db.DEVOLUCIONES_APLICAR(Int32.Parse(this.grdSalidas.GetRowValues(this.grdSalidas.FocusedRowIndex, "ID").ToString()));
                this.grdSalidas.DataBind();
            }
            catch (Exception ex) { ex.ToString(); }
        }
    }
}