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
    public partial class Garzi : Form
    {
        public Garzi()
        {
            InitializeComponent();
        }

        MySqlConnection con = new MySqlConnection("server=localhost;user id=root;password=root;database=gestiunepacienti;persistsecurityinfo=True");

        private void button1_Click(object sender, EventArgs e)
        {
            string selectQuery = "SELECT D.IDDoctor AS ID_Doctor, D.Nume AS NumeDoctor, D.Prenume AS PrenumeDoctor, SUM(G.Nrorelucrate) AS Nr_ore FROM doctori D JOIN garzi G ON D.IDDoctor = G.Doctori_IDDoctor GROUP BY D.IDDoctor HAVING SUM(Nrorelucrate) < 10 ORDER BY SUM(Nrorelucrate)";
            DataTable table = new DataTable();
            MySqlDataAdapter adapter = new MySqlDataAdapter(selectQuery, con);
            adapter.Fill(table);
            dataGridView1.DataSource = table;
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            string selectQuery = "SELECT D.IDoctor AS ID_Doctor, D.Nume AS NumeDoctor, D.Prenume AS PrenumeDoctor, SUM(G.Nrorelucrate) AS Nr_ore FROM doctori D JOIN garzi G ON D.IDDoctor = G.Doctori_IDDoctor GROUP BY D.IDDoctor HAVING SUM(Nrorelucrate) < 10 ORDER BY SUM(Nrorelucrate)";
            DataTable table = new DataTable();
            MySqlDataAdapter adapter = new MySqlDataAdapter(selectQuery, con);
            adapter.Fill(table);
            dataGridView1.DataSource = table;
        }

        private void button6_Click(object sender, EventArgs e)
        {
            string selectQuery = "SELECT * FROM garzi";
            DataTable table = new DataTable();
            MySqlDataAdapter adapter = new MySqlDataAdapter(selectQuery, con);
            adapter.Fill(table);
            dataGridView2.DataSource = table;
        }

        private void dataGridView2_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            string selectQuery = "SELECT * FROM garzi";
            DataTable table = new DataTable();
            MySqlDataAdapter adapter = new MySqlDataAdapter(selectQuery, con);
            adapter.Fill(table);
            dataGridView2.DataSource = table;
        }

        private void button3_Click(object sender, EventArgs e)
        {
            String query = "INSERT INTO garzi (Datagarda,Nrorelucrate,Doctori_IDDoctor) VALUES ('" + textBox7.Text + "','" + textBox3.Text + "','" + textBox2.Text + "')";
            con.Open();
            MySqlCommand comm = new MySqlCommand(query, con);
            comm.ExecuteNonQuery();
            MessageBox.Show("Internare finalizata cu succes!");
        }

        private void label3_Click(object sender, EventArgs e)
        {

        }

        private void button4_Click(object sender, EventArgs e)
        {
            string selectQuery = "SELECT G.IDGarda, G.Datagarda, G.Nrorelucrate FROM garzi G JOIN doctori D ON G.Doctori_IDDoctor = D.IDDoctor WHERE D.Nume = '" + textBox4.Text + "' AND D.Prenume = '" + textBox5.Text + "' ";
            DataTable table = new DataTable();
            MySqlDataAdapter adapter = new MySqlDataAdapter(selectQuery, con);
            adapter.Fill(table);
            dataGridView3.DataSource = table;
        }

        private void dataGridView3_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            string selectQuery = "SELECT G.IDGarda, G.Datagarda, G.Nrorelucrate FROM garzi G JOIN doctori D ON G.Doctori_IDDoctor = D.IDDoctor WHERE D.Nume = '" + textBox4.Text + "' AND D.Prenume = '" + textBox5.Text + "' ";
            DataTable table = new DataTable();
            MySqlDataAdapter adapter = new MySqlDataAdapter(selectQuery, con);
            adapter.Fill(table);
            dataGridView3.DataSource = table;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            String query = "UPDATE garzi SET Nrorelucrate = '" + textBox6.Text + "' WHERE Datagarda = '"+textBox1.Text+"' ";
            MySqlCommand comm = new MySqlCommand(query, con);
            comm.ExecuteNonQuery();
         

            string selectQuery = "SELECT G.IDGarda, G.Datagarda, G.Nrorelucrate FROM garzi G JOIN doctori D ON G.Doctori_IDDoctor = D.IDDoctor WHERE D.Nume = '" + textBox4.Text + "' AND D.Prenume = '" + textBox5.Text + "' ";
            DataTable table = new DataTable();
            MySqlDataAdapter adapter = new MySqlDataAdapter(selectQuery, con);
            adapter.Fill(table);
            dataGridView3.DataSource = table;
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void button5_Click(object sender, EventArgs e)
        {
            String query = "DELETE FROM garzi WHERE Doctori_IDDoctor = '" + textBox9.Text + "'  AND Datagarda = '" + textBox8.Text + "'   ";
            con.Open();
            MySqlCommand comm = new MySqlCommand(query, con);
            comm.ExecuteNonQuery();
            MessageBox.Show("Stergere finalizata cu succes!");
        }

        private void groupBox2_Enter(object sender, EventArgs e)
        {

        }
    }
}
