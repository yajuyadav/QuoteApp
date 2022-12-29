import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quotes_app/models/images.dart';
import 'package:quotes_app/models/quotes.dart';
class RemoteService {
  Future<List<Quotes>?> getQuotes() async {
    var client = http.Client();
    var _headers = {
      'key': '32430915-136ef9f903ed6dd486817179e',
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
      'Accept': 'application/json',
    };
    var uri = Uri.parse('https://type.fit/api/quotes');
    var response = await client.get(uri, headers: _headers);

    if (response.statusCode == 200) {
      var data = response.body;
      return quotesFromJson(data);
    }
  }

  Future<Images?> getImages() async {
    var client = http.Client();
    var _headers = {
      'key': '32430915-136ef9f903ed6dd486817179e',
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
      'Accept': 'application/json',
    };
    var uri = Uri.parse(
        'https://pixabay.com/api/?key=32430915-136ef9f903ed6dd486817179e');
    var response = await client.get(uri, headers: _headers);

    if (response.statusCode == 200) {
      var data = response.body;
      print(imagesFromJson(data).toString());
      return imagesFromJson(data);
    }
  }
}