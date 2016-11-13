using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace Clases
{
    public class Conexion
    {
        public SqlConnection Conex()
        {
            SqlConnection con = new SqlConnection(ConfigurationSettings.AppSettings["Conexion"].ToString());
            return con;
        }
    }
}
