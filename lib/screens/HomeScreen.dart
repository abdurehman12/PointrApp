import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pointr/screens/login.dart';

import '../AllRouteBloc/AllRouteUI.dart';
import '../CustomRouteBloc/CustomRouteUI.dart';
import '../classes/custom_route.dart';
import '../widgets/Add_Route.dart';
import '../widgets/bottomNavMint.dart';
import 'home.dart';

class HomeScreen extends StatelessWidget {
  _signOut(context) async {
    // Perform sign out logic here
    FirebaseAuth.instance.signOut();
    // Navigator.popUntil(context, ModalRoute.withName('/login'));
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (_) => LoginPage()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 162, 232, 1.0),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await _signOut(context);
            },
          ),
        ],
        title: Text('Home'),
        centerTitle: true,
      ),
      bottomNavigationBar: MyBottomNavigationBar(),
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
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Route'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Route Name'),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        ),
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
