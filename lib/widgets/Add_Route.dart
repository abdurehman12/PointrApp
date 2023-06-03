import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../classes/custom_route.dart';
import '../screens/HomeScreen.dart';

class AddRouteForm extends StatelessWidget {
  const AddRouteForm({super.key});

  // var _routeNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const TextField(
            decoration: InputDecoration(labelText: 'Route Name'),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                child: const Text('Cancel'),
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                child: const Text('Add Route'),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const DashboardScreen()),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};
  final List<LatLng> _pressedCoordinates = [];

  static const CameraPosition _initialCameraPosition = CameraPosition(
    target:
        LatLng(37.7749, -122.4194), // Set your desired initial position here
    zoom: 12,
  );

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _addMarker(LatLng position) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(position.toString()),
          position: position,
        ),
      );
      _pressedCoordinates.add(position);
    });
  }

  void _removeLastMarker() {
    setState(() {
      if (_markers.isNotEmpty) {
        final lastMarker = _markers.last;
        _markers.remove(lastMarker);
        _pressedCoordinates.removeWhere(
          (coordinate) => coordinate == lastMarker.position,
        );
      }
    });
  }

  void _showSaveForm() {
    var routeNameController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.pink[100],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            // padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Save Route',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: routeNameController,
                      decoration: InputDecoration(
                        labelText: 'Enter route name',
                        prefixIcon: const Icon(
                          Icons.text_fields,
                          color: Colors.blue,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey[400]!,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.blue,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Route name is required';
                        }
                        return null;
                      },
                    )),
                const SizedBox(height: 16),
                const Text('Coordinates:'),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    itemCount: _pressedCoordinates.length,
                    itemBuilder: (BuildContext context, int index) {
                      final coordinate = _pressedCoordinates[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: const Icon(
                            Icons.location_on,
                            color: Colors.blue,
                          ),
                          title: Text(
                            'Coordinate ${index + 1}: (${coordinate.latitude}, ${coordinate.longitude})',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          tileColor: Colors.grey[200],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        CustomRoute.addRouteToDb(
                            routeNameController.text, _pressedCoordinates);
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return const AlertDialog(
                              content: Row(
                                children: [
                                  CircularProgressIndicator(),
                                  SizedBox(width: 16),
                                  Text('Saving your route...'),
                                ],
                              ),
                            );
                          },
                        );

                        Future.delayed(const Duration(seconds: 3), () {
                          Navigator.pop(context); // Close the saving dialog

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Success'),
                                content:
                                    const Text('Route saved successfully.'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      print(routeNameController.text);

                                      setState(() {
                                        _pressedCoordinates
                                            .clear(); // Empty the _pressedCoordinates list
                                      });

                                      Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HomeScreen()),
                                        (route) => false,
                                      );
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        });
                      },
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
    print(routeNameController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        title: const Text('Add Route Screen'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.undo),
            onPressed: _removeLastMarker,
          ),
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              _showSaveForm();
            },
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: _onMapCreated,
        markers: _markers,
        onTap: (LatLng position) {
          _addMarker(position);
          print(_pressedCoordinates);
        },
      ),
    );
  }
}
