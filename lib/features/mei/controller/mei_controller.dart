import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/core/helpers/formatters/maks_apply.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class MeiServiceModel {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final String? url; // Pronto para você preencher
  final VoidCallback? action;

  MeiServiceModel({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    this.url,
    this.action,
  });
}

class MeiServicesController extends BaseController {
  final List<MeiServiceModel> services = [
    MeiServiceModel(
      title: 'Emissão de Comprovante (CCMEI)',
      subtitle: 'Emita o seu comprovante e saiba mais sobre o CCMEI',
      icon: Icons.description_outlined,
      iconColor: const Color(0xFF3B82F6), // Azul
      url:
          'https://www.gov.br/empresas-e-negocios/pt-br/empreendedor/servicos-para-mei/emissao-de-comprovante-ccmei', // Substitua pelas URLs reais
    ),
    MeiServiceModel(
      title: 'Atualização Cadastral',
      subtitle: 'Solicitar e alterar dados de inscrição',
      icon: Icons.edit_document,
      iconColor: const Color(0xFF10B981), // Verde
      url:
          'https://www.gov.br/empresas-e-negocios/pt-br/empreendedor/servicos-para-mei/atualizacao-cadastral-de-mei',
    ),
    MeiServiceModel(
      title: 'Pagamento DAS',
      subtitle: 'Contribuição mensal e parcelamentos',
      icon: Icons.credit_card_outlined,
      iconColor: const Color(0xFF8B5CF6), // Roxo
      action: () =>
          Get.find<MeiServicesController>()._showCompanySelectionModal(),
    ),
    MeiServiceModel(
      title: 'Relatório Mensal',
      subtitle: 'Relatório Mensal de Receitas Brutas',
      icon: Icons.calendar_month_outlined,
      iconColor: const Color(0xFFF97316), // Laranja
      url:
          'https://www.gov.br/empresas-e-negocios/pt-br/empreendedor/servicos-para-mei/relatorio-mensal',
    ),
    MeiServiceModel(
      title: 'Declaração Anual (DASN-SIMEI)',
      subtitle: 'Envie sua declaração anual de faturamento',
      icon: Icons.request_quote_outlined,
      iconColor: const Color(0xFFEF4444), // Vermelho
      url:
          'https://www.gov.br/empresas-e-negocios/pt-br/empreendedor/servicos-para-mei/declaracao-anual-de-faturamento',
    ),
    MeiServiceModel(
      title: 'Nota Fiscal',
      subtitle: 'Orientação sobre emissão de Nota Fiscal',
      icon: Icons.receipt_long_outlined,
      iconColor: const Color(0xFF3B82F6), // Azul
      url:
          'https://www.gov.br/empresas-e-negocios/pt-br/empreendedor/servicos-para-mei/nota-fiscal',
    ),
    MeiServiceModel(
      title: 'Soluções Financeiras (CRED+)',
      subtitle: 'Acesso a produtos e serviços financeiros',
      icon: Icons.attach_money,
      iconColor: const Color(0xFF10B981), // Verde
      url:
          'https://www.gov.br/empresas-e-negocios/pt-br/empreendedor/servicos-para-mei/solucoes-financeiras-para-o-seu-negocio-credmei',
    ),
    MeiServiceModel(
      title: 'Certidões e Comprovantes',
      subtitle: 'FGTS, INSS, Débitos e certidões diversas',
      icon: Icons.verified_user_outlined,
      iconColor: const Color(0xFF06B6D4), // Ciano
      url:
          'https://www.gov.br/empresas-e-negocios/pt-br/empreendedor/servicos-para-mei/certidoes-e-comprovantes',
    ),
    MeiServiceModel(
      title: 'Contratação de Empregado',
      subtitle: 'Documentos e procedimentos para admissão',
      icon: Icons.people_outline,
      iconColor: const Color(0xFFF59E0B), // Amarelo/Laranja
      url:
          'https://www.gov.br/empresas-e-negocios/pt-br/empreendedor/servicos-para-mei/contratacao-de-empregado',
    ),
    MeiServiceModel(
      title: 'Saúde e Segurança do Trabalho',
      subtitle: 'Informações sobre SST',
      icon: Icons.health_and_safety_outlined,
      iconColor: const Color(0xFF10B981), // Verde
      url:
          'https://www.gov.br/empresas-e-negocios/pt-br/empreendedor/servicos-para-mei/saude-e-seguranca-do-trabalho-2013-sst',
    ),
    MeiServiceModel(
      title: 'Acesso a Mercados',
      subtitle: 'Contrata+Brasil - Oportunidades de negócios',
      icon: Icons.storefront_outlined,
      iconColor: const Color(0xFF8B5CF6), // Roxo
      url:
          'https://www.gov.br/empresas-e-negocios/pt-br/empreendedor/servicos-para-mei/acesso-a-mercados',
    ),
    MeiServiceModel(
      title: 'Transição para Microempresa',
      subtitle: 'Desenquadramento do MEI',
      icon: Icons.trending_up,
      iconColor: const Color(0xFFF43F5E), // Rosa escuro
      url:
          'https://www.gov.br/empresas-e-negocios/pt-br/empreendedor/servicos-para-mei/quero-crescer-desenquadramento',
    ),
    MeiServiceModel(
      title: 'Cadastro Turismo (Cadastur)',
      subtitle: 'Para atividades no setor de turismo',
      icon: Icons.domain_outlined,
      iconColor: const Color(0xFF3B82F6), // Azul
      url:
          'https://www.gov.br/empresas-e-negocios/pt-br/empreendedor/quero-ser-mei/cadastro-de-atividade-turistica-cadastur',
    ),
    MeiServiceModel(
      title: 'Baixa da Empresa',
      subtitle: 'Informações sobre baixa do MEI',
      icon: Icons.exit_to_app_outlined,
      iconColor: const Color(0xFFEF4444), // Vermelho
      url:
          'https://www.gov.br/empresas-e-negocios/pt-br/empreendedor/servicos-para-mei/baixa-de-mei',
    ),
    MeiServiceModel(
      title: 'MEI Caminhoneiro',
      subtitle: 'Transportador Autônomo de Carga',
      icon: Icons.local_shipping_outlined,
      iconColor: const Color(0xFF4B5563), // Cinza escuro
      url:
          'https://www.gov.br/empresas-e-negocios/pt-br/empreendedor/mei-caminhoneiro',
    ),
    MeiServiceModel(
      title: 'Perguntas Frequentes',
      subtitle: 'Tire suas dúvidas sobre MEI',
      icon: Icons.help_outline,
      iconColor: const Color(0xFF6B7280), // Cinza
      url:
          'https://www.gov.br/empresas-e-negocios/pt-br/empreendedor/perguntas-frequentes',
    ),
  ];

