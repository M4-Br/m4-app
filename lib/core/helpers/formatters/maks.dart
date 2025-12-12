class MaskUtil {
  static String applyMask(String value, String mask) {
    final result = StringBuffer();
    var valueIndex = value.length - 1;

    for (var i = mask.length - 1; i >= 0; i--) {
      if (valueIndex < 0) {
        break;
      }

      if (mask[i] == '#') {
        result.write(value[valueIndex]);
        valueIndex--;
      } else {
        result.write(mask[i]);
      }
    }

    return result.toString().split('').reversed.join();
  }
}
