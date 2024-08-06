import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';

import 'package:http/http.dart' as http;
String _basicAuth = 'Basic ' +
    base64Encode(utf8.encode(
        'ahmed:ahmed12345'));

Map<String, String> myheaders = {
  'authorization': _basicAuth
};

class CRUD {

  getRequest(String url) async {
    try {
      var request = await http.get(Uri.parse(url));
      if (request.statusCode == 200)
        return json.decode(request.body);
      else {
        print('Failed to load data');
        return null;
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  postRequest(String url, Map data,) async {
    try {
      var request = await http.post(Uri.parse(url), body: data,headers: myheaders);
      if (request.statusCode == 200) {
        var body = jsonDecode(request.body);
        return body;
      } else {
        print('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  postReqWithFile(String url, Map data, File file) async {
    try{
      var request=await http.MultipartRequest("POST",Uri.parse(url),);
      var length=await file.length();
      var stream= http.ByteStream(file.openRead());
      var multipartfile=await http.MultipartFile("file",stream,length,filename: basename(file.path));
      request.headers.addAll(myheaders);
      request.files.add(multipartfile);
      data.forEach((key, value) {
        request.fields[key]=value;
      });
      var sendRequest=await request.send();
      var response=await http.Response.fromStream(sendRequest);
      if(sendRequest.statusCode==200){
        return json.decode(response.body);
      }
      else{
        print('Failed to load data+${response.statusCode}');
      }

    }catch(e){
      print('Catch Error: $e');

    }

  }
}