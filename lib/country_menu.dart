import 'package:flutter/material.dart';

enum Country {
  us,
  id,
  my,
  sa,
  // Add more countries as needed
}

class CountryMenu extends StatelessWidget {
  final Country selectedCountry;
  final Function(Country) onCountrySelected;

  const CountryMenu({
    super.key,
    required this.selectedCountry,
    required this.onCountrySelected,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Country>(
      onSelected: onCountrySelected,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Country>>[
        const PopupMenuItem<Country>(
          value: Country.us,
          child: Text('United States'),
        ),
        const PopupMenuItem<Country>(
          value: Country.id,
          child: Text('Indonesia'),
        ),
        const PopupMenuItem<Country>(
          value: Country.my,
          child: Text('Malaysia'),
        ),
        const PopupMenuItem<Country>(
          value: Country.sa,
          child: Text('Saudi Arabia'),
        ),
        // Add more countries as needed
      ],
    );
  }
}
