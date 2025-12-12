import 'dart:io';
import 'package:image/image.dart' as imageLib;
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
      imageLib.Image? image = imageLib.decodeImage(bytes);

      if (image == null) {
        throw Exception('Não foi possível decodificar a imagem.');
      }

      image = imageLib.bakeOrientation(image);

      if (image.width > targetWidth) {
        image = imageLib.copyResize(image, width: targetWidth);
      }

      final directory = await getTemporaryDirectory();
      final fileName = 'resized_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final resizedFile = File('${directory.path}/$fileName');

      await resizedFile.writeAsBytes(
        imageLib.encodeJpg(image, quality: quality),
      );

      return resizedFile;
    } catch (e, s) {
      AppLogger.I().error('Erro ao redimensionar imagem', e, s);
      rethrow;
    }
  }
}
