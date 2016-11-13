using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SISGRES
{
    public partial class Fondo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void ASPxUploadControl1_FileUploadComplete(object sender, DevExpress.Web.FileUploadCompleteEventArgs e)
        {
            try
            { //string filename = Path.GetFileName(e.UploadedFile.FileName);
                string directory = "";



                if (Directory.Exists(Server.MapPath("Fondo/")))
                {
                    directory = Server.MapPath("Fondo");
                    string fExtension = Path.GetExtension(e.UploadedFile.FileName);
                    string fileName = "Fondo" + fExtension;



                    string targetPath = Path.Combine(directory, fileName);
                    if (File.Exists(targetPath))
                    {
                        File.Delete(targetPath);
                    }


                    e.UploadedFile.SaveAs(Path.Combine(directory, fileName));
                }
                else
                {
                    Directory.CreateDirectory(Server.MapPath("Fondo/"));
                    string fExtension = Path.GetExtension(e.UploadedFile.FileName);
                    string fileName = "Fondo" + fExtension;



                    string targetPath = Path.Combine(directory, fileName);
                    if (File.Exists(targetPath))
                    {
                        File.Delete(targetPath);
                    }


                    e.UploadedFile.SaveAs(Path.Combine(directory, fileName));
                }

            }
            catch (Exception ex) { ex.ToString(); }

        }
    }
}