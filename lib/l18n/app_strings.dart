import 'package:app_flutter_miban4/l18n/en_us_strings.dart';
import 'package:app_flutter_miban4/l18n/es_es_strings.dart';
import 'package:app_flutter_miban4/l18n/pt_br_strings.dart';
import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          ...StringsEnUS.enUS,
        },
        'pt_BR': {
          ...StringsPtBR.ptBR,
        },
        'es_ES': {...StringsEsES.esES}
      };
}
