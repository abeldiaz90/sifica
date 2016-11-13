using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SISGRES
{
    public partial class Puestos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack) { }

        }

        protected void cboDePartamento_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.grd.DataBind();
        }
    }
}