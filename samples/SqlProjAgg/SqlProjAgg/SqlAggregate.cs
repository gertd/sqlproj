//------------------------------------------------------------------------------
// <copyright file="SqlAggregate.cs" company="Microsoft">
//     Copyright (c) Microsoft Corporation.  All rights reserved.
// </copyright>
//------------------------------------------------------------------------------
using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;
using System.Text;
using System.IO;

[Serializable]
[SqlUserDefinedAggregate(
    //use CLR serialization to serialize the intermediate result. 
    Format.UserDefined,
    //Optimizer property: 
    IsInvariantToNulls = true,
    //Optimizer property: 
    IsInvariantToDuplicates = false,
    //Optimizer property: 
    IsInvariantToOrder = false,
    //Maximum size in bytes of persisted value: 
    MaxByteSize = 8000)
]

public class Concatenate : IBinarySerialize
{
    /// <summary> 
    /// Variable holds intermediate result of the concatenation 
    /// </summary> 
    private StringBuilder intermediateResult;
    /// <summary> 
    /// Initialize the internal data structures 
    /// </summary> 
    public void Init()
    {
        intermediateResult = new StringBuilder();
    }
    /// <summary> 
    /// Accumulate the next value, nop if the value is null 
    /// </summary> 
    /// <param name="value"></param> 
    public void Accumulate(SqlString value)
    {
        if (value.IsNull)
        {
            return;
        }
        intermediateResult.Append(value.Value).Append(',');
    }
    /// <summary> 
    /// Merge the partially computed aggregate with this aggregate. 
    /// </summary> 
    /// <param name="other"></param> 
    public void Merge(Concatenate other)
    {
        intermediateResult.Append(other.intermediateResult);
    }
    /// <summary> 
    /// Called at end of aggregation, to return results. 
    /// </summary> 
    /// <returns></returns> 
    public SqlString Terminate()
    {
        string output = string.Empty;
        //Delete the trailing comma, if any .
        if (intermediateResult != null && intermediateResult.Length > 0)
            output = intermediateResult.ToString(0, intermediateResult.Length - 1);
        return new SqlString(output);
    }

    public void Read(BinaryReader r)
    {
        intermediateResult = new StringBuilder(r.ReadString());
    }

    public void Write(BinaryWriter w)
    {
        w.Write(intermediateResult.ToString());
    }
}
