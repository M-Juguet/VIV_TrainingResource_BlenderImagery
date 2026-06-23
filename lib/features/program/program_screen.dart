import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/viv_colors.dart';
import '../../core/theme/viv_spacing.dart';
import '../../core/theme/viv_typography.dart';

class ChapterPoint {
  final String label;
  final String targetModuleId;

  const ChapterPoint({
    required this.label,
    required this.targetModuleId,
  });
}

class Chapter {
  final int id;
  final String title;
  final String objective;
  final IconData icon;
  final String routePath;
  final List<ChapterPoint> points;

  const Chapter({
    required this.id,
    required this.title,
    required this.objective,
    required this.icon,
    required this.routePath,
    required this.points,
  });
}

class ProgramScreen extends StatelessWidget {
  const ProgramScreen({super.key});

  static const List<Chapter> chapters = [
    Chapter(
      id: 1,
      title: 'Chapitre 1',
      objective: 'Objectif pédagogique du premier chapitre. Description des compétences clés à acquérir lors de cette introduction.',
      icon: LucideIcons.film,
      routePath: '/chapter-1',
      points: [
        ChapterPoint(label: 'Analyse globale', targetModuleId: 'ch1_text1'),
        ChapterPoint(label: 'Représentation visuelle', targetModuleId: 'ch1_side'),
        ChapterPoint(label: 'Note d\'information', targetModuleId: 'ch1_info'),
      ],
    ),
    Chapter(
      id: 2,
      title: 'Chapitre 2',
      objective: 'Objectif pédagogique du second chapitre. Approfondissement des notions théoriques et mise en pratique.',
      icon: LucideIcons.shapes,
      routePath: '/chapter-2',
      points: [
        ChapterPoint(label: 'Approfondissement théorique', targetModuleId: 'ch2_text1'),
        ChapterPoint(label: 'Illustration média', targetModuleId: 'ch2_media'),
        ChapterPoint(label: 'Avertissement et vigilance', targetModuleId: 'ch2_warning'),
        ChapterPoint(label: 'Ressource d\'accompagnement', targetModuleId: 'ch2_resource'),
      ],
    ),
    Chapter(
      id: 3,
      title: 'Chapitre 3',
      objective: 'Objectif pédagogique du troisième chapitre. Finalisation des compétences, validation des acquis et projet pratique.',
      icon: LucideIcons.image,
      routePath: '/chapter-3',
      points: [
        ChapterPoint(label: 'Synthèse des acquis', targetModuleId: 'ch3_text1'),
        ChapterPoint(label: 'Défi d\'apprentissage', targetModuleId: 'ch3_challenge'),
        ChapterPoint(label: 'Quiz de validation', targetModuleId: 'ch3_quiz'),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(VivSpacing.space6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Text(
            'PROGRAMME DE FORMATION',
            style: VivTypography.eyebrow.copyWith(color: VivColors.limeDeep),
          ),
          const SizedBox(height: VivSpacing.space2),
          Text(
            'Intitulé du programme de formation',
            style: VivTypography.h1,
          ),
          const SizedBox(height: VivSpacing.space3),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Text(
              'Parcourez le programme détaillé de cette formation. Ce parcours pédagogique structuré est conçu pour guider les apprenants étape par étape dans l\'acquisition de compétences opérationnelles spécifiques.',
              style: VivTypography.lead.copyWith(color: VivColors.gray500),
            ),
          ),
          const SizedBox(height: VivSpacing.space7),

          // Chapters List
          Column(
            children: chapters.map((chapter) => _buildChapterCard(context, chapter)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildChapterCard(BuildContext context, Chapter chapter) {
    return Container(
      margin: const EdgeInsets.only(bottom: VivSpacing.space6),
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
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Left visual accent indicator
              Container(
                width: 6,
                color: VivColors.lime,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(VivSpacing.space6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Badge and Icon
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: VivSpacing.space3,
                              vertical: VivSpacing.space1,
                            ),
                            decoration: BoxDecoration(
                              color: VivColors.black,
                              borderRadius: BorderRadius.circular(VivSpacing.radiusSm),
                            ),
                            child: Text(
                              'CHAPITRE 0${chapter.id}',
                              style: VivTypography.eyebrow.copyWith(
                                color: VivColors.paper,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Icon(
                            chapter.icon,
                            color: VivColors.gray400,
                            size: 24,
                          ),
                        ],
                      ),
                      const SizedBox(height: VivSpacing.space4),

                      // Title
                      Text(
                        chapter.title,
                        style: VivTypography.h3,
                      ),
                      const SizedBox(height: VivSpacing.space2),

                      // Objective
                      Text(
                        chapter.objective,
                        style: VivTypography.body.copyWith(
                          color: VivColors.ink700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: VivSpacing.space5),

                      // Divider
                      Divider(
                        color: VivColors.gray100,
                        height: 1,
                      ),
                      const SizedBox(height: VivSpacing.space4),

                      // Key Points Title
                      Text(
                        'Points clés au programme :',
                        style: VivTypography.small.copyWith(
                          fontWeight: FontWeight.bold,
                          color: VivColors.black,
                        ),
                      ),
                      const SizedBox(height: VivSpacing.space3),

                      // Key Points List
                      Wrap(
                        spacing: VivSpacing.space4,
                        runSpacing: VivSpacing.space2,
                        children: chapter.points.map((point) => _buildKeyPointItem(context, chapter, point)).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKeyPointItem(BuildContext context, Chapter chapter, ChapterPoint point) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          context.go('${chapter.routePath}?target=${point.targetModuleId}');
        },
        borderRadius: BorderRadius.circular(VivSpacing.radiusSm),
        hoverColor: VivColors.gray100,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: VivSpacing.space3,
            vertical: VivSpacing.space2,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(VivSpacing.radiusSm),
            border: Border.all(color: VivColors.gray200),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                LucideIcons.check,
                color: VivColors.green600,
                size: 14,
              ),
              const SizedBox(width: VivSpacing.space2),
              Text(
                point.label,
                style: VivTypography.small.copyWith(
                  color: VivColors.ink,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
