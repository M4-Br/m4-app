import 'package:app_flutter_miban4/data/api/balance/balanceAPI.dart';
import 'package:app_flutter_miban4/data/model/userData/balance.dart';
import 'package:app_flutter_miban4/data/model/userData/user.dart';
import 'package:app_flutter_miban4/ui/colors/theme.dart';
import 'package:app_flutter_miban4/ui/controllers/login/user_controller.dart';
import 'package:app_flutter_miban4/ui/screens/login/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeCard extends StatefulWidget {
  const HomeCard({super.key});

  @override
  State<HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  late Future<Balance> _balanceFuture;
  bool _isVisible = false;
  late String _balanceValue;
  late String _transational;
  late String _transationalValue;
  final UserController _userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    _balanceFuture = getBalance();
  }

  void _toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: '');
    UserData? userData = _userController.userData.value;

    Color cardColor;
    Color fontColor;
    String assetPath;

    if (userData != null) {
      cardColor = Color(
        int.parse(
          "0xFF${userData.payload.cardColor.replaceAll('#', '')}",
        ),
      );
      fontColor = Color(
        int.parse(
          "0xFF${userData.payload.fontColor.replaceAll('#', '')}",
        ),
      );
    } else {
      cardColor = const Color(0xFF194f91);
      fontColor = Colors.white;
    }

    if (userData != null) {
      switch (userData.payload.companyId) {
        case 1:
          assetPath = 'assets/images/ic_default_logo.png';
          break;
        case 2:
          assetPath = 'assets/images/acme_logo.png';
          break;
        default:
          assetPath = 'assets/images/ic_default_logo.png';
      }
    } else {
      assetPath = 'assets/images/ic_default_logo.png';
    }

    return FutureBuilder<Balance>(
      future: _balanceFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingCard(cardColor, fontColor, assetPath);
        } else if (snapshot.hasError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Get.defaultDialog(
              title: 'message'.tr,
              content: Column(
                children: [
                  Text(snapshot.error.toString(),
                      style: TextStyle(color: fontColor)),
                  ElevatedButton(
                    onPressed: () => Get.offAll(() => const SplashPage(),
                        transition: Transition.fade),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: secondaryColor),
                    child:
                        const Text('OK', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            );
          });
          return Container();
        } else {
          Balance balance = snapshot.data!;
          _balanceValue = balance.balanceCents != "N/D"
              ? balance.balanceCents != null && balance.balanceCents != 0
                  ? currencyFormat
                      .format(double.parse(balance.balanceCents) / 100)
                  : "0,00"
              : balance.balanceCents;
          _transationalValue = balance.transactionalValue;
          _transational = _transationalValue != "N/D"
              ? _transationalValue.isNotEmpty
                  ? currencyFormat
                      .format(double.parse(_transationalValue.toString()) / 100)
                  : "0,00"
              : _transationalValue;

          return _buildBalanceCard(cardColor, fontColor, assetPath);
        }
      },
    );
  }

  Widget _buildLoadingCard(Color cardColor, Color fontColor, String assetPath) {
    return Container(
      height: 200,
      alignment: Alignment.topLeft,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [cardColor, cardColor.withOpacity(1)],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 20),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Image.asset(assetPath, width: 100),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text('balance_available'.tr,
                  style: TextStyle(color: fontColor, fontSize: 18)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 8),
              child: Row(
                children: [
                  Text('R\$', style: TextStyle(color: fontColor, fontSize: 16)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Stack(
                      children: [
                        const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(),
                        ),
                        Positioned(
                          right: 0,
                          child: InkWell(
                            onTap: _toggleVisibility,
                            child: Icon(
                              _isVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: fontColor,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 8),
              child: Text('balance_transational'.tr,
                  style: TextStyle(color: fontColor, fontSize: 14)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard(Color cardColor, Color fontColor, String assetPath) {
    return Container(
      height: 200,
      alignment: Alignment.topLeft,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [cardColor, cardColor.withOpacity(1)],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 20),
            Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 8),
              child: Image.asset(assetPath, width: 100),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text('balance_available'.tr,
                  style: TextStyle(color: fontColor, fontSize: 18)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 8),
              child: Row(
                children: [
                  Text('R\$', style: TextStyle(color: fontColor, fontSize: 16)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Stack(
                      children: [
                        Text(
                          _isVisible ? _balanceValue : '******',
                          style: TextStyle(color: fontColor, fontSize: 20),
                        ),
                        Positioned(
                          right: 0,
                          child: InkWell(
                            onTap: _toggleVisibility,
                            child: Icon(
                              _isVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: fontColor,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 8),
              child: Text('balance_transational'.tr,
                  style: TextStyle(color: fontColor, fontSize: 14)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 8),
              child: Row(
                children: [
                  Text('R\$', style: TextStyle(color: fontColor, fontSize: 12)),
                  const SizedBox(width: 10),
                  Text(
                    _isVisible ? _transational : '******',
                    style: TextStyle(color: fontColor, fontSize: 16),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
