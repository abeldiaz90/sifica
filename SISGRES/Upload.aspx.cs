using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SISGRES
{
    public partial class Upload : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void SubirArchivos_FileUploadComplete(object sender, DevExpress.Web.FileUploadCompleteEventArgs e)
        {
            string ExcelContentType = "application/vnd.ms-excel";
            string Excel2010ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            if (e.UploadedFile.ContentLength > 0)
            {
                //Check the Content Type of the file
                //////////if (e.UploadedFile.ContentType == ExcelContentType || e.UploadedFile.ContentType == Excel2010ContentType)
                //////////{
                try
                {
                    //Save file path
                    string path = string.Concat(Server.MapPath("~/TempFiles/"), e.UploadedFile.FileName);
                    //Save File as Temp then you can delete it if you want
                    e.UploadedFile.SaveAs(path);
                    //string path = @"C:\Users\Johnney\Desktop\ExcelData.xls";
                    //For Office Excel 2010  please take a look to the followng link  http://social.msdn.microsoft.com/Forums/en-US/exceldev/thread/0f03c2de-3ee2-475f-b6a2-f4efb97de302/#ae1e6748-297d-4c6e-8f1e-8108f438e62e
                    //string excelConnectionString = string.Format("Provider=Microsoft.Jet.OLEDB.4.0;Data Source={0};Extended Properties=Excel 8.0", path);
                    string excelConnectionString = string.Format("Provider=Microsoft.ACE.OLEDB.12.0;Data Source={0};Extended Properties=Excel 8.0;", path);

                    //FinanzasDataContext db = new FinanzasDataContext();                        
                    //db.ExcelJDEs.DeleteAllOnSubmit(db.ExcelJDEs);
                    //db.SubmitChanges();                 
                    //BorrarTabla();



                    // Create Connection to Excel Workbook
                    using (OleDbConnection connection = new OleDbConnection(excelConnectionString))
                    {
                        OleDbCommand command = new OleDbCommand("Select * FROM [Sheet1$]", connection);
                        connection.Open();
                        command.CommandTimeout = 0;
                        // Create DbDataReader to Data Worksheet
                        using (DbDataReader dr = command.ExecuteReader())
                        {
                            // SQL Server Connection String
                            string sqlConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["SIFICA"].ToString();


                            // Bulk Copy to SQL Server
                            using (SqlBulkCopy bulkCopy = new SqlBulkCopy(sqlConnectionString))
                            {
                                bulkCopy.BulkCopyTimeout = 0;
                                bulkCopy.DestinationTableName = "Uploads";
                                bulkCopy.WriteToServer(dr);
                                //ActualizarMesAño();
                            }

                        }
                    }

                    SIFICADataContext db = new SIFICADataContext();
                    db.PRECARGA_INSERTAR();
                    this.grdUpload.DataBind();
                    //Transformar();
                    //MostrarDatos();
                }

                catch (Exception ex)
                {
                    //this.lblResultado.Text = "EL ITEM LEDGER SE INSERTO EN LA BD CORRECTAMENTE";
                    //Label1.Text = ex.Message;
                }
                //////////}
            }
        }

        protected void SubirArchivos2_FileUploadComplete(object sender, DevExpress.Web.FileUploadCompleteEventArgs e)
        {
            SIFICADataContext db = new SIFICADataContext();
            db.UPLOAD_ARCHIVO2_ELIMINAR();

            string ExcelContentType = "application/vnd.ms-excel";
            string Excel2010ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            if (e.UploadedFile.ContentLength > 0)
            {
                //Check the Content Type of the file
                //////////if (e.UploadedFile.ContentType == ExcelContentType || e.UploadedFile.ContentType == Excel2010ContentType)
                //////////{
                try
                {
                    //Save file path
                    string path = string.Concat(Server.MapPath("~/TempFiles/"), e.UploadedFile.FileName);
                    //Save File as Temp then you can delete it if you want
                    e.UploadedFile.SaveAs(path);
                    //string path = @"C:\Users\Johnney\Desktop\ExcelData.xls";
                    //For Office Excel 2010  please take a look to the followng link  http://social.msdn.microsoft.com/Forums/en-US/exceldev/thread/0f03c2de-3ee2-475f-b6a2-f4efb97de302/#ae1e6748-297d-4c6e-8f1e-8108f438e62e
                    //string excelConnectionString = string.Format("Provider=Microsoft.Jet.OLEDB.4.0;Data Source={0};Extended Properties=Excel 8.0", path);
                    string excelConnectionString = string.Format("Provider=Microsoft.ACE.OLEDB.12.0;Data Source={0};Extended Properties=Excel 8.0;", path);

                    //FinanzasDataContext db = new FinanzasDataContext();                        
                    //db.ExcelJDEs.DeleteAllOnSubmit(db.ExcelJDEs);
                    //db.SubmitChanges();                 
                    //BorrarTabla();



                    // Create Connection to Excel Workbook
                    using (OleDbConnection connection = new OleDbConnection(excelConnectionString))
                    {
                        OleDbCommand command = new OleDbCommand("Select * FROM [Sheet1$]", connection);
                        connection.Open();

                        // Create DbDataReader to Data Worksheet
                        using (DbDataReader dr = command.ExecuteReader())
                        {
                            // SQL Server Connection String
                            string sqlConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["SIFICA"].ToString();


                            // Bulk Copy to SQL Server
                            using (SqlBulkCopy bulkCopy = new SqlBulkCopy(sqlConnectionString))
                            {
                                bulkCopy.DestinationTableName = "Uploads2";
                                bulkCopy.WriteToServer(dr);
                                //ActualizarMesAño();
                            }

                        }
                    }

                    //////SIFICADataContext db = new SIFICADataContext();
                    //////db.PRECARGA_INSERTAR();
                    //////this.grdUpload.DataBind();
                    //Transformar();
                    //MostrarDatos();
                }

                catch (Exception ex)
                {
                    //this.lblResultado.Text = "EL ITEM LEDGER SE INSERTO EN LA BD CORRECTAMENTE";
                    //Label1.Text = ex.Message;
                }
                //////////}
            }
        }

        protected void btnEnviarProduccion_Click(object sender, EventArgs e)
        {
            try
            {
                SIFICADataContext db = new SIFICADataContext();
                db.CARGAR_PRODUCCION();
                this.grdUpload.DataBind();
            }
            catch (Exception ex) { ex.ToString(); }
        }
    }
}