import 'package:app_flutter_miban4/data/api/store/store_request.dart';
import 'package:app_flutter_miban4/data/model/store/store_model.dart';
import 'package:app_flutter_miban4/ui/controllers/store/store_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../colors/app_colors.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  late Future<Merchant> _merchant;
  final StoreController _storeController = Get.put(StoreController());


  @override
  void initState() {
    super.initState();
    _storeController.getMerchants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.black,
            )),
      ),
      body: Obx(() {
        if (_storeController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: secondaryColor,
            ),
          );
        } else if (_storeController.merchantList.isEmpty) {
          return const Center(
            child: Text('Nenhum merchant encontrado'),
          );
        } else {
          return ListView.builder(
            itemCount: _storeController.merchantList.length,
            itemBuilder: (context, index) {
              final merchant = _storeController.merchantList[index];
              return ListTile(
                title: Text(merchant.merchantName),
                subtitle: Text(merchant.merchantCategory),
                onTap: () {
                  // Ação ao clicar no merchant
                },
              );
            },
          );
        }
      }),
    );
  }
}
