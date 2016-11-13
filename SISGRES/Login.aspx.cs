using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Security;

namespace SISGRES
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

            }
        }




        protected void btnIniciarSesion_Click(object sender, EventArgs e)
        {
            try
            {
                SqlConnection Conex = new SqlConnection();
                Conex.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["SIFICA"].ToString();
                Conex.Open();
                SqlCommand com = new SqlCommand();
                com.Connection = Conex;
                com.CommandType = CommandType.StoredProcedure;
                com.CommandText = "USUARIOS_VALIDAR_ACCESO";
                com.Parameters.Add("@usuario", this.txtUsuario.Value);
                com.Parameters.Add("@password", this.txtPassword.Value);
                SqlDataReader leer = com.ExecuteReader();
                if (leer.HasRows)
                {
                    //bool isCookiePersistent = Login1.RememberMeSet;
                    FormsAuthenticationTicket authTicket = new FormsAuthenticationTicket(2,
                              this.txtUsuario.Value, DateTime.Now, DateTime.Now.AddDays(365), true , "");

                    string encryptedTicket = FormsAuthentication.Encrypt(authTicket);
                    HttpCookie authCookie = new HttpCookie(FormsAuthentication.FormsCookieName, encryptedTicket);

                    //HttpCookie authCookie = new HttpCookie(FormsAuthentication.FormsCookieName, "Usuario");
                    //if (isCookiePersistent)
                    //    authCookie.Expires = authTicket.Expiration;

                    //authCookie.Name = "Usuario";
                    //authCookie.Value = this.txtUsuario.Text;
                    //Response.Cookies.Add(authCookie);

                    //Session["Compañia"] = "";
                    Session.Abandon();
                    FormsAuthentication.RedirectFromLoginPage(this.txtUsuario.Value, true);

                }
                //else { this.lblError.Text = "!Usuario o Password Incorrecto!"; }
                Conex.Close();
            }
            catch (Exception ex) { 
                //this.lblError.Text=ex.ToString(); 
            }
        }
    }
}
