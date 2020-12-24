import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  // final url = 'http://worldclockapi.com/api/json';
  String location; // location name for UI
  String time; //
  String flag; // url to an asset flag icon
  String url; // location url for api endpoint
  bool isDayTime;

  WorldTime({ this.location, this.flag, this.url });

  Future <void> getTime() async {

    try {
      // make the request
      Response response = await get('http://worldclockapi.com/api/json/$url');
      Map data = jsonDecode(response.body);

      // get properties from data
      String datetime = data['currentDateTime'];
      String offset = data['utcOffset'];

      if (offset.startsWith('-')) {
        offset = offset.substring(0, 3);
      } else {
        offset = offset.substring(0, 2);
      }

      // create DateTime object
      DateTime dateTime = DateTime.parse(datetime);
      dateTime = dateTime.add(Duration(hours: int.parse(offset)));

      isDayTime = (dateTime.hour > 6 && dateTime.hour < 20) ? true : false;

      // set the time property
      time = DateFormat.jm().format(dateTime);
    } catch (e) {
      print(e);
      time = 'Server error.';
    }
  }
}
