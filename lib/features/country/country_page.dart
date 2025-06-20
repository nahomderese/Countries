import 'package:flutter/material.dart';
import 'package:countries_app/shared/domain/models/country_model.dart';
import 'package:countries_app/shared/utils/formatPopulation.dart';

class CountryPage extends StatelessWidget {
  final Country country;
  const CountryPage({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text(
          'Country Details',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 1.5,
              child: ClipRRect(
                child: Image.network(
                  country.flagUrl,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) =>
                          const Center(child: Icon(Icons.flag)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    country.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _DetailLabelValue(
                    label: 'Area',
                    value:
                        '${country.area.toStringAsFixed(0).replaceAllMapped(RegExp(r"\B(?=(\d{3})+(?!\d))"), (match) => ',')} sq km',
                  ),
                  const SizedBox(height: 8),
                  _DetailLabelValue(
                    label: 'Population',
                    value: formatPopulation(country.population),
                  ),
                  const SizedBox(height: 8),
                  _DetailLabelValue(label: 'Region', value: country.region),
                  const SizedBox(height: 8),
                  _DetailLabelValue(
                    label: 'Sub Region',
                    value: country.subregion,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Timezone',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    children:
                        country.timezones
                            .map(
                              (tz) => Chip(
                                label: Text(
                                  tz,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: const BorderSide(
                                    color: Color(0xFFE0E0E0),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailLabelValue extends StatelessWidget {
  final String label;
  final String value;
  const _DetailLabelValue({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Color(0xFF8E99A6), fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
          ),
        ],
      ),
    );
  }
}
