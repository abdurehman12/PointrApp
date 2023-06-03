import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/bottomNavMint.dart';
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
          // bottomNavigationBar: MyBottomNavigationBar(),
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 20, 243, 50),
            title: const Text('AllRoute'),
            centerTitle: true,
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
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 16,
                            ),
                            tileColor: Color.fromARGB(255, 20, 243, 50),
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
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Icon(
                          Icons.location_on,
                          color: Colors.blue,
                        ),
                        title: Text(
                          'Coordinate ${index + 1}: (${coordinate.latitude}, ${coordinate.longitude})',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        tileColor: Colors.grey[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
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
