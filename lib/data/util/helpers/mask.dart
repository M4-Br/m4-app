import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

var cpfMaskFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##', filter: {'#': RegExp(r'[0-9]')});

var cnpjMaskFormatter = MaskTextInputFormatter(
    mask: '##.###.###/####-##', filter: {'#': RegExp(r'[0-9]')});

var phoneMaskFormatter = MaskTextInputFormatter(
    mask: '(##) #####-####', filter: {'#': RegExp(r'[0-9]')});

var cepMaskFormatter =
    MaskTextInputFormatter(mask: '#####-###', filter: {'#': RegExp(r'[0-9]')});

var rgMaskFormatter = MaskTextInputFormatter(mask: '##.###.###-#');

var birthMaskFormatter =
    MaskTextInputFormatter(mask: '##/##/####', filter: {'#': RegExp(r'[0-9]')});

var noneFormatter = MaskTextInputFormatter();

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
