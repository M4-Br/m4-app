// ==========================================
// MODELOS COMPARTILHADOS
// ==========================================
class EntidadeModel {
  final String numero;
  final int tipo;

  EntidadeModel({required this.numero, required this.tipo});

  factory EntidadeModel.fromJson(Map<String, dynamic> json) {
    return EntidadeModel(
      numero: json['numero'] ?? '',
      tipo: json['tipo'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {'numero': numero, 'tipo': tipo};
}

class PedidoDadosModel {
  final String idSistema;
  final String idServico;
  final String versaoSistema;
  final String dados;

  PedidoDadosModel({
    required this.idSistema,
    required this.idServico,
    required this.versaoSistema,
    required this.dados,
  });

  factory PedidoDadosModel.fromJson(Map<String, dynamic> json) {
    return PedidoDadosModel(
      idSistema: json['idSistema'] ?? '',
      idServico: json['idServico'] ?? '',
      versaoSistema: json['versaoSistema'] ?? '',
      dados: json['dados'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'idSistema': idSistema,
        'idServico': idServico,
        'versaoSistema': versaoSistema,
        'dados': dados,
      };
}

class ValoresModel {
  final double principal;
  final double multa;
  final double juros;
  final double total;

  ValoresModel({
    required this.principal,
    required this.multa,
    required this.juros,
    required this.total,
  });

  factory ValoresModel.fromJson(Map<String, dynamic> json) {
    return ValoresModel(
      principal: (json['principal'] ?? 0).toDouble(),
      multa: (json['multa'] ?? 0).toDouble(),
      juros: (json['juros'] ?? 0).toDouble(),
      total: (json['total'] ?? 0).toDouble(),
    );
  }
}

// ==========================================
// REQUEST (O QUE VOCÊ ENVIA NO POST)
// ==========================================
class DasRequestModel {
  final EntidadeModel contratante;
  final EntidadeModel autorPedidoDados;
  final EntidadeModel contribuinte;
  final PedidoDadosModel pedidoDados;

  DasRequestModel({
    required this.contratante,
    required this.autorPedidoDados,
    required this.contribuinte,
    required this.pedidoDados,
  });

  Map<String, dynamic> toJson() {
    return {
      'contratante': contratante.toJson(),
      'autorPedidoDados': autorPedidoDados.toJson(),
      'contribuinte': contribuinte.toJson(),
      'pedidoDados': pedidoDados.toJson(),
    };
  }
}

// ==========================================
// RESPONSE (O QUE VOCÊ RECEBE DA API)
// ==========================================

// --- CLASSE PAI (QUE ESTAVA FALTANDO) ---
class DasResponseModel {
  final bool success;
  final DasResponseDataModel? data;

  DasResponseModel({required this.success, this.data});

  factory DasResponseModel.fromJson(Map<String, dynamic> json) {
    return DasResponseModel(
      success: json['success'] ?? false,
      data: json['data'] != null
          ? DasResponseDataModel.fromJson(json['data'])
          : null,
    );
  }
}
// ----------------------------------------

class DasResponseDataModel {
  final int status;
  final String responseId;
  final List<DadoContribuinteModel> dados;
  final List<MensagemModel> mensagens;

  DasResponseDataModel({
    required this.status,
    required this.responseId,
    required this.dados,
    required this.mensagens,
  });

  factory DasResponseDataModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> rawDados = [];
    if (json['dados'] is List) {
      rawDados = json['dados'];
    }

    var mensagensList = json['mensagens'] as List? ?? [];

    return DasResponseDataModel(
      status: json['status'] ?? 0,
      responseId: json['response_id'] ?? '',
      dados: rawDados.map((e) => DadoContribuinteModel.fromJson(e)).toList(),
      mensagens: mensagensList.map((e) => MensagemModel.fromJson(e)).toList(),
    );
  }
}

class MensagemModel {
  final String codigo;
  final String texto;

  MensagemModel({required this.codigo, required this.texto});

  factory MensagemModel.fromJson(Map<String, dynamic> json) {
    return MensagemModel(
      codigo: json['codigo'] ?? '',
      texto: json['texto'] ?? '',
    );
  }
}

class DadoContribuinteModel {
  final String cnpjCompleto;
  final String razaoSocial;
  final List<DetalhamentoDasModel> detalhamento;

  DadoContribuinteModel({
    required this.cnpjCompleto,
    required this.razaoSocial,
    required this.detalhamento,
  });

  factory DadoContribuinteModel.fromJson(Map<String, dynamic> json) {
    var detalhamentoList = json['detalhamento'] as List? ?? [];
    return DadoContribuinteModel(
      cnpjCompleto: json['cnpjCompleto'] ?? '',
      razaoSocial: json['razaoSocial'] ?? '',
      detalhamento: detalhamentoList
          .map((e) => DetalhamentoDasModel.fromJson(e))
          .toList(),
    );
  }
}

class DetalhamentoDasModel {
  final String periodoApuracao;
  final String numeroDocumento;
  final String dataVencimento;
  final ValoresModel valores;
  final List<String> codigoDeBarras;
  final String observacao2;

  DetalhamentoDasModel({
    required this.periodoApuracao,
    required this.numeroDocumento,
    required this.dataVencimento,
    required this.valores,
    required this.codigoDeBarras,
    required this.observacao2,
  });

  factory DetalhamentoDasModel.fromJson(Map<String, dynamic> json) {
    var codigosList = json['codigoDeBarras'] as List? ?? [];
    return DetalhamentoDasModel(
      periodoApuracao: json['periodoApuracao'] ?? '',
      numeroDocumento: json['numeroDocumento'] ?? '',
      dataVencimento: json['dataVencimento'] ?? '',
      valores: ValoresModel.fromJson(json['valores'] ?? {}),
      codigoDeBarras: codigosList.map((e) => e.toString()).toList(),
      observacao2: json['observacao2'] ?? '',
    );
  }

  String get linhaDigitavel => codigoDeBarras.join(' ');
}
