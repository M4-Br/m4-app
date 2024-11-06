import 'package:app_flutter_miban4/data/api/credit/get_credit_installment.dart';
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/controllers/login/user_controller.dart';
import 'package:app_flutter_miban4/ui/screens/home/groups/group_my_transactions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CreditInstallments extends StatefulWidget {
  final Map<String, dynamic>? creditInstallment;
  final String id;
  final int pay;
  final int? page;
  final String type;
  final double? amount;

  const CreditInstallments({
    super.key,
    required this.creditInstallment,
    required this.id,
    required this.pay,
    this.amount,
    this.page,
    required this.type,
  });

  @override
  State<CreditInstallments> createState() => _CreditInstallmentsState();
}

class _CreditInstallmentsState extends State<CreditInstallments> {
  final UserController _userController = Get.put(UserController());
  var _obscureText = true.obs;
  var _isLoading = false.obs;
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    DateTime dueDate =
        DateTime.parse(widget.creditInstallment!['dueDate'].toString());
    DateTime today = DateTime.now();
    DateTime todayAtMidnight = DateTime(today.year, today.month, today.day);

    if (dueDate.isBefore(todayAtMidnight)) {
      Future.delayed(
        Duration.zero,
        () {
          Get.dialog(AlertDialog(
            title: Text('message'.tr, textAlign: TextAlign.center,),
            content:
                Text('credit_installment_delayed'.tr, textAlign: TextAlign.center,),
            actions: [
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 45,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: secondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(45),
                      ),
                    ),
                    child: const Text(
                      'OK',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ));
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: '');
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          'credit_credit'.toUpperCase().tr,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.white,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              widget.pay == 0
                  ? Text(
                      'group_will_pay'.tr,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                      textAlign: TextAlign.center,
                    )
                  : Text(
                      'group_you_paid'.tr,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
              Text(
                'R\$ ${currencyFormat.format(widget.creditInstallment!['amount'] / 100).toString()}',
                style: const TextStyle(
                    color: secondaryColor,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'group_day'.tr,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Text(
                      dateFormat.format(
                        DateTime.parse(
                          widget.creditInstallment!['dueDate'].toString(),
                        ),
                      ),
                      style: const TextStyle(
                          color: secondaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'group_installment'.tr,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Text(
                      '${widget.creditInstallment!['installment']} ${'off'.tr} ${widget.creditInstallment!['total_installment']}',
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'credit_credit'.tr,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Text(
                      'credit_credit'.tr,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'CPF/CNPJ',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Text(
                      widget.creditInstallment!['document'],
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'group_name'.tr,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Text(
                      widget.creditInstallment!['name'],
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'group_account'.tr,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Text(
                      _userController
                          .userData.value!.payload.aliasAccount.accountNumber,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'group_fees'.tr,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    const Text(
                      'R\$ 0,00',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              widget.creditInstallment!['status'] == 'pending'
                  ? Container(
                      height: 50,
                      width: double.infinity,
                      color: Colors.white,
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (_) {
                                return AlertDialog.adaptive(
                                  backgroundColor: Colors.white,
                                  title: Text(
                                    'password'.tr,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 20),
                                    textAlign: TextAlign.center,
                                  ),
                                  content: Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      children: [
                                        Obx(
                                          () => TextField(
                                            controller: _passwordController,
                                            cursorColor: secondaryColor,
                                            keyboardType: const TextInputType
                                                .numberWithOptions(),
                                            obscureText: _obscureText.value,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.black),
                                            maxLength: 6,
                                            decoration: InputDecoration(
                                              counterText: "",
                                              isDense: true,
                                              border: InputBorder.none,
                                              enabledBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey),
                                              ),
                                              focusedBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: secondaryColor),
                                              ),
                                              contentPadding: EdgeInsets.zero,
                                              hintText: '',
                                              suffixIcon: Obx(
                                                () => IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      _obscureText.value =
                                                          !_obscureText.value;
                                                    });
                                                  },
                                                  icon: Icon(
                                                    _obscureText.value == true
                                                        ? Icons.visibility_off
                                                        : Icons.visibility,
                                                    color: secondaryColor,
                                                    size: 25,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8, top: 16),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: SizedBox(
                                                  height: 45,
                                                  child: ElevatedButton(
                                                    onPressed: () => Get.back(),
                                                    style: ElevatedButton.styleFrom(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                        backgroundColor:
                                                            Colors.red),
                                                    child: Text(
                                                      'cancel'
                                                          .toUpperCase().tr,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Expanded(
                                                child: Obx(
                                                  () => _isLoading.value ==
                                                          false
                                                      ? SizedBox(
                                                          height: 45,
                                                          child: ElevatedButton(
                                                            onPressed:
                                                                () async {
                                                              setState(() {
                                                                _isLoading(
                                                                    true);
                                                              });
                                                              String pass =
                                                                  await SharedPreferencesFunctions
                                                                      .getString(
                                                                          key:
                                                                              'pass');

                                                              if (pass ==
                                                                  _passwordController
                                                                      .text
                                                                      .toString()) {
                                                                await getCreditInstallment(
                                                                        widget.creditInstallment![
                                                                            'id'],
                                                                        context)
                                                                    .then(
                                                                        (response) {
                                                                  if (response
                                                                          .status ==
                                                                      'success') {
                                                                    setState(
                                                                        () {
                                                                      _isLoading(
                                                                          false);
                                                                    });
                                                                    Get.back();
                                                                    Get.off(() =>
                                                                        GroupMyTransactions(
                                                                          id: int.parse(
                                                                              widget.id),
                                                                          page:
                                                                              widget.page!,
                                                                          type:
                                                                              widget.type,
                                                                        ));
                                                                    Get.snackbar(
                                                                        'dialog_success'.tr,
                                                                        'dialog_payment'.tr,
                                                                        snackPosition: SnackPosition
                                                                            .BOTTOM,
                                                                        duration: const Duration(
                                                                            seconds:
                                                                                5),
                                                                        icon: SvgPicture.asset(
                                                                            'assets/images/miban4_colored_logo.svg'),
                                                                        backgroundColor: Colors
                                                                            .white,
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            8));
                                                                  } else {
                                                                    setState(
                                                                        () {
                                                                      _isLoading(
                                                                          false);
                                                                    });
                                                                  }
                                                                });
                                                              } else {
                                                                setState(() {
                                                                  _isLoading(
                                                                      false);
                                                                });
                                                                Get.snackbar(
                                                                    'dialog_error'.tr,
                                                                    'dialog_password_incorrect'.tr,
                                                                    snackPosition:
                                                                        SnackPosition
                                                                            .BOTTOM,
                                                                    duration:
                                                                        const Duration(
                                                                            seconds:
                                                                                5),
                                                                    icon: SvgPicture
                                                                        .asset(
                                                                            'assets/images/miban4_colored_logo.svg'),
                                                                    backgroundColor:
                                                                        Colors
                                                                            .white,
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8));
                                                              }
                                                            },
                                                            style: ElevatedButton.styleFrom(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20)),
                                                                backgroundColor:
                                                                    secondaryColor),
                                                            child: Text(
                                                              'group_pay'
                                                                  .toUpperCase().tr,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        )
                                                      : const CircularProgressIndicator(
                                                          color: secondaryColor,
                                                        ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            backgroundColor: secondaryColor),
                        child: Text(
                          'group_pay'.toUpperCase().tr,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
