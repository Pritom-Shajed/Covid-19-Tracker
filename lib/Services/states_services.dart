import 'dart:convert';
import 'package:covid_tracker/Model/countries_model.dart';
import 'package:covid_tracker/Model/world_states_model.dart';
import 'package:covid_tracker/Services/utils.dart';
import 'package:covid_tracker/View/contries_states.dart';
import 'package:http/http.dart' as http;

class StatesServices {



  Future<WorldStatesModel> fetchWorldStatesRecord() async {
    final response = await http.get(Uri.parse(ApiUrl.worldStatesApi));

    if(response.statusCode == 200){
      var json = jsonDecode(response.body);
      return WorldStatesModel.fromJson(json);
    } else {
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> fetchCountriesRecord() async{
    Uri uri = Uri.parse(ApiUrl.countriesApi);

    http.Response response = await http.get(uri);

    try{
      switch(response.statusCode){
        case 200:
          var data = jsonDecode(response.body);
          return data;
        case 400:
          throw Exception('Error Occurred');
        default:
          throw Exception('Error Occurred');
      }
    }catch(e){
      throw Exception(e.toString());
    }

  }
}
