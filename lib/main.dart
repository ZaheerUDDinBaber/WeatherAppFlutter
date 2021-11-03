import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

main(){
  runApp(MaterialApp(home:MyWeatherApp()));
}

class MyWeatherApp extends StatefulWidget {
  const MyWeatherApp({Key? key}) : super(key: key);

  @override
  _MyWeatherAppState createState() => _MyWeatherAppState();
}

class _MyWeatherAppState extends State<MyWeatherApp> {
  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;
  var visibility;

  String ApiKey ="715d9301a789d1656c2b1873e2bb251f";
  String City = "Lahore";

  Future getWeather()async{
    http.Response response = await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=${City}&appid=${ApiKey}"));
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.windSpeed = results['wind']['speed'];
      this.visibility = results['visibility'];
    });
  }

  void initState(){
    super.initState();
    this.getWeather();
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text("Weather App"),centerTitle: true, backgroundColor: Colors.red,),
      body: Column(children: [
        Container(
          height:height/3,
          width: width,
          color: Colors.red,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child:Text("Currently In ${City}", style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600
                ),),),
              Text(temp !=null ? temp.toString() : "Loading",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w600
                ),
              ),
            ],
          ),
        ),
        Expanded(child: Padding(
          padding: EdgeInsets.all(20.0),
          child: ListView(
            children: [
              ListTile(
                leading: FaIcon(FontAwesomeIcons.road),
                title: Text("Visibility"),
                trailing: Text(visibility !=null ? visibility.toString(): "Loading"),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.cloud),
                title: Text("Weather"),
                trailing: Text(description !=null ? description.toString(): "Loading"),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.sun),
                title: Text("Humidity"),
                trailing: Text(humidity !=null ? humidity.toString(): "Loading"),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.wind),
                title: Text("Wind Speed"),
                trailing: Text(windSpeed !=null ? windSpeed.toString()+" KM/H" : "Loading"),
              )
            ],
          ),
        ))

      ],),);
  }
}
