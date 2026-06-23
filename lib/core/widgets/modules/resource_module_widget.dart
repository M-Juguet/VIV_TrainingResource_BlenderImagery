import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shadcn_ui/shadcn_ui.dart' hide LucideIcons;

import '../../../core/models/content_module.dart';
import '../../../core/theme/viv_colors.dart';
import '../../../core/theme/viv_spacing.dart';
import '../../../core/theme/viv_typography.dart';

class ResourceModuleWidget extends StatelessWidget {
  final ResourceModule module;

  const ResourceModuleWidget({super.key, required this.module});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(VivSpacing.space5),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [VivColors.ink900, VivColors.ink700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(VivSpacing.radiusMd),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon Box
          Container(
            padding: const EdgeInsets.all(VivSpacing.space4),
            decoration: BoxDecoration(
              color: VivColors.paper.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(VivSpacing.radiusSm),
            ),
            child: Icon(
              LucideIcons.downloadCloud,
              color: VivColors.lime,
              size: 28,
            ),
          ),
          const SizedBox(width: VivSpacing.space4),
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  module.title.toUpperCase(),
                  style: VivTypography.eyebrow.copyWith(
                    color: VivColors.lime,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  module.fileName,
                  style: VivTypography.h4.copyWith(
                    color: VivColors.paper,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  module.description,
                  style: VivTypography.small.copyWith(
                    color: VivColors.gray300,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: VivSpacing.space4),
          // Action Button
          ShadButton(
            onPressed: () async {
              final uri = Uri.parse(module.downloadUrl);
              try {
                if (await canLaunchUrl(uri)) {
                  await launchUrl(
                    uri,
                    mode: LaunchMode.externalApplication,
                  );
                }
              } catch (e) {
                // error handling
              }
            },
            backgroundColor: VivColors.lime,
            hoverBackgroundColor: VivColors.green300,
            child: Row(
              children: [
                Text(
                  'RÉCUPÉRER',
                  style: VivTypography.small.copyWith(
                    color: VivColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  LucideIcons.externalLink,
                  size: 14,
                  color: VivColors.black,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
