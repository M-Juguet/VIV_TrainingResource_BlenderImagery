import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../core/models/content_module.dart';
import '../../../core/theme/viv_colors.dart';
import '../../../core/theme/viv_spacing.dart';
import '../../../core/theme/viv_typography.dart';

class InfoModuleWidget extends StatelessWidget {
  final InfoModule module;

  const InfoModuleWidget({super.key, required this.module});

  @override
  Widget build(BuildContext context) {
    Color primaryColor;
    IconData icon;
    String label;

    switch (module.type) {
      case InfoType.idea:
        primaryColor = Colors.amber.shade700;
        icon = LucideIcons.lightbulb;
        label = "IDÉE";
        break;
      case InfoType.tip:
        primaryColor = Colors.purple.shade400;
        icon = LucideIcons.sparkles;
        label = "CONSEIL EXPERT";
        break;
      case InfoType.warning:
        primaryColor = Colors.redAccent.shade400;
        icon = LucideIcons.alertTriangle;
        label = "ATTENTION";
        break;
      case InfoType.info:
        primaryColor = Colors.blue.shade600;
        icon = LucideIcons.info;
        label = "INFORMATION";
        break;
      case InfoType.objective:
        primaryColor = VivColors.limeDeep;
        icon = LucideIcons.target;
        label = "OBJECTIF";
        break;
      case InfoType.challenge:
        primaryColor = Colors.orange.shade800;
        icon = LucideIcons.flag;
        label = "DÉFI FIL ROUGE";
        break;
    }

    return Container(
      padding: const EdgeInsets.all(VivSpacing.space5),
      decoration: BoxDecoration(
        color: primaryColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(VivSpacing.radiusMd),
        border: Border.all(
          color: primaryColor.withValues(alpha: 0.15),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, color: primaryColor, size: 22),
              const SizedBox(width: VivSpacing.space3),
              Text(
                '$label :',
                style: VivTypography.eyebrow.copyWith(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: VivSpacing.space2),
          Padding(
            padding: const EdgeInsets.only(left: 34), // Icon size 22 + spacing 12
            child: Text(
              module.text,
              style: VivTypography.body.copyWith(
                color: VivColors.ink800,
                fontSize: 15,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
