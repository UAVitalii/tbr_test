import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/spacex_providers.dart';
import '../widgets/rocket_slider.dart';
import '../widgets/page_indicator.dart';
import '../widgets/launch_list.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rocketsAsync = ref.watch(rocketsProvider);
    final launchesAsync = ref.watch(launchesProvider);
    final selectedIndex = ref.watch(selectedRocketIndexProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: rocketsAsync.when(
          loading: () => const Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
          error: (error, _) => Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Failed to load rockets',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => ref.invalidate(rocketsProvider),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
          data: (rockets) => Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                child: Center(
                  child: Text(
                    'SpaceX Launches',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                    ),
                  ),
                ),
              ),
              RocketSlider(
                rockets: rockets,
                selectedIndex: selectedIndex,
                onPageChanged: (index) {
                  ref.read(selectedRocketIndexProvider.notifier).state = index;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 8),
                child: PageIndicator(
                  count: rockets.length,
                  selectedIndex: selectedIndex,
                ),
              ),
              Expanded(
                child: launchesAsync.when(
                  loading: () => const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                  error: (error, _) => Center(
                    child: Text(
                      'Failed to load launches',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                  data: (launches) => LaunchList(launches: launches),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