  Future<void> openUrl(String url, String title) async {
    if (url.isEmpty || url.startsWith('https://exemplo.gov.br')) {
      Get.rawSnackbar(
        message: 'A URL para "$title" ainda não foi configurada.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (kIsWeb) {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } else {
      Get.toNamed(AppRoutes.webView, arguments: {
        'url': url,
        'title': title,
      });
    }
  }

  void openGovPortal() {
    openUrl('https://gov.br/mei', 'Portal Oficial do Governo');
  }

  void handleServiceClick(MeiServiceModel service) {
    if (service.action != null) {
      service.action!();
    } else {
      openUrl(service.url ?? '', service.title);
    }
  }

  void _showCompanySelectionModal() {
    final company = userRx.company;

    if (company == null || company.document.isEmpty) {
      Get.rawSnackbar(
        message: 'Você não possui uma empresa (CNPJ) cadastrada.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final cnpjFormatado =
        MaskUtil.applyMask(company.document, '##.###.###/####-##');

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Selecione a Empresa',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Para qual empresa você deseja gerar o boleto DAS?',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),
            const SizedBox(height: 24),

            // CARD DA EMPRESA SELECIONÁVEL
            InkWell(
              onTap: () {
                Get.back(); // Fecha o modal
                // Abre a tela de DAS passando o CNPJ PURO como argumento
                Get.toNamed(AppRoutes.dasMei,
                    arguments: {'cnpj': company.document});
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  border: Border.all(color: Colors.blue.shade200),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child:
                          const Icon(Icons.business, color: Color(0xFF3B82F6)),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            company.name, // Nome da Empresa
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'CNPJ: $cnpjFormatado', // CNPJ formatado com a máscara
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: Colors.black26),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
