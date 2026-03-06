import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_connection.dart';
import 'package:app_flutter_miban4/features/partners/model/partners_model.dart';

class PartnerManagementRepository {
  final ApiConnection _api = ApiConnection();

  Future<List<PartnerCategory>> getCategories() async {
    return _api.get(
      endpoint: AppEndpoints.partnerCategory,
      fromJson: (json) {
        if (json is List) {
          return json.map((e) => PartnerCategory.fromJson(e)).toList();
        }
        if (json is Map && json['data'] is List) {
          return (json['data'] as List)
              .map((e) => PartnerCategory.fromJson(e))
              .toList();
        }
        return [];
      },
    );
  }

  Future<void> createCategory(String name) async {
    return _api.post(
      endpoint: AppEndpoints.partnerCategory,
      body: {'description': name},
      fromJson: (json) {},
    );
  }

  Future<void> deleteCategory(String id) async {
    return _api.delete(
      endpoint: '${AppEndpoints.partnerCategory}/$id',
      fromJson: (json) {},
    );
  }

  Future<List<PartnerItem>> getProducts() async {
    return _api.get(
      endpoint: AppEndpoints.partnerProduct,
      fromJson: (json) {
        if (json is List) {
          return json.map((e) => PartnerItem.fromJson(e)).toList();
        }
        if (json is Map && json['data'] is List) {
          return (json['data'] as List)
              .map((e) => PartnerItem.fromJson(e))
              .toList();
        }
        return [];
      },
    );
  }

  Future<void> createProduct(PartnerItem product, int categoryId) async {
    final payload = product.toJson();
    payload['partner_category_id'] = categoryId;

    return _api.post(
      endpoint: AppEndpoints.partnerProduct,
      body: payload,
      fromJson: (json) {},
    );
  }

  Future<void> updateProduct(PartnerItem product) async {
    return _api.put(
      endpoint: '${AppEndpoints.partnerProduct}/${product.id}',
      body: product.toJson(),
      fromJson: (json) {},
    );
  }

  Future<void> deleteProduct(String id) async {
    return _api.delete(
      endpoint: '${AppEndpoints.partnerProduct}/$id',
      fromJson: (json) {},
    );
  }

  Future<List<PartnerItem>> myProducts(String userId) {
    return _api.get(
      endpoint: '${AppEndpoints.partnerProduct}/$userId',
      fromJson: (json) {
        if (json is List) {
          return json.map((e) => PartnerItem.fromJson(e)).toList();
        }
        if (json is Map && json['data'] is List) {
          return (json['data'] as List)
              .map((e) => PartnerItem.fromJson(e))
              .toList();
        }
        return [];
      },
    );
  }
}
