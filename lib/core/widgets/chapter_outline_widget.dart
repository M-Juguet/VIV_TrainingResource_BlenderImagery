import 'dart:ui';
import 'package:flutter/material.dart';

import '../models/content_module.dart';
import '../theme/viv_colors.dart';
import '../theme/viv_spacing.dart';

class OutlineItem {
  final String id;
  final String title;
  final bool isMain;

  OutlineItem({
    required this.id,
    required this.title,
    required this.isMain,
  });
}

class ChapterOutlineWidget extends StatefulWidget {
  final List<ContentModule> modules;
  final String? activeModuleId;
  final ValueChanged<String> onNavigate;

  const ChapterOutlineWidget({
    super.key,
    required this.modules,
    required this.activeModuleId,
    required this.onNavigate,
  });

  @override
  State<ChapterOutlineWidget> createState() => _ChapterOutlineWidgetState();
}

class _ChapterOutlineWidgetState extends State<ChapterOutlineWidget> {
  bool _isExpanded = false;
  final ScrollController _outlineScrollController = ScrollController();

  @override
  void dispose() {
    _outlineScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final outlineItems = <OutlineItem>[];
    for (var module in widget.modules) {
      if (module is TitleModule) {
        outlineItems.add(OutlineItem(id: module.id, title: module.title, isMain: true));
      } else if (module is TextModule && module.title != null) {
        outlineItems.add(OutlineItem(id: module.id, title: module.title!, isMain: false));
      } else if (module is SideBySideModule && module.title != null) {
        outlineItems.add(OutlineItem(id: module.id, title: module.title!, isMain: false));
      } else if (module is ResourceModule) {
        outlineItems.add(OutlineItem(id: module.id, title: module.title, isMain: false));
      } else if (module is ListModule) {
        outlineItems.add(OutlineItem(id: module.id, title: module.title, isMain: false));
      } else if (module is QuizModule) {
        outlineItems.add(OutlineItem(id: module.id, title: module.question, isMain: false));
      }
    }

    if (outlineItems.isEmpty) return const SizedBox.shrink();

    return ExcludeSemantics(
      child: MouseRegion(
        onEnter: (_) => setState(() => _isExpanded = true),
        onExit: (_) => setState(() => _isExpanded = false),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(VivSpacing.radiusMd),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: _isExpanded ? 12.0 : 0.0,
              sigmaY: _isExpanded ? 12.0 : 0.0,
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              width: _isExpanded ? 260.0 : 40.0,
              constraints: BoxConstraints(
                maxHeight: _isExpanded 
                    ? MediaQuery.of(context).size.height - 180 
                    : MediaQuery.of(context).size.height - 220,
              ),
              decoration: BoxDecoration(
                color: _isExpanded 
                    ? VivColors.paper.withValues(alpha: 0.85) 
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(VivSpacing.radiusMd),
                border: Border.all(
                  color: _isExpanded ? VivColors.gray200 : Colors.transparent,
                  width: 1,
                ),
                boxShadow: _isExpanded 
                    ? const [
                        BoxShadow(
                          color: Color(0x0F000000),
                          blurRadius: 16,
                          offset: Offset(0, 8),
                        ),
                      ]
                    : [],
              ),
              padding: EdgeInsets.symmetric(
                vertical: VivSpacing.space4, 
                horizontal: _isExpanded ? VivSpacing.space4 : 12,
              ),
              child: ClipRect(
                child: Scrollbar(
                  controller: _outlineScrollController,
                  thumbVisibility: false,
                  child: SingleChildScrollView(
                    controller: _outlineScrollController,
                    physics: _isExpanded 
                        ? const BouncingScrollPhysics() 
                        : const NeverScrollableScrollPhysics(),
                    child: _isExpanded
                        ? SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: const NeverScrollableScrollPhysics(),
                            child: SizedBox(
                              width: 228.0,
                              child: _buildExpandedContent(outlineItems),
                            ),
                          )
                        : _buildCollapsedContent(outlineItems),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCollapsedContent(List<OutlineItem> items) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: items.map((item) {
        final isActive = item.id == widget.activeModuleId;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 3.0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            height: 2,
            width: isActive ? 20.0 : (item.isMain ? 12.0 : 6.0),
            decoration: BoxDecoration(
              color: isActive 
                  ? VivColors.limeDeep 
                  : VivColors.gray300.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(1),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildExpandedContent(List<OutlineItem> items) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'SOMMAIRE',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: VivColors.gray500,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: VivSpacing.space3),
        const Divider(color: VivColors.gray200, height: 1),
        const SizedBox(height: VivSpacing.space2),
        ...items.map((item) {
          final isActive = item.id == widget.activeModuleId;
          return _OutlineItemRow(
            item: item,
            isActive: isActive,
            onTap: () => widget.onNavigate(item.id),
          );
        }),
      ],
    );
  }
}

class _OutlineItemRow extends StatefulWidget {
  final OutlineItem item;
  final bool isActive;
  final VoidCallback onTap;

  const _OutlineItemRow({
    required this.item,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_OutlineItemRow> createState() => _OutlineItemRowState();
}

class _OutlineItemRowState extends State<_OutlineItemRow> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
          margin: const EdgeInsets.only(bottom: 2.0),
          decoration: BoxDecoration(
            color: _isHovered
                ? VivColors.lime.withValues(alpha: 0.05)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(VivSpacing.radiusMd),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: widget.item.isMain ? 0.0 : 12.0),
            child: Row(
              children: [
                if (widget.isActive)
                  Container(
                    width: 3,
                    height: 12,
                    decoration: BoxDecoration(
                      color: VivColors.limeDeep,
                      borderRadius: BorderRadius.circular(1.5),
                    ),
                  ),
                if (widget.isActive) const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    widget.item.title,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: widget.isActive 
                          ? FontWeight.bold 
                          : (widget.item.isMain ? FontWeight.w600 : FontWeight.w400),
                      color: widget.isActive
                          ? VivColors.limeDeep
                          : (_isHovered ? VivColors.black : VivColors.gray500),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
