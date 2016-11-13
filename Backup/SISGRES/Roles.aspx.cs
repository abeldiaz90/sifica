using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using DevExpress.Web.ASPxTreeList;

namespace SISGRES
{
    public partial class Roles : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void imgPermisos_Click(object sender, ImageClickEventArgs e)
        {
            this.popupPermisos.ShowOnPageLoad = true;
            DataTable VerificaPermisos = VerificarPermisos();
            this.popupPermisos.HeaderText = " MODULOS DE ACCESO DEL ROL: " + this.grdRoles.GetRowValues(this.grdRoles.FocusedRowIndex, "ROL").ToString();
            this.popupPermisos.ShowOnPageLoad = true;
            this.ASPxTreeList1.UnselectAll();
            if (VerificaPermisos.Rows.Count >= 1)
            {
                string[] a = VerificaPermisos.Rows[0][0].ToString().Split(',');

                for (int i = 0; i <= a.Length - 1; i++)
                {
                    TreeListNodeIterator iterator = new TreeListNodeIterator(this.ASPxTreeList1.RootNode);
                    while (iterator.GetNext() != null)
                    {
                        if (iterator.Current["Id"].ToString() == a[i].ToString())
                        {
                            iterator.Current.Selected = true;
                        }                      
                    }
                }
            }
        }

        public DataTable VerificarPermisos()
        {
            SqlConnection con = new SqlConnection();
            DataTable TablaPermisos = new DataTable();
            try
            {
                con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["SIFICA"].ToString();
                con.Open();
                SqlCommand cmd = new SqlCommand();                
                cmd.Connection = con;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "[ROLES_OBTENER_PERMISOS]";
                cmd.Parameters.AddWithValue("@ID_ROL", this.grdRoles.GetRowValues(this.grdRoles.FocusedRowIndex, "ID_ROL").ToString());
                cmd.CommandTimeout = 0;
                cmd.ExecuteNonQuery();
                SqlDataAdapter ObtencionNumero = new SqlDataAdapter(cmd);
                ObtencionNumero.Fill(TablaPermisos);
            }
            catch (Exception Error)
            { Error.ToString(); }
            finally { con.Close(); }
            return TablaPermisos;
        }

        protected void ASPxButton2_Click(object sender, EventArgs e)
        {
            String Permisos = "";
            try
            {
                DataTable VerificaPermisos = VerificarPermisos();

                TreeListNodeIterator iterator = new TreeListNodeIterator(this.ASPxTreeList1.RootNode);
                while (iterator.GetNext() != null)
                {
                    if (iterator.Current.Selected == true)
                    {
                        Permisos = iterator.Current["Id"].ToString() + "," + Permisos;
                    }
                }

                if (VerificaPermisos.Rows.Count >= 1)
                {
                    SIFICADataContext db = new SIFICADataContext();
                    db.ROLES_MODIFICAR_PERMISOS(Int32.Parse(this.grdRoles.GetRowValues(this.grdRoles.FocusedRowIndex, "ID_ROL").ToString()), Permisos);
                    db.SubmitChanges();
                }
                //else
                //{
                //    SIFICADataContext db = new SIFICADataContext();
                //    db.INSERTA_PERMISOS_USUARIOS(this.grdRoles.GetRowValues(this.grdRoles.FocusedRowIndex, "ID_ROL").ToString(), Permisos);
                //    db.SubmitChanges();
                //}
            }
            catch (Exception ex) { ex.ToString(); }
        }
    }
}