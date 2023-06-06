import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Catalogue {
  static Set<Polyline>? routes;
  static Future<void> loadRoutes() async {
    // initialize catalogue
    routes = {};
    // read routes
    var query = await FirebaseFirestore.instance.collection('routes').get();
    List approved = query.docs.asMap().entries.first.value.data()['approved'];
    routes = approved
        .map<Polyline>(
          (e) => Polyline(
            polylineId: PolylineId(
              e['name'],
            ),
            points: e['coordinates']
                .map<LatLng>((e) => LatLng(e.latitude, e.longitude))
                .toList(),
          ),
        )
        .toSet();
  }
}
