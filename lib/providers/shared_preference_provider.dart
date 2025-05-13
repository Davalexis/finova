import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _hasOpenedBeforeKey = 'has_app_opened_before';

final sharedPreferencesProvider = FutureProvider<SharedPreferences>((
  ref,
) async {
  return await SharedPreferences.getInstance();
});

final hasOpenedBeforeProvider = FutureProvider<bool>((ref) async {
  final prefs = await ref.watch(sharedPreferencesProvider.future);

  return prefs.getBool(_hasOpenedBeforeKey) ?? false;
});

Future<void> markAsOpened(reader) async {
  try {
    final prefs = await reader(sharedPreferencesProvider.future);
    await prefs.setBool(_hasOpenedBeforeKey, true);
    print('Successfully marked app as opened.'); // For debugging
  } catch (e) {
    print('Error in markAsOpened: Failed to set "hasOpenedBefore" flag: $e');
  }
}

Future<void> clearHasOpenedBeforeFlag(reader) async {
  try {
    final prefs = await reader(sharedPreferencesProvider.future);
    await prefs.remove(_hasOpenedBeforeKey);
    print('Successfully cleared "hasOpenedBefore" flag.'); // For debugging
  } catch (e) {
    print('Error in clearHasOpenedBeforeFlag: Failed to clear flag: $e');
  }
}
