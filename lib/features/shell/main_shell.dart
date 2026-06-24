import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:window_manager/window_manager.dart';

import '../../core/theme/viv_colors.dart';
import '../../core/theme/viv_spacing.dart';
import '../../core/theme/viv_typography.dart';
import '../../core/router/app_router.dart';

class MainShell extends ConsumerStatefulWidget {
  final StatefulNavigationShell navigationShell;

  const MainShell({super.key, required this.navigationShell});

  @override
  ConsumerState<MainShell> createState() => _MainShellState();
}

class _MainShellState extends ConsumerState<MainShell> {
  bool _isSidebarCollapsed = false;
  bool _isBasicsExpanded = true;
  bool _isFormationExpanded = true;

  static const Map<int, String> _routeTitles = {
    0: 'Tableau de bord',
    1: 'Programme',
    2: 'Mes signets',
    3: 'Basics 101',
    4: 'Chapitre 1',
    5: 'Chapitre 2',
    6: 'Chapitre 3',
    7: 'Paramètres',
  };

  void _goBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = widget.navigationShell.currentIndex;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ref.read(activeBranchIndexProvider) != selectedIndex) {
        ref.read(activeBranchIndexProvider.notifier).changeIndex(selectedIndex);
      }
    });

    return Scaffold(
      backgroundColor: VivColors.offWhite,
      body: Row(
        children: [
          // Navigation Sidebar
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: _isSidebarCollapsed ? 64 : 260,
            decoration: const BoxDecoration(
              color: VivColors.black,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isCompact = constraints.maxWidth < 160;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Branding Header
                    DragToMoveArea(
                      child: Container(
                        height: 70,
                        padding: EdgeInsets.symmetric(
                          horizontal: isCompact ? 0 : VivSpacing.space5,
                        ),
                        alignment: isCompact
                            ? Alignment.center
                            : Alignment.centerLeft,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: isCompact
                              ? Image.asset(
                                  'assets/images/viv-mark-white.png',
                                  key: const ValueKey('mark'),
                                  height: 24,
                                )
                              : Image.asset(
                                  'assets/images/viv-formation-blanc.png',
                                  key: const ValueKey('full'),
                                  height: 24,
                                ),
                        ),
                      ),
                    ),

                    const SizedBox(height: VivSpacing.space2),

                    // Nav Items
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.symmetric(
                          horizontal: isCompact
                              ? VivSpacing.space2
                              : VivSpacing.space3,
                        ),
                        children: [
                          if (!isCompact)
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: VivSpacing.space3,
                                vertical: VivSpacing.space2,
                              ),
                              child: Text(
                                'MENU',
                                style: TextStyle(
                                  color: VivColors.gray500,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),
                          _buildNavItem(
                            icon: LucideIcons.layoutDashboard,
                            title: _routeTitles[0]!,
                            index: 0,
                            selectedIndex: selectedIndex,
                            isCompact: isCompact,
                          ),
                          const SizedBox(height: VivSpacing.space1),
                          _buildNavItem(
                            icon: LucideIcons.bookOpen,
                            title: _routeTitles[1]!,
                            index: 1,
                            selectedIndex: selectedIndex,
                            isCompact: isCompact,
                          ),
                          const SizedBox(height: VivSpacing.space1),
                          _buildNavItem(
                            icon: LucideIcons.bookmark,
                            title: _routeTitles[2]!,
                            index: 2,
                            selectedIndex: selectedIndex,
                            isCompact: isCompact,
                          ),
                          const SizedBox(height: VivSpacing.space4),
                          if (!isCompact)
                            _buildSectionHeader(
                              title: 'LES BASES',
                              isExpanded: _isBasicsExpanded,
                              onTap: () {
                                setState(() {
                                  _isBasicsExpanded = !_isBasicsExpanded;
                                });
                              },
                            ),
                          AnimatedSize(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                            alignment: Alignment.topCenter,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (_isBasicsExpanded || isCompact) ...[
                                  _buildNavItem(
                                    icon: LucideIcons.compass,
                                    title: _routeTitles[3]!,
                                    index: 3,
                                    selectedIndex: selectedIndex,
                                    isCompact: isCompact,
                                  ),
                                ],
                              ],
                            ),
                          ),
                          const SizedBox(height: VivSpacing.space4),
                          if (!isCompact)
                            _buildSectionHeader(
                              title: 'FORMATION',
                              isExpanded: _isFormationExpanded,
                              onTap: () {
                                setState(() {
                                  _isFormationExpanded = !_isFormationExpanded;
                                });
                              },
                            ),
                          AnimatedSize(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                            alignment: Alignment.topCenter,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (_isFormationExpanded || isCompact) ...[
                                  _buildNavItem(
                                    icon: LucideIcons.film,
                                    title: _routeTitles[4]!,
                                    index: 4,
                                    selectedIndex: selectedIndex,
                                    isCompact: isCompact,
                                  ),
                                  const SizedBox(height: VivSpacing.space1),
                                  _buildNavItem(
                                    icon: LucideIcons.shapes,
                                    title: _routeTitles[5]!,
                                    index: 5,
                                    selectedIndex: selectedIndex,
                                    isCompact: isCompact,
                                  ),
                                  const SizedBox(height: VivSpacing.space1),
                                  _buildNavItem(
                                    icon: LucideIcons.image,
                                    title: _routeTitles[6]!,
                                    index: 6,
                                    selectedIndex: selectedIndex,
                                    isCompact: isCompact,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Séparateur discret (Divider)
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isCompact ? VivSpacing.space2 : VivSpacing.space4,
                        vertical: VivSpacing.space2,
                      ),
                      child: Divider(
                        color: VivColors.gray100.withValues(alpha: 0.1),
                        height: 1,
                        thickness: 1,
                      ),
                    ),

                    // Bouton Paramètres tout en bas
                    Padding(
                      padding: EdgeInsets.only(
                        left: isCompact ? VivSpacing.space2 : VivSpacing.space3,
                        right: isCompact ? VivSpacing.space2 : VivSpacing.space3,
                        bottom: VivSpacing.space4,
                      ),
                      child: _buildNavItem(
                        icon: LucideIcons.settings,
                        title: _routeTitles[7]!,
                        index: 7,
                        selectedIndex: selectedIndex,
                        isCompact: isCompact,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          // Main Area
          Expanded(
            child: Column(
              children: [
                // Top Header
                Container(
                  height: 70,
                  decoration: const BoxDecoration(
                    color: VivColors.paper,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x04000000),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: VivSpacing.space2),
                      IconButton(
                        onPressed: () => setState(
                          () => _isSidebarCollapsed = !_isSidebarCollapsed,
                        ),
                        icon: Icon(
                          _isSidebarCollapsed
                              ? LucideIcons.menu
                              : LucideIcons.panelLeft,
                          size: 20,
                          color: VivColors.black,
                        ),
                      ),
                      Expanded(
                        child: DragToMoveArea(
                          child: Container(
                            height: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: VivSpacing.space2,
                            ),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              _getTitle(selectedIndex),
                              style: VivTypography.h3.copyWith(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                      _buildWindowControls(),
                    ],
                  ),
                ),

                // Viewport
                Expanded(child: widget.navigationShell),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getTitle(int index) {
    return _routeTitles[index] ?? '';
  }

  Widget _buildNavItem({
    required IconData icon,
    required String title,
    required int index,
    required int selectedIndex,
    required bool isCompact,
  }) {
    bool isSelected = selectedIndex == index;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: InkWell(
        onTap: () => _goBranch(index),
        borderRadius: BorderRadius.circular(VivSpacing.radiusMd),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            horizontal: isCompact ? VivSpacing.space2 : VivSpacing.space3,
            vertical: VivSpacing.space2,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? VivColors.lime.withValues(alpha: 0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(VivSpacing.radiusMd),
            border: Border.all(
              color: isSelected
                  ? VivColors.lime.withValues(alpha: 0.2)
                  : Colors.transparent,
            ),
          ),
          child: Row(
            mainAxisAlignment: isCompact
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: isSelected ? VivColors.lime : VivColors.gray400,
                size: isCompact ? 22 : 20,
              ),
              if (!isCompact) ...[
                const SizedBox(width: VivSpacing.space3),
                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    softWrap: false,
                    style: TextStyle(
                      color: isSelected ? VivColors.paper : VivColors.gray400,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.normal,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader({
    required String title,
    required bool isExpanded,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(VivSpacing.radiusSm),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: VivSpacing.space3,
            vertical: VivSpacing.space2,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: VivColors.gray500,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              Icon(
                isExpanded ? LucideIcons.chevronDown : LucideIcons.chevronRight,
                color: VivColors.gray500,
                size: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWindowControls() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _WindowButton(
          icon: LucideIcons.minus,
          onTap: () => windowManager.minimize(),
        ),
        _WindowButton(
          icon: LucideIcons.square,
          onTap: () async {
            if (await windowManager.isMaximized()) {
              windowManager.unmaximize();
            } else {
              windowManager.maximize();
            }
          },
        ),
        _WindowButton(
          icon: LucideIcons.x,
          onTap: () => windowManager.close(),
          isClose: true,
        ),
      ],
    );
  }
}

class _WindowButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isClose;

  const _WindowButton({
    required this.icon,
    required this.onTap,
    this.isClose = false,
  });

  @override
  State<_WindowButton> createState() => _WindowButtonState();
}

class _WindowButtonState extends State<_WindowButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final hoverBgColor = widget.isClose ? const Color(0xFFE81123) : VivColors.gray100;
    final iconColor = (_isHovered && widget.isClose) ? Colors.white : VivColors.black;

    return ExcludeSemantics(
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: Container(
            width: 48,
            height: double.infinity,
            color: _isHovered ? hoverBgColor : Colors.transparent,
            child: Icon(
              widget.icon,
              size: 14,
              color: iconColor,
            ),
          ),
        ),
      ),
    );
  }
}
