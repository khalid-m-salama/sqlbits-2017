using System;
using System.Text;
using Microsoft.ServiceBus.Messaging;
using Newtonsoft.Json;

namespace GenerateDataToEventHub
{
    class Program
    {
        static string eventHubName = "<your event hub name>";
        static string connectionString = "<your event hub connection string>";

        static EventHubClient eventHubClient = EventHubClient.CreateFromConnectionString(connectionString, eventHubName);

        static void Main(string[] args)
        {
            Random r = new Random();

            while (true)
            {
                int input = r.Next(-50, 50);
                SendMessage(input);
                System.Threading.Thread.Sleep(500);
            }
      
        }

        private static void SendMessage(int input)
        {
            try
            {
                var dataPoint = new DataPoint() { Input = input };
                var message = JsonConvert.SerializeObject(dataPoint);
                Console.WriteLine("{0} > Sending message: {1}", DateTime.Now, message);
                eventHubClient.Send(new EventData(Encoding.UTF8.GetBytes(message)));
            }
            catch (Exception exception)
            {
                Console.ForegroundColor = ConsoleColor.Red;
                Console.WriteLine("{0} > Exception: {1}", DateTime.Now, exception.Message);
                Console.ResetColor();
            }
        }
    }

    public class DataPoint
    {
        public int Input
        { get; set; }
    }
}
