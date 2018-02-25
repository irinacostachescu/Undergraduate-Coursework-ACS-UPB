using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using MySql.Data.MySqlClient; //introduc biblioteca mySQL

namespace GestiunePacienti
{
    public partial class Internare : Form
    {
        public Internare()
        {
            InitializeComponent();
        }

        //Realizez conexiunea cu serverul bazei de date
        MySqlConnection con = new MySqlConnection("server=localhost;user id=root;password=root;database=gestiunepacienti;persistsecurityinfo=True");


        //Metodele de mai jos reprezinta toate butoanele/textbox-urile/groupbox-urile/etc pe care le am in interfata
        private void label3_Click(object sender, EventArgs e)
        {

        }

        private void groupBox1_Enter(object sender, EventArgs e)
        {

        }

        private void groupBox2_Enter(object sender, EventArgs e)
        {

        }

        private void label8_Click(object sender, EventArgs e)
        {

        }

        private void groupBox3_Enter(object sender, EventArgs e)
        {

        }

        private void Internare_Load(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {
           
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string selectQuery = "SELECT * FROM sali";              //Afiseaza sali (obiect tip data grid-view, afiseaza functionalitatea implementata)
            DataTable table = new DataTable();                      //creez tabela pentru a o afisa in spatiul grid-view
            MySqlDataAdapter adapter = new MySqlDataAdapter(selectQuery, con);  //creez obiectul care va efectua interogarea
            adapter.Fill(table);                //apelez comanda pentru efectuarea interogarii; parametrul este obiectul tabela, in care vreau sa aiba loc afisarea rezultatului interogarii
            dataGridViewSali.DataSource = table; //tebelul sursa pentru afisare este cel delcarat anterior
        }

        private void dataGridView2_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            //populate datagridview
            string selectQuery = "SELECT * FROM pacienti";      //Afiseaza pacienti
            DataTable table = new DataTable();
            MySqlDataAdapter adapter = new MySqlDataAdapter(selectQuery, con);
            adapter.Fill(table);
            dataGridViewPacienti.DataSource = table; 

        }

        private void button3_Click(object sender, EventArgs e)  //Inserez in pacienti
        {
            String query = "INSERT INTO pacienti (Nume,Prenume,Sex,Varsta,DataNasterii) VALUES ('" + textBox1.Text + "','" + textBox2.Text + "','" + textBox3.Text + "','" + textBox4.Text + "','" + textBox5.Text + "')";
            con.Open(); //deschid conexiunea
            MySqlCommand comm = new MySqlCommand(query, con); //creez comanda
            comm.ExecuteNonQuery(); //o apelez
            MessageBox.Show("Inserare efectuata cu succes!"); //afisez un mesaj dupa efectuarea comenzii
            con.Close();            //inchid conexiunea
        }

        private void button5_Click(object sender, EventArgs e) //Afiseaza pacienti (obiect corelat cu obiectul de tip data grid_view; ambele implementeaza aceeasi functionalitate
            //Este nevoie de acelasi cod atat in metoda butonului, cat si in cea a obiectului de tip data grid-view pentru ca in aceasta sa se afiseze ceea ce butonul executa;
        {
            string selectQuery = "SELECT * FROM pacienti";
            DataTable table = new DataTable();
            MySqlDataAdapter adapter = new MySqlDataAdapter(selectQuery, con);
            adapter.Fill(table);
            dataGridViewPacienti.DataSource = table;
        }

       

       private void button6_Click(object sender, EventArgs e)
        {
            string selectQuery = "SELECT * FROM spitalizare"; //Afisez inregistrarile tabelei spitalizare
            DataTable table = new DataTable();
            MySqlDataAdapter adapter = new MySqlDataAdapter(selectQuery, con);
            adapter.Fill(table);
            dataGridViewSpitalizare.DataSource = table;
        }

        private void button4_Click(object sender, EventArgs e) //Inserez in spitalizare
        {
            String query = "INSERT INTO spitalizare (Pacienti_IDPacient,Sali_IDSala,Diagnostic,DataInternare) VALUES ('" + textBox6.Text + "','" + textBox7.Text + "','" + textBox8.Text + "','" + textBox9.Text + "')";
            con.Open();
            MySqlCommand comm = new MySqlCommand(query, con);
            comm.ExecuteNonQuery();
            MessageBox.Show("Internare finalizata cu succes!");

            String query2 = "UPDATE sali SET Capacitate=(Capacitate-1) WHERE IdSala = '" + textBox7.Text + "' "; //In acelasi timp, updatez capacitatea salii in care s-a facut internarea;
            MySqlCommand comm2 = new MySqlCommand(query2, con);
            comm2.ExecuteNonQuery();
            con.Close();
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            //populate datagridview
            string selectQuery = "SELECT * FROM spitalizare";
            DataTable table = new DataTable();
            MySqlDataAdapter adapter = new MySqlDataAdapter(selectQuery, con);
            adapter.Fill(table);
            dataGridViewSpitalizare.DataSource = table;

        }

        private void dataGridViewSali_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {   
            //populate data girdview
            string selectQuery = "SELECT * FROM sali WHERE (Capacitate > 0)";
            DataTable table = new DataTable();
            MySqlDataAdapter adapter = new MySqlDataAdapter(selectQuery, con);
            adapter.Fill(table);
            dataGridViewSali.DataSource = table;
        }
    }
}
