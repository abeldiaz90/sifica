using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SISGRES
{
    public partial class TiposConcretos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
  
        }

  

        protected void cboTipoConcreto_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void btnAditivos_Click(object sender, EventArgs e)
        {
            try
            {
                this.grdTiposConcreto.DataBind();
                this.cboTipoConcreto.DataBind();
                this.cboTipoConcreto.Items.FindByValue(this.grdTiposConcreto.GetRowValues(this.grdTiposConcreto.FocusedRowIndex, "ID_TIPO_CONCRETO").ToString()).Selected = true;
                this.grdCostosAditivosAdicionales.DataBind();
                this.grdMaterialesAdicionales.Visible = false;
                this.grdCostosAditivosAdicionales.Visible = true;
                this.popupAdiciones.ShowOnPageLoad = true;
            }
            catch (Exception ex) { ex.ToString(); }
        }

        protected void btnAdicionar_Click(object sender, EventArgs e)
        {
            try
            {
                this.grdTiposConcreto.DataBind();
                this.cboTipoConcreto.DataBind();              
                this.cboTipoConcreto.Items.FindByValue(this.grdTiposConcreto.GetRowValues(this.grdTiposConcreto.FocusedRowIndex, "ID_TIPO_CONCRETO").ToString()).Selected = true;
                this.grdMaterialesAdicionales.DataBind();
                this.grdMaterialesAdicionales.Visible = true;
                this.grdCostosAditivosAdicionales.Visible = false;
                this.popupAdiciones.ShowOnPageLoad = true;
                
            }
            catch (Exception ex) { ex.ToString(); }
        }

       
    }
}