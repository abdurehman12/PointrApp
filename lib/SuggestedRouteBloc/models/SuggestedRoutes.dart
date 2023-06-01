// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// import 'package:google_maps_flutter/google_maps_flutter.dart';

class SuggestedRoutes {
  String? routeName;
  List<LatLng> routeStops;
  SuggestedRoutes({
    this.routeName,
    required this.routeStops,
  });

  SuggestedRoutes copyWith({
    String? routeName,
    List<LatLng>? routeStops,
  }) {
    return SuggestedRoutes(
      routeName: routeName ?? this.routeName,
      routeStops: routeStops ?? this.routeStops,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'routeName': routeName,
      'routeStops': routeStops //?.map((x) => x.toMap()).toList(),
    };
  }

  factory SuggestedRoutes.fromJson(Map<String, dynamic> map) {
    return SuggestedRoutes(
      routeName: map['routeName'] as String,
      routeStops: List<LatLng>.from(
        (map['routeStops'] as List<int>).map<LatLng>(
          (x) => LatLng.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  void fromJson(Map<String, dynamic> map) {
    routeName = map['routeName'];
    // routeStops = List<LatLng>.from(
    //   (map['routeStops'] as List<int>).map<LatLng>(
    //     (x) => LatLng.fromMap(x as Map<String, dynamic>),
    //   ),
    routeStops = map['routeStops'];

    // );
  }
  // String toJson() => json.encode(toMap());

  // factory SuggestedRoutes.fromJson(String source) => SuggestedRoutes.fromMap(json.decode(source) as Map<String, dynamic>);
}

class LatLng {
  final double latitude;
  final double longitude;

  LatLng({
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory LatLng.fromMap(Map<String, dynamic> map) {
    return LatLng(
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
    );
  }
}
