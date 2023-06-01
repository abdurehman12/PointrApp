import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/AllRoutes.dart';

class AllRoutesRepo {
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
        'approved': [
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

  // DeleteProduct(String id) {
  //   CollectionReference collectionReference =
  //       FirebaseFirestore.instance.collection('ProductsV2');
  //   collectionReference.doc(id).delete().then((value) => {print("Deleted")});
  // }
  deleteRoute(String routeId) async {
    try {
      await collectionReference.doc(routeId).delete();
      print('Route deleted successfully.');
    } catch (error) {
      print('Failed to delete route: $error');
    }
  }
  // Future<ProductModels> ReadProduct(String id) async {
  //   CollectionReference collectionReference =
  //       FirebaseFirestore.instance.collection('ProductsV2');
  //   DocumentReference documentReference = collectionReference.doc(id);
  //   ProductModels product = ProductModels();
  //   try {
  //     DocumentSnapshot documentSnapshot = await documentReference.get();
  //     if (documentSnapshot.exists) {
  //       product.fromJson(documentSnapshot.data() as Map<String, dynamic>);
  //       print("Data Read successfully");
  //     } else {
  //       print("No such user");
  //     }
  //   } catch (error) {
  //     print("Failed to Read data: $error");
  //   }
  //   return product;
  // }

  Future<List<AllRoutes>> ReadAllRoutes() async {
    List<AllRoutes> products = [];
    try {
      QuerySnapshot querySnapshot = await collectionReference.get();
      // querySnapshot.docs.forEach((element) {
      //   AllRoutes product = AllRoutes();
      //   product.fromJson(element.data() as Map<String, dynamic>);
      //   print(element.id);
      //   products.add(product);
      // });
      for (var route in querySnapshot.docs) {
        // AllRoutes myroute = AllRoutes();
        final data =
            route.data() as Map<String, dynamic>?; // Cast to the expected type
        final approved =
            data?['approved'] as List<dynamic>?; // Perform a null check
        if (approved != null) {
          for (var item in approved) {
            AllRoutes myroute = AllRoutes(routeStops: []);
            final name = item['name'];
            final coordinates = item['coordinates']
                as List<dynamic>; //[0].latitude; //as List<dynamic>?;
            if (coordinates != null) {
              myroute.routeName = name;
              for (var point in coordinates) {
                final geoPoint = point as GeoPoint;
                final latitude = geoPoint.latitude;
                final longitude = geoPoint.longitude;
                print('Latitude: $latitude, Longitude: $longitude');
                myroute.routeStops
                    .add(LatLng(latitude: latitude, longitude: longitude));
              }
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

  // UpdateProduct(String Name, String Email, String phone) {
  //   CollectionReference collectionReference =
  //       FirebaseFirestore.instance.collection('ProductsV2');
  //   collectionReference.doc(Email).update({
  //     'Name': Name,
  //     'Email': Email,
  //     'phone': phone,
  //   });
  // }

  updateRoute(String name, List<LatLng> coordinates) async {
    try {
      await collectionReference.doc('aYGBu0I7TEbK94fwjpUC').update({
        'approved': [
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
}
