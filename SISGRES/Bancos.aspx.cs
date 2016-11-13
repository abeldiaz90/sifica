using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace SISGRES
{
    public partial class Bancos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Subir_FileUploadComplete(object sender, DevExpress.Web.FileUploadCompleteEventArgs e)
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
            ts.BANCOS_MODIFICAR_LOGO(Int32.Parse(this.grdBancos.GetRowValues(this.grdBancos.FocusedRowIndex, "ID_BANCO").ToString()),"~/Logos/" + e.UploadedFile.FileName.ToString(), fileBytes);
            ts.SubmitChanges();
            this.popupLogos.ShowOnPageLoad = false;
            this.grdBancos.DataBind();
        }
    }
}