using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace CognitiveServicesDemo
{
    public partial class MainFrom : Form
    {
        public MainFrom()
        {
            InitializeComponent();
        }

        bool isRunning = false;
        string folderPath = @"C:\Master\Technology\Source Code\CSharp\SqlbitsDemos\CognitveServicesDemo\Images";
        Random random = new Random();
   

        private void button1_Click(object sender, EventArgs e)
        {

            if (isRunning)
            {
                this.button1.Text = "Start";
                this.isRunning = false;
            }
            else
            {
                this.button1.Text = "Stop";
                this.isRunning = true;
            }

        }



        private void backgroundWorker1_ProgressChanged(object sender, ProgressChangedEventArgs e)
        {
            var imageBytes = this.GetImageByteRandomly();

            var stream = new System.IO.MemoryStream(imageBytes);

            try
            {
                lbEmotion.Text = "processing...";
         
                string emotion = EmotionAPIWrapper.GetEmotions(imageBytes);
                this.pictureBox1.Image = Image.FromStream(stream);
                
                lbEmotion.Text = emotion.ToUpper();


            }
            catch {

                lbEmotion.Text = "processing...";
            }
        }

        private byte[] GetImageByteRandomly()
        {
            return System.IO.File.ReadAllBytes(GetImageFilePathRandomly());
        }

        private string GetImageFilePathRandomly()
        {          

            var files = System.IO.Directory.GetFiles(this.folderPath);

            int index = random.Next(0, files.Length);

            return files[index];
        }

        private void backgroundWorker1_DoWork(object sender, DoWorkEventArgs e)
        {
            while (true)
            {
                if (isRunning)
                {
                    backgroundWorker1.ReportProgress(0);                    
                }

                System.Threading.Thread.Sleep(2000);
            }
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            if (this.backgroundWorker1.IsBusy != true)
            {
                backgroundWorker1.RunWorkerAsync();
            }
        }
    }
}
