import 'dart:io';
import 'package:image/image.dart' as image_lib;
import 'package:path_provider/path_provider.dart';
import 'package:app_flutter_miban4/core/config/log/logger.dart';

class ImageHelper {
  ImageHelper._();
  static Future<File> resize({
    required File file,
    int targetWidth = 480,
    int quality = 85,
  }) async {
    try {
      final bytes = await file.readAsBytes();
      image_lib.Image? image = image_lib.decodeImage(bytes);

      if (image == null) {
        throw Exception('Não foi possível decodificar a imagem.');
      }

      image = image_lib.bakeOrientation(image);

      if (image.width > targetWidth) {
        image = image_lib.copyResize(image, width: targetWidth);
      }

      final directory = await getTemporaryDirectory();
      final fileName = 'resized_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final resizedFile = File('${directory.path}/$fileName');

      await resizedFile.writeAsBytes(
        image_lib.encodeJpg(image, quality: quality),
      );

      return resizedFile;
    } catch (e, s) {
      AppLogger.I().error('Erro ao redimensionar imagem', e, s);
      rethrow;
    }
  }
}
