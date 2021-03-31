import 'dart:ui';

import 'package:flutter/material.dart';
//import 'package:weather/utilities/constants.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityname;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xff3c415c)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)))),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 50.0,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter the city name',
                    hintStyle: TextStyle(color: Colors.grey),
                    icon: Icon(
                      Icons.search,
                      color: Colors.blue,
                      size: 50,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onChanged: (value) {
                    cityname = value;
                  },
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 20),
              //   child: SizedBox(
              //     height: 50,
              //     width: 250,
              //     child: ElevatedButton(
              //       // style: ElevatedButton.styleFrom(
              //       //   primary: Colors.grey,

              //       // ),
              //         style: ButtonStyle(
              //          shape: MaterialStateProperty.all(
              //           RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(30),

              //           ),
              //         ),
              //       ),
              //       onPressed: () {
              //         Navigator.pop(context, cityname);
              //       },
              //       child: Text(
              //         'Get Weather',
              //         style: TextStyle(
              //             fontSize: 30,
              //             // decorationStyle: TextDecorationStyle.solid,
              //             color: Colors.white),
              //       ),
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pop(context, cityname);
                  },
                  child: Text(
                    'Get Weather',
                    style: TextStyle(
                        fontSize: 30,
                        // decorationStyle: TextDecorationStyle.solid,
                        color: Colors.white),
                  ),
                  color: Color(0xff3c415c),
                  shape: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  height: 80,
                  minWidth: 250,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
