import 'dart:io';

import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_file_connection.dart';
import 'package:app_flutter_miban4/core/helpers/functions/resize_image.dart';
import 'package:app_flutter_miban4/features/completeProfile/model/complete_profile_selfie_response.dart';
import 'package:image_picker/image_picker.dart';

class CompleteProfileSelfieRepository {
  Future<CompleteProfileSelfieResponse> sendSelfie({
    required String id,
    required XFile photo,
  }) async {
    final File fileToResize = File(photo.path);

    final File finalPhoto = await ImageHelper.resize(
      file: fileToResize,
      targetWidth: 600,
      quality: 85,
    );

    return ApiMultipartConnection().post(
      endpoint: '${AppEndpoints.completeSelfie}/$id',
      fromJson: (json) => CompleteProfileSelfieResponse.fromJson(json),
      fields: {'_method': 'POST'},
      files: {'file_path': finalPhoto},
    );
  }
}
