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
      title: 'Chapitre 1 : Fondamentaux du Shading & LookDev',
      objective: 'Comprendre le shading physique PBR, manipuler l\'éditeur de nœuds et le Principled BSDF, et créer des matériaux procéduraux.',
      icon: LucideIcons.palette,
      routePath: '/chapter-1',
      points: [
        ChapterPoint(label: 'Le shading physique (PBR)', targetModuleId: 'ch1_sec1_title'),
        ChapterPoint(label: 'L\'éditeur de nœuds', targetModuleId: 'ch1_sec2_title'),
        ChapterPoint(label: 'Le Principled BSDF en détail', targetModuleId: 'ch1_sec3_title'),
        ChapterPoint(label: 'Finitions industrielles types', targetModuleId: 'ch1_sec4_title'),
        ChapterPoint(label: 'Les nœuds de réglage', targetModuleId: 'ch1_sec5_title'),
        ChapterPoint(label: 'Masques procéduraux', targetModuleId: 'ch1_sec6_title'),
      ],
    ),
    Chapter(
      id: 2,
      title: 'Chapitre 2 : Texturage Agile & Gestion Simplifiée des UVs',
      objective: 'Comprendre les coordonnées UV, maîtriser le dépliage automatique Smart UV Project, utiliser la projection Box sans UV et organiser ses matériaux avec l\'Asset Browser.',
      icon: LucideIcons.layers,
      routePath: '/chapter-2',
      points: [
        ChapterPoint(label: 'Comprendre les UV', targetModuleId: 'ch2_sec1_title'),
        ChapterPoint(label: 'Le dépliage automatique', targetModuleId: 'ch2_sec2_title'),
        ChapterPoint(label: 'Texturer sans UV : projection Box', targetModuleId: 'ch2_sec3_title'),
        ChapterPoint(label: 'Maîtriser le Mapping', targetModuleId: 'ch2_sec4_title'),
        ChapterPoint(label: 'Choisir la bonne méthode', targetModuleId: 'ch2_sec5_title'),
        ChapterPoint(label: 'L\'Asset Browser', targetModuleId: 'ch2_sec6_title'),
      ],
    ),
    Chapter(
      id: 3,
      title: 'Chapitre 3 : Mise en lumière & Méthodes de Rendu',
      objective: 'Comparer EEVEE et Cycles, mettre en œuvre un éclairage studio trois points ou HDRI, optimiser les paramètres de rendu et cadrer avec la caméra physique.',
      icon: LucideIcons.lightbulb,
      routePath: '/chapter-3',
      points: [
        ChapterPoint(label: 'Les moteurs EEVEE et Cycles', targetModuleId: 'ch3_sec1_title'),
        ChapterPoint(label: 'Sources de lumière', targetModuleId: 'ch3_sec2_title'),
        ChapterPoint(label: 'Éclairage de studio (CMF)', targetModuleId: 'ch3_sec3_title'),
        ChapterPoint(label: 'Éclairage HDRI', targetModuleId: 'ch3_sec4_title'),
        ChapterPoint(label: 'Paramètres des moteurs', targetModuleId: 'ch3_sec5_title'),
        ChapterPoint(label: 'Caméra physique', targetModuleId: 'ch3_sec6_title'),
      ],
    ),
    Chapter(
      id: 4,
      title: 'Chapitre 4 : Post-production & Finalisation de l\'Image',
      objective: 'Comprendre le fonctionnement non destructif du compositeur par nœuds, régler l\'exposition AgX, générer un effet de bloom avec le nœud Glare, isoler des composantes avec les passes de rendu et exporter au format adapté.',
      icon: LucideIcons.sparkles,
      routePath: '/chapter-4',
      points: [
        ChapterPoint(label: 'Le compositing dans Blender', targetModuleId: 'ch4_sec1_title'),
        ChapterPoint(label: 'Exposition, contraste et bloom', targetModuleId: 'ch4_sec2_title'),
        ChapterPoint(label: 'Les passes de rendu', targetModuleId: 'ch4_sec3_title'),
        ChapterPoint(label: 'Exporter en haute définition', targetModuleId: 'ch4_sec4_title'),
        ChapterPoint(label: 'Atelier : visuels « Beauté »', targetModuleId: 'ch4_sec5_title'),
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
            'Matériaux et rendu dans Blender : les fondamentaux',
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
