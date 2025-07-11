import 'dart:convert';
import 'dart:io';

import 'package:app_flutter_miban4/data/api/statement/statment_voucher.dart';
import 'package:app_flutter_miban4/data/model/statement/statementVoucherModel.dart';
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class StatementVoucherScreen extends StatefulWidget {
  final String? status;
  final String? amount;
  final String? beneficiary;
  final String? documentBeneficiary;
  final String? bank;
  final String? origin;
  final String? originDocument;
  final String? originBank;
  final String? id;
  final String? type;
  final String? date;

  const StatementVoucherScreen(
      {super.key,
      this.status,
      this.amount,
      this.beneficiary,
      this.documentBeneficiary,
      this.bank,
      this.origin,
      this.originDocument,
      this.originBank,
      this.id,
      this.type,
      this.date});

  @override
  State<StatementVoucherScreen> createState() => _StatementVoucherScreenState();
}

class _StatementVoucherScreenState extends State<StatementVoucherScreen> {
  late String lang;

  _getLang() async {
    lang = await SharedPreferencesFunctions.getString(key: 'codeLang');
  }

  @override
  void initState() {
    super.initState();
    _getLang();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: grey100,
        elevation: 0,
        centerTitle: true,
        title: SafeArea(
          child: Text(
            'statement_title'.tr,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        leading: SafeArea(
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder<StatementVoucher>(
          future: getStatementVoucher(widget.id!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: secondaryColor,
                ),
              );
            } else if (snapshot.hasError) {
              String errorMessage = 'unavailable'.tr;

              if (snapshot.error is Exception) {
                errorMessage = snapshot.error.toString().replaceFirst('Exception: ', '');
              } else {
                errorMessage = snapshot.error.toString();
              }

              WidgetsBinding.instance!.addPostFrameCallback((_) {
                Get.defaultDialog(
                    title: 'dialogErro'.tr,
                    titleStyle: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    content: Column(
                      children: [
                        Text(
                          errorMessage,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: ElevatedButton(
                            onPressed: () {
                              Get.back();
                              Get.back();
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: secondaryColor),
                            child: const Text(
                              'Ok',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ));
              });
              return Container();
            } else if (snapshot.data.toString().isEmpty) {
              return const Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Text('Falha ao consultar ID'),
                  ),
                  Spacer(),
                ],
              );
            } else {
              final statementData = snapshot.data!;
              return Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: _buildVoucher(statementData),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, bottom: 32, right: 16),
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            // Obtém o diretório de cache
                            final directory = await getTemporaryDirectory();
                            final path = directory.path;
                            final file = File('$path/voucher.png');

                            // Verifica se o arquivo existe
                            if (await file.exists()) {
                              // Compartilha o arquivo
                              Share.shareXFiles([XFile(file.path)],
                                  text: 'Aqui está o voucher');
                            } else {
                              throw Exception('Arquivo não encontrado!');
                            }
                          } catch (e) {
                            throw Exception('Erro ao compartilhar arquivo: $e');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            backgroundColor: secondaryColor),
                        child: Text(
                          'share'.tr.toUpperCase(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          }),
    );
  }

  _buildVoucher(StatementVoucher? statementData) {
    final currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: '');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          widget.type!,
          style: const TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        Text.rich(
          TextSpan(
              style: const TextStyle(color: Colors.black, fontSize: 16),
              children: [
                TextSpan(text: '${statementData!.date}'),
              ]),
          textAlign: TextAlign.center,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Divider(
            height: 1,
            color: Colors.black45,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Status',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              Text(
                statementData.status.toString(),
                style: const TextStyle(color: Colors.black, fontSize: 16),
              )
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    'statement_code'.tr,
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                    overflow: TextOverflow.visible,
                  ),
                ),
                Flexible(
                  child: Text(
                    statementData.id.toString(),
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                    overflow: TextOverflow.visible,
                    maxLines: 2,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            )),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'statement_value'.tr,
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
              Text(
                'R\$${currencyFormat.format(int.parse(statementData.amount.toString()) / 100)}',
                style: const TextStyle(color: Colors.black, fontSize: 16),
              )
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Divider(
            height: 1,
            color: Colors.black45,
          ),
        ),
        Text(
          'statement_origin'.tr,
          style: const TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'name'.tr,
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
              const SizedBox(
                width: 100,
              ),
              Flexible(
                child: Text(
                  splitNameAndNumber(
                          statementData.payer!.name.toString())['name']
                      .toString(),
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                  overflow: TextOverflow.visible,
                  maxLines: 2,
                  textAlign: TextAlign.end,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'statement_document'.tr,
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
              Text(
                containsNumbers(statementData.payer!.document!)
                    ? statementData.payer!.document!
                    : '',
                style: const TextStyle(color: Colors.black, fontSize: 16),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'statement_institute'.tr,
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
              Text(
                statementData.payer!.bankName.toString(),
                style: const TextStyle(color: Colors.black, fontSize: 16),
              )
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Divider(
            height: 1,
            color: Colors.black45,
          ),
        ),
        Text(
          'statement_destiny'.tr,
          style: const TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'name'.tr,
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
              Flexible(
                child: Text(
                  splitNameAndNumber(
                          statementData.receiver!.name.toString())['name']
                      .toString(),
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                  overflow: TextOverflow.visible,
                  maxLines: 2,
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'statement_document'.tr,
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
              Text(
                statementData.receiver!.document!.isNotEmpty
                    ? statementData.receiver!.document!
                    : '',
                style: const TextStyle(color: Colors.black, fontSize: 16),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'statement_institute'.tr,
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
              Text(
                statementData.receiver!.bankName.toString(),
                style: const TextStyle(color: Colors.black, fontSize: 16),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'statement_agency'.tr,
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
              Text(
                statementData.receiver!.agency.toString().isNotEmpty
                    ? statementData.receiver!.agency.toString()
                    : "",
                style: const TextStyle(color: Colors.black, fontSize: 16),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'statement_account'.tr,
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
              Text(
                statementData.receiver!.accountNumber.toString().isNotEmpty
                    ? statementData.receiver!.accountNumber.toString()
                    : "",
                style: const TextStyle(color: Colors.black, fontSize: 16),
              )
            ],
          ),
        ),
      ],
    );
  }

  Map<String, String> splitNameAndNumber(String fullName) {
    List<String> parts = fullName.split(' - ');
    String number = parts.length > 1 ? parts[0] : '';
    String name = parts.length > 1 ? parts[1] : fullName;
    return {
      'number': number,
      'name': name,
    };
  }

  bool containsNumbers(String text) {
    final RegExp regExp = RegExp(r'\d');
    return regExp.hasMatch(text);
  }
}
