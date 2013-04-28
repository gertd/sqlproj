//------------------------------------------------------------------------------
// <copyright>
//	 Copyright (c) SQLproj.com.  All rights reserved.
// </copyright>
//------------------------------------------------------------------------------
namespace SqlProj.Tools.PowerPack
{
    using System;

    static class GuidList
    {
        public const string guidSqlProjProjectString = "00d1a9c2-b5f0-4af3-8072-f6c62b433612";
        public const string guidDbProjProjectString = "c8d11400-126e-41cd-887f-60bd40844f9e";
        public const string guidMiscFilesProjectString = "6bb5f8f0-4483-11d3-8bcf-00c04f8ec28c";

        public const string guidSqlProjPowerPackPkgString = "5281d64c-bc64-4d8f-b5bc-c40e5cf77804";
        public const string guidSqlProjPowerPackCmdSetString = "2acbbce5-e854-466d-bf73-35236d76bb9c";

        public static readonly Guid guidSqlProjPowerPackCmdSet = new Guid(guidSqlProjPowerPackCmdSetString);
    };
}