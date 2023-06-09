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
            AllRouteBloc(AllRoutesRepo())..add(const readAllRouteEvent()),
        child: Scaffold(
          // bottomNavigationBar: MyBottomNavigationBar(),
          appBar: AppBar(
            // backgroundColor: const Color.fromARGB(255, 20, 243, 50),
            backgroundColor: Colors.green[400],
            title: const Text('All Routes'),
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
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 16,
                            ),
                            tileColor: Colors.green[100],

                            leading: Image.asset(
                              'assets/images/signpost.png',
                              height: 50,
                              width: 50,
                            ),
                            // onTap: () {
                            //   _showSaveForm(state.data[index].routeStops);
                            // },

                            title: Padding(
                              padding: const EdgeInsets.only(left: 65.0),
                              child: Text(
                                  state.data[index].routeName != null
                                      ? state.data[index].routeName as String
                                      : "MyName",
                                  style: const TextStyle(
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

  void _showSaveForm(pressedCoordinates) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
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
                  itemCount: pressedCoordinates.length,
                  itemBuilder: (BuildContext context, int index) {
                    final coordinate = pressedCoordinates[index];
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
                      Navigator.of(context).pop();
                    },
                    child: const Text('ok'),
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
