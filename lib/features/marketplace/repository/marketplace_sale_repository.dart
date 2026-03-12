import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_connection.dart';
import 'package:app_flutter_miban4/features/marketplace/model/partner_sale_history_model.dart';
import 'package:app_flutter_miban4/features/marketplace/model/partner_sale_model.dart';

class MarketplaceSaleRepository {
  final ApiConnection _api = ApiConnection();

  final Map<String, String> _headers = {'Accept': 'application/json'};

  // Listar todas as vendas
  Future<List<MarketplaceSaleHistory>> getSales() async {
    return _api.get(
      endpoint: AppEndpoints.marketplaceale,
      extraHeaders: _headers,
      fromJson: (json) {
        if (json is Map && json['data'] != null) {
          final List data = json['data'];
          return data.map((e) => MarketplaceSaleHistory.fromJson(e)).toList();
        }
        return [];
      },
    );
  }

  // Registrar uma nova venda (Store)
  Future<void> createSale(MarketplaceSale sale) async {
    return _api.post(
      endpoint: AppEndpoints.marketplaceale,
      body: sale.toJson(),
      extraHeaders: _headers,
      fromJson: (json) {},
    );
  }

  // Detalhes de uma venda específica (Show)
  Future<MarketplaceSale?> getSaleById(int id) async {
    return _api.get(
      endpoint: '${AppEndpoints.marketplaceale}/$id',
      extraHeaders: _headers,
      fromJson: (json) {
        if (json is Map && json['data'] != null) {
          return MarketplaceSale.fromJson(json['data']);
        }
        return null;
      },
    );
  }

  // Atualizar dados de uma venda (Update)
  Future<void> updateSale(int id, MarketplaceSale sale) async {
    return _api.put(
      endpoint: '${AppEndpoints.marketplaceale}/$id',
      body: sale.toJson(),
      extraHeaders: _headers,
      fromJson: (json) {},
    );
  }

  // Estornar/Deletar uma venda (Destroy)
  Future<void> deleteSale(int id) async {
    return _api.delete(
      endpoint: '${AppEndpoints.marketplaceale}/$id',
      extraHeaders: _headers,
      fromJson: (json) {},
    );
  }
}
