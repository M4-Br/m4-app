import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:app_flutter_miban4/features/mei/model/das_model.dart';
import 'package:app_flutter_miban4/features/mei/repository/mei_repository.dart';
import 'package:get/get.dart';

class DasController extends BaseController {
  final MeiRepository _repository = MeiRepository();

  final Rxn<DasResponseModel> dasData = Rxn<DasResponseModel>();

  late String cnpjContribuinte;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;
    if (args != null && args['cnpj'] != null) {
      cnpjContribuinte =
          args['cnpj'].toString().replaceAll(RegExp(r'[^0-9]'), '');

      fetchDasData();
    } else {
      Future.microtask(() {
        Get.back();
        ShowToaster.toasterInfo(
            message: 'CNPJ não informado para gerar o DAS.', isError: true);
      });
    }
  }

  Future<void> fetchDasData() async {
    await executeSafe(() async {
      final bodyMock = DasRequestModel(
        contratante: EntidadeModel(numero: '65382140000117', tipo: 2),
        autorPedidoDados: EntidadeModel(numero: '65382140000117', tipo: 2),
        contribuinte: EntidadeModel(numero: cnpjContribuinte, tipo: 2),
        pedidoDados: PedidoDadosModel(
          idSistema: 'PGMEI',
          idServico: 'GERARDASCODBARRA22',
          versaoSistema: '1.0',
          dados: '{"periodoApuracao": "202302"}',
        ),
      );

      final result = await _repository.gerarDas(bodyMock);
      dasData.value = result;
    }, message: 'Erro ao gerar o boleto DAS no servidor');
  }
}
