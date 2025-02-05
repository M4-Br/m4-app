import 'package:app_flutter_miban4/data/api/balance/balanceAPI.dart';
import 'package:app_flutter_miban4/data/api/credit/get_credit_installment.dart';
import 'package:app_flutter_miban4/data/api/groups/getContributionId.dart';
import 'package:app_flutter_miban4/data/api/groups/payInstallment.dart';
import 'package:app_flutter_miban4/data/model/groups/contributionID.dart';
import 'package:app_flutter_miban4/data/model/userData/balance.dart';
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/controllers/login/user_controller.dart';
import 'package:app_flutter_miban4/ui/screens/home/groups/group_my_transactions.dart';
import 'package:app_flutter_miban4/ui/screens/home/groups/group_voucher_screen.dart';
import 'package:app_flutter_miban4/ui/screens/home/notifications/notifications_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Contribution extends StatefulWidget {
  final Map<String, dynamic>? group;
  final String id;
  final int pay;
  final String groupID;
  final int? page;
  final String type;
  final double? amount;

  const Contribution({
    super.key,
    this.group,
    required this.id,
    required this.pay,
    required this.groupID,
    this.page,
    required this.type,
    this.amount,
  });

  @override
  State<Contribution> createState() => _ContributionState();
}

class _ContributionState extends State<Contribution> {
  late Future<ContributionID> _contribution;
  late Future<ContributionID> _installment;
  final UserController _userController = Get.put(UserController());
  var _obscureText = true.obs;
  var _isLoading = false.obs;
  final TextEditingController _passwordController = TextEditingController();
  late Balance _balance;

  void _loadContribution() {
    setState(() {
      _contribution = getContributionId(
        widget.id,
      );
    });
  }

  void _loadInstallment() {
    _installment = getCreditInstallment(widget.id, context);
  }

  void _loadBalance() async {
    _balance = await getBalance();
  }

