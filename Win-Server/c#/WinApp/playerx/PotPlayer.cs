using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WinApp.playerx
{
    public class PotPlayer
    {

        /**
 * 命令
 */
        public enum KV
        {
            PLAY,
            LEFT,
            RIGHT,
            UP_VOICE,
            DOWN_VOICE,
            PGUP,
            PGDOWN
        }

        public static void ActiveWin() {
            IntPtr intPtr = User32.FindWindow("PotPlayer64", null);
            Console.WriteLine(intPtr);
            User32.SetForegroundWindow(intPtr);

        }

        public static void Command(KV kv) {
            Console.WriteLine(kv);
            switch (kv)
            {
                case KV.PLAY:
                    SendKeys.SendWait(" ");
                    break;

                case KV.LEFT:
                    SendKeys.SendWait("{LEFT}");
                    break;

                case KV.RIGHT:
                    SendKeys.SendWait("{RIGHT}");
                    break;

                case KV.UP_VOICE:
                    SendKeys.SendWait("{UP}");
                    break;

                case KV.DOWN_VOICE:
                    SendKeys.SendWait("{DOWN}");
                    break;

                case KV.PGUP:
                    SendKeys.SendWait("{PGUP}");
                    break;

                case KV.PGDOWN:
                    SendKeys.SendWait("{PGDN}");
                    break;
            }
        }

        public static void Command(String kv)
        { 
            SendKeys.SendWait(Encoding.UTF8.GetString(Convert.FromBase64String(kv)));
        }
    }
}
