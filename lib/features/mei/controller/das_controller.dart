import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/features/mei/model/das_model.dart';
import 'package:app_flutter_miban4/features/mei/repository/mei_repository.dart';
import 'package:get/get.dart';

class DasController extends BaseController {
  final MeiRepository _repository = MeiRepository();

  final Rxn<DasResponseModel> dasData = Rxn<DasResponseModel>();

  @override
  void onInit() {
    super.onInit();
    fetchDasData();
  }

  Future<void> fetchDasData() async {
    await executeSafe(() async {
      // 1. CRIANDO O SEU MOCK DE BODY (O PAYLOAD DO POST)
      final bodyMock = DasRequestModel(
        contratante: EntidadeModel(numero: '65382140000117', tipo: 2),
        autorPedidoDados: EntidadeModel(numero: '65382140000117', tipo: 2),
        contribuinte: EntidadeModel(numero: '49571816000164', tipo: 2),
        pedidoDados: PedidoDadosModel(
          idSistema: 'PGMEI',
          idServico: 'GERARDASCODBARRA22',
          versaoSistema: '1.0',
          dados: '{"periodoApuracao": "202302"}', // A String JSON exata
        ),
      );

      // 2. DISPARANDO O POST PARA O SERVIDOR
      final result = await _repository.gerarDas(bodyMock);

      // 3. RECEBENDO O RESPONSE REAL E ATUALIZANDO A TELA
      dasData.value = result;
    }, message: 'Erro ao gerar o boleto DAS no servidor');
  }
}
