import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/AllRouteBloc/bloc/all_route_bloc_bloc.dart';

import 'Repo/AllRoutes_Repo.dart';

class AllRouteUI extends StatefulWidget {
  late AllRoutesRepo? repo;

  AllRouteUI({super.key, this.repo});

  @override
  State<AllRouteUI> createState() => _AllRouteUIState();
}

class _AllRouteUIState extends State<AllRouteUI> {
  @override
  Widget build(BuildContext context) {
    AllRoutesRepo? repository =
        widget.repo == null ? AllRoutesRepo() : widget.repo!;
    return BlocProvider(
        create: (context) => AllRouteBloc(AllRoutesRepo()),
        child: MyBody(context, repository));
  }

  Widget MyBody(BuildContext context, AllRoutesRepo repository) {
    return BlocProvider(
        create: (context) =>
            AllRouteBloc(repository)..add(const readAllRouteEvent()),
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
                return Container(
                  color: Colors.white,
                  child: ListView.builder(
                      itemCount: state.data.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          key: ValueKey(index),
                          onTap: () {
                            _showSaveForm(state.data[index].routeStops);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              color: Colors.green[100],
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
                                  height: 40,
                                  width: 40,
                                ),
                                // onTap: () {
                                //   _showSaveForm(state.data[index].routeStops);
                                // },

                                title: Padding(
                                  padding: const EdgeInsets.only(left: 65.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        state.data[index].routeName != null
                                            ? state.data[index].routeName
                                                as String
                                            : "MyName",
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                  ),
                                ),

                                // subtitle: Text(state.data[index].coordinates),
                              ),
                            ),
                          ),
                        );
                      }),
                );
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
          backgroundColor: Colors.white,
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
                    color: Colors.black,
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
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Coordinate ${index + 1}:',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Lang: ${coordinate.longitude} ",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                )),
                            const SizedBox(
                              height: 6,
                            ),
                            Text("Lat:    ${coordinate.latitude} ",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                )),
                          ],
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
