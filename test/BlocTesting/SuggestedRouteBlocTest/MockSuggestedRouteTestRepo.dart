import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pointr/SuggestedRouteBloc/Repo/SuggestedRoutes_Repo.dart';
import 'package:pointr/SuggestedRouteBloc/models/SuggestedRoutes.dart';

List<SuggestedRoutes> MockData = [
  SuggestedRoutes(
      routeStops: [LatLng(latitude: 12.68, longitude: 15.85)],
      routeName: "My Route"),
  SuggestedRoutes(
      routeStops: [LatLng(latitude: 18.68, longitude: 19.85)],
      routeName: "My Route2")
];

class MockSuggestedRoutes implements SuggestedRoutesRepo {
  @override
  Future<List<SuggestedRoutes>> ReadAllRoutes() {
    return Future.delayed(const Duration(seconds: 2), () => MockData);
  }

  @override
  addToSuggested(SuggestedRoutes obj) {
    print("Save to Approved firebase");
  }

  @override
  addToApproved(int index) {
    // TODO: implement addToApproved
    // throw UnimplementedError();
  }

  @override
  // TODO: implement collectionReference
  CollectionReference<Object?> get collectionReference =>
      throw UnimplementedError();

  @override
  Future<void> createRoute(String name, List<LatLng> coordinates) {
    // TODO: implement createRoute
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
    print("Route deleted successfully");
  }

  @override
  // TODO: implement docRef
  DocumentReference<Object?> get docRef => throw UnimplementedError();

  @override
  removeFromSuggested(int index) {
    // TODO: implement removeFromSuggested
    // throw UnimplementedError();
    print("Remove from suggested complete");
  }

  @override
  updateRoute(String name, List<LatLng> coordinates) {
    // TODO: implement updateRoute
    // throw UnimplementedError();
    print("Route updated successfully");
  }
}
