using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;

[Serializable]
[Microsoft.SqlServer.Server.SqlUserDefinedType(Format.Native, IsByteOrdered = true, ValidationMethodName = "ValidateIPv4")]
[System.Runtime.InteropServices.StructLayout(System.Runtime.InteropServices.LayoutKind.Sequential)]
public class IPv4 : INullable
{
    private byte ip1;
    private byte ip2;
    private byte ip3;
    private byte ip4;
    private byte ip5;   // NULL byte

    public IPv4()
    {
        ip1 = ip2 = ip3 = ip4 = ip5 = 0x0;
    }

    public IPv4(byte i1, byte i2, byte i3, byte i4)
    {
        if ((i1 >= 0) && (i1 <= 255) &&
            (i2 >= 0) && (i2 <= 255) &&
            (i3 >= 0) && (i3 <= 255) &&
            (i4 >= 0) && (i4 <= 255))
        {
            ip1 = i1;
            ip2 = i2;
            ip3 = i3;
            ip4 = i4;
            ip5 = 0x1;
        }
    }

    public override string ToString()
    {
        return ((ip5 == 0x0) ? "NULL" : String.Format("{0}.{1}.{2}.{3}", ip1, ip2, ip3, ip4));
    }

    public bool IsNull
    {
        get
        {
            return (ip5 == 0x0);
        }
    }

    public static IPv4 CreateIPv4(byte i1, byte i2, byte i3, byte i4)
    {
        return (new IPv4(i1, i2, i3, i4));
    }

    public static IPv4 Null
    {
        get
        {
            return (new IPv4());
        }
    }

    public static IPv4 IP255255255255
    {
        get
        {
            return (new IPv4(255, 255, 255, 255));
        }
    }

    [SqlMethod(OnNullCall = false)]
    public static IPv4 Parse(SqlString s)
    {
        if (s.IsNull)
        {
            return Null;
        }

        char[] splitChars = { '.' };

        string[] ss = s.ToString().Split(splitChars);

        if (ss.Length == 4)
        {
            return (new IPv4(
                Convert.ToByte(ss[0]),
                Convert.ToByte(ss[1]),
                Convert.ToByte(ss[2]),
                Convert.ToByte(ss[3])));
        }
        else
        {
            return Null;
        }
    }

    [SqlMethod(OnNullCall = false)]
    public void SetIPv4(byte i1, byte i2, byte i3, byte i4)
    {
        if ((i1 >= 0) && (i1 <= 255) &&
            (i2 >= 0) && (i2 <= 255) &&
            (i3 >= 0) && (i3 <= 255) &&
            (i4 >= 0) && (i4 <= 255))
        {
            ip1 = i1;
            ip2 = i2;
            ip3 = i3;
            ip4 = i4;
            ip5 = 0x1;
        }
        return;
    }

    private bool ValidateIPv4()
    {
        if (ip5 == 0x0)
        {
            return true;
        }
        else if ((ip1 >= 0) && (ip1 <= 255) &&
                 (ip2 >= 0) && (ip2 <= 255) &&
                 (ip3 >= 0) && (ip3 <= 255) &&
                 (ip4 >= 0) && (ip4 <= 255))
        {
            return true;
        }
        else
        {
            return false;
        }
    }
}


