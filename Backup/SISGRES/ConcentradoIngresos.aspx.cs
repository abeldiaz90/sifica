using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SISGRES
{
    public partial class ConcentradoIngresos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack) 
            {
                this.cboMes.Items.FindByValue(DateTime.Now.Month).Selected = true;
                this.cboAño.Items.FindByValue(DateTime.Now.Year.ToString()).Selected = true;
            }
        }

        protected void cboCuentasBancarias_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void ASPxButton2_Click(object sender, EventArgs e)
        {
            this.GrdIngresos.DataBind();
        }

        protected void ASPxButton2_Click1(object sender, EventArgs e)
        {
            this.ASPxGridViewExporter1.WriteXlsxToResponse();
        }
    }
}