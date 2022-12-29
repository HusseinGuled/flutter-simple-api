import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatelessWidget {
  const Home({super.key});
//get all data
  // Future<List<Map>> getData() async {
  //   List<Map> data = [];
  //   var url = Uri.parse('http://localhost:300/api/get-data');
  //   var response = await http.get(url);
  //   if (response.statusCode == 200) {
  //     var keyd = jsonDecode(response.body.toString());
  //     data = keyd.cast<Map>();
  //   }
  //   return data;
  // }

//single
  Future getData() async {
    var data = {};
    var url = Uri.parse('http://localhost:300/api/get-single');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var keyd = jsonDecode(response.body.toString());
      data = keyd;
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile from API"),
      ),
      //display array data
      //  body: FutureBuilder(
      //       future: getData(),
      //       builder: (BuildContext context, AsyncSnapshot snapshot) {
      //         if (snapshot.hasError) {
      //           return Center(child: Text('Error occured in: ${snapshot.error}'));
      //         }
      //         if (snapshot.hasData) {
      //           List<Map> keyd = snapshot.data;
      //           return ListView.builder(
      //               itemCount: 1,
      //               itemBuilder: ((context, index) {
      //                 Map item = keyd[0];
      //                 return Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Row(
      //                       children: [
      //                         Container(
      //                             margin: EdgeInsets.only(top: 30, left: 30),
      //                             height: 40,
      //                             width: 40,
      //                             child: ClipOval(
      //                                 child: Image.network(
      //                               item["img"],
      //                               fit: BoxFit.cover,
      //                             ))),
      //                         Container(
      //                           margin: EdgeInsets.only(
      //                             left: 15,
      //                             top: 29,
      //                           ),
      //                           child: Text(
      //                             item['name'],
      //                             style: TextStyle(
      //                                 fontWeight: FontWeight.w700, fontSize: 19),
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                     Container(
      //                         margin: EdgeInsets.only(top: 10, left: 35),
      //                         child: Text(item['id'])),
      //                     Container(
      //                         margin: EdgeInsets.only(top: 5, left: 35),
      //                         child: Text(item['tell'].toString())),
      //                   ],
      //                 );
      //               }));
      //         }
      //         return Center(child: CircularProgressIndicator());
      //       }),

      //display single
      body: FutureBuilder(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            if (snapshot.hasData) {
              var items = snapshot.data;
              return ListView.builder(
                  itemCount: 1,
                  itemBuilder: ((context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 30, top: 30),
                          child: Row(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                child: ClipOval(
                                  child: Image.file(
                                    File(items['img']),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  left: 13,
                                  top: 13,
                                ),
                                child: Column(
                                  children: [
                                    Text(items['name']),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(items['tell'].toString()),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(items['id']),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }));
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
