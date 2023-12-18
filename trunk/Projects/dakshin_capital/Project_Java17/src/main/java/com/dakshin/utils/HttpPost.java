package com.dakshin.utils;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;

public class HttpPost
{
	 public static String SendHttpPost(String path)
     {
    	 try 
    	 {        
             // Send the request
             URL url = new URL(path);
             URLConnection conn = url.openConnection();
             conn.setDoOutput(true);
             OutputStreamWriter writer = new OutputStreamWriter(conn.getOutputStream());
             
             //write parameters
             writer.write("");
             writer.flush();
             
             // Get the response
             StringBuffer answer = new StringBuffer();
             BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
             String line;
             
             while ((line = reader.readLine()) != null) 
             {
                 answer.append(line);
             }
             writer.close();
             reader.close();
             
             return answer.toString();
             
         } catch (MalformedURLException ex) {
             ex.printStackTrace();
         } catch (IOException ex) {
             ex.printStackTrace();
         }
		return null;
     }
	
     public static String SendHttpPost(String path,String parameters)
     {
    	 try 
    	 {        
             // Send the request
             URL url = new URL(path);
             URLConnection conn = url.openConnection();
             conn.setDoOutput(true);
             OutputStreamWriter writer = new OutputStreamWriter(conn.getOutputStream());
             
             //write parameters
             writer.write(parameters);
             writer.flush();
             
             // Get the response
             StringBuffer answer = new StringBuffer();
             BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
             String line;
             
             while ((line = reader.readLine()) != null) 
             {
                 answer.append(line);
             }
             writer.close();
             reader.close();
             
             return answer.toString();
             
         } catch (MalformedURLException ex) {
             ex.printStackTrace();
         } catch (IOException ex) {
             ex.printStackTrace();
         }
		return null;
     }
     
     public static String SendHttpGet(String url)
     {
    	 try 
    	 {   
    		 URL urls = new URL(url);
             URLConnection conn = urls.openConnection();
             StringBuffer answer = new StringBuffer();
             BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
             String line;
             
             while ((line = reader.readLine()) != null) 
             {
                 answer.append(line);
             }
             reader.close();          
             return line;
     	}
     	catch (Exception ex) 
     	{
 			ex.printStackTrace();
 		}
            
		return null;
     }
     
     public  static String sendGet(String url) throws Exception {
    	 
 		URL obj = new URL(url);
 		HttpURLConnection con = (HttpURLConnection) obj.openConnection();
  
 		// optional default is GET
 		con.setRequestMethod("GET");
  
 		//add request header
 		con.setRequestProperty("User-Agent", "Mozilla/5.0");
  
 		//int responseCode = con.getResponseCode();
 		
 		BufferedReader in = new BufferedReader(
 		        new InputStreamReader(con.getInputStream()));
 		String inputLine;
 		StringBuffer response = new StringBuffer();
  
 		while ((inputLine = in.readLine()) != null) {
 			response.append(inputLine);
 		}
 		in.close();
  
 		return response.toString();
 	}

    public static String getBankDetailsByIFSC(String ifsc) throws Exception {
        String response = "";
        try
        {
            ifsc = ifsc.toUpperCase();
            URL url = new URL("https://banksindia.p.mashape.com/");
            HttpURLConnection httpCon = (HttpURLConnection) url.openConnection();
            httpCon.addRequestProperty("User-Agent", "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:25.0) Gecko/20100101 Firefox/25.0");
            httpCon.setDoOutput(true);
            httpCon.setRequestMethod("POST");
            httpCon.setRequestProperty("Content-Type", "application/json");
            httpCon.setRequestProperty("X-Mashape-Key", "mXriVr19dOmshAFrD1ePIk8PAhMbp1zeeyqjsnIbg1kVYMT6TL");
            httpCon.setRequestProperty("accept", "application/json");
            OutputStream os = httpCon.getOutputStream();
            OutputStreamWriter osw = new OutputStreamWriter(os, "UTF-8");
            osw.write("{\"searchBy\": \"ifsc\",\"value\": \"" + ifsc + "\"}");
            osw.flush();
            osw.close();
            os.close();
            httpCon.connect();
            BufferedInputStream bis = new BufferedInputStream(httpCon.getInputStream());
            ByteArrayOutputStream buf = new ByteArrayOutputStream();
            int result2 = bis.read();
            while(result2 != -1) {
                buf.write((byte) result2);
                result2 = bis.read();
            }
            response = buf.toString();
        }
        catch (Exception ex)
        {
            ex.printStackTrace();
            return response;
        }
        return response;
    }
     
}
