import 'package:flutter/material.dart';
import 'package:pointr/CustomRouteBloc/CustomRouteUI.dart';

import '../AllRouteBloc/AllRouteUI.dart';
import 'Add_Route.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Perform navigation based on the selected index
    switch (index) {
      case 0:
        // Navigate to the Dashboard screen
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => Home()));
        break;
      case 1:
        // Navigate to the Account screen
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AllRouteUI()));
        break;
      case 2:
        //Pop up request form

        // Show the form dialog
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const DashboardScreen()));
        break;
      case 3:
        // Navigate to the Store screen
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const CustomRouteUI()));
        break;
      case 4:
        // Navigate to the Settings screen
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => Home()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.location_on),
          label: 'FindRoute',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bus_alert_rounded),
          label: 'AllRoutes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'AddRoute',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt_rounded),
          label: 'CustomRoutes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
      // currentIndex: _selectedIndex,
      // selectedItemColor: Colors.blue,
      // onTap: _onItemTapped,
      currentIndex: _selectedIndex,
      backgroundColor: Colors.white,
      selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
      unselectedItemColor: Colors.grey,
      onTap: _onItemTapped,
    );
  }
}
