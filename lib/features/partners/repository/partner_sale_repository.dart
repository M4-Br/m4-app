import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_connection.dart';
import 'package:app_flutter_miban4/features/partners/model/partner_sale_history_model.dart';
import 'package:app_flutter_miban4/features/partners/model/partner_sale_model.dart';

class PartnerSaleRepository {
  final ApiConnection _api = ApiConnection();

  final Map<String, String> _headers = {'Accept': 'application/json'};

  // Listar todas as vendas
  Future<List<PartnerSaleHistory>> getSales() async {
    return _api.get(
      endpoint: AppEndpoints.partnerSale,
      extraHeaders: _headers,
      fromJson: (json) {
        if (json is Map && json['data'] != null) {
          final List data = json['data'];
          return data.map((e) => PartnerSaleHistory.fromJson(e)).toList();
        }
        return [];
      },
    );
  }

  // Registrar uma nova venda (Store)
  Future<void> createSale(PartnerSale sale) async {
    return _api.post(
      endpoint: AppEndpoints.partnerSale,
      body: sale.toJson(),
      extraHeaders: _headers,
      fromJson: (json) {},
    );
  }

  // Detalhes de uma venda específica (Show)
  Future<PartnerSale?> getSaleById(int id) async {
    return _api.get(
      endpoint: '${AppEndpoints.partnerSale}/$id',
      extraHeaders: _headers,
      fromJson: (json) {
        if (json is Map && json['data'] != null) {
          return PartnerSale.fromJson(json['data']);
        }
        return null;
      },
    );
  }

  // Atualizar dados de uma venda (Update)
  Future<void> updateSale(int id, PartnerSale sale) async {
    return _api.put(
      endpoint: '${AppEndpoints.partnerSale}/$id',
      body: sale.toJson(),
      extraHeaders: _headers,
      fromJson: (json) {},
    );
  }

  // Estornar/Deletar uma venda (Destroy)
  Future<void> deleteSale(int id) async {
    return _api.delete(
      endpoint: '${AppEndpoints.partnerSale}/$id',
      extraHeaders: _headers,
      fromJson: (json) {},
    );
  }
}
