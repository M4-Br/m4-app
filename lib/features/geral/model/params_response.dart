class ParamsResponse {
  ParamsResponse({
    required this.periods,
    required this.amountByPeriods,
    required this.mutualInstallments,
    required this.mutualPriorities,
    required this.mutualFee,
    required this.mutualRequestDay,
    required this.mutualVotationDays,
    required this.mutualApprovationDay,
    required this.mutualApprovationHour,
    required this.mutualMinimunApprovation,
    required this.mutualAmountMultiplier,
    required this.mutualExtraFee,
    required this.mutualCheckoutCharge,
    required this.mutualCharge,
    required this.quotationCredit,
    required this.mutualMinimunApprovationValue,
    required this.minimumGroupSaving,
    required this.minimumPeriodContribution,
    required this.creditAvailableDay,
    required this.creditAvailableHour,
    required this.sacMibanka4,
    required this.installments,
    required this.quantityOfMembers,
  });
  late final List<Periods> periods;
  late final List<AmountByPeriods> amountByPeriods;
  late final List<MutualInstallments> mutualInstallments;
  late final List<MutualPriorities> mutualPriorities;
  late final List<MutualFee> mutualFee;
  late final List<MutualRequestDay> mutualRequestDay;
  late final List<MutualVotationDays> mutualVotationDays;
  late final List<MutualApprovationDay> mutualApprovationDay;
  late final List<MutualApprovationHour> mutualApprovationHour;
  late final List<MutualMinimunApprovation> mutualMinimunApprovation;
  late final List<MutualAmountMultiplier> mutualAmountMultiplier;
  late final List<MutualExtraFee> mutualExtraFee;
  late final List<MutualCheckoutCharge> mutualCheckoutCharge;
  late final List<MutualCharge> mutualCharge;
  late final List<QuotationCredit> quotationCredit;
  late final List<MutualMinimunApprovationValue> mutualMinimunApprovationValue;
  late final List<MinimumGroupSaving> minimumGroupSaving;
  late final List<MinimumPeriodContribution> minimumPeriodContribution;
  late final List<CreditAvailableDay> creditAvailableDay;
  late final List<CreditAvailableHour> creditAvailableHour;
  late final List<SacMibanka4> sacMibanka4;
  late final List<Installments> installments;
  late final List<QuantityOfMembers> quantityOfMembers;

  ParamsResponse.fromJson(Map<String, dynamic> json) {
    periods =
        List.from(json['periods']).map((e) => Periods.fromJson(e)).toList();
    amountByPeriods = List.from(json['amount_by_periods'])
        .map((e) => AmountByPeriods.fromJson(e))
        .toList();
    mutualInstallments = List.from(json['mutual_installments'])
        .map((e) => MutualInstallments.fromJson(e))
        .toList();
    mutualPriorities = List.from(json['mutual_priorities'])
        .map((e) => MutualPriorities.fromJson(e))
        .toList();
    mutualFee = List.from(json['mutual_fee'])
        .map((e) => MutualFee.fromJson(e))
        .toList();
    mutualRequestDay = List.from(json['mutual_request_day'])
        .map((e) => MutualRequestDay.fromJson(e))
        .toList();
    mutualVotationDays = List.from(json['mutual_votation_days'])
        .map((e) => MutualVotationDays.fromJson(e))
        .toList();
    mutualApprovationDay = List.from(json['mutual_approvation_day'])
        .map((e) => MutualApprovationDay.fromJson(e))
        .toList();
    mutualApprovationHour = List.from(json['mutual_approvation_hour'])
        .map((e) => MutualApprovationHour.fromJson(e))
        .toList();
    mutualMinimunApprovation = List.from(json['mutual_minimun_approvation'])
        .map((e) => MutualMinimunApprovation.fromJson(e))
        .toList();
    mutualAmountMultiplier = List.from(json['mutual_amount_multiplier'])
        .map((e) => MutualAmountMultiplier.fromJson(e))
        .toList();
    mutualExtraFee = List.from(json['mutual_extra_fee'])
        .map((e) => MutualExtraFee.fromJson(e))
        .toList();
    mutualCheckoutCharge = List.from(json['mutual_checkout_charge'])
        .map((e) => MutualCheckoutCharge.fromJson(e))
        .toList();
    mutualCharge = List.from(json['mutual_charge'])
        .map((e) => MutualCharge.fromJson(e))
        .toList();
    quotationCredit = List.from(json['quotation_credit '])
        .map((e) => QuotationCredit.fromJson(e))
        .toList();
    mutualMinimunApprovationValue =
        List.from(json['mutual_minimun_approvation_value'])
            .map((e) => MutualMinimunApprovationValue.fromJson(e))
            .toList();
    minimumGroupSaving = List.from(json['minimum_group_saving'])
        .map((e) => MinimumGroupSaving.fromJson(e))
        .toList();
    minimumPeriodContribution = List.from(json['minimum_period_contribution'])
        .map((e) => MinimumPeriodContribution.fromJson(e))
        .toList();
    creditAvailableDay = List.from(json['credit_available_day'])
        .map((e) => CreditAvailableDay.fromJson(e))
        .toList();
    creditAvailableHour = List.from(json['credit_available_hour'])
        .map((e) => CreditAvailableHour.fromJson(e))
        .toList();
    sacMibanka4 = List.from(json['sac_mibanka4'])
        .map((e) => SacMibanka4.fromJson(e))
        .toList();
    installments = List.from(json['installments'])
        .map((e) => Installments.fromJson(e))
        .toList();
    quantityOfMembers = List.from(json['quantity_of_members'])
        .map((e) => QuantityOfMembers.fromJson(e))
        .toList();
  }
}

