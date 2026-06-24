import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../models/content_module.dart';
import '../theme/viv_colors.dart';
import '../theme/viv_spacing.dart';
import '../theme/viv_typography.dart';
import 'modules/info_module_widget.dart';
import 'modules/resource_module_widget.dart';
import 'modules/quiz_module_widget.dart';

class ContentModuleRenderer extends StatelessWidget {
  final ContentModule module;
  final bool isBookmarked;
  final VoidCallback? onBookmarkToggle;
  final Function(String path, String? caption)? onImageTap;

  const ContentModuleRenderer({
    super.key,
    required this.module,
    this.isBookmarked = false,
    this.onBookmarkToggle,
    this.onImageTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasBookmark = onBookmarkToggle != null && module is! TitleModule;

    return Padding(
      padding: const EdgeInsets.only(bottom: VivSpacing.space8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bookmark Action on the Left (more discrete)
          if (hasBookmark) ...[
            SizedBox(
              width: 28,
              height: 28,
              child: IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(
                  LucideIcons.bookmark,
                  color: isBookmarked ? VivColors.limeDeep : VivColors.gray300,
                  size: 16,
                ),
                onPressed: onBookmarkToggle,
                tooltip: isBookmarked ? 'Retirer des signets' : 'Ajouter aux signets',
              ),
            ),
            const SizedBox(width: VivSpacing.space2),
          ],

          // Render Main Content
          Expanded(
            child: _buildModuleContent(context),
          ),
        ],
      ),
    );
  }

  Widget _buildModuleContent(BuildContext context) {
    final mod = module;
    if (mod is TitleModule) {
      return Padding(
        padding: const EdgeInsets.only(top: VivSpacing.space4, bottom: VivSpacing.space2),
        child: Text(
          mod.title,
          style: VivTypography.h2,
        ),
      );
    } else if (mod is TextModule) {
      final paragraphs = mod.content.split('\n');
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (mod.title != null) ...[
            Text(mod.title!, style: VivTypography.h3),
            const SizedBox(height: VivSpacing.space3),
          ],
          ...paragraphs.where((p) => p.trim().isNotEmpty).map(
                (p) => Padding(
                  padding: const EdgeInsets.only(bottom: VivSpacing.space3),
                  child: Text(
                    p.trim(),
                    style: VivTypography.body.copyWith(color: VivColors.ink),
                  ),
                ),
              ),
        ],
      );
    } else if (mod is SideBySideModule) {
      final isTextLeft = mod.layout == ContentLayout.textLeft;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (mod.title != null) ...[
            Text(mod.title!, style: VivTypography.h3),
            const SizedBox(height: VivSpacing.space4),
          ],
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isTextLeft)
                Expanded(
                  child: Text(mod.content, style: VivTypography.body.copyWith(color: VivColors.ink)),
                ),
              if (isTextLeft) const SizedBox(width: VivSpacing.space6),
              Expanded(
                child: _buildClickableImage(context, mod.imagePath, mod.caption),
              ),
              if (!isTextLeft) const SizedBox(width: VivSpacing.space6),
              if (!isTextLeft)
                Expanded(
                  child: Text(mod.content, style: VivTypography.body.copyWith(color: VivColors.ink)),
                ),
            ],
          ),
        ],
      );
    } else if (mod is FullMediaModule) {
      return _buildClickableImage(context, mod.imagePath, mod.caption, isFullWidth: true);
    } else if (mod is InfoModule) {
      return InfoModuleWidget(module: mod);
    } else if (mod is ResourceModule) {
      return ResourceModuleWidget(module: mod);
    } else if (mod is ListModule) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(mod.title, style: VivTypography.h3),
          const SizedBox(height: VivSpacing.space3),
          if (mod.intro != null) ...[
            Text(mod.intro!, style: VivTypography.body.copyWith(color: VivColors.ink)),
            const SizedBox(height: VivSpacing.space3),
          ],
          ...mod.items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: VivSpacing.space2, left: VivSpacing.space1),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: const Icon(
                      LucideIcons.chevronRight,
                      color: VivColors.limeDeep,
                      size: 14,
                    ),
                  ),
                  const SizedBox(width: VivSpacing.space3),
                  Expanded(
                    child: Text(
                      item,
                      style: VivTypography.body.copyWith(
                        color: VivColors.ink,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (mod.outro != null) ...[
            const SizedBox(height: VivSpacing.space3),
            Text(mod.outro!, style: VivTypography.body.copyWith(color: VivColors.ink)),
          ],
        ],
      );
    } else if (mod is QuizModule) {
      return QuizModuleWidget(module: mod);
    }
    return const SizedBox.shrink();
  }

  Widget _buildClickableImage(BuildContext context, String imagePath, String? caption, {bool isFullWidth = false}) {
    return Column(
      crossAxisAlignment: isFullWidth ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: onImageTap != null ? () => onImageTap!(imagePath, caption) : null,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(VivSpacing.radiusMd),
                border: Border.all(color: VivColors.gray200),
                color: VivColors.offWhite,
              ),
              clipBehavior: Clip.hardEdge,
              constraints: BoxConstraints(
                maxHeight: isFullWidth ? 450.0 : 300.0,
              ),
              child: imagePath.startsWith('http')
                  ? Image.network(
                      imagePath,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          _buildErrorPlaceholder(isFullWidth, imagePath),
                    )
                  : Image.asset(
                      imagePath,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          _buildErrorPlaceholder(isFullWidth, imagePath),
                    ),
            ),
          ),
        ),
        if (caption != null) ...[
          const SizedBox(height: VivSpacing.space2),
          Text(
            caption,
            style: VivTypography.small.copyWith(
              fontStyle: FontStyle.italic,
              color: VivColors.gray500,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildErrorPlaceholder(bool isFullWidth, String path) {
    return Container(
      height: isFullWidth ? 300 : 200,
      color: VivColors.offWhite,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            LucideIcons.image,
            color: VivColors.gray400,
            size: 36,
          ),
          const SizedBox(height: 8),
          Text(
            'Média Placeholder\n($path)',
            textAlign: TextAlign.center,
            style: VivTypography.small.copyWith(color: VivColors.gray400),
          ),
        ],
      ),
    );
  }
}
