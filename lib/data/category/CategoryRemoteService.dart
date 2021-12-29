import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sisemprol/data/URL.dart';
import 'package:sisemprol/data/category/Category.dart';
import 'package:sisemprol/data/settings/SettingRepository.dart';
import 'package:sisemprol/event/Eventbus.dart';
import 'package:sisemprol/event/events.dart';

class CategoryRemoteService {
  final _eventBust = EventBusProvider.defaultInstance();

  Future<List<Category>> fetchCategory(String apiToken) async {
    var url = URL.addQuery(URL.category, {
      'api_token': apiToken,
    });
    final response =
        await http.get(url, headers: {'Accept': 'application/json'});

    if (response.statusCode == 200) {
      return Category.listFromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      SettingRepository.create().saveApiToken('');
      _eventBust.fire(AuthErrorEvent());
      throw Exception('Auth Error');
    } else {
      throw Exception('Failed to load post');
    }
  }
}
