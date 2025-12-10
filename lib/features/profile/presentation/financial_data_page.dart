import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_loading.dart';
import 'package:app_flutter_miban4/data/util/helpers/currencyFormatter.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:app_flutter_miban4/features/profile/controller/financial_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class FinancialDataPage extends GetView<FinancialController> {
  final String? groupID;

  const FinancialDataPage({super.key, this.groupID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'account_data'.tr,
        showBackButton: false,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: const AppLoading());
        }

        if (controller.userCapacity.value == null ||
            controller.userParams.value == null) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: const Center(
              child: Text('Erro ao exibir dados'),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'financial_info'.tr.toUpperCase(),
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'financial_inf_att'.tr.toUpperCase(),
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    // Text(
                    //   data.updateDate != null // Supus o nome 'updateDate'
                    //       ? DateFormat('dd/MM/yyyy')
                    //           .format(DateTime.parse(data.updateDate!))
                    //       : '',
                    //   style: const TextStyle(color: Colors.black, fontSize: 16),
                    // )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'financial_house'.tr.toUpperCase(),
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    DropdownButton<String>(
                      value: controller.selectedHomeType.value,
                      items: controller.dropdownHouse,
                      onChanged: (String? value) {
                        controller.selectedHomeType.value = value;
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'financial_transport'.tr.toUpperCase(),
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    DropdownButton<String>(
                      value: controller.selectedTransport.value,
                      items: controller.dropdownTransport,
                      onChanged: (String? value) {
                        controller.selectedTransport.value = value;
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'financial_income'.tr.toUpperCase(),
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    Expanded(
                      child: TextFormField(
                        textAlign: TextAlign.right,
                        controller: controller.incomeController,
                        readOnly: false,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16),
                        keyboardType: const TextInputType.numberWithOptions(),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CurrencyFormatter(),
                        ],
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'R\$ 0,00',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'financial_family'.tr.toUpperCase(),
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                    ),
                    Expanded(
                      child: TextFormField(
                        textAlign: TextAlign.right,
                        controller: controller.familySizeController,
                        readOnly: false,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16),
                        keyboardType: const TextInputType.numberWithOptions(),
                        decoration: const InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: secondaryColor),
                          ),
                          contentPadding: EdgeInsets.zero,
                          labelStyle: TextStyle(
                            color: Colors.black54,
                            fontSize: 15,
                          ),
                          hintText: '',
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Divider(
                    height: 1,
                    color: grey120,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'financial_expenses'.tr,
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'financial_house'.tr.toUpperCase(),
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    Expanded(
                      child: TextFormField(
                        textAlign: TextAlign.right,
                        controller: controller.houseCostsController,
                        readOnly: false,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16),
                        keyboardType: const TextInputType.numberWithOptions(),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CurrencyFormatter(),
                        ],
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'R\$ 0,00',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'financial_transport'.tr.toUpperCase(),
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    Expanded(
                      child: TextFormField(
                        textAlign: TextAlign.right,
                        controller: controller.transportCostsController,
                        readOnly: false,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16),
                        keyboardType: const TextInputType.numberWithOptions(),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CurrencyFormatter(),
                        ],
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'R\$ 0,00',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'financial_utilities'.tr.toUpperCase(),
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    Expanded(
                      child: TextFormField(
                        textAlign: TextAlign.right,
                        controller: controller.utilityCostsController,
                        readOnly: false,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16),
                        keyboardType: const TextInputType.numberWithOptions(),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CurrencyFormatter(),
                        ],
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'R\$ 0,00',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'financial_another_expenses'.tr.toUpperCase(),
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    Expanded(
                      child: TextFormField(
                        textAlign: TextAlign.right,
                        controller: controller.otherCostsController,
                        readOnly: false,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16),
                        keyboardType: const TextInputType.numberWithOptions(),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CurrencyFormatter(),
                        ],
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'R\$ 0,00',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.all(16),
      //   // 10. Obx reativo para o botão (loading de post e habilidado)
      //   child: Obx(
      //     () => controller.isPosting.value
      //         ? const Center(
      //             // Mostra loading de post
      //             child: CircularProgressIndicator(
      //               color: secondaryColor,
      //             ),
      //           )
      //         : SizedBox(
      //             height: 45,
      //             width: double.infinity,
      //             child: ElevatedButton(
      //               // Lê o valor reativo do controller
      //               onPressed: controller.isButtonEnabled.value
      //                   ? () => controller.postFinancial(groupID)
      //                   : null,
      //               style: ElevatedButton.styleFrom(
      //                   backgroundColor: controller.isButtonEnabled.value
      //                       ? secondaryColor
      //                       : Colors.grey,
      //                   shape: RoundedRectangleBorder(
      //                       borderRadius: BorderRadius.circular(50))),
      //               child: Text(
      //                 'confirm'.tr.toUpperCase(),
      //                 style: const TextStyle(
      //                     color: Colors.white,
      //                     fontSize: 16,
      //                     fontWeight: FontWeight.bold),
      //               ),
      //             ),
      //           ),
      //   ),
      // ),
    );
  }
}
