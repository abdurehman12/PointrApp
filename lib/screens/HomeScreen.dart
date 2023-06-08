import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pointr/screens/set_points_view_routes.dart';

import '../AllRouteBloc/AllRouteUI.dart';
import '../CustomRouteBloc/CustomRouteUI.dart';
import '../widgets/Add_Route.dart';
import 'NewLogin.dart';
import '../classes/catalogue.dart';

class HomeScreen extends StatelessWidget {
  late FirebaseAuth? auth;
  HomeScreen({super.key, this.auth});

  _signOut(context) async {
    // Perform sign out logic here
    auth == null ? await FirebaseAuth.instance.signOut() : {};
    // Navigator.popUntil(context, ModalRoute.withName('/login'));
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Logging out...'),
            ],
          ),
        );
      },
    );
    await Future.delayed(const Duration(seconds: 2), () async {
      Navigator.of(context).pop();

      await Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => const Login()), (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    auth == null ? Catalogue.loadRoutes() : {};
    // Catalogue.loadRoutes();
    return Scaffold(
      // backgroundColor: const Color.fromRGBO(0, 162, 232, 1.0),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              auth == null ? await _signOut(context) : {};
            },
          ),
        ],
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              splashFactory:
                  InkRipple.splashFactory, // Increase the duration here,
              onTap: () {
                // Navigation logic here
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SetPointsViewRoutes()),
                );
              },
              splashColor: Colors.red, // Customize the splash color
              highlightColor: Colors.green,
              child: Card(
                //
                color: Colors.green[100],
                elevation: 40, // Adjust the elevation for desired shadow depth
                shadowColor: Colors.black.withOpacity(0.8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      16.0), // Adjust the radius as needed
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/map (1).png', // Replace with your image path
                        width: 48,
                        height: 48,
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Find Best Bus Routes',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'You can enter your source and destination points here and we will find the best bus route for you.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              splashFactory:
                  InkRipple.splashFactory, // Increase the duration here,
              onTap: () {
                // Navigation logic here
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => OtherScreen()),
                // );
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CustomRouteUI()));
              },
              splashColor: Colors.red, // Customize the splash color
              highlightColor: Colors.green,
              child: Card(
                // color: Colors.green[100],
                color: Colors.orange[400],
                elevation: 50, // Adjust the elevation for desired shadow depth
                shadowColor: Colors.black.withOpacity(0.8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      16.0), // Adjust the radius as needed
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/bus.png', // Replace with your image path
                        width: 48,
                        height: 48,
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'My Custom Bus Routes',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'You can find your custom bus routes here. Click on the route to see the coordinates of the route.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              splashFactory:
                  InkRipple.splashFactory, // Increase the duration here,
              onTap: () {
                // Navigation logic here
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => OtherScreen()),
                // );
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DashboardScreen()));
              },
              splashColor: Colors.red[400], // Customize the splash color
              highlightColor: Colors.red[400],
              child: Card(
                color: Colors.red[400],
                elevation: 50, // Adjust the elevation for desired shadow depth
                shadowColor: Colors.black.withOpacity(0.8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      16.0), // Adjust the radius as needed
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/map.png', // Replace with your image path
                        width: 48,
                        height: 48,
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Add Custom Bus Routes',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'You can add custom bus routes here. Click on the Map to add coordinates to your route.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              splashFactory:
                  InkRipple.splashFactory, // Increase the duration here,
              onTap: () {
                // Navigation logic here
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => OtherScreen()),
                // );
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AllRouteUI()));
              },
              splashColor: Colors.blue[400], // Customize the splash color
              highlightColor: Colors.blue[400],
              child: Card(
                color: Colors.blue[400],
                elevation: 50, // Adjust the elevation for desired shadow depth
                shadowColor: Colors.black.withOpacity(0.8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      16.0), // Adjust the radius as needed
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/route.png', // Replace with your image path
                        width: 48,
                        height: 48,
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'All Bus Routes',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'You can find all available bus routes here. Click on the route to see the coordinates of the route.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: const MyBottomNavigationBar(),
      // bottomNavigationBar: BottomAppBar(
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       IconButton(
      //         icon: Icon(Icons.add),
      //         onPressed: () {
      //           showDialog(
      //             context: context,
      //             builder: (BuildContext context) {
      //               return AddRouteDialog();
      //               // CustomRoute().fetchRoutesFromDb();
      //             },
      //           );
      //         },
      //       ),
      //       IconButton(
      //         icon: Icon(Icons.delete),
      //         onPressed: () async {
      //           List<Map<String, dynamic>> items =
      //               await CustomRoute.fetchRoutesFromDb();
      //           for (Map<String, dynamic> x in items) {
      //             print(x);
      //           }
      //         },
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}

class AddRouteDialog extends StatelessWidget {
  const AddRouteDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Route'),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Route Name'),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        ),
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
    );
  }
}

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _currentIndex = 0;
//   final PageController _pageController = PageController();
//   List<Widget> _screens = [
//     HomePage(),
//     AllRouteUI(),
//     DashboardScreen(),
//     CustomRouteUI(),
//     DashboardScreen(),
//     // Home()
//   ];

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromRGBO(0, 162, 232, 1.0),
//       appBar: AppBar(
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: () async {
//               await _signOut(context);
//             },
//           ),
//         ],
//         title: Text('Home'),
//         centerTitle: true,
//       ),
//       body: PageView(
//         controller: _pageController,
//         children: _screens,
//         onPageChanged: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//             _pageController.animateToPage(
//               index,
//               duration: Duration(milliseconds: 300),
//               curve: Curves.easeInOut,
//             );
//           });
//         },
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.location_on),
//             label: 'FindRoute',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.bus_alert_rounded),
//             label: 'AllRoutes',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.add),
//             label: 'AddRoute',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.list_alt_rounded),
//             label: 'CustomRoutes',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: 'Settings',
//           ),
//         ],
//       ),
//     );
//   }

//   _signOut(context) async {
//     // Perform sign out logic here
//     FirebaseAuth.instance.signOut();
//     // Navigator.popUntil(context, ModalRoute.withName('/login'));
//     Navigator.pushAndRemoveUntil(context,
//         MaterialPageRoute(builder: (_) => LoginPage()), (route) => false);
//   }
// }
