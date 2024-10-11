
import 'package:mask_shifter_v2/mask_shifter.dart';

class MaskShifter {

  static MaskedTextInputFormatterShifter get idFormatter {
    return MaskedTextInputFormatterShifter(
        maskONE: 'XXX.XXX.XXX-XX',
        maskTWO: 'XX.XXX.XXX/XXXX-XX'
    );
  }
}