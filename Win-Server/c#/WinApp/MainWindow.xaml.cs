using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Net;
using System.IO;
using WinApp.playerx;
using System.Windows.Media.Imaging;

namespace WinApp
{
    /// <summary>
    /// MainWindow.xaml 的交互逻辑
    /// </summary>
    public partial class MainWindow : Window
    {
        Boolean isStart = false;
        HttpListener httpListener = null;

        public MainWindow()
        {
            InitializeComponent();
        }

        private void Server(object sender, RoutedEventArgs e)
        {
            Button button = (Button)sender;
            if (!isStart)
            {
                //qrImg.fr = User32.CreateQRCode(User32.GetLocalIpAddress());
                qrImg.Source =
                    System.Windows.Interop.Imaging.CreateBitmapSourceFromHBitmap(
                        User32.CreateQRCode(User32.GetLocalIpAddress()).GetHbitmap(),
                        IntPtr.Zero,
                        Int32Rect.Empty,
                        BitmapSizeOptions.FromEmptyOptions()
                        );
                isStart = true;
                button.Content = "停止";
                StartHttp();
            }
            else {
                isStart = false;
                httpListener.Close();
                button.Content = "启动";
            }
        }


        private void StartHttp() {
            httpListener = new HttpListener();
            httpListener.Prefixes.Add("http://+:8099/");
            httpListener.Start();
            httpListener.BeginGetContext(HttpHandler, httpListener);
           
        }

        private void HttpHandler(IAsyncResult result) {

            HttpListener listener = result.AsyncState as HttpListener;

            if (listener.IsListening)
            {
                httpListener.BeginGetContext(HttpHandler, httpListener);
                HttpListenerContext context = listener.EndGetContext(result);
                //解析Request请求
                HttpListenerRequest request = context.Request;
                switch (request.HttpMethod)
                {
                    case "GET":
                        {
                            var data = request.QueryString;
                            string action = data["action"];
                            if (null != action) {
                                playerx.PotPlayer.ActiveWin();
                                playerx.PotPlayer.Command(action);
                            }
                        }
                        break;
                }


                //构造Response响应
                HttpListenerResponse response = context.Response;
                response.StatusCode = 200;
                response.ContentType = "application/json;charset=UTF-8";
                response.ContentEncoding = Encoding.UTF8;
                response.AppendHeader("Content-Type", "application/json;charset=UTF-8");


                using (StreamWriter writer = new StreamWriter(response.OutputStream, Encoding.UTF8))
                {
                    writer.Write("OK");
                    writer.Close();
                    response.Close();
                }

            }
        }
    }
}
