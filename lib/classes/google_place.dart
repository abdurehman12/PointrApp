import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pointr/classes/google_api.dart';
import 'package:pointr/classes/located_google_place.dart';
import 'package:pointr/classes/place.dart';

class GooglePlace implements Place {
  @override
  final String title;
  final String placeId;
  const GooglePlace({required this.placeId, required this.title});

  Future<LatLng> getLatLng() async => this is LocatedGooglePlace
      ? (this as LocatedGooglePlace).latLng
      : await GoogleApi.latLngFromPlaceId(placeId);
}
