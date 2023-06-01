import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/AllRouteBloc/bloc/all_route_bloc_bloc.dart';

import 'Repo/AllRoutes_Repo.dart';

class AllRouteUI extends StatefulWidget {
  const AllRouteUI({super.key});

  @override
  State<AllRouteUI> createState() => _AllRouteUIState();
}

class _AllRouteUIState extends State<AllRouteUI> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AllRouteBloc(AllRoutesRepo()),
        child: MyBody(context));
  }

  Widget MyBody(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            AllRouteBloc(AllRoutesRepo())..add(readAllRouteEvent()),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('AllRoute'),
          ),
          body: BlocBuilder<AllRouteBloc, AllRouteBlocState>(
            builder: (context, state) {
              if (state is AllRouteLoad) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is AllRouteSuccess) {
                return ListView.builder(
                    itemCount: state.data.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          _showSaveForm(state.data[index].routeStops);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ListTile(
                            // trailing: CircleAvatar(
                            //   child: Text(
                            //     '$index', // Replace with the actual index number
                            //     style: TextStyle(color: Colors.white),
                            //   ),
                            //   backgroundColor: Colors
                            //       .blue, // Replace with the desired background color
                            // ),
                            leading: Icon(Icons.directions_bus),
                            // onTap: () {
                            //   _showSaveForm(state.data[index].routeStops);
                            // },
                            title: Align(
                              alignment: Alignment.center,
                              child: Text(
                                  state.data[index].routeName != null
                                      ? state.data[index].routeName as String
                                      : "MyName",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ),
                            // subtitle: Text(state.data[index].coordinates),
                          ),
                        ),
                      );
                    });
              } else if (state is AllRouteError) {
                return const Center(
                  child: Text('Error'),
                );
              } else {
                return const Center(
                  child: Text('Error'),
                );
              }
            },
          ),
        ));
  }

  void _showSaveForm(_pressedCoordinates) {
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
                  'Route Coordinates',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
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
                      Navigator.of(context).pop();
                    },
                    child: Text('ok'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}