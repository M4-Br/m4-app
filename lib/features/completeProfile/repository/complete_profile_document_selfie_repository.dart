import 'dart:io';

import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_file_connection.dart';
import 'package:app_flutter_miban4/features/completeProfile/model/complete_profile_response.dart';
import 'package:app_flutter_miban4/core/helpers/functions/resize_image.dart';
import 'package:image_picker/image_picker.dart';

class CompleteProfileDocumentSelfieRepository {
  Future<CompleteProfileResponse> sendDocumentSelfie(
      String id, XFile photo) async {
    final File fileToResize = File(photo.path);

    final File finalPhoto = await ImageHelper.resize(
      file: fileToResize,
      targetWidth: 800,
      quality: 85,
    );

    return await ApiMultipartConnection().post(
      endpoint: '${AppEndpoints.completeDocumentSelfie}/$id',
      fields: {'_method': 'POST'},
      files: {'file_path': finalPhoto},
      fromJson: (json) => CompleteProfileResponse.fromJson(json),
    );
  }
}
