import 'package:app_flutter_miban4/data/model/userData/user.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/controllers/login/user_controller.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixHome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PixVoucher extends StatelessWidget {
  final Map<String, dynamic>? transfer;
  final String? amount;
  final String? name;
  final String? institute;

  PixVoucher(
      {super.key, this.transfer, this.amount, this.name, this.institute});

  String _formatDate(String dateHour) {
    // Converte a string para um objeto DateTime.
    DateTime dateTime = DateTime.parse(dateHour);

    // Formata a data.
    String date = DateFormat('dd/MM/yyyy').format(dateTime);

    // Formata a hora.
    String hour = DateFormat('HH:mm:ss').format(dateTime);

    // Retorna a data e hora formatadas.
    return '$date | $hour';
  }

  final UserController _userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SafeArea(
          child: Text(
            'pix_withKey'.tr,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 0,
        leading: SafeArea(
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              Get.off(() => PixHome(), transition: Transition.rightToLeft);
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          UserData? userData = _userController.userData.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              Image.asset(
                'assets/icons/ic_pix_success.png',
                scale: 4,
              ),
              Text(
                'pix_success'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                _formatDate(transfer!['transaction_date']),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black54, fontSize: 16),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  children: [
                    Text(
                      'statement_value'.tr,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Spacer(),
                    Text(
                      'R\$ ${NumberFormat.currency(locale: 'pt_BR', symbol: '').format(int.parse(amount!) / 100)}',
                      style: const TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    'statement_destiny'.tr,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Spacer(),
                  Text(
                    name!,
                    style: const TextStyle(fontSize: 16),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  children: [
                    Text(
                      'statement_institute'.tr,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Spacer(),
                    Flexible(
                      child: Text(
                        institute!,
                        style: const TextStyle(
                            fontSize: 16,
                            overflow: TextOverflow.ellipsis,
                            color: Colors.black),
                        maxLines: 2,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    'statement_origin'.tr,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Spacer(),
                  Text(
                    userData!.payload.fullName,
                    style: const TextStyle(fontSize: 16),
                  )
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
