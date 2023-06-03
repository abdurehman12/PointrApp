// import 'package:google_maps_flutter/google_maps_flutter.dart';

// /// usage: CustomRoute.addRouteToDb()
// class CustomRoute {
//   static Future<void> addRouteToDb(String name, List<LatLng> coordinates) async =>
//       throw UnimplementedError();

//   /// [{"name": "a3", "coordinates": [LatLng, LatLng]}]
//   static Future<List<Map<String, dynamic>>> fetchRoutesFromDb() async =>
//       throw UnimplementedError();
//   CustomRoute();
// }

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sqflite/sqflite.dart';
import 'my_db.dart';

/// usage: CustomRoute.addRouteToDb()
class CustomRoute {
  static List<Polyline> _all = <Polyline>[];

  static Future<void> _readAll() async {
    // get routes
    final List<Map<String, dynamic>> routes =
        await MyDb.db.query('custom_route');
    // get coordinates
    final List<Map<String, dynamic>> coordinates =
        await MyDb.db.query('coordinates');
    // create static _all
    _all = List.generate(
      routes.length,
      // generate polyline
      (i) => Polyline(
        // name from route
        polylineId: PolylineId(routes[i]['name'] as String),
        // coordinates as List<LatLng> from coordinates table
        points: coordinates
            .where((c) => c['route_id'] == routes[i]['id'])
            .map((e) => LatLng(e['lat'], e['lng']))
            .toList(),
      ),
    );
  }

  // template for deletion
  // Future<void> delete(Star star) async {
  //   await MyDb.db.delete(
  //     'star',
  //     where: 'id = ?',
  //     whereArgs: [star.id],
  //   );
  //   _all.removeWhere((element) => element.id == star.id);
  //   notifyListeners();
  // }

  static Future<void> addRouteToDb(
      String name, List<LatLng> coordinates) async {
    // convert to db acceptable format
    int id = await MyDb.db.insert(
      'custom_route',
      {'name': name},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    for (var latLng in coordinates) {
      await MyDb.db.insert(
        'coordinates',
        {
          'route_id': id,
          'lat': latLng.latitude,
          'lng': latLng.latitude,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    _all.add(Polyline(polylineId: PolylineId(name), points: coordinates));
    // add to db
  }

  /// [{"name": "a3", "coordinates": [LatLng, LatLng]}]
  static Future<List<Map<String, dynamic>>> fetchRoutesFromDb() async {
    await _readAll();
    return _all
        .map((e) => {
              'name': e.polylineId.value,
              'coordinates': e.points,
            })
        .toList();
  }

  CustomRoute._();
}
