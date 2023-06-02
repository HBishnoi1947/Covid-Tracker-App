import 'dart:convert';

import 'package:covid_tracker/Model/world_states_model.dart';
import 'package:covid_tracker/Services/Utilities/app_url.dart';
import 'package:http/http.dart';

class StatesServices{

  Future <WorldStatesModel> fetchWorldStatesRecords() async{

    final response = await get(Uri.parse(AppUrl.worldStateApi));

    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);
    }
    else{
      throw Exception('Error');
    }
  }


  Future <List<dynamic>> countriesListApi() async{

    final response = await get(Uri.parse(AppUrl.coutriesList));

    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      return data;
    }
    else{
      throw Exception('Error');
    }
  }
}