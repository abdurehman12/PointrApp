import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../screens/HomeScreen.dart';

class AddRouteForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Route Name'),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                child: Text('Cancel'),
                onPressed: () => Navigator.pop(context),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                child: Text('Add Route'),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => DashboardScreen()),
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
  DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  List<LatLng> _pressedCoordinates = [];

  static final CameraPosition _initialCameraPosition = CameraPosition(
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Save Route',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter route name',
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text('Coordinates:'),
              SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: _pressedCoordinates.length,
                  itemBuilder: (BuildContext context, int index) {
                    final coordinate = _pressedCoordinates[index];
                    return ListTile(
                      title: Text(
                        'Coordinate ${index + 1}: (${coordinate.latitude}, ${coordinate.longitude})',
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
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

                      Future.delayed(Duration(seconds: 3), () {
                        Navigator.pop(context); // Close the saving dialog

                        setState(() {
                          _pressedCoordinates
                              .clear(); // Empty the _pressedCoordinates list
                        });
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Success'),
                              content: Text('Route saved successfully.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => HomeScreen()),
                                      (route) => false,
                                    );
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      });
                    },
                    child: Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.undo),
            onPressed: _removeLastMarker,
          ),
          IconButton(
            icon: Icon(Icons.save),
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
