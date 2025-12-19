import 'dart:io';
import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_file_connection.dart';
import 'package:app_flutter_miban4/features/completeProfile/model/complete_profile_response.dart';
import 'package:app_flutter_miban4/core/helpers/functions/resize_image.dart';
import 'package:image_picker/image_picker.dart';

class CompleteProfileDocumentPhotoRepository {
  Future<CompleteProfileResponse> uploadDocument({
    required String id,
    required String imageType,
    required String documentType,
    required XFile photo,
  }) async {
    File fileToResize = File(photo.path);

    final File finalPhoto = await ImageHelper.resize(
      file: fileToResize,
      targetWidth: 1024,
      quality: 85,
    );
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
      files: {'file_path': finalPhoto},
      fromJson: (json) => CompleteProfileResponse.fromJson(json),
    );
  }
}
