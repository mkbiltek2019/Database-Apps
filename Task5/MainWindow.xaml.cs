﻿using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using MongoDB.Bson;
using MongoDB.Bson.IO;
using MongoDB.Driver;

namespace Task5
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        const string ConnetionString = "mongodb://localhost";
        const string DbName = "Reports";
        private const string ColectionName = "SalesByProductReports";
        private const string Dbpath = @"c:\data\db";

        private DateTime starDate = DateTime.Now;
        private DateTime endDate = DateTime.Now;
        public MainWindow()
        {
            InitializeComponent();
            MakeCalendars();
        }

        private void MakeCalendars()
        {
            // TODO: Set dates wit first and last date form db
            var endCalendar = this.FindName("ReportEndDate") as Calendar;
            var startCalendar = this.FindName("ReportStartDate") as Calendar;

            // TODO: Check for null
            endCalendar.DisplayDateStart = new DateTime(2015, 02, 12);
            startCalendar.DisplayDateStart = new DateTime(2015, 02, 12);
            endCalendar.DisplayDateEnd = DateTime.Now;
            startCalendar.DisplayDateEnd = DateTime.Now;
        }

        public DateTime StarDate
        {
            get
            {
                return this.starDate;
            }
            set
            {
                this.starDate = value;
            }
        }

        public DateTime EndDate
        {
            get
            {
                return this.endDate;
            }
            set
            {
                this.endDate = value;
            }
        }

        private void ReportStartDate_OnSelectedDatesChanged(object sender, SelectionChangedEventArgs e)
        {
            var calendar = sender as Calendar;

            //TODO: Make check for null
            if (calendar.SelectedDate.HasValue)
            {
                // MessageBox.Show(calendar.SelectedDate.Value.ToShortDateString());
                this.StarDate = calendar.SelectedDate.GetValueOrDefault(DateTime.Now);
                var box = this.FindName("StartDateBox") as TextBox;

                //TODO: Make check for null
                box.Text = this.StarDate.ToShortDateString();
            }
        }

        private void ReportEndDate_OnSelectedDatesChanged(object sender, SelectionChangedEventArgs e)
        {
            var calendar = sender as Calendar;

            //TODO: Make check for null
            if (calendar.SelectedDate.HasValue)
            {
                this.EndDate = calendar.SelectedDate.GetValueOrDefault(DateTime.Now);
                var box = this.FindName("EndDateBox") as TextBox;

                //TODO: Make check for null
                box.Text = this.EndDate.ToShortDateString();
            }
        }

        private void MakeReportButton_OnClick(object sender, RoutedEventArgs e)
        {
            // TODO: When db is redy
            // Get all data from sql server. With foreach meake report for all products in given period

            var report = new BsonDocument
            {
                {"product-id", 3},
                {"product-name", "Beer “Zagorka”"},
                {"vendor-name", "Zagorka Corp."},
                {"total-quantity-sold", 673},
                {"total-incomes", 700.24}
            };

            if (!Directory.Exists(@"c:\reports"))
            {
                Directory.CreateDirectory(@"c:\reports");
            }

            string destination = string.Format("c:\\reports\\{0}_[{1}__{2}].json", report["product-id"], this.starDate.ToShortDateString(), endDate.ToShortDateString());
            File.WriteAllText(@destination, report.ToJson(
                new JsonWriterSettings { OutputMode = JsonOutputMode.Strict }));
            MessageBox.Show("Reports are done!");
        }

        private Process StartMongoServer()
        {
            if (!Directory.Exists(Dbpath))
            {
                Directory.CreateDirectory(Dbpath);
            }

            var startInfo = new ProcessStartInfo();
            //startInfo.CreateNoWindow = true;
            startInfo.UseShellExecute = true;
            startInfo.FileName = "mongod.exe";
            startInfo.Arguments = "--dbpath " + Dbpath;
            startInfo.WindowStyle = ProcessWindowStyle.Hidden;
            return Process.Start(startInfo);
        }

        private void SendReportButton_OnClick(object sender, RoutedEventArgs e)
        {
            var process = StartMongoServer();
            SendReportToMongo(process);
        }

        private static void SendReportToMongo(Process process)
        {
            try
            {
                var client = new MongoClient(ConnetionString);
                var server = client.GetServer();
                var db = server.GetDatabase(DbName);
                var isExist = db.CollectionExists(ColectionName);
                if (!isExist)
                {
                    db.CreateCollection(ColectionName);
                }

                var report = new BsonDocument
            {
                {"product-id", 3},
                {"product-name", "Beer “Zagorka”"},
                {"vendor-name", "Zagorka Corp."},
                {"total-quantity-sold", 673},
                {"total-incomes", 609.24}
            };

                var reports = db.GetCollection(ColectionName);
                reports.Insert(report);
                // If document exist change field values else create document
                //            var rep = reports.FindOne(Query.EQ("product-id", ));
                //            if (rep == null)
                //            {
                //                reports.Insert(report);
                //            }
                //            else
                //            {
                //                //TODO: Set only new values without make new document
                //                //                rep["total-incomes"] = 10;
                //                //                reports.Save(rep);
                //            }

                // This kill mongod.exe procces
                Thread.Sleep(5000);
                process.Kill();

                MessageBox.Show("Your data are on the server now!");
            }
            catch (Exception)
            {
                MessageBox.Show("We have problem with connection! Please try again later!");
            }
            
        }
    }
}
