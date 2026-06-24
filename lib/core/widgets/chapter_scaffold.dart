import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/content_module.dart';
import 'content_module_renderer.dart';
import 'chapter_outline_widget.dart';
import '../theme/viv_colors.dart';
import '../theme/viv_spacing.dart';
import '../theme/viv_typography.dart';
import '../router/app_router.dart';
import '../storage/bookmarks_provider.dart';
import '../storage/chapter_progress_provider.dart';

class ChapterScaffold extends ConsumerStatefulWidget {
  final String title;
  final List<ContentModule> modules;
  final String? targetModuleId;
  final int branchIndex;

  const ChapterScaffold({
    super.key,
    required this.title,
    required this.modules,
    this.targetModuleId,
    required this.branchIndex,
  });

  @override
  ConsumerState<ChapterScaffold> createState() => _ChapterScaffoldState();
}

class _ChapterScaffoldState extends ConsumerState<ChapterScaffold> {
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _moduleKeys = {};
  String? _activeModuleId;

  @override
  void initState() {
    super.initState();
    _scrollToTarget();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _onScroll();
    });
  }

  @override
  void didUpdateWidget(ChapterScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.targetModuleId != oldWidget.targetModuleId) {
      _scrollToTarget();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!mounted) return;

    String? newActiveId;
    double bestDy = -double.infinity;
    const double threshold = 200.0; // Seuil sous la top bar pour considérer un module actif

    for (var entry in _moduleKeys.entries) {
      final context = entry.value.currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox?;
        if (box != null && box.hasSize) {
          final position = box.localToGlobal(Offset.zero);
          final dy = position.dy;
          if (dy <= threshold && dy > bestDy) {
            bestDy = dy;
            newActiveId = entry.key;
          }
        }
      }
    }

    if (newActiveId == null && _moduleKeys.isNotEmpty) {
      newActiveId = _moduleKeys.keys.first;
    }

    if (newActiveId != _activeModuleId) {
      setState(() {
        _activeModuleId = newActiveId;
      });
    }
  }

  void _scrollToTarget() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (!mounted) return;
        if (widget.targetModuleId != null) {
          final key = _moduleKeys[widget.targetModuleId];
          if (key != null && key.currentContext != null) {
            Scrollable.ensureVisible(
              key.currentContext!,
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOutCubic,
              alignment: 0.15, // Espace par rapport au haut de l'écran
            );
          }
        } else {
          // Remonter en haut de la page si aucun module cible n'est spécifié
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              0.0,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<int>(activeBranchIndexProvider, (previous, current) {
      if (current == widget.branchIndex) {
        _scrollToTarget();
      }
    });

    final bookmarks = ref.watch(bookmarksProvider);

    return Stack(
      children: [
        // Main scrollable content
        Positioned.fill(
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.only(
              top: VivSpacing.space6,
              bottom: VivSpacing.space6,
              right: 80, // Marge de respiration pour le sommaire
            ),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 800),
                padding: const EdgeInsets.symmetric(horizontal: VivSpacing.space6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPreviousButton(context),
                    ...widget.modules.map((module) {
                      _moduleKeys.putIfAbsent(module.id, () => GlobalKey());
                      final isBookmarked = bookmarks.contains(module.id);
                      return Container(
                        key: _moduleKeys[module.id],
                        child: ContentModuleRenderer(
                          module: module,
                          isBookmarked: isBookmarked,
                          onBookmarkToggle: () {
                            ref.read(bookmarksProvider.notifier).toggleBookmark(module.id);
                          },
                          onImageTap: (path, caption) {
                            _showFullscreenImage(context, path, caption);
                          },
                        ),
                      );
                    }),
                    _buildBottomActions(context, ref),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Sticky Outline Navigation on the right
        Positioned(
          top: VivSpacing.space6,
          right: VivSpacing.space4,
          child: ChapterOutlineWidget(
            modules: widget.modules,
            activeModuleId: _activeModuleId,
            onNavigate: (moduleId) {
              final key = _moduleKeys[moduleId];
              if (key != null && key.currentContext != null) {
                Scrollable.ensureVisible(
                  key.currentContext!,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOutCubic,
                  alignment: 0.15,
                );
              }
            },
          ),
        ),
      ],
    );
  }

  void _showFullscreenImage(BuildContext context, String imagePath, String? caption) {
    final isNetwork = imagePath.startsWith('http');
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Fermer la visionneuse',
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Positioned.fill(
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      color: Colors.black.withValues(alpha: 0.65),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(VivSpacing.space6),
                    child: InteractiveViewer(
                      minScale: 0.8,
                      maxScale: 5.0,
                      clipBehavior: Clip.none,
                      child: isNetwork
                          ? CachedNetworkImage(
                              imageUrl: imagePath,
                              fit: BoxFit.contain,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                              errorWidget: (context, url, error) => Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    LucideIcons.cloudOff,
                                    color: Colors.white30,
                                    size: 64,
                                  ),
                                  const SizedBox(height: VivSpacing.space3),
                                  Text(
                                    'Image indisponible hors ligne',
                                    style: VivTypography.body.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: VivSpacing.space2),
                                  Text(
                                    'Cette image sera automatiquement mise en cache lors de sa première consultation en ligne afin d\'être visible hors ligne.',
                                    style: VivTypography.small.copyWith(
                                      color: Colors.white70,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            )
                          : Image.asset(
                              imagePath,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(LucideIcons.image, size: 64, color: Colors.white30),
                            ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: VivSpacing.space6,
                right: VivSpacing.space6,
                child: ClipOval(
                  child: Material(
                    color: Colors.white.withValues(alpha: 0.1),
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Icon(
                          LucideIcons.x,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (caption != null && caption.isNotEmpty)
                Positioned(
                  left: VivSpacing.space6,
                  right: VivSpacing.space6,
                  bottom: VivSpacing.space8,
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(VivSpacing.radiusLg),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(VivSpacing.radiusLg),
                            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                          ),
                          child: Text(
                            caption,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.95, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
            ),
            child: child,
          ),
        );
      },
    );
  }

  String _getPathForBranchIndex(int index) {
    switch (index) {
      case 3:
        return '/basics-101';
      case 4:
        return '/chapter-1';
      case 5:
        return '/chapter-2';
      case 6:
        return '/chapter-3';
      default:
        return '/dashboard';
    }
  }

  String _getTitleForBranchIndex(int index) {
    switch (index) {
      case 3:
        return 'Basics 101';
      case 4:
        return 'Shading & LookDev';
      case 5:
        return 'Chapitre 2';
      case 6:
        return 'Chapitre 3';
      default:
        return '';
    }
  }

  Widget _buildPreviousButton(BuildContext context) {
    if (widget.branchIndex <= 3) return const SizedBox.shrink();

    final prevIndex = widget.branchIndex - 1;
    final prevTitle = _getTitleForBranchIndex(prevIndex);
    final prevPath = _getPathForBranchIndex(prevIndex);

    return Padding(
      padding: const EdgeInsets.only(bottom: VivSpacing.space4),
      child: TextButton.icon(
        onPressed: () => context.go(prevPath),
        icon: const Icon(LucideIcons.chevronLeft, size: 16, color: VivColors.gray500),
        label: Text(
          'Chapitre précédent : $prevTitle',
          style: VivTypography.small.copyWith(
            color: VivColors.gray500,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
    );
  }

  Widget _buildBottomActions(BuildContext context, WidgetRef ref) {
    final currentPath = _getPathForBranchIndex(widget.branchIndex);
    final completedChapters = ref.watch(chapterProgressProvider);
    final isCompleted = completedChapters.contains(currentPath);

    final hasNext = widget.branchIndex < 6;
    final nextIndex = widget.branchIndex + 1;
    final nextTitle = _getTitleForBranchIndex(nextIndex);
    final nextPath = _getPathForBranchIndex(nextIndex);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: VivSpacing.space6),
        const Divider(color: VivColors.gray200, height: 1),
        const SizedBox(height: VivSpacing.space6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              child: ElevatedButton.icon(
                onPressed: () {
                  ref.read(chapterProgressProvider.notifier).toggleCompletion(currentPath);
                },
                icon: Icon(
                  isCompleted ? LucideIcons.check : LucideIcons.square,
                  size: 16,
                  color: isCompleted ? VivColors.limeDeep : VivColors.gray500,
                ),
                label: Text(
                  isCompleted ? 'Complété !' : 'Marquer comme terminé',
                  style: TextStyle(
                    color: isCompleted ? VivColors.limeDeep : VivColors.ink700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isCompleted
                      ? VivColors.lime.withValues(alpha: 0.15)
                      : VivColors.paper,
                  foregroundColor: isCompleted ? VivColors.limeDeep : VivColors.ink700,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: VivSpacing.space4,
                    vertical: VivSpacing.space3,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(VivSpacing.radiusMd),
                    side: BorderSide(
                      color: isCompleted
                          ? VivColors.lime.withValues(alpha: 0.3)
                          : VivColors.gray300,
                    ),
                  ),
                ),
              ),
            ),
            if (hasNext)
              ElevatedButton.icon(
                onPressed: () => context.go(nextPath),
                icon: const Icon(LucideIcons.arrowRight, size: 16, color: VivColors.black),
                label: Text(
                  'Chapitre suivant : $nextTitle',
                  style: const TextStyle(
                    color: VivColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: VivColors.lime,
                  foregroundColor: VivColors.black,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: VivSpacing.space4,
                    vertical: VivSpacing.space3,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(VivSpacing.radiusMd),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
