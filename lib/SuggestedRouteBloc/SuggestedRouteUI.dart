
import '../screens/NewLogin.dart';
import '/SuggestedRouteBloc/bloc/suggested_route_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Repo/SuggestedRoutes_Repo.dart';

class SuggestedRouteUI extends StatefulWidget {
  const SuggestedRouteUI({super.key});

  @override
  State<SuggestedRouteUI> createState() => _SuggestedRouteUI();
}

class _SuggestedRouteUI extends State<SuggestedRouteUI> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SuggestedRouteBloc(SuggestedRoutesRepo()),
        // child: MyBody(context));
        child: AlertDialog(
          title: const Text("Welcome Admin"),
          content: const Text(
              "You are in the Suggested Routes database, and can approve or reject routes suggested by users. Approved routes will be added to the allroutes list."),
          actions: [
            TextButton(
                onPressed: () {
                  // Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyBody(context)),
                  );
                  // MyBody(context);
                },
                child: const Text("OK"))
          ],
        ));
  }

  Widget MyBody(BuildContext context) {
    return BlocProvider(
        create: (context) => SuggestedRouteBloc(SuggestedRoutesRepo())
          ..add(const SuggestedAllRouteEvent()),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green[400],
            title: const Text('Suggested Routes'),
            centerTitle: true,
            actions: [
              // IconButton(
              //   icon: Icon(Icons.list),
              //   tooltip: 'AllRoutes',
              //   color: Colors.white,
              //   onPressed: () {
              //     Navigator.push(context,
              //         MaterialPageRoute(builder: (context) => AllRouteUI()));
              //   },
              // ),
              IconButton(
                icon: const Icon(Icons.logout),
                tooltip: 'AllRoutes',
                color: Colors.white,
                onPressed: () {
                  // Navigator.popUntil(context, ModalRoute.withName("/login"));
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return const AlertDialog(
                        content: Row(
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(width: 16),
                            Text('Signing out...'),
                          ],
                        ),
                      );
                    },
                  );

                  Future.delayed(const Duration(seconds: 2), () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Login(),
                        )); // Close the signing out dialog
                  });
                },
              ),
            ],
          ),
          body: BlocListener<SuggestedRouteBloc, SuggestedRouteBlocState>(
            listener: (context, state) {
              if (state is SuggestedRouteMoved) {
                BlocProvider.of<SuggestedRouteBloc>(context)
                    .add(const SuggestedAllRouteEvent());
              }
            },
            child: BlocBuilder<SuggestedRouteBloc, SuggestedRouteBlocState>(
              builder: (context, state) {
                if (state is SuggestedRouteLoad) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SuggestedRouteSuccess) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      BlocProvider.of<SuggestedRouteBloc>(context)
                          .add(const SuggestedAllRouteEvent());
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
                                leading: Image.asset(
                                  'assets/images/pathway (1).png',
                                  height: 40,
                                  width: 40,
                                ),
                                tileColor: Colors.green[100],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 16,
                                ),
                                subtitle: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SizedBox(width: 8.0),
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            await showApproveDialog();
                                            BlocProvider.of<SuggestedRouteBloc>(
                                                    context)
                                                .add(SuggestedRouteDeleteEvent(
                                                    index: index));
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green,
                                          ),
                                          child: const Text('Approve'),
                                        ),
                                      ),
                                      const SizedBox(width: 8.0),
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            BlocProvider.of<SuggestedRouteBloc>(
                                                    context)
                                                .add(SuggestedRouteUpdateEvent(
                                                    index: index));
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                          ),
                                          child: const Text('Reject'),
                                        ),
                                      ),
                                    ]),

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
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                                // subtitle: Text(state.data[index].coordinates),
                              ),
                            ),
                          );
                        }),
                  );
                } else if (state is SuggestedRouteError) {
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

  showApproveDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Return AlertDialog with circular progress indicator
        return const AlertDialog(
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
    Future.delayed(const Duration(seconds: 3), () {
      // Close the dialog
      Navigator.of(context).pop();

      // Show success dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Route Successfully Added'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  // Close the dialog
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    });
  }
}
