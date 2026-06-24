import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../core/theme/viv_colors.dart';
import '../../core/theme/viv_spacing.dart';
import '../../core/theme/viv_typography.dart';
import '../../core/data/mock_chapters_data.dart';
import '../../core/models/content_module.dart';
import '../../core/storage/bookmarks_provider.dart';

class BookmarkItemData {
  final String chapterTitle;
  final int chapterId;
  final String routePath;
  final ContentModule module;

  const BookmarkItemData({
    required this.chapterTitle,
    required this.chapterId,
    required this.routePath,
    required this.module,
  });
}

class BookmarksScreen extends ConsumerWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarkedIds = ref.watch(bookmarksProvider);

    // Rassembler tous les modules de tous les chapitres
    final List<BookmarkItemData> bookmarkedItems = [];

    void checkModules(List<ContentModule> modules, String chapterTitle, int chapterId, String routePath) {
      for (var module in modules) {
        if (bookmarkedIds.contains(module.id)) {
          bookmarkedItems.add(BookmarkItemData(
            chapterTitle: chapterTitle,
            chapterId: chapterId,
            routePath: routePath,
            module: module,
          ));
        }
      }
    }

    checkModules(basics101Modules, 'Basics 101', 0, '/basics-101');
    checkModules(chapter1Modules, 'Fondamentaux du Shading & LookDev', 1, '/chapter-1');
    checkModules(chapter2Modules, 'Texturage Agile & Gestion Simplifiée des UVs', 2, '/chapter-2');
    checkModules(chapter3Modules, 'Mise en lumière & Méthodes de Rendu', 3, '/chapter-3');

    return Scaffold(
      backgroundColor: Colors.transparent, // Car affiché dans le viewport de MainShell
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(VivSpacing.space6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Text(
              'MES SIGNETS',
              style: VivTypography.eyebrow.copyWith(color: VivColors.limeDeep),
            ),
            const SizedBox(height: VivSpacing.space2),
            Text(
              'Points techniques favoris',
              style: VivTypography.h1,
            ),
            const SizedBox(height: VivSpacing.space3),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Text(
                'Retrouvez ici tous les modules et points précis que vous avez marqués d\'un signet au fil de votre formation. Cliquez sur un élément pour y être redirigé automatiquement.',
                style: VivTypography.lead.copyWith(color: VivColors.gray500),
              ),
            ),
            const SizedBox(height: VivSpacing.space7),

            // Content Section
            if (bookmarkedItems.isEmpty)
              _buildEmptyState()
            else
              Column(
                children: bookmarkedItems.map((item) => _buildBookmarkCard(context, ref, item)).toList(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: VivSpacing.space8 * 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(VivSpacing.space5),
              decoration: BoxDecoration(
                color: VivColors.offWhite,
                shape: BoxShape.circle,
                border: Border.all(color: VivColors.gray100),
              ),
              child: const Icon(
                LucideIcons.bookmark,
                size: 48,
                color: VivColors.gray300,
              ),
            ),
            const SizedBox(height: VivSpacing.space5),
            Text(
              'Aucun signet pour le moment',
              style: VivTypography.h3.copyWith(color: VivColors.ink),
            ),
            const SizedBox(height: VivSpacing.space2),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Text(
                'Parcourez les différents chapitres de la formation et cliquez sur l\'icône de signet à droite de n\'importe quel paragraphe ou quiz pour le retrouver ici.',
                textAlign: TextAlign.center,
                style: VivTypography.body.copyWith(color: VivColors.gray500),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookmarkCard(BuildContext context, WidgetRef ref, BookmarkItemData item) {
    final title = _getModuleTitle(item.module);

    return Container(
      margin: const EdgeInsets.only(bottom: VivSpacing.space4),
      decoration: BoxDecoration(
        color: VivColors.paper,
        borderRadius: BorderRadius.circular(VivSpacing.radiusMd),
        border: Border.all(color: VivColors.gray200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          context.go('${item.routePath}?target=${item.module.id}');
        },
        child: Padding(
          padding: const EdgeInsets.all(VivSpacing.space5),
          child: Row(
            children: [
              // Lead decorative icon depending on module type
              Container(
                padding: const EdgeInsets.all(VivSpacing.space3),
                decoration: BoxDecoration(
                  color: VivColors.lime.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(VivSpacing.radiusSm),
                ),
                child: Icon(
                  _getModuleIcon(item.module),
                  color: VivColors.limeDeep,
                  size: 20,
                ),
              ),
              const SizedBox(width: VivSpacing.space4),

              // Title and Subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: VivTypography.body.copyWith(
                        fontWeight: FontWeight.bold,
                        color: VivColors.ink,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: VivSpacing.space1),
                    Text(
                      item.chapterTitle,
                      style: VivTypography.small.copyWith(
                        color: VivColors.gray500,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: VivSpacing.space3),

              // Trash / remove from bookmarks action
              IconButton(
                icon: const Icon(
                  LucideIcons.bookmark,
                  color: VivColors.limeDeep,
                  size: 20,
                ),
                onPressed: () {
                  ref.read(bookmarksProvider.notifier).toggleBookmark(item.module.id);
                },
                tooltip: 'Retirer des signets',
              ),
              const Icon(
                LucideIcons.chevronRight,
                color: VivColors.gray400,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getModuleIcon(ContentModule module) {
    if (module is TitleModule) {
      return LucideIcons.heading;
    } else if (module is TextModule) {
      return LucideIcons.alignLeft;
    } else if (module is SideBySideModule) {
      return LucideIcons.columns;
    } else if (module is FullMediaModule) {
      return LucideIcons.image;
    } else if (module is InfoModule) {
      switch (module.type) {
        case InfoType.idea:
          return LucideIcons.lightbulb;
        case InfoType.tip:
          return LucideIcons.checkCircle;
        case InfoType.warning:
          return LucideIcons.alertTriangle;
        case InfoType.info:
          return LucideIcons.info;
        case InfoType.objective:
          return LucideIcons.target;
        case InfoType.challenge:
          return LucideIcons.trophy;
      }
    } else if (module is ResourceModule) {
      return LucideIcons.download;
    } else if (module is ListModule) {
      return LucideIcons.list;
    } else if (module is QuizModule) {
      return LucideIcons.helpCircle;
    }
    return LucideIcons.fileText;
  }

  String _getModuleTitle(ContentModule module) {
    if (module is TitleModule) {
      return module.title;
    } else if (module is TextModule) {
      final t = module.title;
      if (t != null && t.trim().isNotEmpty) {
        return t;
      }
      return module.content.length > 60
          ? '${module.content.substring(0, 57)}...'
          : module.content;
    } else if (module is SideBySideModule) {
      final t = module.title;
      if (t != null && t.trim().isNotEmpty) {
        return t;
      }
      return module.content.length > 60
          ? '${module.content.substring(0, 57)}...'
          : module.content;
    } else if (module is FullMediaModule) {
      final c = module.caption;
      return (c != null && c.trim().isNotEmpty) ? c : 'Illustration pleine largeur';
    } else if (module is InfoModule) {
      String prefix = 'Info';
      switch (module.type) {
        case InfoType.idea:
          prefix = 'Idée';
          break;
        case InfoType.tip:
          prefix = 'Astuce';
          break;
        case InfoType.warning:
          prefix = 'Avertissement';
          break;
        case InfoType.info:
          prefix = 'Information';
          break;
        case InfoType.objective:
          prefix = 'Objectif';
          break;
        case InfoType.challenge:
          prefix = 'Défi';
          break;
      }
      final cleanText = module.text.trim();
      return '$prefix : ${cleanText.length > 50 ? "${cleanText.substring(0, 47)}..." : cleanText}';
    } else if (module is ResourceModule) {
      return 'Ressource : ${module.title.trim().isNotEmpty ? module.title : module.fileName}';
    } else if (module is ListModule) {
      return module.title.trim().isNotEmpty ? module.title : 'Liste de points';
    } else if (module is QuizModule) {
      final q = module.question.trim();
      return 'Quiz : ${q.length > 50 ? "${q.substring(0, 47)}..." : q}';
    }
    return 'Point technique';
  }
}
