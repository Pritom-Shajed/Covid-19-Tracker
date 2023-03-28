import 'dart:convert';
import 'package:covid_tracker/Model/world_states_model.dart';
import 'package:covid_tracker/Services/utils.dart';
import 'package:http/http.dart' as http;

class StatesServices {



  Future<WorldStatesModel> fetchWorldStatesRecord() async {
    final response = await http.get(Uri.parse(ApiUrl.worldStatesApi));

    if(response.statusCode == 200){
      var json = jsonDecode(response.body);
      print(json);
      return WorldStatesModel.fromJson(json);
    } else {
      throw Exception('Error');
    }
  }
}
