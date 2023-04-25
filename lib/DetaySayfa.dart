import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:imbd/FilmApi.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class DetaySayfa extends StatefulWidget {
  String aramaKelimesi;

  DetaySayfa({required this.aramaKelimesi});

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  Future<Filmler> aramaYap(String aramaKelimesi) async {
    var url = Uri.parse(
        "https://api.collectapi.com/imdb/imdbSearchByName?query=${widget.aramaKelimesi}");
    var response = await http.get(url, headers: {
      'Authorization': 'apikey 1Djuv5aGeWJbuue5aWH3bA:2suqPREUSuAyIKSZ3RrirL',
      'Content-Type': 'application/json'
    });
    return Filmler.fromJson(jsonDecode(response.body));
  }

  final Uri _url = Uri.parse("https://www.imdb.com");

  Future<void> _launchUrl(Uri parse) async {
    if (!await launchUrl(parse)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.yellow,
          title: Text("${widget.aramaKelimesi}",
              style: TextStyle(color: Colors.black)),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Colors.black),
          )),
      body: FutureBuilder(
          future: aramaYap(widget.aramaKelimesi),
          builder: (context, AsyncSnapshot<Filmler> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.result.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        children: [
                          SizedBox(
                              width: 350,
                              child: Image.network(
                                  snapshot.data!.result[index].poster)),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(snapshot.data!.result[index].title,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    "Year: ${snapshot.data!.result[index].year}",
                                    style: TextStyle(
                                      fontSize: 20,
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    "Type: ${snapshot.data!.result[index].type}",
                                    style: TextStyle(
                                      fontSize: 20,
                                    )),
                              ),
                              ElevatedButton(
                                  style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(0),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.yellow)),
                                  child: Text("Rating",
                                      style: TextStyle(color: Colors.black)),
                                  onPressed: () {
                                    _launchUrl(
                                        Uri.parse("https://www.imdb.com/title/${snapshot.data!.result[index].imdbId}/ratings/?ref_=tt_ov_rt"));
                                  },

                                  //"https://www.imdb.com/title/${snapshot.data!.result[index].imdbId}/ratings/?ref_=tt_ov_rt");
                                  )
                            ],
                          ),
                        ],
                      ),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
