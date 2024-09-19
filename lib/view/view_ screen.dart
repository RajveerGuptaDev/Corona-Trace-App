import 'dart:convert';

import 'package:http/http.dart 'as http;
import 'package:virus_app/Model/app_url.dart';

import '../Model/world_state.dart';
class ViewApi{

  Future<WorldStatesModel> fetchWorldRecords() async{
    final response = await http.get(Uri.parse(App_url.worldStatesApi));
    if (response.statusCode == 200 ){
      var data = jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);

    }else{
      throw Exception("throw");
    }
  }
  Future<List<dynamic>> CountriesApi() async {
    var data ;
    final response = await http.get(Uri.parse (App_url.countriesList));
    print(response.statusCode.toString());


    if (response.statusCode ==  200 ){
         data = jsonDecode(response.body.toString());
         return data;
    }else{
      throw Exception(" error");
    }

  }



}
