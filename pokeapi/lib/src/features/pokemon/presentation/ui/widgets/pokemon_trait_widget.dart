import 'package:flutter/material.dart';

import 'trait_item_widget.dart';

class PokemonTraitWidget extends StatelessWidget {
  const PokemonTraitWidget({
    super.key,
    required this.traitName,
    required this.traitDescription,
  });

  final String traitName;
  final String traitDescription;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4,
      children: [
        Text(
          traitName,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),

        TraitItemWidget(description: traitDescription),
      ],
    );
  }
}
