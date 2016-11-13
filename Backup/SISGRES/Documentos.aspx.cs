using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SISGRES
{
    public partial class Documentos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Subir_FileUploadComplete(object sender, DevExpress.Web.FileUploadCompleteEventArgs e)
        {
            try
            {
                String RutaFisica = "";
                if (e.UploadedFile.FileContent != null)
                {
                    string filename = DateTime.Now.Year.ToString() + "" + DateTime.Now.Month.ToString() + "" + DateTime.Now.Day.ToString() + "" + DateTime.Now.Hour.ToString() + "" + DateTime.Now.Minute.ToString() + "" + DateTime.Now.Second.ToString() + "." + e.UploadedFile.FileName.ToString().Split('.')[1].ToString();
                    RutaFisica = "~\\Documentos\\" + filename;
                    string targetPath = Server.MapPath("Documentos/" + filename);
                    e.UploadedFile.SaveAs(targetPath);
                    SIFICADataContext db = new SIFICADataContext();
                    db.DOCUMENTOS_CALIDAD_INSERTAR(this.txtDescripcion.Text, Int32.Parse(this.cboProyecto.SelectedItem.Value.ToString()), System.DateTime.Now, RutaFisica, this.User.Identity.Name.ToString());
                    db.SubmitChanges();
                }

            }
            catch (Exception ex) { ex.ToString(); }
            //this.txtDescripcion.Text = string.Empty;
            //this.cboCliente.SelectedIndex = -1;
            //this.cboProyecto.SelectedIndex = -1;
        }

        protected void btnAbrirDocumentos_Click(object sender, EventArgs e)
        {
            llenarDocumentos();
        }

        public void llenarDocumentos() 
        {
            this.popupDocumentos.ShowOnPageLoad = true;
            SIFICADataContext db = new SIFICADataContext();
            this.grdDocumentosDetalles.DataSource = db.DOCUMENTOS_CALIDAD_MOSTRAR_POR_PUBLICACION(Int32.Parse(this.grdDocumentos.GetRowValues(this.grdDocumentos.FocusedRowIndex, "ID_DOCUMENTO").ToString()));
            this.grdDocumentosDetalles.DataBind();        
        }

        protected void grdDocumentosDetalles_AfterPerformCallback(object sender, DevExpress.Web.ASPxGridViewAfterPerformCallbackEventArgs e)
        {
            llenarDocumentos();
        }
    }
}