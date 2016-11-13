using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Data.SqlClient;
using System.Data;
using System.Globalization;
using System.DirectoryServices;
using System.IO;


namespace SISGRES
{
    public partial class Principal : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                try
                {
                    CultureInfo ci = new CultureInfo("Es-mx");
                    this.lblFechaHora.Text = ci.DateTimeFormat.GetDayName(System.DateTime.Now.DayOfWeek) + " " + System.DateTime.Today.Day.ToString() + " de " + ci.DateTimeFormat.GetMonthName(System.DateTime.Now.Month) + " del " + System.DateTime.Now.Year + " ";
                    
                    if (Session["Compañia"] != null || Session["Compañia"] == "")
                    {
                        ObtenerNombreEmpresa(); 
                        LlenarMenu();
                    }
                    else { this.popupCompañia.ShowOnPageLoad = true; }
                }
                catch (Exception ex) { ex.ToString(); }
            }
        }

        public void ObtenerNombreEmpresa() 
        {
            SIFICADataContext DB = new SIFICADataContext();
            var Query = DB.COMPAÑIAS_MOSTRAR_ID(Int32.Parse(Session["Compañia"].ToString()));
            foreach (var i in Query)
            {
                this.ASPxLabel1.Text = i.COMPAÑIA;
                this.Image1.ImageUrl = i.IMAGEURL;

            }
        }

        public void LlenarMenu()
        {
            try
            {
                //this.ASPxLabel1.Text = Session["CompañiaNombre"].ToString();
                String Form = ObtenerNumeroFormulario(Path.GetFileName(Request.Url.AbsolutePath)).ToString();
                String MisPermisos = ObtenerMisPermisos(this.Page.User.Identity.Name.ToString());
                String[] Total = MisPermisos.Split(',');

                for (int i = 0; i <= Total.Length - 1; i++)
                {
                    if (Total[i].ToString() == Form.ToString())
                    {
                        DataTable dtMenu = new DataTable();
                        DataSet ds = new DataSet();

                        XmlDataSource xmlDataSource = new XmlDataSource();
                        xmlDataSource.ID = "XmlSource1";
                        xmlDataSource.EnableCaching = false;

                        dtMenu = GetMenuTable();
                        ds.Tables.Add(dtMenu);

                        ds.DataSetName = "Menus";
                        ds.Tables[0].TableName = "Menu";

                        DataRelation relation = new DataRelation("Parentchild", ds.Tables["Menu"].Columns["Id"], ds.Tables["Menu"].Columns["ParentId"], true);
                        relation.Nested = true;
                        ds.Relations.Add(relation);

                        xmlDataSource.Data = ds.GetXml();

                        //Reformat the xmldatasource from the dataset to fit menu into xml format
                        xmlDataSource.TransformFile = Server.MapPath("~/Menu.xslt");

                        //assigning the path to start read all MenuItem under MenuItems
                        xmlDataSource.XPath = "MenuItems/MenuItem";

                        this.Menu.DataSource = xmlDataSource;
                        this.Menu.DataBind();
                        return;
                    }
                    else if (i == Total.Length - 1)
                    {
                        Response.Redirect("Error.aspx");
                    }
                }

            }
            catch (Exception ex) { ex.ToString(); }
        }


        public void BusquedaDA(String Usuario)
        {
            try
            {
                DirectoryEntry searchRoot = new DirectoryEntry("LDAP://10.129.1.6");
                DirectorySearcher search = new DirectorySearcher(searchRoot);
                search.Filter = "(&(objectClass=user)(objectCategory=person)(mail=*)(samaccountname=" + Usuario + "))";
                search.PropertiesToLoad.Add("displayname");
                SearchResult result;
                SearchResultCollection resultCol = search.FindAll();
                if (resultCol != null)
                {
                    for (int counter = 0; counter <= resultCol.Count - 1; counter++)
                    {
                        result = resultCol[counter];
                        if (result.Properties.Contains("displayname"))
                        {
                            //this.lblUsuario.Text = (String)(result.Properties["displayname"][0].ToString());
                        }
                    }
                }
            }
            catch (Exception ex) { ex.ToString(); }
        }


        private DataTable GetMenuTable()
        {
            DataTable TablaDatos = new DataTable();
            try
            {
                SqlConnection con = new SqlConnection();
                con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["SIFICA"].ToString();
                con.Open();
                SqlCommand com = new SqlCommand();
                com.Connection = con;
                com.Parameters.AddWithValue("@USUARIO", this.Page.User.Identity.Name.ToString());
                com.CommandText = "OBTENER_MENU";
                com.CommandType = CommandType.StoredProcedure;
                com.ExecuteNonQuery();
                SqlDataAdapter Datos = new SqlDataAdapter(com);
                Datos.Fill(TablaDatos);
                con.Close();

            }
            catch (Exception ex) { ex.ToString(); }
            return TablaDatos;
        }

        private DataTable ObtenerMenu()
        {
            DataTable TablaDatos = new DataTable();
            try
            {
                SqlConnection con = new SqlConnection();
                con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["SIFICA"].ToString();
                con.Open();
                SqlCommand com = new SqlCommand();
                com.Connection = con;
                com.Parameters.AddWithValue("@USUARIO", this.Page.User.Identity.Name.ToString());
                com.CommandText = "OBTENER_MENU";
                com.CommandType = CommandType.StoredProcedure;
                com.ExecuteNonQuery();
                SqlDataAdapter Datos = new SqlDataAdapter(com);
                Datos.Fill(TablaDatos);
                con.Close();

            }
            catch (Exception ex) { ex.ToString(); }
            return TablaDatos;
        }



        public Int32 ObtenerNumeroFormulario(String Formulario)
        {
            Int32 Numero = 0;
            try
            {
                SqlConnection con = new SqlConnection();
                con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["SIFICA"].ToString();
                con.Open();
                SqlCommand com = new SqlCommand();
                com.Connection = con;
                com.Parameters.AddWithValue("@FORMULARIO", Formulario);
                com.CommandText = "ObtenerNumeroFormulario";
                com.CommandType = CommandType.StoredProcedure;
                com.ExecuteNonQuery();
                SqlDataAdapter Datos = new SqlDataAdapter(com);
                DataTable TablaDatos = new DataTable();
                Datos.Fill(TablaDatos);
                if (TablaDatos.Rows.Count >= 1)
                {
                    Numero = Convert.ToInt32(TablaDatos.Rows[0][0].ToString());
                }
            }
            catch (Exception Ex) { Ex.ToString(); }
            return Numero;
        }



        public String BuscarUusario(String Usuario)
        {
            String Imagen = "";
            try
            {
                string[] a = this.Page.User.Identity.Name.Split('\\');
                SqlConnection con = new SqlConnection();
                con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConexionSIAW"].ToString();
                con.Open();
                SqlCommand com = new SqlCommand();
                com.Connection = con;
                com.CommandText = "select id_empleado from cat_empleados where user_red='" + Usuario + "'";
                com.ExecuteNonQuery();
                SqlDataAdapter Datos = new SqlDataAdapter(com);
                DataTable Tabla = new DataTable();
                Datos.Fill(Tabla);
                Imagen = Tabla.Rows[0][0].ToString();
                con.Close();
            }
            catch (Exception ex) { ex.ToString(); }
            return Imagen;
        }


        public String ObtenerMisPermisos(String Usuario)
        {
            String Resultado = "";
            DataTable TablaDatos = new DataTable();
            try
            {
                SqlConnection con = new SqlConnection();
                con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["SIFICA"].ToString();
                con.Open();
                SqlCommand com = new SqlCommand();
                com.Connection = con;
                com.Parameters.AddWithValue("@USUARIO", Usuario);
                com.CommandText = "VERIFICAR_PERMISOS";
                com.CommandType = CommandType.StoredProcedure;
                com.ExecuteNonQuery();
                SqlDataAdapter Datos = new SqlDataAdapter(com);
                Datos.Fill(TablaDatos);
                if (TablaDatos.Rows.Count >= 1)
                {
                    Resultado = TablaDatos.Rows[0][0].ToString();
                }
                con.Close();
            }
            catch (Exception ex) { ex.ToString(); }
            return Resultado;
        }





        protected void ASPxButton1_Click(object sender, EventArgs e)
        {
            //HttpCookie authCookie = new HttpCookie("Compañia", this.cboCia.SelectedItem.Value.ToString());
            ////authCookie.Name = "Compañia";
            ////authCookie.Value = this.cboCia.SelectedItem.Value.ToString();
            //authCookie.Expires = DateTime.Now.AddDays(365);
            //Response.Cookies.Add(authCookie);

            Session["Compañia"] = this.cboCia.SelectedItem.Value.ToString();
            //Session["CompañiaNombre"] = this.cboCia.SelectedItem.Text.ToString();
            this.popupCompañia.ShowOnPageLoad = false;
            ObtenerNombreEmpresa(); 
            LlenarMenu();
        }


        protected void LoginStatus1_LoggingOut(object sender, LoginCancelEventArgs e)
        {
            FormsAuthentication.SignOut();
            FormsAuthentication.RedirectToLoginPage();

        }

    }
}
