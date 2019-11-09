import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wintec_waiata/shared/Waiata.dart';
import 'package:wintec_waiata/shared/WaiataAux.dart';

class WaiataContent extends StatelessWidget {
  final int index;
  final String title;

  WaiataContent(this.index, this.title);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => initWaiata(context, index), //set null then point to method stops auto trigger
        child: Stack(
          children: <Widget>[
            Card(
              elevation: 2.0,
              child: Image(
                image: AssetImage("assets/images/image2.jpg"),
                // height: 150.0,
                // width: 92.0,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 19.0,
                    ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      );
  }

  //load waiata info for brief through json file
  initWaiata(BuildContext context, int index) async { 
    //read and convert json
    String jsonContent = await rootBundle.loadString("assets/json/waiata.json");
    List json = jsonDecode(jsonContent);
    
    //initialize static waita from json
    WaiataAux.waiata = await new Waiata(json[index]["name"], json[index]["brief"], 
                                  json[index]["maoriWords"], json[index]["englishWords"], 
                                  json[index]["thumbnailPath"], json[index]["vocalPath"], 
                                  json[index]["nonVocalPath"]);
   
    //debug
    // print(WaiataAux.waiata.name + WaiataAux.waiata.brief);
    
    //navigate to brief page
    Navigator.of(context).pushNamed('/waiataBrief');
  }
}