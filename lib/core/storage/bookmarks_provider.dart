import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final bookmarksProvider = NotifierProvider<BookmarksNotifier, Set<String>>(() {
  return BookmarksNotifier();
});

class BookmarksNotifier extends Notifier<Set<String>> {
  static const _bookmarksKey = 'viv_formation_bookmarks';

  @override
  Set<String> build() {
    _loadBookmarks();
    return {};
  }

  Future<void> _loadBookmarks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final saved = prefs.getStringList(_bookmarksKey);
      if (saved != null) {
        state = saved.toSet();
      }
    } catch (e) {
      // Silent catch
    }
  }

  Future<void> toggleBookmark(String moduleId) async {
    final current = Set<String>.from(state);
    if (current.contains(moduleId)) {
      current.remove(moduleId);
    } else {
      current.add(moduleId);
    }
    state = current;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_bookmarksKey, current.toList());
    } catch (e) {
      // Silent catch
    }
  }

  bool isBookmarked(String moduleId) {
    return state.contains(moduleId);
  }
}
