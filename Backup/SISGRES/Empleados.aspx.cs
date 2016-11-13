using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;

namespace SISGRES
{
    public partial class Empleados : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Subir_FileUploadComplete(object sender, DevExpress.Web.FileUploadCompleteEventArgs e)
        {
            //string filename = Path.GetFileName(e.UploadedFile.FileName);
            string targetPath = Server.MapPath("FotosEmpleados/" + this.grdEmpleados.GetRowValues(this.grdEmpleados.FocusedRowIndex, "ID_EMPLEADO").ToString() + ".jpg");
            //if (File.Exists(targetPath))
            //{
            //    FileShare.None;
            //    File.Delete(targetPath);
            //}


            e.UploadedFile.SaveAs(targetPath,true);
            //byte[] fileBytes = System.IO.File.ReadAllBytes(targetPath);
            SIFICADataContext ts = new SIFICADataContext();
            ts.EMPLEADOS_ACTUALIZAR_FOTOS(Int32.Parse(this.grdEmpleados.GetRowValues(this.grdEmpleados.FocusedRowIndex, "ID_EMPLEADO").ToString()), null);
            ts.SubmitChanges();
            //this.popupFotos.ShowOnPageLoad = false;
            //this.grdEmpleados.DataBind();
            //MostrarFotos();
        }


        protected void Subirfirma_FileUploadComplete(object sender, DevExpress.Web.FileUploadCompleteEventArgs e)
        {
            string filename = Path.GetFileName(e.UploadedFile.FileName);
            string targetPath = Server.MapPath("Firmas/" + e.UploadedFile.FileName);
            if (File.Exists(targetPath))
            {
                File.Delete(targetPath);
            }


            e.UploadedFile.SaveAs(targetPath);
            byte[] fileBytes = System.IO.File.ReadAllBytes(targetPath);
            SIFICADataContext ts = new SIFICADataContext();
            ts.EMPLEADOS_ACTUALIZAR_FIRMAS(Int32.Parse(this.grdEmpleados.GetRowValues(this.grdEmpleados.FocusedRowIndex, "ID_EMPLEADO").ToString()), fileBytes);
            ts.SubmitChanges();
            this.popupFirmas.ShowOnPageLoad = false;
            this.grdEmpleados.DataBind();

        }



        protected void imgPDF_Click(object sender, ImageClickEventArgs e)
        {
            this.ASPxGridViewExporter1.WritePdfToResponse();
        }

        protected void imgEXCEL_Click(object sender, ImageClickEventArgs e)
        {
            this.ASPxGridViewExporter1.WriteXlsToResponse();
        }


        public static byte[] ConvertImageToByteArray(System.Drawing.Image _image, ImageFormat _formatImage)
        {
            byte[] ImageByte;

            try
            {
                using (MemoryStream ms = new MemoryStream())
                {
                    _image.Save(ms, _formatImage);
                    ImageByte = ms.ToArray();
                }
            }
            catch (Exception) { throw; }
            return ImageByte;
        }

        protected void btnFotografia_Click(object sender, EventArgs e)
        {
            this.grdEmpleados.DataBind();
            MostrarFotos();

        }

        public void MostrarFotos()
        {
            this.popupFotos.ShowOnPageLoad = true;
            try
            {
                System.Drawing.Image img = new Bitmap(Server.MapPath("~/FotosEmpleados/") + this.grdEmpleados.GetRowValues(this.grdEmpleados.FocusedRowIndex, "ID_EMPLEADO").ToString() + ".jpg");
                byte[] ByteImage = ConvertImageToByteArray(img, ImageFormat.Jpeg);
                string base64String = Convert.ToBase64String(ByteImage, 0, ByteImage.Length);
                this.imgFoto.ImageUrl = "data:image/png;base64," + base64String;
          
            }
            catch (Exception ex) { ex.ToString(); }

        }


        public System.Drawing.Image ByteArrayToImage(byte[] byteArrayIn)
        {
            using (MemoryStream ms = new MemoryStream(byteArrayIn))
            {
                System.Drawing.Image returnImage = System.Drawing.Image.FromStream(ms);
                return returnImage;
            }
        }

        protected void cp_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            MostrarFotos();
        }
    }
}