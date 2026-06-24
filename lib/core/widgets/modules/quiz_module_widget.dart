import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shadcn_ui/shadcn_ui.dart' hide LucideIcons;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/models/content_module.dart';
import '../../../core/theme/viv_colors.dart';
import '../../../core/theme/viv_spacing.dart';
import '../../../core/theme/viv_typography.dart';

class QuizModuleWidget extends StatefulWidget {
  final QuizModule module;

  const QuizModuleWidget({super.key, required this.module});

  @override
  State<QuizModuleWidget> createState() => _QuizModuleWidgetState();
}

class _QuizModuleWidgetState extends State<QuizModuleWidget> {
  final Set<int> _selectedIndices = {};
  bool _isSubmitted = false;

  void _toggleOption(int index) {
    if (_isSubmitted) return;
    setState(() {
      if (_selectedIndices.contains(index)) {
        _selectedIndices.remove(index);
      } else {
        _selectedIndices.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isCorrect =
        _selectedIndices.length == widget.module.correctIndices.length &&
        _selectedIndices.every((i) => widget.module.correctIndices.contains(i));

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      padding: const EdgeInsets.all(VivSpacing.space6),
      decoration: BoxDecoration(
        color: VivColors.paper,
        borderRadius: BorderRadius.circular(VivSpacing.radiusMd),
        border: Border.all(color: VivColors.gray200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Badge
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
              'AUTO-ÉVALUATION',
              style: VivTypography.eyebrow.copyWith(
                color: VivColors.paper,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
          ),
          const SizedBox(height: VivSpacing.space4),

          // Question
          Text(
            widget.module.question,
            style: VivTypography.h3.copyWith(
              height: 1.3,
            ),
          ),
          const SizedBox(height: VivSpacing.space5),

          // Options List
          ...List.generate(widget.module.options.length, (index) {
            bool isSelected = _selectedIndices.contains(index);
            bool isActuallyCorrect = widget.module.correctIndices.contains(index);

            Color borderColor = VivColors.gray200;
            Color currentOptionBg = VivColors.paper;
            Color textOptionColor = VivColors.ink;

            if (_isSubmitted) {
              if (isActuallyCorrect) {
                borderColor = Colors.green.shade600;
                currentOptionBg = Colors.green.shade50.withValues(alpha: 0.5);
              } else if (isSelected) {
                borderColor = Colors.red.shade600;
                currentOptionBg = Colors.red.shade50.withValues(alpha: 0.5);
              }
            } else if (isSelected) {
              borderColor = VivColors.black;
              currentOptionBg = VivColors.offWhite;
              textOptionColor = VivColors.black;
            }

            return GestureDetector(
              onTap: () => _toggleOption(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(bottom: VivSpacing.space2),
                padding: const EdgeInsets.all(VivSpacing.space4),
                decoration: BoxDecoration(
                  color: currentOptionBg,
                  borderRadius: BorderRadius.circular(VivSpacing.radiusSm),
                  border: Border.all(color: borderColor, width: 1.5),
                ),
                child: Row(
                  children: [
                    // Circle indicator
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: isSelected ? VivColors.black : Colors.transparent,
                        border: Border.all(
                          color: isSelected ? VivColors.black : VivColors.gray400,
                          width: 2,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: isSelected
                          ? Icon(
                              LucideIcons.check,
                              size: 12,
                              color: VivColors.lime,
                            )
                          : null,
                    ),
                    const SizedBox(width: VivSpacing.space3),
                    Expanded(
                      child: Text(
                        widget.module.options[index],
                        style: VivTypography.body.copyWith(
                          color: textOptionColor,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: VivSpacing.space5),

          // Submit Button
          if (!_isSubmitted)
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ShadButton(
                onPressed: _selectedIndices.isEmpty
                    ? null
                    : () => setState(() => _isSubmitted = true),
                backgroundColor: VivColors.black,
                hoverBackgroundColor: VivColors.ink700,
                child: Text(
                  'VÉRIFIER MES RÉPONSES',
                  style: VivTypography.small.copyWith(
                    fontWeight: FontWeight.bold,
                    color: _selectedIndices.isEmpty ? VivColors.gray400 : VivColors.lime,
                  ),
                ),
              ),
            ),

          if (_isSubmitted) _buildExplanationBlock(isCorrect),
        ],
      ),
    );
  }

  Widget _buildExplanationBlock(bool isSuccess) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      padding: const EdgeInsets.all(VivSpacing.space4),
      width: double.infinity,
      decoration: BoxDecoration(
        color: VivColors.offWhite,
        borderRadius: BorderRadius.circular(VivSpacing.radiusSm),
        border: Border.all(
          color: isSuccess
              ? Colors.green.shade600.withValues(alpha: 0.3)
              : Colors.orange.shade600.withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isSuccess ? LucideIcons.checkCircle2 : LucideIcons.helpCircle,
                color: isSuccess ? Colors.green.shade600 : Colors.orange.shade700,
                size: 20,
              ),
              const SizedBox(width: VivSpacing.space2),
              Text(
                isSuccess ? 'EXCELLENT !' : 'À REVOIR ...',
                style: VivTypography.eyebrow.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isSuccess ? Colors.green.shade600 : Colors.orange.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: VivSpacing.space3),
          MarkdownBody(
            data: widget.module.explanation,
            styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
              p: VivTypography.body.copyWith(
                fontSize: 14,
                height: 1.5,
                color: VivColors.ink800,
              ),
              strong: VivTypography.body.copyWith(
                fontSize: 14,
                height: 1.5,
                color: VivColors.ink800,
                fontWeight: FontWeight.bold,
              ),
              em: VivTypography.body.copyWith(
                fontSize: 14,
                height: 1.5,
                color: VivColors.ink800,
                fontStyle: FontStyle.italic,
              ),
              code: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFFC7254E),
                backgroundColor: Color(0xFFEFF1F3),
              ),
            ),
            onTapLink: (text, href, title) async {
              if (href != null) {
                final uri = Uri.tryParse(href);
                if (uri != null) {
                  try {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  } catch (e) {
                    // error handling
                  }
                }
              }
            },
          ),
          const SizedBox(height: VivSpacing.space4),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => setState(() {
                _isSubmitted = false;
                _selectedIndices.clear();
              }),
              style: OutlinedButton.styleFrom(
                foregroundColor: VivColors.black,
                side: const BorderSide(color: VivColors.gray300),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(VivSpacing.radiusSm),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text(
                'RECOMMENCER LE QUIZ',
                style: VivTypography.small.copyWith(
                  fontWeight: FontWeight.bold,
                  color: VivColors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
