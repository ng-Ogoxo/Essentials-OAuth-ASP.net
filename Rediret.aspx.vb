Imports Newtonsoft.Json
Imports Newtonsoft.Json.Linq
Imports System
Imports System.Collections.Generic
Imports System.IO
Imports System.Linq
Imports System.Net
Imports System.Net.Http
Imports System.Net.Http.Headers
Imports System.Text
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls

Public Class Redirect
    Inherits System.Web.UI.Page


    Public Const client_secret As String = ""
    Public Const OAuthScope As String = "la.global"
    Public Const client_id As String = ""
    Public Const redirect_url = "http://localhost:8107/Redirect.aspx"


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
      
      'Get the access token and display it in a pop p.
        MsgBox(getTokens(getAccessCode().ToString))
    End Sub

    Public Function getAccessCode()

        Dim url2 As String = HttpContext.Current.Request.Url.AbsoluteUri
        Dim accessCode As String = ExtractSubstring(url2, "code=", "")
        Dim accessCodeDecoded As String = HttpUtility.UrlDecode(accessCode)


        Return accessCodeDecoded


    End Function



    Private Function ExtractSubstring(input As String, startsWith As String, endsWith As String) As String
        Dim match As Match = Regex.Match(input, startsWith + "(.*)" + endsWith)
        Dim code As String = match.Groups(1).Value
        Return code
    End Function

    
    Public Function CfList()


        Dim theToken = getTokens(getAccessCode())

        '  Dim uriString As String = apiUrl
        Dim myWebClient As New WebClient()
      
         myWebClient.Headers.Add("Content-Type", "application/x-www-form-urlencoded")
        myWebClient.Headers.Add("Authorization", "Bearer " + theToken)
        ' myWebClient.KeepAlive = True
        myWebClient.Headers.Add("x-myobapi-cftoken", "")
        myWebClient.Headers.Add("x-myobapi-key", "")
        myWebClient.Headers.Add("x-myobapi-version", "v2")
        ' Display the headers in the request
        Console.Write("Resulting Request Headers: ")
        Console.WriteLine(myWebClient.Headers.ToString())


        Dim theList = myWebClient.DownloadString(apiUrl)


        Dim companyFiles = JsonConvert.DeserializeObject(theList)


        Return companyFiles
    End Function




    Public Shared Function GetDataTableFromArray(ByVal array As JArray()) As DataTable

        Dim dataTable As New DataTable()

        dataTable.LoadDataRow(array, True) 'Pass array object to LoadDataRow method 

        Return dataTable

    End Function


    Public Function getTokens(accessCode As String)


        Dim request As WebRequest = WebRequest.Create("https://secure-myob-com-nr6x0b8f750n.runscope.net/oauth2/v1/authorize")
        ' Set the Method property of the request to POST.
        request.Method = "POST"
        ' Create POST data and convert it to a byte array.
    
        Dim postData As String = String.Format("code={0}&redirect_uri={1}&client_id={2}&scope={3}&client_secret={4}&grant_type=authorization_code", _
                                         HttpUtility.UrlEncode(accessCode), HttpUtility.UrlEncode(redirect_url), client_id, OAuthScope, client_secret)
        Console.WriteLine("PostData " + postData)
        Dim byteArray As Byte() = Encoding.UTF8.GetBytes(postData)
        ' Set the ContentType property of the WebRequest.
        request.ContentType = "application/x-www-form-urlencoded"
        ' Set the ContentLength property of the WebRequest.
        request.ContentLength = byteArray.Length
        ' Get the request stream.
        Dim dataStream As Stream = request.GetRequestStream()
        ' Write the data to the request stream.
        dataStream.Write(byteArray, 0, byteArray.Length)
        ' Close the Stream object.
        dataStream.Close()
        ' Get the response.
        Dim response As WebResponse = request.GetResponse()
        ' Display the status.
        Console.WriteLine(CType(response, HttpWebResponse).StatusDescription)
        ' Get the stream containing content returned by the server.
        dataStream = response.GetResponseStream()
        ' Open the stream using a StreamReader for easy access.
        Dim reader As New StreamReader(dataStream)
        ' Read the content.
        Dim responseFromServer As String = reader.ReadToEnd()
        ' Display the content.
        Console.WriteLine(responseFromServer)
        Dim accessToken As String = responseFromServer
        ' Clean up the streams.
        reader.Close()
        dataStream.Close()
        response.Close()
        
        'Trim to get just the string you want from the token for using in your headers
        Dim theToken As String = accessToken.Substring(17, 912)

        '
        Return theToken


    End Function




End Class




