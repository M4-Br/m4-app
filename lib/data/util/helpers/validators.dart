import 'package:intl/intl.dart';

mixin ValidationsMixin {
  String? isNotEmpty(String? value, [String? message]) {
    if (value!.isEmpty) return message ?? 'Este campo é obrigatório';
    return null;
  }

  String? isValidDocument(String? value, [String? message]) {
    if (value!.length < 14) return message ?? 'O documento deve conter 11 caracteres';
    return null;
  }

  String? hasSixChars(String? value, [String? message]) {
    if (value!.length < 6) return message ?? 'A senha precisa conter 6 caracteres';
    return null;
  }

  String? isValidEmail(String? value, [String? message]) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value ?? '')) {
      return message ?? 'Digite um e-mail válido';
    }
    return null;
  }

  String? confirmPassword(String? value, String? value2, [String? message]) {
    if (value != value2) return message ?? "As senhas precisam ser iguais";
    return null;
  }

  String? combineValidators(List<String? Function()> validators) {
    for (final fun in validators) {
      final validation = fun();
      if (validation != null) return validation;
    }
    return null;
  }

  String? validateChar(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nome não pode estar vazio';
    }
    final RegExp regex = RegExp(r'^[a-zA-Z0-9 ]+$');
    if (!regex.hasMatch(value)) {
      return 'Não use acentuação e/ou caracteres especiais';
    }
    return null;
  }

  String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira a data de nascimento.';
    }

    try {
      final dateFormat = DateFormat('dd/MM/yyyy');
      final parsedDate = dateFormat.parseStrict(value);

      final today = DateTime.now();
      final eighteenYearsAgo = today.subtract(const Duration(days: 18 * 365));
      final seventyYearsAgo = today.subtract(const Duration(days: 70 * 365));

      if (parsedDate.isAfter(eighteenYearsAgo) || parsedDate.isBefore(seventyYearsAgo)) {
        return 'A idade deve estar entre 18 e 70 anos.';
      }
    } catch (e) {
      return 'Data inválida. Use o formato dd/MM/yyyy.';
    }

    return null;
  }
}
