import 'package:flutter/material.dart';
import 'package:flutter_douban/HotMovieData.dart';
import 'package:flutter_douban/HotMovieItemWidget.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HotMoviesListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HotMoviesListWidgetState();
  }
}

class HotMoviesListWidgetState extends State<HotMoviesListWidget> {
  List<HotMovieData> hotMovies = new List<HotMovieData>();
  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    List<HotMovieData> serverDataList = new List();
    var response = await http.get(
        'https://api.douban.com/v2/movie/in_theaters?apikey=0b2bdeda43b5688921839c8ecb20399b&city=%E6%B7%B1%E5%9C%B3&start=0&count=10&client=&udid=');
    //成功获取数据
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      for (dynamic data in responseJson['subjects']) {
        HotMovieData hotMovieData = HotMovieData.fromJson(data);
        serverDataList.add(hotMovieData);
      }
      setState(() {
        hotMovies = serverDataList;
      });
    } 
  }

  Widget build(BuildContext contexst) {
    return ListView.separated(
      itemCount: hotMovies.length,
      itemBuilder: (context, index) {
        return HotMovieItemWidget(hotMovies[index]);
      },
      separatorBuilder: (context, index) {
        return Divider(height: 1, color: Colors.black26,);
      },
    );
  }
}