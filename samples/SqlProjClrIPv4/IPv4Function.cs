//------------------------------------------------------------------------------
// <copyright file="CSSqlFunction.cs" company="Microsoft">
//     Copyright (c) Microsoft Corporation.  All rights reserved.
// </copyright>
//------------------------------------------------------------------------------

using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;

public partial class UserDefinedFunctions
{
    [Microsoft.SqlServer.Server.SqlFunction(
        Name = "IsValidIPv4",
        DataAccess = DataAccessKind.None,
        SystemDataAccess = SystemDataAccessKind.None,
        IsDeterministic = true,
        IsPrecise = true,
        FillRowMethodName = "",
        TableDefinition = "")
    ]
    public static bool IsValidIPv4(IPv4 ip)
    {
        if ((ip == null) || (ip.IsNull))
            return false;
        else
            return true;
    }

    [Microsoft.SqlServer.Server.SqlFunction(
        Name = "CreateIPv4",
        DataAccess = DataAccessKind.None,
        SystemDataAccess = SystemDataAccessKind.None,
        IsDeterministic = true,
        IsPrecise = true,
        FillRowMethodName = "",
        TableDefinition = "")
    ]
    public static IPv4 CreateIPv4(SqlByte i1, SqlByte i2, SqlByte i3, SqlByte i4)
    {
        IPv4 ip = new IPv4(i1.Value, i2.Value, i3.Value, i4.Value);
        if (ip == null)
            return IPv4.Null;
        else
            return ip;
    }
};
