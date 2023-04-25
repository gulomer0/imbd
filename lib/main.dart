import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:imbd/DetaySayfa.dart';
import 'package:imbd/FilmApi.dart';
import 'package:lottie/lottie.dart' as Lottie;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var aramaKelimesi = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("About Search"),
                          content: Text(
                              "When you search for movies, please use english and correct words. Please stay with internet connection."),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Close"),
                                style:
                                    TextButton.styleFrom(primary: Colors.black))
                          ],
                        );
                      });
                },
                icon: Icon(
                  Icons.info_outline,
                  color: Colors.black,
                ))
          ],
          elevation: 0,
          backgroundColor: Colors.yellow,
          title: Text("IMBd",
              style: TextStyle(
                color: Colors.black,
              )),
        ),
        body: Center(
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Lottie.Lottie.asset('lottie/movie.json'),
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: TextField(
                  controller: aramaKelimesi,
                  decoration: InputDecoration(
                    hintText: "Search for a Movie",
                    hintStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: Colors.yellow,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetaySayfa(
                                  aramaKelimesi: aramaKelimesi.text,
                                )));
                  },
                  child: Icon(Icons.search, color: Colors.black)),
            ],
          )),
        ));
  }
}
