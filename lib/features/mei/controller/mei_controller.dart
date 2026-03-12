import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MeiServiceModel {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final String url; // Pronto para você preencher

  MeiServiceModel({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.url,
  });
}

class MeiServicesController extends BaseController {
  // Lista com todos os itens do print
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
      url:
          'https://www.gov.br/empresas-e-negocios/pt-br/empreendedor/servicos-para-mei/pagamento-de-contribuicao-mensal',
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

  // Método que abre a sua WebviewPage já existente
  void openUrl(String url, String title) {
    if (url.isEmpty || url.startsWith('https://exemplo.gov.br')) {
      Get.rawSnackbar(
        message: 'A URL para "$title" ainda não foi configurada.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
      );
      return;
    }

    Get.toNamed(AppRoutes.webView, arguments: {
      'url': url,
      'title': title,
    });
  }

  void openGovPortal() {
    openUrl('https://gov.br/mei', 'Portal Oficial do Governo');
  }
}
