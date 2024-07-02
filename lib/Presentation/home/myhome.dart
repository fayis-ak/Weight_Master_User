import 'package:flutter/material.dart';
import 'package:weigh_master/Presentation/cart/cart.dart';
import 'package:weigh_master/Presentation/home/buy.dart';
import 'package:weigh_master/Presentation/message/notification.dart';
import 'package:weigh_master/Presentation/my_home_detils.dart';
import 'package:weigh_master/Presentation/setting/setting.dart';

class Myhome extends StatefulWidget {
  const Myhome({Key? key}) : super(key: key);

  @override
  State<Myhome> createState() => _MyhomeState();
}

class _MyhomeState extends State<Myhome> {
  int _selectedIndex = 0;
  late List<Product> cartItems = [];
  late Cart cart;

  late List<Widget> _widgetOptions;
  late List<AppBar> _appBars;

  @override
  void initState() {
    super.initState();
    cartItems = []; // Initialize cartItems here if needed
    cart = Cart(); // Create an instance of the Cart class
    _widgetOptions = <Widget>[
      const MyHomeDetails(),
      CartPage(),
      const Notificationn(),
      Setting(),
    ];
    _appBars = <AppBar>[
      AppBar(
        backgroundColor: const Color.fromARGB(255, 100, 250, 250),
        title: const Text('Weigh Master'),
        automaticallyImplyLeading: false,
      ),
      AppBar(
        backgroundColor: Color.fromARGB(255, 163, 255, 255),
        title: const Text('Cart'),
        automaticallyImplyLeading: false,
      ),
      AppBar(
        backgroundColor: const Color.fromARGB(255, 100, 250, 250),
        title: const Text('Notifications'),
        automaticallyImplyLeading: false,
      ),
      AppBar(
        backgroundColor: const Color.fromARGB(255, 100, 250, 250),
        title: const Text('Settings'),
        automaticallyImplyLeading: false,
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBars[_selectedIndex],
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromRGBO(100, 205, 250, 219),
        unselectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dehaze_sharp),
            label: 'Settings',
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
