import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/theme/viv_colors.dart';
import '../../core/theme/viv_spacing.dart';
import '../../core/theme/viv_typography.dart';
import '../../core/storage/bookmarks_provider.dart';
import '../../core/data/mock_chapters_data.dart';
import '../../core/models/content_module.dart';

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

class DashboardChapterData {
  final int id;
  final String title;
  final String objective;
  final IconData icon;
  final String routePath;

  const DashboardChapterData({
    required this.id,
    required this.title,
    required this.objective,
    required this.icon,
    required this.routePath,
  });
}

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  static const List<DashboardChapterData> chapters = [
    DashboardChapterData(
      id: 1,
      title: 'Chapitre 1 : Introduction et Mise en place',
      objective: 'Découvrez les bases fondamentales de l\'outil et préparez votre espace de travail.',
      icon: LucideIcons.film,
      routePath: '/chapter-1',
    ),
    DashboardChapterData(
      id: 2,
      title: 'Chapitre 2 : Approfondissement et Modélisation',
      objective: 'Apprenez à modéliser des objets complexes et à structurer vos scènes.',
      icon: LucideIcons.shapes,
      routePath: '/chapter-2',
    ),
    DashboardChapterData(
      id: 3,
      title: 'Chapitre 3 : Rendu et Synthèse',
      objective: 'Configurez vos lumières, textures et caméras pour produire un rendu final.',
      icon: LucideIcons.image,
      routePath: '/chapter-3',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarkedIds = ref.watch(bookmarksProvider);

    return Scaffold(
      backgroundColor: Colors.transparent, // Car affiché dans le viewport de MainShell
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(VivSpacing.space6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Bandeau Héro d'accueil (Accès direct au Chapitre 1)
            _buildHeroSection(context),
            const SizedBox(height: VivSpacing.space6),

            // 2. Bento Layout pour les Chapitres, Signets et Liens
            LayoutBuilder(
              builder: (context, constraints) {
                final isLargeScreen = constraints.maxWidth > 960;

                if (isLargeScreen) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Partie gauche (2/3) : Grille Bento des chapitres de formation
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'CHAPITRES DE FORMATION',
                              style: VivTypography.eyebrow.copyWith(color: VivColors.gray500),
                            ),
                            const SizedBox(height: VivSpacing.space3),
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: chapters.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: VivSpacing.space4,
                                mainAxisSpacing: VivSpacing.space4,
                                childAspectRatio: 1.25,
                              ),
                              itemBuilder: (context, index) => _buildChapterBentoCard(context, chapters[index]),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: VivSpacing.space6),
                      // Partie droite (1/3) : Signets récents + Liens utiles
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildRecentBookmarksWidget(context, ref, bookmarkedIds),
                            const SizedBox(height: VivSpacing.space6),
                            _buildUsefulLinksWidget(context),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  // Stack vertical pour les mobiles/petites fenêtres
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CHAPITRES DE FORMATION',
                        style: VivTypography.eyebrow.copyWith(color: VivColors.gray500),
                      ),
                      const SizedBox(height: VivSpacing.space3),
                      ...chapters.map((chapter) => Padding(
                            padding: const EdgeInsets.only(bottom: VivSpacing.space4),
                            child: _buildChapterMobileCard(context, chapter),
                          )),
                      const SizedBox(height: VivSpacing.space5),
                      _buildRecentBookmarksWidget(context, ref, bookmarkedIds),
                      const SizedBox(height: VivSpacing.space6),
                      _buildUsefulLinksWidget(context),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: VivColors.black,
        borderRadius: BorderRadius.circular(VivSpacing.radiusLg),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          // Subtle lime accent visual
          Positioned(
            right: -100,
            top: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: VivColors.lime.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(VivSpacing.space8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'FORMATION EN COURS',
                  style: VivTypography.eyebrow.copyWith(color: VivColors.lime),
                ),
                const SizedBox(height: VivSpacing.space2),
                Text(
                  'Intitulé du programme de formation',
                  style: VivTypography.h1.copyWith(color: VivColors.paper),
                ),
                const SizedBox(height: VivSpacing.space3),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Text(
                    'Parcourez les chapitres pédagogiques interactifs, testez vos compétences avec les quiz et enregistrez vos points clés favoris.',
                    style: VivTypography.body.copyWith(
                      color: VivColors.gray300,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: VivSpacing.space6),
                ElevatedButton(
                  onPressed: () => context.go('/chapter-1'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: VivColors.lime,
                    foregroundColor: VivColors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: VivSpacing.space5,
                      vertical: VivSpacing.space4,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(VivSpacing.radiusMd),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(LucideIcons.play, size: 16),
                      const SizedBox(width: VivSpacing.space2),
                      Text(
                        'Commencer le Chapitre 1',
                        style: VivTypography.body.copyWith(
                          fontWeight: FontWeight.bold,
                          color: VivColors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChapterBentoCard(BuildContext context, DashboardChapterData chapter) {
    return Container(
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
        onTap: () => context.go(chapter.routePath),
        child: Padding(
          padding: const EdgeInsets.all(VivSpacing.space5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(VivSpacing.space2),
                    decoration: BoxDecoration(
                      color: VivColors.lime.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(VivSpacing.radiusSm),
                    ),
                    child: Icon(
                      chapter.icon,
                      color: VivColors.limeDeep,
                      size: 20,
                    ),
                  ),
                  Text(
                    'CHAPITRE 0${chapter.id}',
                    style: VivTypography.eyebrow.copyWith(
                      color: VivColors.gray400,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                chapter.title,
                style: VivTypography.h3.copyWith(fontSize: 16),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: VivSpacing.space2),
              Text(
                chapter.objective,
                style: VivTypography.small.copyWith(
                  color: VivColors.gray500,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    'Y ACCÉDER',
                    style: VivTypography.eyebrow.copyWith(
                      color: VivColors.limeDeep,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    LucideIcons.arrowRight,
                    color: VivColors.limeDeep,
                    size: 14,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChapterMobileCard(BuildContext context, DashboardChapterData chapter) {
    return Container(
      decoration: BoxDecoration(
        color: VivColors.paper,
        borderRadius: BorderRadius.circular(VivSpacing.radiusMd),
        border: Border.all(color: VivColors.gray200),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(VivSpacing.space4),
        leading: Container(
          padding: const EdgeInsets.all(VivSpacing.space2),
          decoration: BoxDecoration(
            color: VivColors.lime.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(VivSpacing.radiusSm),
          ),
          child: Icon(chapter.icon, color: VivColors.limeDeep, size: 20),
        ),
        title: Text(chapter.title, style: VivTypography.h3.copyWith(fontSize: 15)),
        subtitle: Text(
          chapter.objective,
          style: VivTypography.small.copyWith(color: VivColors.gray500),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Icon(LucideIcons.chevronRight, size: 16, color: VivColors.gray400),
        onTap: () => context.go(chapter.routePath),
      ),
    );
  }

  Widget _buildRecentBookmarksWidget(BuildContext context, WidgetRef ref, Set<String> bookmarkedIds) {
    BookmarkItemData? recentBookmark;

    BookmarkItemData? findBookmark(List<ContentModule> modules, String chapterTitle, String routePath) {
      if (bookmarkedIds.isEmpty) return null;
      final targetId = bookmarkedIds.last;
      for (var module in modules) {
        if (module.id == targetId) {
          return BookmarkItemData(
            chapterTitle: chapterTitle,
            chapterId: 0,
            routePath: routePath,
            module: module,
          );
        }
      }
      return null;
    }

    recentBookmark = findBookmark(basics101Modules, 'Basics 101', '/basics-101') ??
        findBookmark(chapter1Modules, 'Chapitre 1', '/chapter-1') ??
        findBookmark(chapter2Modules, 'Chapitre 2', '/chapter-2') ??
        findBookmark(chapter3Modules, 'Chapitre 3', '/chapter-3');

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(VivSpacing.space5),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(LucideIcons.bookmark, size: 18, color: VivColors.limeDeep),
              const SizedBox(width: VivSpacing.space2),
              Text(
                'SIGNET RÉCENT',
                style: VivTypography.eyebrow.copyWith(
                  color: VivColors.limeDeep,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: VivSpacing.space4),
          if (recentBookmark == null) ...[
            Text(
              'Aucun favori enregistré',
              style: VivTypography.body.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: VivSpacing.space1),
            Text(
              'Marquez des paragraphes ou quiz lors de votre lecture pour y accéder directement.',
              style: VivTypography.small.copyWith(color: VivColors.gray500),
            ),
          ] else ...[
            Text(
              _getModuleTitle(recentBookmark.module),
              style: VivTypography.body.copyWith(
                fontWeight: FontWeight.bold,
                color: VivColors.ink,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: VivSpacing.space1),
            Text(
              recentBookmark.chapterTitle,
              style: VivTypography.small.copyWith(color: VivColors.gray500),
            ),
            const SizedBox(height: VivSpacing.space4),
            ElevatedButton(
              onPressed: () {
                context.go('${recentBookmark!.routePath}?target=${recentBookmark.module.id}');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: VivColors.black,
                foregroundColor: VivColors.paper,
                elevation: 0,
                minimumSize: const Size(double.infinity, 38),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(VivSpacing.radiusSm),
                ),
              ),
              child: Text(
                'Y retourner',
                style: VivTypography.small.copyWith(
                  color: VivColors.paper,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildUsefulLinksWidget(BuildContext context) {
    Future<void> launchUrlHelper(String urlString) async {
      final url = Uri.parse(urlString);
      try {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } catch (e) {
        debugPrint('Erreur lors du lancement de l\'URL : $e');
      }
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(VivSpacing.space5),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(LucideIcons.link, size: 18, color: VivColors.limeDeep),
              const SizedBox(width: VivSpacing.space2),
              Text(
                'RESSOURCES UTILES',
                style: VivTypography.eyebrow.copyWith(
                  color: VivColors.limeDeep,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: VivSpacing.space4),
          _buildLinkItem(
            icon: LucideIcons.fileText,
            label: 'Documentation de référence',
            onTap: () => launchUrlHelper('https://example.com'),
          ),
          const Divider(height: 16),
          _buildLinkItem(
            icon: LucideIcons.download,
            label: 'Téléchargement des outils',
            onTap: () => launchUrlHelper('https://example.com'),
          ),
        ],
      ),
    );
  }

  Widget _buildLinkItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(VivSpacing.radiusSm),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: VivSpacing.space2, horizontal: VivSpacing.space1),
        child: Row(
          children: [
            Icon(icon, size: 16, color: VivColors.gray500),
            const SizedBox(width: VivSpacing.space3),
            Expanded(
              child: Text(
                label,
                style: VivTypography.body.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: VivColors.ink,
                ),
              ),
            ),
            const Icon(LucideIcons.externalLink, size: 12, color: VivColors.gray400),
          ],
        ),
      ),
    );
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
