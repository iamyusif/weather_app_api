import 'dart:convert';
import 'package:api_weather/weather_api.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'havaEsas.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

WeatherApiCilents weatherApiCilents = WeatherApiCilents();
var tfCityName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hava Durumu",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold,
          fontFamily: "Baskerville",


        ),),
        centerTitle: true,

      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: tfCityName.text.isEmpty ? weatherApiCilents.havaOyren("Baku") : weatherApiCilents.havaOyren(tfCityName.text),
          builder: (context, AsyncSnapshot<Weather> snapshot) {
            if(snapshot.hasData){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text("${snapshot.data!.temp.toString()}°",
                        style: TextStyle(
                          fontSize: 50,
                          color: Colors.orange,
                          fontFamily: "Baskerville",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("${snapshot.data!.cityName}",
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.orange,
                          fontFamily: "Baskerville",
                        ),
                      ),
                    ),
                    // first letter of description is uppercase
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("${snapshot.data!.description[0].toUpperCase()}${snapshot.data!.description.substring(1)}",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.orange,
                          fontFamily: "Baskerville",
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 40,left: 40, right: 40,bottom: 20),
                      child: TextField(
                        controller: tfCityName,
                        decoration: InputDecoration(

                          hintText: "Şəhər adı daxil edin",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            shadows: [
                              Shadow(
                                color: Colors.orange,
                                offset: Offset(0.0, 0.0),
                                blurRadius: 1.0,
                              ),

                            ],
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(top: 10,bottom: 20),
                      child: ElevatedButton(
                        // size of button
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(150, 40),
                          primary: Colors.orange,
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            weatherApiCilents.havaOyren(tfCityName.text);
                          });
                        },
                        child: Text("Axtar"),
                      ),
                    ),
                    // hr
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 1,
                        width: 300,
                        color: Colors.orange,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Hissedilən: ${snapshot.data!.feelsLike.toString()}°",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.orange,
                              fontFamily: "Baskerville",
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Min: ${snapshot.data!.tempMin.toString()}°",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.orange,
                              fontFamily: "Baskerville",
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Max: ${snapshot.data!.tempMax.toString()}°",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.orange,
                              fontFamily: "Baskerville",
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Nəmişlik: ${snapshot.data!.humidity.toString()}",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.orange,
                          fontFamily: "Baskerville",
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }else{
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Icon(Icons.error_outline, size: 100, color: Colors.red,)                ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Text("Melumat Tapilmadi"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        // pushReplacementNamed() methodu ile birinci sayfaya geri döndük
                        Navigator.pushReplacementNamed(context, "/");
                      });
                    },
                    child: Text("Geri"),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
