import 'getWeather.dart';
import 'parseTime.dart';
import '../structures/Weather.dart';

Future<List<Weather>> parseWeather() async {
  final rawWeather = await getWeather();

  List<Weather> weathers = [];
  final dynamic sols = rawWeather['sol_keys'];
  for (int i = sols.length - 1; i > -1; i--) {
    String sol = sols[i];
    Weather weather = new Weather();
    weather.sol = sol;
    weather.temperature = rawWeather[sol]['AT'];
    weather.windSpeed = rawWeather[sol]['HWS'];
    weather.pressure = rawWeather[sol]['PRE'];
    weather.windDirection =
        rawWeather[sol]['WD']['most_common']['compass_point'];
    weather.windDegrees =
        rawWeather[sol]['WD']['most_common']['compass_degrees'];
    String date = parseTime(rawWeather[sol]['Last_UTC']);
    weather.date = date.substring(0, date.indexOf(','));
    String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
    weather.season = capitalize(rawWeather[sol]['Season']);

    weathers.add(weather);
  }

  return weathers;
}
