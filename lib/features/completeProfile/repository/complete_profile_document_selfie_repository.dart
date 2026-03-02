import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_file_connection.dart';
import 'package:app_flutter_miban4/features/completeProfile/model/complete_profile_response.dart';
import 'package:image_picker/image_picker.dart';

class CompleteProfileDocumentSelfieRepository {
  Future<CompleteProfileResponse> sendDocumentSelfie(
      String id, XFile photo) async {
    // O XFile vai direto para a conexão, sem usar o dart:io
    return await ApiMultipartConnection().post(
      endpoint: '${AppEndpoints.completeDocumentSelfie}/$id',
      fields: {'_method': 'POST'},
      files: {'file_path': photo},
      fromJson: (json) => CompleteProfileResponse.fromJson(json),
    );
  }
}
