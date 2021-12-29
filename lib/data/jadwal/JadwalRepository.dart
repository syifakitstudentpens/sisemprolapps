import 'dart:async';

import 'package:sisemprol/data/database/appDataBase.dart';
import 'package:sisemprol/data/jadwal/Jadwal.dart';
import 'package:sisemprol/data/jadwal/JadwalRemoteService.dart';
import 'package:sisemprol/data/settings/SettingRepository.dart';
import 'package:sisemprol/event/Eventbus.dart';
import 'package:sisemprol/event/events.dart';

class JadwalRepository {
  JadwalRemoteService remoteService;

  SettingRepository settings;

  JadwalRepository(this.remoteService, this.settings);

  factory JadwalRepository.create() {
    return JadwalRepository(
      JadwalRemoteService(),
      SettingRepository.create(),
    );
  }

  Future<List<Jadwal>> fetchAndGet(String type, String categoryId) async {
    var database = await AppDatabase.openMyDatabase();

    if (type == 'fav') {
      return database.getFavJadwal();
    }

    var apiToken = await settings.getApiToken();
    var future = remoteService.fetchJadwal(
      apiToken,
      type,
      categoryId,
    );
    return await fetchJadwal(future, type, categoryId);
  }

  fetchJadwal(
      Future<List<Jadwal>> future, String type, String categoryId) async {
    var data = await future;
    var database = await AppDatabase.openMyDatabase();
    data.forEach((item) async {
      var _jadwal = await database.getJadwalById(item.id);
      if (_jadwal != null) {
        database.deleteJadwal(item.id);
      }
      database.createJadwal(
        item.id,
        item.title,
        item.body,
        item.image,
        item.categoryId,
        item.type,
        item.published,
        item.publishedAt,
        item.categoryName,
      );
    });

    if (type.isEmpty && categoryId.isEmpty) {
      return database.getAllJadwal();
    }
    if (type.isNotEmpty && categoryId.isNotEmpty) {
      return database.getAllJadwalForCategoryAndType(
          int.parse(categoryId), type);
    }
    if (type.isNotEmpty) {
      return database.getAllJadwalByType(type);
    } else {
      return database.getAllJadwalForCategory(int.parse(categoryId));
    }
  }

  saveFavJadwal(Jadwal jadwal) async {
    var database = await AppDatabase.openMyDatabase();
    database.deleteFavJadwal(jadwal.id);
    database.createFavJadwal(
        jadwal.id,
        jadwal.title,
        jadwal.body,
        jadwal.image,
        jadwal.categoryId,
        jadwal.type,
        jadwal.published,
        jadwal.publishedAt,
        jadwal.categoryName);

    EventBusProvider.defaultInstance().fire(new FavJadwalUpdateEvent());
  }

  removeFavJadwal(Jadwal jadwal) async {
    var database = await AppDatabase.openMyDatabase();
    database.deleteFavJadwal(jadwal.id);
    EventBusProvider.defaultInstance().fire(new FavJadwalUpdateEvent());
  }

  Future<bool> isFavouriteJadwal(int id) async {
    var database = await AppDatabase.openMyDatabase();
    var jadwal = await database.getFavJadwalById(id);
    if (jadwal == null) {
      return false;
    } else {
      return true;
    }
  }
}
