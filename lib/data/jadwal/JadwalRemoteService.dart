import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sisemprol/data/URL.dart';
import 'package:sisemprol/data/jadwal/Jadwal.dart';
import 'package:sisemprol/data/settings/SettingRepository.dart';
import 'package:sisemprol/event/Eventbus.dart';
import 'package:sisemprol/event/events.dart';

class JadwalRemoteService {
  final _eventBust = EventBusProvider.defaultInstance();

  Future<List<Jadwal>> fetchJadwal(
    String apiToken,
    String type,
    String categoryId,
  ) async {
    var url = URL.addQuery(URL.jadwal, {
      'api_token': apiToken,
      'type': type,
      'category_id': categoryId,
    });
    final response = await http.get(
      url,
      headers: {'Accept': 'application/json'},
    );
    if (response.statusCode == 200) {
      return Jadwal.listFromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      SettingRepository.create().saveApiToken('');
      _eventBust.fire(AuthErrorEvent());
      throw Exception('Auth Error');
    } else {
      throw Exception('Failed to load post');
    }
  }
}
