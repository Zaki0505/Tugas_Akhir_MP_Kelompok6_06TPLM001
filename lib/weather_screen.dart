import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'weather_provider.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        backgroundColor: Colors.blue[700],
      ),
      body: FutureBuilder(
        future: Provider.of<WeatherProvider>(context, listen: false)
            .fetchWeatherData(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('An error occurred!'));
          } else {
            return Consumer<WeatherProvider>(
              builder: (ctx, weatherData, child) => Container(
                decoration: BoxDecoration(
                  color: Colors.blue[300], // background color
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      // Search section
                      TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          labelText: 'Enter city name',
                          suffixIcon: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              Provider.of<WeatherProvider>(context,
                                      listen: false)
                                  .setCityName(_controller.text);
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      // Header section
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                weatherData.date,
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                weatherData.cityName,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),

                      // Weather condition section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            'http://openweathermap.org/img/wn/${weatherData.icon}@2x.png',
                            width: 50,
                            height: 50,
                          ),
                          SizedBox(width: 10),
                          Text(
                            '${weatherData.temperature}°',
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),

                      // Weather details section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Wind',
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                '${weatherData.windSpeed} km/h',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'Humidity',
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                '${weatherData.humidity}%',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'Visibility',
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                '${weatherData.visibility / 1000} km',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),

                      // Forecast section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Today',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Next 7 Days',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white, // box color
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.wb_sunny,
                                  size: 30,
                                  color: Colors.yellow,
                                ),
                                Text(
                                  '13:00',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  '26°',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white, // box color
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.cloud_done,
                                  size: 30,
                                  color: Colors.grey,
                                ),
                                Text(
                                  '14:00',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  '26°',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white, // box color
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.storm,
                                  size: 30,
                                  color: Colors.blueGrey,
                                ),
                                Text(
                                  '15:00',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  '23°',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
