import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/helpers/extensions/strings.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dimens.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_loading.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/statements/controllers/statement_invoice_controller.dart';
import 'package:app_flutter_miban4/features/statements/model/statement_invoice_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatementInvoiceScreen extends GetView<StatementInvoiceController> {
  const StatementInvoiceScreen({super.key});

  static final GlobalKey _invoiceKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText.titleLarge(
          context,
          'invoice'.tr,
          color: Colors.white,
        ),
        foregroundColor: Colors.white,
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: AppLoading());
        }

        final invoice = controller.invoice.value;

        if (invoice == null) {
          return Center(
            child: AppText.bodyLarge(
              context,
              'Não foi possível carregar o comprovante.',
              color: Colors.grey.shade600,
            ),
          );
        }

        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: RepaintBoundary(
                  key: _invoiceKey,
                  child: Padding(
                    padding: const EdgeInsets.all(AppDimens.kPaddingL),
                    child: Container(
                      color: Theme.of(context).cardColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHeader(context, invoice),
                          const SizedBox(height: 24),
                          _buildTransactionDetails(context, invoice),
                          const SizedBox(height: 24),
                          _buildPartyDetailsCard(
                            context,
                            title: 'statement_origin'.tr,
                            party: invoice.payer,
                          ),
                          const SizedBox(height: 16),
                          _buildPartyDetailsCard(
                            context,
                            title: 'statement_destiny'.tr,
                            party: invoice.receiver,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            _buildFooterButtons(context, invoice, _invoiceKey),
          ],
        );
      }),
    );
  }

  Widget _buildHeader(BuildContext context, StatementInvoice invoice) {
    return Center(
      child: Column(
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 50),
          const SizedBox(height: 8),
          AppText.titleMedium(
            context,
            'invoice_success'.tr,
            color: Colors.grey.shade800,
          ),
          const SizedBox(height: 8),
          AppText.headlineLarge(
            context,
            invoice.amount.toBRL(),
          ),
          const SizedBox(height: 4),
          AppText.bodyMedium(context, invoice.date,
              color: Colors.grey.shade600),
        ],
      ),
    );
  }

  Widget _buildTransactionDetails(
      BuildContext context, StatementInvoice invoice) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow(context, 'invoice_type'.tr,
            invoice.type.capitalizeFirst ?? invoice.type),
        const Divider(height: 24),
        _buildDetailRow(
            context, 'statement_identifier'.tr, invoice.authentication),
      ],
    );
  }

  Widget _buildPartyDetailsCard(BuildContext context,
      {required String title, required dynamic party}) {
    return Card(
      elevation: 2,
      shadowColor: Colors.grey.withValues(alpha: 0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.titleMedium(
              context,
              title,
            ),
            const SizedBox(height: 12),
            _buildDetailRow(context, 'name'.tr, party.name),
            const SizedBox(height: 8),
            _buildDetailRow(context, 'statement_document'.tr, party.document),
            if (party.bankName.isNotEmpty) ...[
              const Divider(height: 24),
              _buildDetailRow(
                  context, 'statement_institute'.tr, party.bankName),
              const SizedBox(height: 8),
              _buildDetailRow(context, 'statement_agency'.tr, party.agency),
              const SizedBox(height: 8),
              _buildDetailRow(context, 'statement_account'.tr,
                  '${party.accountNumber}-${party.accountDigit}'),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.bodySmall(context, title, color: Colors.grey.shade600),
        const SizedBox(height: 2),
        AppText.bodyMedium(
          context,
          value,
          color: Colors.grey.shade800,
        ),
      ],
    );
  }

  Widget _buildFooterButtons(
      BuildContext context, StatementInvoice invoice, GlobalKey invoiceKey) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            icon: const Icon(
              Icons.share_outlined,
              color: Colors.white,
            ),
            label: AppText.bodyLarge(context, 'invoice_share'.tr,
                color: Colors.white),
            style: ElevatedButton.styleFrom(
              backgroundColor: secondaryColor,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              controller.shareInvoiceAsImage(invoiceKey, invoice);
            },
          ),
        ),
      ),
    );
  }
}
