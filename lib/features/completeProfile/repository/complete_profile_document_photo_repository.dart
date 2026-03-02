import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_file_connection.dart';
import 'package:app_flutter_miban4/features/completeProfile/model/complete_profile_response.dart';
import 'package:image_picker/image_picker.dart';

class CompleteProfileDocumentPhotoRepository {
  Future<CompleteProfileResponse> uploadDocument({
    required String id,
    required String imageType,
    required String documentType,
    required XFile photo,
  }) async {
    return ApiMultipartConnection().post(
      endpoint: '${AppEndpoints.completeDocumentPhoto}/$id',
      queryParameters: {
        'image_type': imageType,
        'document_type': documentType,
      },
      fields: {
        '_method': 'POST',
        'image_type': imageType,
        'document_type': documentType,
      },
      files: {'file_path': photo},
      fromJson: (json) => CompleteProfileResponse.fromJson(json),
    );
  }
}
