using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace GestiunePacienti
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Internare f1 = new Internare();
            f1.Show();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Externare f2 = new Externare();
            f2.Show();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            Consultatii f3 = new Consultatii();
            f3.Show();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            Istoric f4 = new Istoric();
            f4.Show();
        }

        private void button5_Click(object sender, EventArgs e)
        {
            Garzi f5 = new Garzi();
            f5.Show();
        }

        private void button6_Click(object sender, EventArgs e)
        {
            DoctorisiDepartamente f6 = new DoctorisiDepartamente();
            f6.Show();
        }
    }
}
