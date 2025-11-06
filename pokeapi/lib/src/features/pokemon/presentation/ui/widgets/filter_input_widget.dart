import 'package:flutter/material.dart';
import 'package:pokeapi/src/core/theme/app_colors.dart';

class FilterInputWidget extends StatelessWidget {
  const FilterInputWidget({super.key, this.onChanged});

  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Filtre por nome',
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: AppColors.white,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide.none,
        ),
      ),
      onChanged: onChanged,
    );
  }
}
