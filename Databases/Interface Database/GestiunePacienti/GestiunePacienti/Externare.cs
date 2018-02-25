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
    public partial class Externare : Form
    {
        public Externare()
        {
            InitializeComponent();
        }

        MySqlConnection con = new MySqlConnection("server=localhost;user id=root;password=root;database=gestiunepacienti;persistsecurityinfo=True");



        private void button1_Click(object sender, EventArgs e)
        {
            String query = "UPDATE spitalizare SET DataExternare = '" + textBox9.Text + "' WHERE Pacienti_IDPacient = '" + textBox6.Text + "' AND DataExternare IS NULL ";
            con.Open();
            MySqlCommand comm = new MySqlCommand(query, con);
            comm.ExecuteNonQuery();

            String query2 = "UPDATE sali SET Capacitate=(Capacitate+1) WHERE IdSala = (SELECT Sali_IDSala FROM spitalizare WHERE Pacienti_IDPacient = '" + textBox6.Text + "' LIMIT 1)";
            MySqlCommand comm2 = new MySqlCommand(query2, con);
            comm2.ExecuteNonQuery();

            String query3 = "UPDATE spitalizare SET SumaPlata=DATEDIFF( '" + textBox9.Text + "', DataInternare)*50 WHERE DataExternare = '" + textBox9.Text + "'";
            MySqlCommand comm3 = new MySqlCommand(query3, con);
            comm3.ExecuteNonQuery();

            MessageBox.Show("Inserare efectuata cu succes!");
            con.Close();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            string selectQuery = "SELECT * FROM  sali ";
            DataTable table = new DataTable();
            MySqlDataAdapter adapter = new MySqlDataAdapter(selectQuery, con);
            adapter.Fill(table);
            dataGridView1.DataSource = table;
        }

        private void button3_Click(object sender, EventArgs e)
        {
            string selectQuery = "SELECT * FROM pacienti WHERE Nume = '" + textBox1.Text + "' AND Prenume = '" + textBox2.Text + "' AND Sex = '" + textBox3.Text + "' AND Varsta = '" + textBox4.Text + "' AND DataNasterii = '" + textBox5.Text + "' ";
            DataTable table = new DataTable();
            MySqlDataAdapter adapter = new MySqlDataAdapter(selectQuery, con);
            adapter.Fill(table);
            dataGridViewPacienti2.DataSource = table;
        }

        private void button4_Click(object sender, EventArgs e)
        {
            string selectQuery = "SELECT * FROM  pacienti ";
            DataTable table = new DataTable();
            MySqlDataAdapter adapter = new MySqlDataAdapter(selectQuery, con);
            adapter.Fill(table);
            dataGridViewSpitalizare2.DataSource = table;
        }

        private void button4_Click_1(object sender, EventArgs e)
        {
            string selectQuery = "SELECT Nume, Prenume, Nrtelefon FROM pacienti P WHERE IdPacient IN (SELECT Pacienti_IDPacient FROM spitalizare WHERE SumaPlata >= 500) ";
            DataTable table = new DataTable();
            MySqlDataAdapter adapter = new MySqlDataAdapter(selectQuery, con);
            adapter.Fill(table);
            dataGridView2.DataSource = table;
        }

          private void button6_Click(object sender, EventArgs e)
        {
            string selectQuery = "SELECT * FROM  spitalizare ";
            DataTable table = new DataTable();
            MySqlDataAdapter adapter = new MySqlDataAdapter(selectQuery, con);
            adapter.Fill(table);
            dataGridViewSpitalizare2.DataSource = table;
        }

      

        private void dataGridViewPacienti_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            
        }

        private void groupBox2_Enter(object sender, EventArgs e)
        {

        }

        private void dataGridViewSali_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
         
        }

      
        private void groupBox1_Enter(object sender, EventArgs e)
        {

        }

       

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
         
        }

        private void dataGridView2_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
        
        }

       
    }
}
