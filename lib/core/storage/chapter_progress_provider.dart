import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final chapterProgressProvider = NotifierProvider<ChapterProgressNotifier, Set<String>>(() {
  return ChapterProgressNotifier();
});

class ChapterProgressNotifier extends Notifier<Set<String>> {
  static const _progressKey = 'viv_chapter_progress';

  @override
  Set<String> build() {
    _loadProgress();
    return {};
  }

  Future<void> _loadProgress() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final saved = prefs.getStringList(_progressKey);
      if (saved != null) {
        state = saved.toSet();
      }
    } catch (e) {
      // Silent catch
    }
  }

  Future<void> toggleCompletion(String chapterPath) async {
    final current = Set<String>.from(state);
    if (current.contains(chapterPath)) {
      current.remove(chapterPath);
    } else {
      current.add(chapterPath);
    }
    state = current;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_progressKey, current.toList());
    } catch (e) {
      // Silent catch
    }
  }

  bool isCompleted(String chapterPath) {
    return state.contains(chapterPath);
  }
}
