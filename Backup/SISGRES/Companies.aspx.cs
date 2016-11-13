using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace SISGRES
{
    public partial class Companies : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ASPxUploadControl1_FileUploadComplete(object sender, DevExpress.Web.FileUploadCompleteEventArgs e)
        {
            string filename = Path.GetFileName(e.UploadedFile.FileName);
            string targetPath = Server.MapPath("Logos/" + e.UploadedFile.FileName);
            if (File.Exists(targetPath))
            {
                File.Delete(targetPath);
            }

           
            e.UploadedFile.SaveAs(targetPath);            

            byte[] fileBytes = System.IO.File.ReadAllBytes(targetPath);

            SIFICADataContext ts = new SIFICADataContext();
            ts.COMPAÑIAS_ACTUALIZAR_FOTOS(Int32.Parse(this.grdCompañias.GetRowValues(this.grdCompañias.FocusedRowIndex, "ID_COMPAÑIA").ToString()), fileBytes, "~/Logos/" + e.UploadedFile.FileName.ToString());
            ts.SubmitChanges();
            this.popupLogos.ShowOnPageLoad = false;
            this.grdCompañias.DataBind();
        }

      
    }
}