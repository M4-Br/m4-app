import 'package:app_flutter_miban4/core/config/consts/lists/brazilian_states_list.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class StatesDropdown extends StatelessWidget {
  final String? selectedState;
  final ValueChanged<String?> onChanged;
  final String? label;

  const StatesDropdown({
    super.key,
    required this.selectedState,
    required this.onChanged,
    this.label = 'UF',
  });

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<String>(
      items: (filter, loadProps) => BrazilianStates.abbreviations,
      selectedItem: selectedState,
      onSelected: onChanged,
      filterFn: (item, filter) =>
          item.toLowerCase().contains(filter.toLowerCase()),
      decoratorProps: DropDownDecoratorProps(
        decoration: InputDecoration(
          labelText: label,
          hintText: 'Selecione',
          border: const OutlineInputBorder(),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        ),
      ),
      popupProps: PopupProps.menu(
        showSearchBox: true,
        fit: FlexFit.loose,
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            hintText: 'Pesquisar...',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
        ),
      ),
    );
  }
}
