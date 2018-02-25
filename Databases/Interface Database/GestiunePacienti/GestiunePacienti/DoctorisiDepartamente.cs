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
    public partial class DoctorisiDepartamente : Form
    {
        public DoctorisiDepartamente()
        {
            InitializeComponent();
        }
        MySqlConnection con = new MySqlConnection("server=localhost;user id=root;password=root;database=gestiunepacienti;persistsecurityinfo=True");

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            string selectQuery = "SELECT * FROM doctori";
            DataTable table = new DataTable();
            MySqlDataAdapter adapter = new MySqlDataAdapter(selectQuery, con);
            adapter.Fill(table);
            dataGridView1.DataSource = table;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string selectQuery = "SELECT IDDepartament, Numedepartament FROM departamente WHERE 3 > (SELECT COUNT(*) FROM doctori WHERE departamente.IDDepartament = Departamente_IDDepartament)";
            DataTable table = new DataTable();
            MySqlDataAdapter adapter = new MySqlDataAdapter(selectQuery, con);
            adapter.Fill(table);
            dataGridView2.DataSource = table;
        }

        private void dataGridView2_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            string selectQuery = "SELECT IDDepartament, Numedepartament FROM departamente WHERE 3 > (SELECT COUNT(*) FROM doctori WHERE departamente.IDDepartament = Departamente_IDDepartament)";
            DataTable table = new DataTable();
            MySqlDataAdapter adapter = new MySqlDataAdapter(selectQuery, con);
            adapter.Fill(table);
            dataGridView2.DataSource = table;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            String query = "INSERT INTO doctori (Nume,Prenume,Departamente_IDDepartament) VALUES ('" + textBox1.Text + "','" + textBox2.Text + "','" + textBox3.Text + "')";
            con.Open();
            MySqlCommand comm = new MySqlCommand(query, con);
            comm.ExecuteNonQuery();
            MessageBox.Show("Angajare finalizata cu succes!");
        }

        private void button3_Click(object sender, EventArgs e)
        {
            string selectQuery = "SELECT * FROM doctori";
            DataTable table = new DataTable();
            MySqlDataAdapter adapter = new MySqlDataAdapter(selectQuery, con);
            adapter.Fill(table);
            dataGridView1.DataSource = table;
        }

        private void button4_Click(object sender, EventArgs e)
        {
            string selectQuery = "SELECT Nume, Prenume, SUM(Nrorelucrate) FROM doctori D, garzi G WHERE IDDoctor = Doctori_IDDoctor GROUP BY IDDoctor HAVING SUM(Nrorelucrate) > (SELECT AVG(Nrorelucrate) FROM garzi)";
            DataTable table = new DataTable();
            MySqlDataAdapter adapter = new MySqlDataAdapter(selectQuery, con);
            adapter.Fill(table);
            dataGridView3.DataSource = table;
        }

        private void dataGridView3_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            string selectQuery = "SELECT Nume, Prenume, SUM(Nrorelucrate) FROM doctori, garzi  WHERE IDDoctor = Doctori_IDDoctor GROUP BY IDDoctor HAVING SUM(Nrorelucrate) > (SELECT AVG(Nrorelucrate) FROM garzi)";
            DataTable table = new DataTable();
            MySqlDataAdapter adapter = new MySqlDataAdapter(selectQuery, con);
            adapter.Fill(table);
            dataGridView3.DataSource = table;
        }

        private void button5_Click(object sender, EventArgs e)
        {
            string selectQuery = "SELECT D.Nume, D.Prenume, (SELECT COUNT(*) FROM consultatie C WHERE C.Doctori_IDDoctor = D.IDDoctor) AS Nr_pacienti FROM Doctori D";
            DataTable table = new DataTable();
            MySqlDataAdapter adapter = new MySqlDataAdapter(selectQuery, con);
            adapter.Fill(table);
            dataGridView4.DataSource = table;
        }

        private void dataGridView4_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            string selectQuery = "SELECT  D.Nume, D.Prenume, (SELECT COUNT(*) FROM consultatie C WHERE C.Doctori_IDDoctor = D.IDDoctor) AS Nr_pacienti FROM Doctori D";
            DataTable table = new DataTable();
            MySqlDataAdapter adapter = new MySqlDataAdapter(selectQuery, con);
            adapter.Fill(table);
            dataGridView4.DataSource = table;
        }
    }
}
