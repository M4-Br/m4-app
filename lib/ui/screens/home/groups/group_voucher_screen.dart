import 'dart:io';

import 'package:app_flutter_miban4/data/model/userData/user.dart';
import 'package:app_flutter_miban4/ui/controllers/login/user_controller.dart';
import 'package:app_flutter_miban4/ui/screens/home/groups/group_my_transactions.dart';
import 'package:app_flutter_miban4/ui/screens/home/home_view_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class GroupVoucher extends StatefulWidget {
  final Map<String, dynamic>? group;
  String status;
  String amount;
  String id;
  String type;
  DateTime date;
  int installment;
  int totalInstallment;
  final String typePayment;
  final String groupID;

  GroupVoucher({
    super.key,
    required this.status,
    required this.amount,
    required this.id,
    required this.type,
    required this.date,
    required this.installment,
    required this.totalInstallment,
    required this.typePayment,
    required this.groupID,
    required this.group,
  });

  @override
  State<GroupVoucher> createState() => _GroupVoucherState();
}

class _GroupVoucherState extends State<GroupVoucher> {
  final UserController _userController = Get.put(UserController());
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserData? userData = _userController.userData.value;
    final currencyFormat =
        NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.transfer_receipt,
          style: const TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => widget.type != 'notifications_pay'
                ? Get.off(
                    () => GroupMyTransactions(
                      id: int.parse(widget.groupID),
                      type: widget.type,
                      group: widget.group,
                    ),
                  )
                : Get.offAll(() => const HomeViewPage(),
                    transition: Transition.rightToLeft),
            icon: const Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.black,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Screenshot(
          controller: screenshotController,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    AppLocalizations.of(context)!.voucher_group_payment,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Divider(
                    height: 1,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Status",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Text(
                      AppLocalizations.of(context)!.success,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!
                            .voucher_group_code_payment,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      Text("${widget.id.substring(0, 15)}...",
                          style: const TextStyle(
                              color: Colors.black, fontSize: 18))
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        AppLocalizations.of(context)!
                            .voucher_group_value_payment,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16)),
                    Text(currencyFormat.format(int.parse(widget.amount) / 100),
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16))
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Divider(
                    height: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    AppLocalizations.of(context)!.voucher_origin.toUpperCase(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.account,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Text(
                      userData!.payload.aliasAccount.accountNumber,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.transfer_name,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      Text(
                        userData.payload.fullName,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.transfer_bank,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    const Text(
                      'Mibank',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Divider(
                    height: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    AppLocalizations.of(context)!
                        .voucher_destination
                        .toUpperCase(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.voucher_destination,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Text(
                      widget.group!['data'][0]['group_account']['name'],
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.transfer_name,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      Text(
                        userData.payload.fullName,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.account,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Text(
                      userData.payload.aliasAccount.economyAccountNumber,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.transfer_bank,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      const Text(
                        'Banco Pagme',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 36),
                  child: SvgPicture.asset(
                    'assets/images/miban4_colored_logo.svg',
                    width: 100,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
