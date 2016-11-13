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
using System.Configuration;


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

                        //DataTable dt = this.GetData();
                        //PopulateMenu(dt, 0, null);

                    }
                    else { this.popupCompañia.ShowOnPageLoad = true; }
                }
                catch (Exception ex) { ex.ToString(); }
            }
        }

        protected void Perfil_Click(object sender, EventArgs e)
        {
            SIFICADataContext db = new SIFICADataContext();
            //var q = db.USUARIOS_MOSTRAR_PERFIL(this.Page.User.Identity.Name.ToString());
            //foreach (var i in q)
            //{
            //    this.txtPrimerNombre.Text = i.NOMBRE;
            //    this.txtSegundoNombre.Text = i.SEGUNDO_NOMBRE;
            //    this.txtApellidoPaterno.Text = i.APELLIDO_PATERNO;
            //    this.txtApellidoMaterno.Text = i.APELLIDO_MATERNO;
            //    this.CorreoElectronico.Text = i.CORREO;
            //    this.FechaNacimiento.Date = Convert.ToDateTime(i.FECHA_NACIMIENTO);
            //}
            ScriptManager.RegisterStartupScript(this, this.GetType(), "MiPerfil", "MiPerfil();", true);
        }

        protected void btnModificar_Click(object sender, EventArgs e)
        {
            try
            {
                SIFICADataContext db = new SIFICADataContext();
                db.USUARIOS_MODIFICAR_CONTRASEÑA(this.ASPxTextBox2.Text, this.Page.User.Identity.Name.ToString());
                db.SubmitChanges();
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "mensajeria", "$('#mensajeria').removeData('#mensajeria').modal({ backdrop: 'static',  keyboard: true});", true);
            }
            catch (Exception ex) { ex.ToString(); }
        }

        protected void btnGuardarPerfil_Click(object sender, EventArgs e)
        {
            try
            {
                //SIFICADataContext db = new SIFICADataContext();
                //db.USUARIOS_MODIFICAR_PERFIL(this.Page.User.Identity.Name.ToString(), this.txtPrimerNombre.Text, this.txtSegundoNombre.Text, this.txtApellidoPaterno.Text, this.txtApellidoMaterno.Text, this.CorreoElectronico.Text, this.FechaNacimiento.Date);
                //db.SubmitChanges();
                //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "mensajeria", "$('#mensajeria').removeData('#mensajeria').modal({ backdrop: 'static',  keyboard: true});", true);
            }
            catch (Exception ex) { ex.ToString(); }
        }
        protected void btnCerrarSession_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            FormsAuthentication.RedirectToLoginPage();
        }

        public void ObtenerNombreEmpresa()
        {
            SIFICADataContext DB = new SIFICADataContext();
            var Query = DB.COMPAÑIAS_MOSTRAR_ID(Int32.Parse(Session["Compañia"].ToString()));
            foreach (var i in Query)
            {
                //this.ASPxLabel1.Text = i.COMPAÑIA;
                this.Image1.ImageUrl = i.IMAGEURL;

            }
        }

        private DataTable GetData()
        {
            string query = "OBTENER_MENU2";
            string constr = ConfigurationManager.ConnectionStrings["SIFICA"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                DataTable dt = new DataTable();
                using (SqlCommand cmd = new SqlCommand(query))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Parameters.AddWithValue("@USUARIO", this.Page.User.Identity.Name.ToString());
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        sda.Fill(dt);
                    }
                }
                return dt;
            }
        }

        private DataTable GetData(int parentId)
        {
            string query = "DECLARE @CADENA AS VARCHAR(MAX) SELECT @CADENA=PERMISOS from ROLES A LEFT JOIN USUARIOS B ON A.ID_ROL=B.ID_ROL where B.USUARIO='" + this.Page.User.Identity.Name.ToString() + "' SELECT Id,ParentId, Name, ToolTip, NavigateUrl FROM [Menu] where ParentId=" + parentId + " and ID IN (SELECT VAL from dbo.Split(@CADENA, ','))";
            string constr = ConfigurationManager.ConnectionStrings["SIFICA"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                DataTable dt = new DataTable();
                using (SqlCommand cmd = new SqlCommand(query))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Parameters.AddWithValue("@ParentId", parentId);
                        cmd.CommandType = CommandType.Text;
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        sda.Fill(dt);
                    }
                }
                return dt;
            }
        }

        private void PopulateMenu(DataTable dt, int parentMenuId, MenuItem parentMenuItem)
        {
            string currentPage = Path.GetFileName(Request.Url.AbsolutePath);
            foreach (DataRow row in dt.Rows)
            {
                MenuItem menuItem = new MenuItem
                {
                    Value = row["Id"].ToString(),
                    Text = row["Name"].ToString(),
                    NavigateUrl = row["NavigateUrl"].ToString(),
                    Selected = row["NavigateUrl"].ToString().EndsWith(currentPage, StringComparison.CurrentCultureIgnoreCase)
                };
                if (parentMenuId == 0)
                {
                    //Menu.Items.Add(menuItem);
                    DataTable dtChild = this.GetData(int.Parse(menuItem.Value));
                    PopulateMenu(dtChild, int.Parse(menuItem.Value), menuItem);
                }
                else
                {
                    parentMenuItem.ChildItems.Add(menuItem);
                }
            }
        }


        public void LlenarMenu()
        {
            try
            {
                //this.ASPxLabel1.Text = Session["CompañiaNombre"].ToString();
                String Form = ObtenerNumeroFormulario(Path.GetFileName(Request.Url.AbsolutePath)).ToString();
                String MisPermisos = ObtenerMisPermisos(HttpContext.Current.User.Identity.Name.ToString());
                //String MisPermisos = ObtenerMisPermisos(this.Page.User.Identity.Name.ToString());
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
            //DataTable dt = this.GetData();
            //PopulateMenu(dt, 0, null);
        }


        protected void LoginStatus1_LoggingOut(object sender, LoginCancelEventArgs e)
        {
            FormsAuthentication.SignOut();
            FormsAuthentication.RedirectToLoginPage();

        }

    }
}
