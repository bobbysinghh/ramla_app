import 'dart:convert';

import 'package:http/http.dart';

class Network {
  final String url;

  Network(this.url);
  Future fetchData() async {
    Response response = await get(Uri.parse(Uri.encodeFull(url)));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return response.statusCode;
    }
  }

  Future fetchDataNotString() async {
    Response response = await get(Uri.parse(Uri.encodeFull(url)));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return response.statusCode;
    }
  }
}
