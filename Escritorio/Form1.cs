using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace Escritorio
{
    public partial class grdClientes : Form
    {
        public grdClientes()
        {
            InitializeComponent();
        }



        private void catalogoDeClientesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            LlenarClientes();
            this.gridClientes.Visible = true;
        }

        public void LlenarClientes()
        {
            try
            {
                SqlConnection con = new SqlConnection();
                con.ConnectionString = "DATA SOURCE=9HFY2Q1\\SQLEXPRESS;INITIAL CATALOG=ERP;USER ID=SA;PASSWORD=Imperio90";
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "CONSULTA_CLIENTES";
                cmd.Connection = con;
                cmd.CommandTimeout = 0;
                SqlDataAdapter Datos = new SqlDataAdapter(cmd);
                DataTable TablaDatos = new DataTable();
                Datos.Fill(TablaDatos);
                this.gridClientes.DataSource = TablaDatos;
                con.Close();
            }
            catch (Exception ex) { ex.ToString(); }
        }
    }
}
