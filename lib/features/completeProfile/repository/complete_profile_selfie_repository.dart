import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_file_connection.dart';
import 'package:app_flutter_miban4/features/completeProfile/model/complete_profile_selfie_response.dart';
import 'package:image_picker/image_picker.dart';

class CompleteProfileSelfieRepository {
  Future<CompleteProfileSelfieResponse> sendSelfie({
    required String id,
    required XFile photo,
  }) async {
    // O XFile vai direto para a conexão, sem usar o dart:io
    return ApiMultipartConnection().post(
      endpoint: '${AppEndpoints.completeSelfie}/$id',
      fromJson: (json) => CompleteProfileSelfieResponse.fromJson(json),
      fields: {'_method': 'POST'},
      files: {'file_path': photo},
    );
  }
}
