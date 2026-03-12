import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_connection.dart';
import 'package:app_flutter_miban4/features/marketplace/model/partners_model.dart';

class MarketplaceManagementRepository {
  final ApiConnection _api = ApiConnection();

  Future<List<MarketplaceCategory>> getCategories() async {
    return _api.get(
      endpoint: AppEndpoints.marketplaceCategory,
      fromJson: (json) {
        if (json is List) {
          return json.map((e) => MarketplaceCategory.fromJson(e)).toList();
        }
        if (json is Map && json['data'] is List) {
          return (json['data'] as List)
              .map((e) => MarketplaceCategory.fromJson(e))
              .toList();
        }
        return [];
      },
    );
  }

  Future<void> createCategory(String name) async {
    return _api.post(
      endpoint: AppEndpoints.marketplaceCategory,
      body: {'description': name},
      fromJson: (json) {},
    );
  }

  Future<void> deleteCategory(String id) async {
    return _api.delete(
      endpoint: '${AppEndpoints.marketplaceCategory}/$id',
      fromJson: (json) {},
    );
  }

  Future<List<MarketplaceItem>> getProducts() async {
    return _api.get(
      endpoint: AppEndpoints.marketplaceProduct,
      fromJson: (json) {
        if (json is List) {
          return json.map((e) => MarketplaceItem.fromJson(e)).toList();
        }
        if (json is Map && json['data'] is List) {
          return (json['data'] as List)
              .map((e) => MarketplaceItem.fromJson(e))
              .toList();
        }
        return [];
      },
    );
  }

  Future<void> createProduct(MarketplaceItem product, int categoryId) async {
    final payload = product.toJson();
    payload['marketplace_category_id'] = categoryId;

    return _api.post(
      endpoint: AppEndpoints.marketplaceProduct,
      body: payload,
      fromJson: (json) {},
    );
  }

  Future<void> updateProduct(MarketplaceItem product) async {
    return _api.put(
      endpoint: '${AppEndpoints.marketplaceProduct}/${product.id}',
      body: product.toJson(),
      fromJson: (json) {},
    );
  }

  Future<void> deleteProduct(String id) async {
    return _api.delete(
      endpoint: '${AppEndpoints.marketplaceProduct}/$id',
      fromJson: (json) {},
    );
  }

  Future<List<MarketplaceItem>> myProducts(String userId) {
    return _api.get(
      endpoint: '${AppEndpoints.marketplaceProduct}/$userId',
      fromJson: (json) {
        if (json is List) {
          return json.map((e) => MarketplaceItem.fromJson(e)).toList();
        }
        if (json is Map && json['data'] is List) {
          return (json['data'] as List)
              .map((e) => MarketplaceItem.fromJson(e))
              .toList();
        }
        return [];
      },
    );
  }
}