  @override
  void initState() {
    super.initState();
    _loadBalance();
    widget.type == 'mutual_payment' ? _loadInstallment() : _loadContribution();
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: '');
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarDefault(
        title: 'group_contribution_individual'.tr.toUpperCase(),
        backPage: () => widget.type == 'notifications_pay'
            ? Get.off(() => const Notifications(),
                transition: Transition.rightToLeft)
            : Get.off(
                () => GroupMyTransactions(
                  group: widget.group,
                  id: int.parse(widget.groupID),
                  page: widget.page!,
                  type: widget.type,
                ),
              ),
      ),
      body: FutureBuilder<ContributionID>(
          future:
              widget.type == 'mutual_payment' ? _installment : _contribution,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: secondaryColor,
                ),
              );
            } else if (snapshot.hasError) {
              return const SizedBox.shrink();
            } else {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      widget.pay == 0
                          ? Text(
                              'group_will_pay'.tr,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                              textAlign: TextAlign.center,
                            )
                          : Text(
                              'group_you_paid'.tr,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                      Text(
                        'R\$ ${currencyFormat.format(snapshot.data!.amount / 100).toString()}',
                        style: const TextStyle(
                            color: secondaryColor,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      Text.rich(
                        TextSpan(children: [
                          TextSpan(text: '${'savings_balance'.tr}: '),
                          TextSpan(
                              text:
                                  'R\$ ${currencyFormat.format(snapshot.data!.groupAccount.amountByPeriod / 100).toString()}')
                        ]),
                        style:
                            const TextStyle(fontSize: 16, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 32),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'group_day'.tr,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                            ),
                            Text(
                              dateFormat.format(
                                DateTime.now(),
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
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                            ),
                            Text(
                              '${snapshot.data!.installment} ${'off'.tr} ${snapshot.data!.groupAccount.installment}',
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
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
                              'group_group'.tr,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                            ),
                            Text(
                              snapshot.data!.groupAccount.name,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
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
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            Text(
                              snapshot.data!.user.document,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
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
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                            ),
                            Text(
                              snapshot.data!.user.name,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
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
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                            ),
                            Text(
                              _userController.userData.value!.payload
                                  .aliasAccount.accountNumber,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
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
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                            ),
                            Text(
                              'R\$ ${currencyFormat.format(snapshot.data!.groupAccount.mutual.fee / 100).toString()}',
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      snapshot.data!.status == 'pending'
                          ? Container(
                              height: 50,
                              width: double.infinity,
                              color: Colors.white,
                              child: ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (_) {
                                        return AlertDialog.adaptive(
                                          backgroundColor: Colors.white,
                                          title: Text(
                                            'password'.tr,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 20),
                                            textAlign: TextAlign.center,
                                          ),
                                          content: Container(
                                            height: 200,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Column(
                                              children: [
                                                Obx(
                                                  () => TextField(
                                                    controller:
                                                        _passwordController,
                                                    cursorColor: secondaryColor,
                                                    keyboardType:
                                                        const TextInputType
                                                            .numberWithOptions(),
                                                    obscureText:
                                                        _obscureText.value,
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
                                                            color:
                                                                secondaryColor),
                                                      ),
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      hintText: '',
                                                      suffixIcon: Obx(
                                                        () => IconButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              _obscureText
                                                                      .value =
                                                                  !_obscureText
                                                                      .value;
                                                            });
                                                          },
                                                          icon: Icon(
                                                            _obscureText.value ==
                                                                    true
                                                                ? Icons
                                                                    .visibility_off
                                                                : Icons
                                                                    .visibility,
                                                            color:
                                                                secondaryColor,
                                                            size: 25,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8,
                                                          right: 8,
                                                          top: 16),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 45,
                                                        width: double.infinity,
                                                        child: ElevatedButton(
                                                          onPressed: () =>
                                                              Get.back(),
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
                                                                .tr
                                                                .toUpperCase(),
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      Obx(
                                                        () => _isLoading
                                                                    .value ==
                                                                false
                                                            ? SizedBox(
                                                                height: 45,
                                                                width: double
                                                                    .infinity,
                                                                child:
                                                                    ElevatedButton(
                                                                  onPressed:
                                                                      () async {
                                                                    setState(
                                                                        () {
                                                                      _isLoading(
                                                                          true);
                                                                    });
                                                                    String
                                                                        pass =
                                                                        await SharedPreferencesFunctions.getString(
                                                                            key:
                                                                                'pass');

                                                                    if (pass ==
                                                                        _passwordController
                                                                            .text
                                                                            .toString()) {
                                                                      if (int.parse(_balance
                                                                              .balanceCents) >=
                                                                          int.parse(snapshot
                                                                              .data!
                                                                              .amount
                                                                              .toString())) {
                                                                        await payInstallment(snapshot.data!.id.toString())
                                                                            .then((response) {
                                                                          if (response.status ==
                                                                              'success') {
                                                                            setState(() {
                                                                              _isLoading(false);
                                                                            });
                                                                            Get.back();
                                                                            Get.off(() =>
                                                                                GroupVoucher(
                                                                                  status: response.status,
                                                                                  amount: response.amount.toString(),
                                                                                  id: response.id,
                                                                                  type: response.transactionType,
                                                                                  date: response.dueDate,
                                                                                  installment: response.installment,
                                                                                  totalInstallment: snapshot.data!.groupAccount.installment,
                                                                                  groupID: widget.groupID.isNotEmpty ? widget.groupID : '',
                                                                                  typePayment: widget.type,
                                                                                  group: widget.group,
                                                                                ));
                                                                            setState(() {
                                                                              _isLoading(false);
                                                                            });
                                                                            Get.snackbar('dialog_success'.tr,
                                                                                'dialog_payment'.tr,
                                                                                snackPosition: SnackPosition.BOTTOM,
                                                                                duration: const Duration(seconds: 5),
                                                                                icon: SvgPicture.asset('assets/images/miban4_colored_logo.svg'),
                                                                                backgroundColor: Colors.white,
                                                                                padding: const EdgeInsets.all(8));
                                                                          } else {
                                                                            setState(() {
                                                                              _isLoading(false);
                                                                            });
                                                                          }
                                                                        });
                                                                      } else {
                                                                        setState(
                                                                            () {
                                                                          _isLoading(
                                                                              false);
                                                                        });
                                                                        Get.back();
                                                                        Get.back();
                                                                        Get.defaultDialog(
                                                                            title: 'dialog_error'.tr,
                                                                            content: Column(
                                                                              children: [
                                                                                Text('balance_insufficient'.tr),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                  child: ElevatedButton(
                                                                                    onPressed: () => Get.back(),
                                                                                    style: ElevatedButton.styleFrom(backgroundColor: secondaryColor),
                                                                                    child: const Text(
                                                                                      'OK',
                                                                                      style: TextStyle(color: Colors.white),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ));
                                                                      }
                                                                    } else {
                                                                      setState(
                                                                          () {
                                                                        _isLoading(
                                                                            false);
                                                                      });
                                                                      Get.snackbar(
                                                                          'dialog_error'
                                                                              .tr,
                                                                          'dialog_password_incorrect'
                                                                              .tr,
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
                                                                    }
                                                                  },
                                                                  style: ElevatedButton.styleFrom(
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.circular(
                                                                              20)),
                                                                      backgroundColor:
                                                                          secondaryColor),
                                                                  child: Text(
                                                                    'group_pay'
                                                                        .tr
                                                                        .toUpperCase(),
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                              )
                                                            : const CircularProgressIndicator(
                                                                color:
                                                                    secondaryColor,
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
                                  'group_pay'.tr.toUpperCase(),
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
              );
            }
          }),
    );
  }
}
