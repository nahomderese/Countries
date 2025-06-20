import 'package:countries_app/routes/app_route.gr.dart';
import 'package:countries_app/shared/utils/formatPopulation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'countries_provider.dart';
import '../favorites/favorites_provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:countries_app/shared/theme/app_theme.dart';

final searchProvider = StateProvider<String>((ref) => '');

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countriesAsync = ref.watch(countriesProvider);
    final search = ref.watch(searchProvider);
    final favorites = ref.watch(favoritesProvider);
    final themeMode = ref.watch(appThemeProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Countries',
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search countries',
                prefixIcon: const Icon(Icons.search, color: Color(0xFFBFC8D0)),
                filled: true,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Color(0xFFBFC8D0)),
                ),
              ),
              onChanged:
                  (value) => ref.read(searchProvider.notifier).state = value,
            ),
          ),
          Expanded(
            child: countriesAsync.when(
              data: (countries) {
                final filtered =
                    countries
                        .where(
                          (c) => c.name.toLowerCase().contains(
                            search.toLowerCase(),
                          ),
                        )
                        .toList();
                if (filtered.isEmpty) {
                  return const Center(child: Text('No countries found.'));
                }
                return RefreshIndicator(
                  onRefresh: () async {
                    ref.invalidate(countriesProvider);
                  },
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.82,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final country = filtered[index];
                      final isFav = favorites.contains(country.name);
                      return GestureDetector(
                        onTap:
                            () => context.router.push(
                              CountryRoute(country: country),
                            ),
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
                                                  const Center(
                                                    child: Icon(Icons.flag),
                                                  ),
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
                                            color: Colors.black.withOpacity(
                                              0.35,
                                            ),
                                            borderRadius:
                                                const BorderRadius.only(
                                                  bottomLeft: Radius.circular(
                                                    16,
                                                  ),
                                                  bottomRight: Radius.circular(
                                                    16,
                                                  ),
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
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              GestureDetector(
                                                onTap:
                                                    () => ref
                                                        .read(
                                                          favoritesProvider
                                                              .notifier,
                                                        )
                                                        .toggleFavorite(
                                                          country.name,
                                                        ),
                                                child: Icon(
                                                  isFav
                                                      ? Icons.favorite
                                                      : Icons.favorite_border,
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
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error:
                  (e, _) => const Center(
                    child: Text('Failed to load countries. Please try again.'),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
