class CepResponse {
  final String cep;
  final String logradouro;
  final String complemento;
  final String bairro;
  final String localidade;
  final String uf;

  CepResponse({
    required this.cep,
    required this.logradouro,
    required this.complemento,
    required this.bairro,
    required this.localidade,
    required this.uf,
  });

  factory CepResponse.fromJson(Map<String, dynamic> json) {
    return CepResponse(
      cep: json['cep'] as String,
      logradouro: json['logradouro'] as String,
      complemento: json['complemento'] as String,
      bairro: json['bairro'] as String,
      localidade: json['localidade'] as String,
      uf: json['uf'] as String,
    );
  }
}