class Periods {
  Periods({
    required this.id,
    required this.label,
    required this.value,
    required this.description,
  });
  late final int id;
  late final String label;
  late final String value;
  late final String description;

  Periods.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    value = json['value'];
    description = json['description'];
  }
}

class AmountByPeriods {
  AmountByPeriods({
    required this.id,
    this.label,
    required this.value,
    required this.description,
  });
  late final int id;
  late final Null label;
  late final String value;
  late final String description;

  AmountByPeriods.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = null;
    value = json['value'];
    description = json['description'];
  }
}

class MutualInstallments {
  MutualInstallments({
    required this.id,
    this.label,
    required this.value,
    required this.description,
  });
  late final int id;
  late final Null label;
  late final String value;
  late final String description;

  MutualInstallments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = null;
    value = json['value'];
    description = json['description'];
  }
}

class MutualPriorities {
  MutualPriorities({
    required this.id,
    required this.label,
    required this.value,
    required this.description,
  });
  late final int id;
  late final String label;
  late final String value;
  late final String description;

  MutualPriorities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    value = json['value'];
    description = json['description'];
  }
}

class MutualFee {
  MutualFee({
    required this.id,
    this.label,
    required this.value,
    required this.description,
  });
  late final int id;
  late final Null label;
  late final String value;
  late final String description;

  MutualFee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = null;
    value = json['value'];
    description = json['description'];
  }
}

class MutualRequestDay {
  MutualRequestDay({
    required this.id,
    this.label,
    required this.value,
    required this.description,
  });
  late final int id;
  late final Null label;
  late final String value;
  late final String description;

  MutualRequestDay.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = null;
    value = json['value'];
    description = json['description'];
  }
}

class MutualVotationDays {
  MutualVotationDays({
    required this.id,
    this.label,
    required this.value,
    required this.description,
  });
  late final int id;
  late final Null label;
  late final String value;
  late final String description;

  MutualVotationDays.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = null;
    value = json['value'];
    description = json['description'];
  }
}

class MutualApprovationDay {
  MutualApprovationDay({
    required this.id,
    this.label,
    required this.value,
    required this.description,
  });
  late final int id;
  late final Null label;
  late final String value;
  late final String description;

  MutualApprovationDay.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = null;
    value = json['value'];
    description = json['description'];
  }
}

class MutualApprovationHour {
  MutualApprovationHour({
    required this.id,
    this.label,
    required this.value,
    required this.description,
  });
  late final int id;
  late final Null label;
  late final String value;
  late final String description;

  MutualApprovationHour.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = null;
    value = json['value'];
    description = json['description'];
  }
}

