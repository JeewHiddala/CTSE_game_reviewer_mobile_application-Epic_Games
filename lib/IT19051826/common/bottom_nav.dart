import 'package:flutter/material.dart';
import 'package:game_reviewer_application/pages/splash_screen.dart';
import '../../home.dart';
import '../pages/game_list.dart';


class BottomNavBar extends StatefulWidget {
  const BottomNavBar({ Key? key, required this.selectedIndex }) : super(key: key);
  final int selectedIndex;
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int _selectedIndex;
  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedIndex = widget.selectedIndex;
    });
  }
  final List<Widget> _children = [
    Home(),
    Home(),
    SplashScreen(),
    //Profile(),
  ];
  void _onItemTapped() {
    // if(_selectedIndex == 0){
    //   Navigator.of(context,rootNavigator:true).pop();
    // }else{
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) => _children[_selectedIndex]));
    // }

  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_back),
            label: 'Back',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Reviews',
          ),
        ],
        currentIndex: _selectedIndex,
        backgroundColor: Colors.amber,
        fixedColor: Colors.black,
        unselectedItemColor: Colors.blueGrey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          _onItemTapped();
        },
      );
  }
}
