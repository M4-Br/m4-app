import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/features/geral/model/professions_response.dart';
import 'package:app_flutter_miban4/features/geral/repository/profession_repository.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class ProfessionsDropdown extends StatelessWidget {
  final ProfessionsResponse? selectedItem;
  final ValueChanged<ProfessionsResponse?> onChanged;
  final String? Function(ProfessionsResponse?)? validator;
  final String? label;

  const ProfessionsDropdown({
    super.key,
    required this.selectedItem,
    required this.onChanged,
    this.validator,
    this.label,
  });

  Future<List<ProfessionsResponse>> _getData(
      String filter, LoadProps? props) async {
    try {
      final response = await ProfessionRepository().fetchProfessions();
      return response;
    } catch (e, s) {
      AppLogger.I().error('Fetch professions', e, s);
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<ProfessionsResponse>(
      items: _getData,
      selectedItem: selectedItem,
      onSelected: onChanged,
      validator: validator,
      itemAsString: (item) => item.description,
      compareFn: (item1, item2) => item1.id == item2.id,
      filterFn: (item, filter) =>
          item.description.toLowerCase().contains(filter.toLowerCase()),
      decoratorProps: DropDownDecoratorProps(
        decoration: InputDecoration(
          labelText: label ?? 'Profissão',
          hintText: 'Selecione',
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          isDense: true,
          labelStyle: const TextStyle(color: Colors.black54, fontSize: 15),
          border: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)),
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: secondaryColor, width: 1.5),
          ),
          errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red)),
        ),
      ),
      popupProps: PopupProps.menu(
        showSearchBox: true,
        fit: FlexFit.loose,
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            hintText: 'Pesquisar profissão...',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
        ),
        // Loading customizado (opcional)
        loadingBuilder: (context, searchEntry) => const Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: CircularProgressIndicator(color: secondaryColor),
          ),
        ),
        emptyBuilder: (context, searchEntry) => Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Nenhuma profissão encontrada',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
        ),
      ),
    );
  }
}
