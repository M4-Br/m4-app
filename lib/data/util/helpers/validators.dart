import 'package:intl/intl.dart';

class Validators {
  static String? isNotEmpty(String? value, [String? message]) {
    if (value == null || value.isEmpty) {
      return message ?? 'Este campo é obrigatório';
    }
    return null;
  }

  static String? isDocument(String? value, [String? message]) {
    if (value == null || (value.length != 14 && value.length != 18)) {
      return message ?? 'Documento inválido';
    }
    return null;
  }

  static String? hasMinChars(String? value, int minLength, [String? message]) {
    if (value == null || value.length < minLength) {
      return message ?? 'O campo precisa ter no mínimo $minLength caracteres';
    }
    return null;
  }

  static String? isValidEmail(String? value, [String? message]) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (value == null || !emailRegex.hasMatch(value)) {
      return message ?? 'Digite um e-mail válido';
    }
    return null;
  }

  static String? confirmPassword(String? value1, String? value2,
      [String? message]) {
    if (value1 != value2) return message ?? "As senhas precisam ser iguais";
    return null;
  }

  static String? combine(List<String? Function()> validators) {
    for (final fun in validators) {
      final validation = fun();
      if (validation != null) return validation;
    }
    return null;
  }

  static String? noSpecialChars(String? value, [String? message]) {
    if (value == null || value.isEmpty) {
      return isNotEmpty(value);
    }
    final RegExp regex = RegExp(r'^[a-zA-Z0-9 ]+$');
    if (!regex.hasMatch(value)) {
      return message ?? 'Não use acentuação e/ou caracteres especiais';
    }
    return null;
  }

  static String? isOfLegalAge(String? value, [String? message]) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira a data de nascimento.';
    }

    try {
      final dateFormat = DateFormat('dd/MM/yyyy');
      final parsedDate = dateFormat.parseStrict(value);
      final today = DateTime.now();

      final eighteenYearsAgo =
          DateTime(today.year - 18, today.month, today.day);

      if (parsedDate.isAfter(eighteenYearsAgo)) {
        return message ?? 'É necessário ter no mínimo 18 anos.';
      }
    } catch (e) {
      return 'Data inválida. Use o formato dd/MM/yyyy.';
    }
    return null;
  }
}
