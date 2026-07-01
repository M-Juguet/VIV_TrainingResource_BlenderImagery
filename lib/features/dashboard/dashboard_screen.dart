import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/theme/viv_colors.dart';
import '../../core/theme/viv_spacing.dart';
import '../../core/theme/viv_typography.dart';
import '../../core/storage/bookmarks_provider.dart';
import '../../core/storage/chapter_progress_provider.dart';
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
      title: 'Chapitre 1 : Fondamentaux du Shading & LookDev',
      objective: 'Maîtrisez les concepts clés du shading PBR, le Shader Editor et le nœud universel Principled BSDF.',
      icon: LucideIcons.palette,
      routePath: '/chapter-1',
    ),
    DashboardChapterData(
      id: 2,
      title: 'Chapitre 2 : Texturage Agile & Gestion Simplifiée des UVs',
      objective: 'Maîtrisez le dépliage UV (Smart UV Project), le mapping de textures, la projection Box et l\'Asset Browser.',
      icon: LucideIcons.layers,
      routePath: '/chapter-2',
    ),
    DashboardChapterData(
      id: 3,
      title: 'Chapitre 3 : Mise en lumière & Méthodes de Rendu',
      objective: 'Maîtrisez les moteurs EEVEE/Cycles, l\'éclairage de studio, les environnements HDRI et le paramétrage caméra.',
      icon: LucideIcons.lightbulb,
      routePath: '/chapter-3',
    ),
    DashboardChapterData(
      id: 4,
      title: 'Chapitre 4 : Post-production & Finalisation de l\'Image',
      objective: 'Maîtrisez le compositing par nœuds, l\'exposition AgX, le bloom (Glare), les passes de rendu et l\'exportation HD.',
      icon: LucideIcons.sparkles,
      routePath: '/chapter-4',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarkedIds = ref.watch(bookmarksProvider);
    final completedChapters = ref.watch(chapterProgressProvider);

    final allPaths = ['/basics-101', '/chapter-1', '/chapter-2', '/chapter-3', '/chapter-4'];
    final completedCount = allPaths.where((p) => completedChapters.contains(p)).length;
    final double progressPercent = completedCount / 5.0;

    return Scaffold(
      backgroundColor: Colors.transparent, // Car affiché dans le viewport de MainShell
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(VivSpacing.space6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Bandeau Héro d'accueil (Accès direct au Chapitre 1)
            _buildHeroSection(context, completedCount, progressPercent, completedChapters),
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
                              itemBuilder: (context, index) => _buildChapterBentoCard(
                                context,
                                chapters[index],
                                completedChapters.contains(chapters[index].routePath),
                              ),
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
                            child: _buildChapterMobileCard(
                              context,
                              chapter,
                              completedChapters.contains(chapter.routePath),
                            ),
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

  Widget _buildHeroSection(
    BuildContext context,
    int completedCount,
    double progressPercent,
    Set<String> completedChapters,
  ) {
    String nextTargetPath = '/chapter-1';
    String buttonText = 'Commencer le Chapitre 1';
    IconData buttonIcon = LucideIcons.play;

    if (!completedChapters.contains('/chapter-1')) {
      nextTargetPath = '/chapter-1';
      buttonText = 'Commencer le Chapitre 1';
      buttonIcon = LucideIcons.play;
    } else if (!completedChapters.contains('/chapter-2')) {
      nextTargetPath = '/chapter-2';
      buttonText = 'Continuer au Chapitre 2';
      buttonIcon = LucideIcons.arrowRight;
    } else if (!completedChapters.contains('/chapter-3')) {
      nextTargetPath = '/chapter-3';
      buttonText = 'Continuer au Chapitre 3';
      buttonIcon = LucideIcons.arrowRight;
    } else if (!completedChapters.contains('/chapter-4')) {
      nextTargetPath = '/chapter-4';
      buttonText = 'Continuer au Chapitre 4';
      buttonIcon = LucideIcons.arrowRight;
    } else if (!completedChapters.contains('/basics-101')) {
      nextTargetPath = '/basics-101';
      buttonText = 'Étudier Découverte & Prise en main';
      buttonIcon = LucideIcons.mousePointer;
    } else {
      nextTargetPath = '/program';
      buttonText = 'Voir le programme complet';
      buttonIcon = LucideIcons.bookOpen;
    }

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
                  'Matériaux et rendu dans Blender : les fondamentaux',
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
                const SizedBox(height: VivSpacing.space5),
                // Progression indicators
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Progression globale : $completedCount/4 chapitres',
                            style: VivTypography.small.copyWith(
                              color: VivColors.gray300,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${(progressPercent * 100).toInt()}%',
                            style: VivTypography.small.copyWith(
                              color: VivColors.lime,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: VivSpacing.space2),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(VivSpacing.radiusSm),
                        child: LinearProgressIndicator(
                          value: progressPercent,
                          backgroundColor: Colors.white.withValues(alpha: 0.1),
                          valueColor: const AlwaysStoppedAnimation<Color>(VivColors.lime),
                          minHeight: 6,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: VivSpacing.space6),
                ElevatedButton(
                  onPressed: () => context.go(nextTargetPath),
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
                      Icon(buttonIcon, size: 16),
                      const SizedBox(width: VivSpacing.space2),
                      Text(
                        buttonText,
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

  Widget _buildChapterBentoCard(
    BuildContext context,
    DashboardChapterData chapter,
    bool isCompleted,
  ) {
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
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isCompleted) ...[
                        const Icon(
                          LucideIcons.check,
                          color: VivColors.limeDeep,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                      ],
                      Text(
                        isCompleted ? 'COMPLÉTÉ' : 'CHAPITRE 0${chapter.id}',
                        style: VivTypography.eyebrow.copyWith(
                          color: isCompleted ? VivColors.limeDeep : VivColors.gray400,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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

  Widget _buildChapterMobileCard(
    BuildContext context,
    DashboardChapterData chapter,
    bool isCompleted,
  ) {
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
        trailing: isCompleted
            ? const Icon(LucideIcons.check, size: 16, color: VivColors.limeDeep)
            : const Icon(LucideIcons.chevronRight, size: 16, color: VivColors.gray400),
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

    recentBookmark = findBookmark(basics101Modules, 'Découverte & Prise en main', '/basics-101') ??
        findBookmark(chapter1Modules, 'Fondamentaux du Shading & LookDev', '/chapter-1') ??
        findBookmark(chapter2Modules, 'Texturage Agile & Gestion Simplifiée des UVs', '/chapter-2') ??
        findBookmark(chapter3Modules, 'Mise en lumière & Méthodes de Rendu', '/chapter-3') ??
        findBookmark(chapter4Modules, 'Post-production & Finalisation de l\'Image', '/chapter-4');

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
            label: 'Documentation officielle',
            onTap: () => launchUrlHelper('https://docs.blender.org/manual/en/latest/'),
          ),
          const Divider(height: 16),
          _buildLinkItem(
            icon: LucideIcons.download,
            label: 'Télécharger Blender',
            onTap: () => launchUrlHelper('https://www.blender.org/download/'),
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
