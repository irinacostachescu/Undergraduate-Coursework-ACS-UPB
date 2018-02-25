using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using MySql.Data.MySqlClient;

namespace GestiunePacienti
{
    public partial class Istoric : Form
    {
        public Istoric()
        {
            InitializeComponent();
        }

        MySqlConnection con = new MySqlConnection("server=localhost;user id=root;password=root;database=gestiunepacienti;persistsecurityinfo=True");

        private void groupBox2_Enter(object sender, EventArgs e)
        {

        }

        private void groupBox3_Enter(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            string selectQuery = "SELECT P.Nume, P.Prenume, S.Etaj, S.NumarSala FROM ((spitalizare I INNER JOIN pacienti P ON I.Pacienti_IDPacient = P.IdPacient) INNER JOIN sali S ON I.Sali_IDSala = S.Idsala ) WHERE I.DataInternare = '" + textBox1.Text + "' ";
            DataTable table = new DataTable();
            MySqlDataAdapter adapter = new MySqlDataAdapter(selectQuery, con);
            adapter.Fill(table);
            dataGridView3.DataSource = table;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            string selectQuery = "SELECT D.Nume as NumeDoctor, D.Prenume AS PrenumeDoctor FROM garzi G INNER JOIN doctori D ON G.Doctori_IDDoctor = D.IDDoctor WHERE G.Datagarda = '" + textBox1.Text + "' ";
            DataTable table = new DataTable();
            MySqlDataAdapter adapter = new MySqlDataAdapter(selectQuery, con);
            adapter.Fill(table);
            dataGridView4.DataSource = table;
        }

        private void button3_Click(object sender, EventArgs e)
        {
            string selectQuery = "SELECT P.Nume AS NumePacient, P.Prenume AS PrenumePacient, D.Nume AS NumeDoctor, D.Prenume AS PrenumeDoctor FROM ((consultatie C INNER JOIN pacienti P ON C.Pacienti_IDPacient = P.IdPacient) INNER JOIN doctori D ON C.Doctori_IDDoctor = D.IDDoctor ) WHERE C.Data = '" + textBox1.Text + "' ";
            DataTable table = new DataTable();
            MySqlDataAdapter adapter = new MySqlDataAdapter(selectQuery, con);
            adapter.Fill(table);
            dataGridView2.DataSource = table;
        }

        private void button4_Click(object sender, EventArgs e)
        {
            string selectQuery = "SELECT P.Nume, P.Prenume, S.Etaj, S.NumarSala FROM ((spitalizare I INNER JOIN pacienti P ON I.Pacienti_IDPacient = P.IdPacient) INNER JOIN sali S ON I.Sali_IDSala = S.Idsala ) WHERE I.DataExternare = '" + textBox1.Text + "' ";
            DataTable table = new DataTable();
            MySqlDataAdapter adapter = new MySqlDataAdapter(selectQuery, con);
            adapter.Fill(table);
            dataGridView1.DataSource = table;
        }


        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void dataGridView2_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void dataGridView3_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
      
        }

        private void dataGridView4_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
   
        }
    }
}
