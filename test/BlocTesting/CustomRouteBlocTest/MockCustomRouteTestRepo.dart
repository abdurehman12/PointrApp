import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pointr/CustomRouteBloc/Repo/CustomRoutes_Repo.dart';
import 'package:pointr/CustomRouteBloc/models/CustomRoutes.dart';

List<CustomRoutes> MockData = [
  CustomRoutes(
      routeStops: [LatLng(latitude: 12.68, longitude: 15.85)],
      routeName: "My Route"),
  CustomRoutes(routeStops: [], routeName: "My Route2")
];

class MockCustomRoutes implements CustomRoutesRepo {
  @override
  Future<List<CustomRoutes>> ReadAllCustomRoutes() {
    return Future.delayed(const Duration(seconds: 2), () => MockData);
  }

  @override
  addToSuggested(CustomRoutes obj) {
    // TODO: implement addToSuggested
    // throw UnimplementedError();
    print("Save to suggested firebase");
  }

  @override
  // TODO: implement collectionReference
  CollectionReference<Object?> get collectionReference =>
      throw UnimplementedError();

  @override
  List<GeoPoint> convertToGeoPoints(List<LatLng> latLngList) {
    // TODO: implement convertToGeoPoints
    throw UnimplementedError();
  }

  @override
  Future<void> createRoute(String name, List<LatLng> coordinates) {
    // TODO: implement createRoute
    // throw UnimplementedError();
    print("Create complete");
    if (name == "1") {
      throw Exception("Error");
    }
    return Future.delayed(const Duration(seconds: 2), () => null);
  }

  @override
  deleteRoute(String routeId) {
    // TODO: implement deleteRoute
    // throw UnimplementedError();
    print("Delete complete");
  }

  @override
  // TODO: implement docRef
  DocumentReference<Object?> get docRef => throw UnimplementedError();

  @override
  updateRoute(String name, List<LatLng> coordinates) {
    // TODO: implement updateRoute
    // throw UnimplementedError();
    print("Route Updated");
  }
}
