using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SISGRES
{
    public partial class Facturacion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ASPxButton2_Click(object sender, EventArgs e)
        {
            try
            {
                for (int i = 0; i <= this.lstFacturacion.VisibleRowCount - 1; i++)
                {
                    if (this.lstFacturacion.Selection.IsRowSelected(i))
                    {
                        SIFICADataContext DB = new SIFICADataContext();
                         DB.FACTURAS_ACTUALIZAR_LISTADO(Int32.Parse(this.lstFacturacion.GetRowValues(i,"ID_PRODUCCION").ToString()), this.txtNumeroFactura.Text,FechaFacturacion.Date,Int32.Parse(this.cboTipoDocumento.SelectedItem.Value.ToString()));
                    }
                }
                this.txtNumeroFactura.Text = string.Empty;
                this.cboTipoDocumento.SelectedIndex = -1;
                this.FechaFacturacion.Date = DateTime.Now;
                this.grdFacturas.DataBind();
                this.lstFacturacion.DataBind();
            }
            catch (Exception ex) { ex.ToString(); }
        }

        protected void grdFacturas_DetailRowExpandedChanged(object sender, DevExpress.Web.ASPxGridViewDetailRowEventArgs e)
        {
            //this.grdFacturas.FocusedRowIndex = e.VisibleIndex;
            try { Session["NUM_FACTURA"] = this.grdFacturas.GetRowValues(e.VisibleIndex, "NUM_FACTURA").ToString(); }
            catch (Exception ex) { ex.ToString(); }
        }
    }
}