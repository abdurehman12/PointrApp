import '../SuggestedRouteBloc/SuggestedRouteUI.dart';
import '../widgets/bottomNavMint.dart';
import '/CustomRouteBloc/bloc/Custom_route_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../AllRouteBloc/AllRouteUI.dart';
import 'Repo/CustomRoutes_Repo.dart';

class CustomRouteUI extends StatefulWidget {
  const CustomRouteUI({super.key});

  @override
  State<CustomRouteUI> createState() => _CustomRouteUI();
}

class _CustomRouteUI extends State<CustomRouteUI> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CustomRouteBloc(CustomRoutesRepo()),
        child: MyBody(context));
  }

  Widget MyBody(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            CustomRouteBloc(CustomRoutesRepo())..add(CustomAllRouteEvent()),
        child: Scaffold(
          // bottomNavigationBar: MyBottomNavigationBar(),
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.pending_actions),
              tooltip: 'Back',
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SuggestedRouteUI()));
              },
            ),
            title: const Text('Custom Routes'),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(Icons.list),
                tooltip: 'AllRoutes',
                color: Colors.white,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AllRouteUI()));
                },
              ),
            ],
          ),
          body: BlocListener<CustomRouteBloc, CustomRouteBlocState>(
            listener: (context, state) {
              if (state is CustomRouteMoved) {
                BlocProvider.of<CustomRouteBloc>(context)
                    .add(CustomAllRouteEvent());
              }
            },
            child: BlocBuilder<CustomRouteBloc, CustomRouteBlocState>(
              builder: (context, state) {
                if (state is CustomRouteLoad) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is CustomRouteSuccess) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      BlocProvider.of<CustomRouteBloc>(context)
                          .add(CustomAllRouteEvent());
                    },
                    child: ListView.builder(
                        itemCount: state.data.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              _showSaveForm(state.data[index].routeStops);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: ListTile(
                                tileColor: Colors.grey[200],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 16,
                                ),
                                trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () async {
                                          await showApproveDialog();
                                          BlocProvider.of<CustomRouteBloc>(
                                                  context)
                                              .add(CustomRouteBroadCastEvent(
                                                  obj: state.data[index]));
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.green,
                                        ),
                                        child: Text('BroadCast'),
                                      ),
                                    ]),
                                // leading: Icon(Icons.directions_bus),
                                // onTap: () {
                                //   _showSaveForm(state.data[index].routeStops);
                                // },
                                title: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                      state.data[index].routeName != null
                                          ? state.data[index].routeName
                                              as String
                                          : "MyName",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                                // subtitle: Text(state.data[index].coordinates),
                              ),
                            ),
                          );
                        }),
                  );
                } else if (state is CustomRouteError) {
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

  showApproveDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Return AlertDialog with circular progress indicator
        return AlertDialog(
          title: Text('Approving Route'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16.0),
              Text('Please wait...'),
            ],
          ),
        );
      },
    );

    // Delay for 3 seconds using Future.delayed
    Future.delayed(Duration(seconds: 3), () {
      // Close the dialog
      Navigator.of(context).pop();

      // Show success dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Route Successfully Added'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  // Close the dialog
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    });
  }
}
