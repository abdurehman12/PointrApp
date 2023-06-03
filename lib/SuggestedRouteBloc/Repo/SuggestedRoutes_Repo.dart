
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/SuggestedRoutes.dart';

class SuggestedRoutesRepo {
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('routes');

  // AddProduct(String RouteName, List<LatLng> RouteStops) {
  //   collectionReference.doc("aYGBu0I7TEbK94fwjpUC").update({
  //     'name': RouteName,
  //     'coordinates': RouteStops.map((e) => e.toMap()).toList(),
  //     // 'phone': phone,
  //   });
  // }

  Future<void> createRoute(String name, List<LatLng> coordinates) async {
    try {
      await collectionReference.add({
        'suggested': [
          {
            'Name': name,
            'coordinates': coordinates.map((e) => e.toMap()).toList(),
          },
        ],
      });
      print('Route created successfully.');
    } catch (error) {
      print('Failed to create route: $error');
    }
  }

  deleteRoute(String routeId) async {
    try {
      await collectionReference.doc(routeId).delete();
      print('Route deleted successfully.');
    } catch (error) {
      print('Failed to delete route: $error');
    }
  }

  Future<List<SuggestedRoutes>> ReadAllRoutes() async {
    List<SuggestedRoutes> products = [];
    try {
      QuerySnapshot querySnapshot = await collectionReference.get();
      for (var route in querySnapshot.docs) {
        // AllRoutes myroute = AllRoutes();
        final data =
            route.data() as Map<String, dynamic>?; // Cast to the expected type
        final approved =
            data?['suggested'] as List<dynamic>?; // Perform a null check
        if (approved != null) {
          for (var item in approved) {
            SuggestedRoutes myroute = SuggestedRoutes(routeStops: []);
            final name = item['name'];
            final coordinates = item['coordinates'] as List<dynamic>;
            myroute.routeName = name;
            for (var point in coordinates) {
              final geoPoint = point as GeoPoint;
              final latitude = geoPoint.latitude;
              final longitude = geoPoint.longitude;
              print('Latitude: $latitude, Longitude: $longitude');
              myroute.routeStops
                  .add(LatLng(latitude: latitude, longitude: longitude));
            }
            // print('Name: $name');
            // print('Coordinates: $coordinates');
            print(myroute.routeStops.length);
            products.add(myroute);
          }
          // Add the user to the list if it exists
        }
      }
    } catch (error) {
      print("Failed to Read data: $error");
    }
    return products;
  }

  updateRoute(String name, List<LatLng> coordinates) async {
    try {
      await collectionReference.doc('aYGBu0I7TEbK94fwjpUC').update({
        'suggested': [
          {
            'Name': name,
            'coordinates': coordinates.map((e) => e.toMap()).toList(),
          },
        ],
      });
      print('Route updated successfully.');
    } catch (error) {
      print('Failed to update route: $error');
    }
  }

// Assuming you have a Firestore instance and a document reference
  final DocumentReference docRef = FirebaseFirestore.instance
      .collection('routes')
      .doc('aYGBu0I7TEbK94fwjpUC');

  addToApproved(int index) async {
    await docRef.get().then((snapshot) async {
      final data = snapshot.data() as Map<String, dynamic>?;
      print(data);
      final suggested = (data?['suggested'] as List<dynamic>)
          .whereType<Map<String, dynamic>>()
          .toList()
          .cast<Map<String, dynamic>>();
      final approved = (data?['approved'] as List<dynamic>)
          .whereType<Map<String, dynamic>>()
          .toList()
          .cast<Map<String, dynamic>>();

      final mapToAdd = suggested[index];
      print(mapToAdd);

      approved.add(mapToAdd);
      suggested.removeAt(index);

      await docRef.update({
        'approved': approved,
        'suggested': suggested,
      });
    });
  }

  removeFromSuggested(int index) async {
    await docRef.get().then((snapshot) async {
      final data = snapshot.data() as Map<String, dynamic>?;
      final suggested = (data?['suggested'] as List<dynamic>)
          .whereType<Map<String, dynamic>>()
          .toList()
          .cast<Map<String, dynamic>>();

      suggested.removeAt(index);

      await docRef.update({
        'suggested': suggested,
      });
    });
  }
}
