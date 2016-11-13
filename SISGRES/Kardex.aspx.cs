using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SISGRES
{
    public partial class Kardex : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.Request.QueryString["ID_ITEM"] != null) 
            {
                SIFICADataContext db = new SIFICADataContext();
                this.grdHistoria.DataSource = db.INVENTARIO_ACTUAL_DETALLE_ITEM(Int32.Parse(Page.Request.QueryString["ID_ITEM"]));
                this.grdHistoria.DataBind();
            }
           
        }

        
    }
}