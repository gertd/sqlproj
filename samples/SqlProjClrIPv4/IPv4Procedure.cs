//------------------------------------------------------------------------------
// <copyright file="CSSqlStoredProcedure.cs" company="Microsoft">
//     Copyright (c) Microsoft Corporation.  All rights reserved.
// </copyright>
//------------------------------------------------------------------------------

using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;

public partial class StoredProcedures
{
    [Microsoft.SqlServer.Server.SqlProcedure(Name = "SwitchIPv4")]
    public static int SwitchIPv4(ref IPv4 ip1, ref IPv4 ip2)
    {
        if ((ip1 == null) || (ip2 == null) || ip1.IsNull || ip2.IsNull)
            return (0);

        IPv4 ipTemp = ip1;
        ip1 = ip2;
        ip2 = ipTemp;
        return (1);
    }
};
