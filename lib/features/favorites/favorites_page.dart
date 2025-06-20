import 'package:countries_app/routes/app_route.gr.dart' show CountryRoute;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../home/countries_provider.dart';
import 'favorites_provider.dart';
import 'package:countries_app/shared/utils/formatPopulation.dart';
import 'package:auto_route/auto_route.dart';
import 'package:countries_app/shared/theme/app_theme.dart';

class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countriesAsync = ref.watch(countriesProvider);
    final favorites = ref.watch(favoritesProvider);
    final themeMode = ref.watch(appThemeProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorites',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
            ),
            tooltip: 'Toggle Theme',
            onPressed: () => ref.read(appThemeProvider.notifier).toggleTheme(),
          ),
        ],
      ),
      body: countriesAsync.when(
        data: (countries) {
          final favCountries =
              countries.where((c) => favorites.contains(c.name)).toList();
          if (favCountries.isEmpty) {
            return const Center(child: Text('No favorite countries yet.'));
          }
          return GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.82,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: favCountries.length,
            itemBuilder: (context, index) {
              final country = favCountries[index];
              return GestureDetector(
                onTap:
                    () => context.router.push(CountryRoute(country: country)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.07),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Image.network(
                                  country.flagUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (context, error, stackTrace) =>
                                          const Center(child: Icon(Icons.flag)),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.35),
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(16),
                                      bottomRight: Radius.circular(16),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.people,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            formatPopulation(
                                              country.population,
                                            ),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap:
                                            () => ref
                                                .read(
                                                  favoritesProvider.notifier,
                                                )
                                                .toggleFavorite(country.name),
                                        child: const Icon(
                                          Icons.favorite,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      country.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error:
            (e, _) => const Center(
              child: Text('Failed to load countries. Please try again.'),
            ),
      ),
    );
  }
}
