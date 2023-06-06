//import allRoutes repo;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pointr/AllRouteBloc/Repo/AllRoutes_Repo.dart';
import 'package:pointr/AllRouteBloc/models/AllRoutes.dart';

List<AllRoutes> MockData = [
  AllRoutes(routeStops: [], routeName: "My Route"),
  AllRoutes(routeStops: [], routeName: "My Route2")
];

class MockAllRoutes implements AllRoutesRepo {
  @override
  Future<List<AllRoutes>> ReadAllRoutes() {
    return Future.delayed(const Duration(seconds: 2), () => MockData);
  }

  @override
  // TODO: implement collectionReference
  CollectionReference<Object?> get collectionReference =>
      throw UnimplementedError();

  @override
  Future<void> createRoute(String name, List<LatLng> coordinates) {
    // TODO: implement createRoute
    throw UnimplementedError();
  }

  @override
  deleteRoute(String routeId) {
    // TODO: implement deleteRoute
    throw UnimplementedError();
  }

  @override
  updateRoute(String name, List<LatLng> coordinates) {
    // TODO: implement updateRoute
    throw UnimplementedError();
  }
}
