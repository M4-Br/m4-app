import 'package:app_flutter_miban4/data/api/balance/balanceAPI.dart';
import 'package:app_flutter_miban4/data/model/userData/balance.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixMyKeys.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixStatement.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

class PixBalance extends StatefulWidget {
  const PixBalance({
    Key? key,
  }) : super(key: key);

  @override
  State<PixBalance> createState() => _PixBalanceState();
}

class _PixBalanceState extends State<PixBalance> {
  bool _isVisible = false;
  late Future<Balance> _balance;
  late String _balanceValue;

  void _toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  void initState() {
    super.initState();
    _balance = getBalance();
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: '');

    return FutureBuilder<Balance>(
        future: _balance,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              width: MediaQuery.of(context).size.width,
              color: primaryColor,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(32, 24, 32, 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'R\$',
                            style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: Stack(
                              children: [
                                const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  child: InkWell(
                                    onTap: _toggleVisibility,
                                    child: Icon(
                                      _isVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                child: const PixStatementPage(),
                                type: PageTransitionType.rightToLeft,
                              ),
                            );
                          },
                          child: Container(
                            height: 60,
                            decoration: const BoxDecoration(
                              color: thirdColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'pix_statement'.tr,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 2),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                child: const PixMyKeys(),
                                type: PageTransitionType.rightToLeft,
                              ),
                            );
                          },
                          child: Container(
                            height: 60,
                            decoration: const BoxDecoration(
                              color: thirdColor,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'pix_myKeys'.tr,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            Balance balance = snapshot.data!;
            _balanceValue =
                currencyFormat.format(double.parse(balance.balanceCents) / 100);

            return Container(
              width: MediaQuery.of(context).size.width,
              color: primaryColor,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(32, 24, 32, 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'R\$',
                            style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: Stack(
                              children: [
                                Text(
                                  _isVisible ? _balanceValue : '******',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                Positioned(
                                  right: 0,
                                  child: InkWell(
                                    onTap: _toggleVisibility,
                                    child: Icon(
                                      _isVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                child: const PixStatementPage(),
                                type: PageTransitionType.rightToLeft,
                              ),
                            );
                          },
                          child: Container(
                            height: 60,
                            decoration: const BoxDecoration(
                              color: thirdColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'pix_statement'.tr,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 2),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                child: const PixMyKeys(),
                                type: PageTransitionType.rightToLeft,
                              ),
                            );
                          },
                          child: Container(
                            height: 60,
                            decoration: const BoxDecoration(
                              color: thirdColor,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'pix_myKeys'.tr,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        });
  }
}
