import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/screens/home/perfil/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'home/home_page.dart';
import 'statement/statement_page.dart';

class HomeViewPage extends StatefulWidget {

  const HomeViewPage({super.key,});

  @override
  State<HomeViewPage> createState() => _HomeViewPageState();
}

class _HomeViewPageState extends State<HomeViewPage> {
  int _selectedIndex = 0;

  Image getIcon(int index) {
    Color color = _selectedIndex == index ? secondaryColor : Colors.grey;
    switch (index) {
      case 0:
        return Image.asset('assets/icons/ic_home.png', width: 30, color: color);
      case 4:
        return Image.asset('assets/icons/ic_card_wallet.png',
            width: 30, color: color);
      case 1:
        return Image.asset('assets/icons/ic_statement2.png',
            width: 30, color: color);
      case 2:
        return Image.asset('assets/icons/ic_config.png',
            width: 30, color: color);
      default:
        return Image.asset('assets/icons/ic_home.png', width: 30, color: color);
    }
  }

  void _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetOptions = <Widget>[
      const HomePage(),
      StatementPage(),
      const ProfilePage(),
    ]; //

    return Scaffold(
      backgroundColor: Colors.white,
      body: widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: getIcon(0),
            label: AppLocalizations.of(context)!.home_icon,
          ),
          BottomNavigationBarItem(
            icon: getIcon(1),
            label: AppLocalizations.of(context)!.statement_icon,
          ),
          BottomNavigationBarItem(
            icon: getIcon(2),
            label: AppLocalizations.of(context)!.perfil_icon,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