class MutualMinimunApprovation {
  MutualMinimunApprovation({
    required this.id,
    this.label,
    required this.value,
    required this.description,
  });
  late final int id;
  late final Null label;
  late final String value;
  late final String description;

  MutualMinimunApprovation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = null;
    value = json['value'];
    description = json['description'];
  }
}

class MutualAmountMultiplier {
  MutualAmountMultiplier({
    required this.id,
    this.label,
    required this.value,
    required this.description,
  });
  late final int id;
  late final Null label;
  late final String value;
  late final String description;

  MutualAmountMultiplier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = null;
    value = json['value'];
    description = json['description'];
  }
}

class MutualExtraFee {
  MutualExtraFee({
    required this.id,
    this.label,
    required this.value,
    required this.description,
  });
  late final int id;
  late final Null label;
  late final String value;
  late final String description;

  MutualExtraFee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = null;
    value = json['value'];
    description = json['description'];
  }
}

class MutualCheckoutCharge {
  MutualCheckoutCharge({
    required this.id,
    this.label,
    required this.value,
    required this.description,
  });
  late final int id;
  late final Null label;
  late final String value;
  late final String description;

  MutualCheckoutCharge.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = null;
    value = json['value'];
    description = json['description'];
  }
}

class MutualCharge {
  MutualCharge({
    required this.id,
    this.label,
    required this.value,
    required this.description,
  });
  late final int id;
  late final Null label;
  late final String value;
  late final String description;

  MutualCharge.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = null;
    value = json['value'];
    description = json['description'];
  }
}

class QuotationCredit {
  QuotationCredit({
    required this.id,
    this.label,
    required this.value,
    required this.description,
  });
  late final int id;
  late final Null label;
  late final String value;
  late final String description;

  QuotationCredit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = null;
    value = json['value'];
    description = json['description'];
  }
}

class MutualMinimunApprovationValue {
  MutualMinimunApprovationValue({
    required this.id,
    this.label,
    required this.value,
    required this.description,
  });
  late final int id;
  late final Null label;
  late final String value;
  late final String description;

  MutualMinimunApprovationValue.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = null;
    value = json['value'];
    description = json['description'];
  }
}

class MinimumGroupSaving {
  MinimumGroupSaving({
    required this.id,
    this.label,
    required this.value,
    required this.description,
  });
  late final int id;
  late final Null label;
  late final String value;
  late final String description;

  MinimumGroupSaving.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = null;
    value = json['value'];
    description = json['description'];
  }
}

class MinimumPeriodContribution {
  MinimumPeriodContribution({
    required this.id,
    this.label,
    required this.value,
    required this.description,
  });
  late final int id;
  late final Null label;
  late final String value;
  late final String description;

  MinimumPeriodContribution.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = null;
    value = json['value'];
    description = json['description'];
  }
}

class CreditAvailableDay {
  CreditAvailableDay({
    required this.id,
    this.label,
    required this.value,
    required this.description,
  });
  late final int id;
  late final Null label;
  late final String value;
  late final String description;

  CreditAvailableDay.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = null;
    value = json['value'];
    description = json['description'];
  }
}

class CreditAvailableHour {
  CreditAvailableHour({
    required this.id,
    this.label,
    required this.value,
    required this.description,
  });
  late final int id;
  late final Null label;
  late final String value;
  late final String description;

  CreditAvailableHour.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = null;
    value = json['value'];
    description = json['description'];
  }
}

class SacMibanka4 {
  SacMibanka4({
    required this.id,
    required this.label,
    required this.value,
    required this.description,
  });
  late final int id;
  late final String label;
  late final String value;
  late final String description;

  SacMibanka4.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    value = json['value'];
    description = json['description'];
  }
}

class Installments {
  Installments({
    required this.id,
    this.label,
    required this.value,
    required this.description,
  });
  late final int id;
  late final Null label;
  late final String value;
  late final String description;

  Installments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = null;
    value = json['value'];
    description = json['description'];
  }
}

class QuantityOfMembers {
  QuantityOfMembers({
    required this.id,
    this.label,
    required this.value,
    required this.description,
  });
  late final int id;
  late final Null label;
  late final String value;
  late final String description;

  QuantityOfMembers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = null;
    value = json['value'];
    description = json['description'];
  }
}
