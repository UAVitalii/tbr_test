import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/rocket.dart';
import '../models/launch.dart';
import '../services/spacex_api.dart';

final spacexApiProvider = Provider<SpaceXApi>((ref) => SpaceXApi());

final rocketsProvider = FutureProvider<List<Rocket>>((ref) {
  final api = ref.watch(spacexApiProvider);
  return api.getRockets();
});

final selectedRocketIndexProvider = StateProvider<int>((ref) => 0);

final launchesProvider = FutureProvider<List<Launch>>((ref) {
  final rocketsAsync = ref.watch(rocketsProvider);
  final selectedIndex = ref.watch(selectedRocketIndexProvider);
  final api = ref.watch(spacexApiProvider);

  return rocketsAsync.when(
    data: (rockets) {
      if (rockets.isEmpty) return Future.value([]);
      final rocketId = rockets[selectedIndex].rocketId;
      return api.getLaunches(rocketId);
    },
    loading: () => Future.value([]),
    error: (_, __) => Future.value([]),
  );
});
