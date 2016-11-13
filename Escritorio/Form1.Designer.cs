using System;
using System.Data.SqlClient;
using System.Data;
using System.Windows.Forms;
namespace Escritorio
{
    partial class grdClientes
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.cLIENTESBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.Clientes = new System.Windows.Forms.MenuStrip();
            this.clientesToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.catalogoDeClientesToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.contratosToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.proovedoresToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.ribbonPageGroup1 = new DevExpress.XtraBars.Ribbon.RibbonPageGroup();
            this.gridClientes = new System.Windows.Forms.DataGridView();
            this.ID = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.NUMERO = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.NOMBRE = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.DIRECCIÓN = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.TELEFONO = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.RFC = new System.Windows.Forms.DataGridViewTextBoxColumn();
            ((System.ComponentModel.ISupportInitialize)(this.cLIENTESBindingSource)).BeginInit();
            this.Clientes.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.gridClientes)).BeginInit();
            this.SuspendLayout();
            // 
            // cLIENTESBindingSource
            // 
         
            // 
            // Clientes
            // 
            this.Clientes.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.clientesToolStripMenuItem,
            this.proovedoresToolStripMenuItem});
            this.Clientes.Location = new System.Drawing.Point(0, 0);
            this.Clientes.Name = "Clientes";
            this.Clientes.Size = new System.Drawing.Size(913, 24);
            this.Clientes.TabIndex = 0;
            this.Clientes.Text = "menuStrip1";
            // 
            // clientesToolStripMenuItem
            // 
            this.clientesToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.catalogoDeClientesToolStripMenuItem,
            this.contratosToolStripMenuItem});
            this.clientesToolStripMenuItem.Name = "clientesToolStripMenuItem";
            this.clientesToolStripMenuItem.Size = new System.Drawing.Size(61, 20);
            this.clientesToolStripMenuItem.Text = "Clientes";
            // 
            // catalogoDeClientesToolStripMenuItem
            // 
            this.catalogoDeClientesToolStripMenuItem.Name = "catalogoDeClientesToolStripMenuItem";
            this.catalogoDeClientesToolStripMenuItem.Size = new System.Drawing.Size(183, 22);
            this.catalogoDeClientesToolStripMenuItem.Text = "Catalogo de Clientes";
            this.catalogoDeClientesToolStripMenuItem.Click += new System.EventHandler(this.catalogoDeClientesToolStripMenuItem_Click);
            // 
            // contratosToolStripMenuItem
            // 
            this.contratosToolStripMenuItem.Name = "contratosToolStripMenuItem";
            this.contratosToolStripMenuItem.Size = new System.Drawing.Size(183, 22);
            this.contratosToolStripMenuItem.Text = "Contratos";
            // 
            // proovedoresToolStripMenuItem
            // 
            this.proovedoresToolStripMenuItem.Name = "proovedoresToolStripMenuItem";
            this.proovedoresToolStripMenuItem.Size = new System.Drawing.Size(85, 20);
            this.proovedoresToolStripMenuItem.Text = "Proovedores";
            // 
            // ribbonPageGroup1
            // 
            this.ribbonPageGroup1.Name = "ribbonPageGroup1";
            this.ribbonPageGroup1.Text = "Clientes";
            // 
            // gridClientes
            // 
            this.gridClientes.AllowUserToOrderColumns = true;
            this.gridClientes.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill;
            this.gridClientes.AutoSizeRowsMode = System.Windows.Forms.DataGridViewAutoSizeRowsMode.AllCells;
            this.gridClientes.BackgroundColor = System.Drawing.Color.Azure;
            this.gridClientes.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.gridClientes.CellBorderStyle = System.Windows.Forms.DataGridViewCellBorderStyle.Raised;
            this.gridClientes.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.gridClientes.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.ID,
            this.NUMERO,
            this.NOMBRE,
            this.DIRECCIÓN,
            this.TELEFONO,
            this.RFC});
            this.gridClientes.Dock = System.Windows.Forms.DockStyle.Fill;
            this.gridClientes.EditMode = System.Windows.Forms.DataGridViewEditMode.EditProgrammatically;
            this.gridClientes.Location = new System.Drawing.Point(0, 24);
            this.gridClientes.Name = "gridClientes";
            this.gridClientes.Size = new System.Drawing.Size(913, 238);
            this.gridClientes.StandardTab = true;
            this.gridClientes.TabIndex = 1;
            this.gridClientes.Visible = false;
            // 
            // ID
            // 
            this.ID.DataPropertyName = "ID";
            this.ID.HeaderText = "ID";
            this.ID.Name = "ID";
            this.ID.Visible = false;
            // 
            // NUMERO
            // 
            this.NUMERO.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.NUMERO.DataPropertyName = "NUMERO";
            this.NUMERO.HeaderText = "NUMERO";
            this.NUMERO.Name = "NUMERO";
            // 
            // NOMBRE
            // 
            this.NOMBRE.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.NOMBRE.DataPropertyName = "NOMBRE";
            this.NOMBRE.HeaderText = "NOMBRE";
            this.NOMBRE.Name = "NOMBRE";
            // 
            // DIRECCIÓN
            // 
            this.DIRECCIÓN.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.DIRECCIÓN.DataPropertyName = "DIRECCION";
            this.DIRECCIÓN.HeaderText = "DIRECCIÓN";
            this.DIRECCIÓN.Name = "DIRECCIÓN";
            // 
            // TELEFONO
            // 
            this.TELEFONO.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.TELEFONO.DataPropertyName = "TELEFONO";
            this.TELEFONO.HeaderText = "TELEFONO";
            this.TELEFONO.Name = "TELEFONO";
            // 
            // RFC
            // 
            this.RFC.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.RFC.DataPropertyName = "RFC";
            this.RFC.HeaderText = "RFC";
            this.RFC.Name = "RFC";
            // 
            // grdClientes
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(913, 262);
            this.Controls.Add(this.gridClientes);
            this.Controls.Add(this.Clientes);
            this.MainMenuStrip = this.Clientes;
            this.Name = "grdClientes";
            this.Text = "grd";
            ((System.ComponentModel.ISupportInitialize)(this.cLIENTESBindingSource)).EndInit();
            this.Clientes.ResumeLayout(false);
            this.Clientes.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.gridClientes)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.BindingSource cLIENTESBindingSource;
        private System.Windows.Forms.MenuStrip Clientes;
        private System.Windows.Forms.ToolStripMenuItem clientesToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem catalogoDeClientesToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem contratosToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem proovedoresToolStripMenuItem;
        private DevExpress.XtraBars.Ribbon.RibbonPageGroup ribbonPageGroup1;
        private DataGridView gridClientes;
        private DataGridViewTextBoxColumn ID;
        private DataGridViewTextBoxColumn NUMERO;
        private DataGridViewTextBoxColumn NOMBRE;
        private DataGridViewTextBoxColumn DIRECCIÓN;
        private DataGridViewTextBoxColumn TELEFONO;
        private DataGridViewTextBoxColumn RFC;



    
    }
}

