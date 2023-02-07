class Weather {

  late String cityName;
  late String description;
  late String icon;
  late double temp;
  late double feelsLike;
  late double tempMin;
  late double tempMax;
  late int humidity;

  Weather(this.cityName,
      this.description,
      this.icon,
      this.temp,
      this.feelsLike,
      this.tempMin,
      this.tempMax,
      this.humidity,);

  Weather.fromJson(Map<String, dynamic> json) {
    cityName = json['name'];
    description = json['weather'][0]['description'];
    icon = json['icon'] == null ? "01d" : json['weather'][0]['icon'];
    temp = json['main']['temp'] ;
    feelsLike = json['main']['feels_like'];
    tempMin = json['main']['temp_min'];
    tempMax = json['main']['temp_max'];
    humidity = json['main']['humidity'];
  }

}