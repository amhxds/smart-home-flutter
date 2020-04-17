import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
var response;
String _status = '';
String url =
    'http://192.168.1.3:80/'; //IP Address which is configured in NodeMCU Sketch

toggleSource() async {
  try {
    response = await http.get(url + 'led', headers: {"Accept": "plain/text"});
    _status = response.body;
  }
  catch (e) {
    // If NodeMCU is not connected, it will throw error
    print(e);
  }
}

String get_status(int x) {
  return _status;
}