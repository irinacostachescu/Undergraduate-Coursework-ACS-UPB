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
    public partial class Consultatii : Form
    {
        public Consultatii()
        {
            InitializeComponent();
        }

        MySqlConnection con = new MySqlConnection("server=localhost;user id=root;password=root;database=gestiunepacienti;persistsecurityinfo=True");

        private void label6_Click(object sender, EventArgs e)
        {

        }

        private void richTextBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {
            string selectQuery = "SELECT * FROM consultatie";
            DataTable table = new DataTable();
            MySqlDataAdapter adapter = new MySqlDataAdapter(selectQuery, con);
            adapter.Fill(table);
            Consultatii2.DataSource = table;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string selectQuery = "SELECT Nume, Prenume, IDDoctor FROM doctori JOIN departamente ON Departamente_IDDepartament = IDDepartament WHERE NumeDepartament =  '" + textBox10.Text + "' ";
            DataTable table = new DataTable();
            MySqlDataAdapter adapter = new MySqlDataAdapter(selectQuery, con);
            adapter.Fill(table);
            Consultatii1.DataSource = table;

        }

        private void button3_Click(object sender, EventArgs e)
        {
            string selectQuery = "SELECT * FROM pacienti WHERE Nume = '" + textBox1.Text + "' AND Prenume = '" + textBox2.Text + "' AND Sex = '" + textBox3.Text + "' AND Varsta = '" + textBox4.Text + "' AND DataNasterii = '" + textBox5.Text + "' ";
            DataTable table = new DataTable();
            MySqlDataAdapter adapter = new MySqlDataAdapter(selectQuery, con);
            adapter.Fill(table);
            dataGridViewPacienti3.DataSource = table;
        }

        private void dataGridViewPacienti3_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            //populate datagrid view
            string selectQuery = "SELECT * FROM pacienti WHERE Nume = '" + textBox1.Text + "' AND Prenume = '" + textBox2.Text + "' AND Sex = '" + textBox3.Text + "' AND Varsta = '" + textBox4.Text + "' AND DataNasterii = '" + textBox5.Text + "' ";
            DataTable table = new DataTable();
            MySqlDataAdapter adapter = new MySqlDataAdapter(selectQuery, con);
            adapter.Fill(table);
            dataGridViewPacienti3.DataSource = table;
        }

        private void Consultatii1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {   
            //populate datagrid view
            string selectQuery = "SELECT Nume, Prenume, IDDoctor FROM doctori JOIN departamente ON Departamente_IDDepartament = IDDepartament WHERE NumeDepartament =  '" + textBox10.Text + "' ";
            DataTable table = new DataTable();
            MySqlDataAdapter adapter = new MySqlDataAdapter(selectQuery, con);
            adapter.Fill(table);
            Consultatii1.DataSource = table;
        }

        private void button6_Click(object sender, EventArgs e)
        {
            String query = "INSERT INTO consultatie (Pacienti_IDPacient,Doctori_IDDoctor,Data,Ora) VALUES ('" + textBox6.Text + "','" + textBox7.Text + "','" + textBox8.Text + "', '" + textBox9.Text + "')";
            con.Open();
            MySqlCommand comm = new MySqlCommand(query, con);
            comm.ExecuteNonQuery();
            MessageBox.Show("Inserare efectuata cu succes!");
            con.Close();
        }

        private void Consultatii2_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            string selectQuery = "SELECT * FROM consultatie";
            DataTable table = new DataTable();
            MySqlDataAdapter adapter = new MySqlDataAdapter(selectQuery, con);
            adapter.Fill(table);
            Consultatii2.DataSource = table;
        }

        private void button7_Click(object sender, EventArgs e)
        {
            string selectQuery = "SELECT C.IDConsultatie,C.Data,C.Ora FROM consultatie C JOIN doctori D ON C.Doctori_IDDoctor=D.IDDoctor  WHERE D.Nume = '" + textBox13.Text + "' AND D.Prenume = '" + textBox16.Text + "' AND C.Data = '"+ textBox12.Text +"' ";
            DataTable table = new DataTable();
            MySqlDataAdapter adapter = new MySqlDataAdapter(selectQuery, con);
            adapter.Fill(table);
            Consultatii3.DataSource = table;
        }

        private void Consultatii3_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            string selectQuery = "SELECT C.IDConsultatie,C.Data,C.Ora FROM consultatie C JOIN doctori D ON C.Doctori_IDDoctor=D.IDDoctor  WHERE D.Nume = '" + textBox13.Text + "' AND D.Prenume = '" + textBox16.Text + "' AND C.Data = '" + textBox12.Text + "' ";
            DataTable table = new DataTable();
            MySqlDataAdapter adapter = new MySqlDataAdapter(selectQuery, con);
            adapter.Fill(table);
            Consultatii3.DataSource = table;
        }

        private void button5_Click(object sender, EventArgs e)
        {   
            String query = "UPDATE consultatie SET Data = '" + textBox14.Text +"' , Ora = '"+textBox15.Text+"' WHERE IDConsultatie = '" + textBox11.Text + "'";
            con.Open();
            MySqlCommand comm = new MySqlCommand(query, con);
            comm.ExecuteNonQuery();
            MessageBox.Show("Inserare efectuata cu succes!");
            con.Close();

        }

        private void button4_Click(object sender, EventArgs e)
        {
            String query = "DELETE FROM consultatie WHERE IDConsultatie = '" + textBox11.Text + "' ";
            con.Open();
            MySqlCommand comm = new MySqlCommand(query, con);
            comm.ExecuteNonQuery();
            MessageBox.Show("Inserare efectuata cu succes!");
            con.Close();
        }
    }
}
