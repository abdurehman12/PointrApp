import 'package:cloud_firestore/cloud_firestore.dart';

import '../../classes/custom_route.dart';
import '../models/CustomRoutes.dart';

class CustomRoutesRepo {
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('routes');

  Future<void> createRoute(String name, List<LatLng> coordinates) async {
    // try {
    //   await collectionReference.add({
    //     'Custom': [
    //       {
    //         'Name': name,
    //         'coordinates': coordinates.map((e) => e.toMap()).toList(),
    //       },
    //     ],
    //   });
    //   print('Route created successfully.');
    // } catch (error) {
    //   print('Failed to create route: $error');
    // }
  }

  deleteRoute(String routeId) async {
    // try {
    //   await collectionReference.doc(routeId).delete();
    //   print('Route deleted successfully.');
    // } catch (error) {
    //   print('Failed to delete route: $error');
    // }
  }

  Future<List<CustomRoutes>> ReadAllCustomRoutes() async {
    List<CustomRoutes> customRoutesList = [];
    List<Map<String, dynamic>> items = await CustomRoute.fetchRoutesFromDb();
    for (Map<String, dynamic> data in items) {
      print(data);
      String? routeName = data['name'];
      List<LatLng> routeStops = (data['coordinates'] as List<dynamic>)
          .map((coordinate) => LatLng(
              latitude: coordinate.latitude, longitude: coordinate.longitude))
          .toList();

      customRoutesList.add(CustomRoutes(
        routeName: routeName,
        routeStops: routeStops,
      ));
    }
    // for (int i = 0; i < 5; i++) {
    //   CustomRoutes myRoute = CustomRoutes(
    //     routeName: 'MyCustomRoute$i',
    //     routeStops: [],
    //   );

    //   // Add latlang points to the routeStops list
    //   for (int j = 0; j < 3; j++) {
    //     LatLng latLng = LatLng(latitude: 10.0, longitude: 15.0);
    //     myRoute.routeStops.add(latLng);
    //   }

    //   // Add the created CustomRoutes object to the list
    //   customRoutesList.add(myRoute);
    // }

    // Print the customRoutesList for verification
    for (CustomRoutes route in customRoutesList) {
      print('Route Name: ${route.routeName}');
      print('Route Stops: ${route.routeStops}');
      print('-----------------------------');
    }
    return (customRoutesList);
  }

  updateRoute(String name, List<LatLng> coordinates) async {
    // try {
    //   await collectionReference.doc('aYGBu0I7TEbK94fwjpUC').update({
    //     'Custom': [
    //       {
    //         'Name': name,
    //         'coordinates': coordinates.map((e) => e.toMap()).toList(),
    //       },
    //     ],
    //   });
    //   print('Route updated successfully.');
    // } catch (error) {
    //   print('Failed to update route: $error');
    // }
  }

  // Assuming you have a Firestore instance and a document reference
  final DocumentReference docRef = FirebaseFirestore.instance
      .collection('routes')
      .doc('aYGBu0I7TEbK94fwjpUC');

  addToSuggested(CustomRoutes obj) async {
    await docRef.get().then((snapshot) async {
      final data = snapshot.data() as Map<String, dynamic>?;
      print(data);
      final suggested = (data?['suggested'] as List<dynamic>)
          .whereType<Map<String, dynamic>>()
          .toList()
          .cast<Map<String, dynamic>>();

      obj.routeStops.forEach((element) {
        print(element.toMap());
      });
      var ls = convertToGeoPoints(obj.routeStops);
      print(ls);

      final mapToAdd = {
        'name': obj.routeName,
        'coordinates': ls,
      };
      print(mapToAdd);

      suggested.add(mapToAdd);
      print(suggested);
      await docRef.update({
        'suggested': suggested,
      });
    });
  }

  List<GeoPoint> convertToGeoPoints(List<LatLng> latLngList) {
    return latLngList.map((latLng) {
      return GeoPoint(latLng.latitude, latLng.longitude);
    }).toList();
  }
}
