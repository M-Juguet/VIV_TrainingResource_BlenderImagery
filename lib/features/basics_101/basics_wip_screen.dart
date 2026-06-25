import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../core/theme/viv_colors.dart';
import '../../core/theme/viv_spacing.dart';
import '../../core/theme/viv_typography.dart';

/// Parameterizable 'Work in Progress' screen for any Basics chapter.
///
/// Shows a premium dark banner with the chapter title and a
/// footer note explaining the content is a free supplement.
class BasicsWipScreen extends StatelessWidget {
  final int chapterNumber;
  final String title;

  const BasicsWipScreen({
    super.key,
    required this.chapterNumber,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VivColors.offWhite,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(VivSpacing.space6),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildWipBanner(),
                const SizedBox(height: VivSpacing.space7),
                _buildFooterNote(),
                const SizedBox(height: VivSpacing.space6),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWipBanner() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: VivColors.black,
        borderRadius: BorderRadius.circular(VivSpacing.radiusLg),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          // Decorative lime accent — top-right
          Positioned(
            right: -60,
            top: -60,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                color: VivColors.lime.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Decorative lime accent — bottom-left
          Positioned(
            left: -40,
            bottom: -50,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                color: VivColors.lime.withValues(alpha: 0.06),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(VivSpacing.space7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Pill badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: VivSpacing.space4,
                    vertical: VivSpacing.space2,
                  ),
                  decoration: BoxDecoration(
                    color: VivColors.lime.withValues(alpha: 0.15),
                    borderRadius:
                        BorderRadius.circular(VivSpacing.radiusPill),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        LucideIcons.hardHat,
                        color: VivColors.lime,
                        size: 14,
                      ),
                      const SizedBox(width: VivSpacing.space2),
                      Text(
                        'CONTENU EN PRÉPARATION',
                        style: VivTypography.eyebrow.copyWith(
                          color: VivColors.lime,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: VivSpacing.space5),
                // Chapter title
                Text(
                  'Chapitre $chapterNumber — $title',
                  style: VivTypography.h2.copyWith(
                    color: VivColors.paper,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: VivSpacing.space3),
                // Subtitle
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: Text(
                    'Ce chapitre est en cours de rédaction et sera '
                    'disponible dans une prochaine mise à jour.',
                    style: VivTypography.body.copyWith(
                      color: VivColors.gray300,
                      fontWeight: FontWeight.w500,
                      height: 1.7,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterNote() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(VivSpacing.space5),
      decoration: BoxDecoration(
        color: VivColors.green100.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(VivSpacing.radiusMd),
        border: Border.all(
          color: VivColors.green300.withValues(alpha: 0.6),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            LucideIcons.info,
            size: 16,
            color: VivColors.limeDeep,
          ),
          const SizedBox(width: VivSpacing.space3),
          Expanded(
            child: Text(
              'Ces chapitres constituent un supplément gratuit à la '
              'formation principale. Leur progression n\'est pas '
              'comptabilisée dans l\'avancement global du programme.',
              style: VivTypography.small.copyWith(
                color: VivColors.ink700,
                fontWeight: FontWeight.w500,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
