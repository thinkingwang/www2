<%@ WebHandler Language="C#" Class="WebHandler" %>

using System;
using System.Data;
using System.Text;
using System.Web;

public class WebHandler : IHttpHandler {
    
    public void ProcessRequest (HttpContext context)
    {
        var method = context.Request["method"];
        if (context.Request["method"] == "1")
        {
            context.Response.Write(GetTrains());
        }
        //context.Response.ContentType = "text/plain";
        //context.Response.Write("Hello World");
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

    public string GetTrains()
    {
        var tb = PUBS.sqlQuery("select * from [Train]");
        StringBuilder trains = new StringBuilder("[");
        foreach (DataRow row in tb.Rows)
        {
            trains.Append(row[0]);
            trains.Append(",");
        }
        if (trains.Length < 2)
        {
            return "[]";
        }
        trains = trains.Remove(trains.Length - 1, 1);
        trains.Append("]");
        return trains.ToString();
    }
}