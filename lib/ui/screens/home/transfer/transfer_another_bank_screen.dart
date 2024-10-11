import 'package:app_flutter_miban4/data/model/bank/bank_entity.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/controllers/bank/bank_list_controller.dart';
import 'package:app_flutter_miban4/ui/screens/home/transfer/transfer_bank_page.dart';
import 'package:app_flutter_miban4/ui/screens/home/transfer/transfer_add_person_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class TransferAnotherBankScreen extends StatefulWidget {
  final Map<String, dynamic>? userTransfer;
  final String? document;
  final int? type;

  const TransferAnotherBankScreen(
      {super.key,
      required this.userTransfer,
      required this.document,
      required this.type});

  @override
  State<TransferAnotherBankScreen> createState() =>
      _TransferAnotherBankScreenState();
}

class _TransferAnotherBankScreenState extends State<TransferAnotherBankScreen> {
  final _bankList = Get.put(BankListController());
  final _searchController = TextEditingController();
  final _filteredBankList = <Bank>[].obs;

  @override
  void initState() {
    super.initState();
    _bankList.getBank().then((_) {
      _filteredBankList.value = _bankList.bankList;
    });
    _searchController.addListener(_filterBanks);
  }

  void _filterBanks() {
    final query = _searchController.text.toLowerCase();
    _filteredBankList.value = _bankList.bankList
        .where((bank) => bank.name.toLowerCase().contains(query))
        .toList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bankList.getBank().then((_) {
      _filteredBankList.value = _bankList.bankList;
    });
    _searchController.addListener(_filterBanks);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterBanks);
    _searchController.dispose();
    _bankList.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefault(
        title: AppLocalizations.of(context)!.transfer,
        backPage: () => Get.off(
          () => TransferBankPage(
            userTransfer: widget.userTransfer,
            type: widget.type,
            document: widget.document,
          ),
          transition: Transition.leftToRight,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.bank_choose,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
              textAlign: TextAlign.start,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.bank_search,
                  prefixIcon: const Icon(Icons.search),
                  floatingLabelStyle:
                      const TextStyle(color: secondaryColor, fontSize: 18),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        const BorderSide(color: secondaryColor, width: 2.0),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: secondaryColor, width: 2.0)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Obx(() => _bankList.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(
                      color: secondaryColor,
                    ),
                  )
                : Expanded(
                    child: Obx(
                      () => ListView.separated(
                        itemCount: _filteredBankList.length,
                        itemBuilder: (context, index) {
                          final bank = _filteredBankList[index];
                          return GestureDetector(
                            onTap: () {
                              Get.to(
                                  () => TransferAddPersonScreen(
                                        userTransfer: widget.userTransfer,
                                        code: bank.code.toString(),
                                        bank: bank.name,
                                        type: widget.type!,
                                        document: widget.document!,
                                      ),
                                  transition: Transition.rightToLeft);
                            },
                            child: ListTile(
                              title: Text('${bank.code} - ${bank.name}'),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(),
                      ),
                    ),
                  )),
          ],
        ),
      ),
    );
  }
}
