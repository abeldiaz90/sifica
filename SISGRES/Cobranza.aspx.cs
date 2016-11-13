using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SISGRES
{
    public partial class Cobranza : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void grdCobranza_DetailRowExpandedChanged(object sender, DevExpress.Web.ASPxGridViewDetailRowEventArgs e)
        {
            try
            {               
                Session["NUM_FACTURA"] = this.grdCobranza.GetRowValues(e.VisibleIndex, "NUM_FACTURA").ToString();
            }
            catch (Exception ex) { ex.ToString(); }
        }
    }
}