import 'dart:io';
import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_file_connection.dart';
import 'package:app_flutter_miban4/features/completeProfile/model/complete_profile_response.dart';
import 'package:app_flutter_miban4/core/helpers/functions/resize_image.dart';

class CompleteProfileDocumentPhotoRepository {
  Future<ProfileStep> uploadDocument({
    required String id,
    required String imageType,
    required String documentType,
    required File photo,
  }) async {
    final File finalPhoto = await ImageHelper.resize(
      file: photo,
      targetWidth: 480,
      quality: 80,
    );

    return ApiMultipartConnection().post(
      endpoint: '${AppEndpoints.onboardingDocumentPhoto}/$id',
      queryParameters: {
        'image_type': imageType,
        'document_type': documentType,
      },
      fields: {'_method': 'POST'},
      files: {'file_path': finalPhoto},
      fromJson: (json) => ProfileStep.fromJson(json),
    );
  }
}
