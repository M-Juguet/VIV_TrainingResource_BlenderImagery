import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:window_manager/window_manager.dart';

import '../../core/theme/viv_colors.dart';
import '../../core/theme/viv_spacing.dart';
import '../../core/theme/viv_typography.dart';

class MainShell extends ConsumerStatefulWidget {
  final StatefulNavigationShell navigationShell;

  const MainShell({super.key, required this.navigationShell});

  @override
  ConsumerState<MainShell> createState() => _MainShellState();
}

class _MainShellState extends ConsumerState<MainShell> {
  bool _isSidebarCollapsed = false;

  void _goBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = widget.navigationShell.currentIndex;

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
                                'OUTILS FORMATION',
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
                            title: 'Tableau de bord',
                            index: 0,
                            selectedIndex: selectedIndex,
                            isCompact: isCompact,
                          ),
                          const SizedBox(height: VivSpacing.space1),
                          _buildNavItem(
                            icon: LucideIcons.filePlus2,
                            title: 'Création de programme',
                            index: 1,
                            selectedIndex: selectedIndex,
                            isCompact: isCompact,
                          ),
                          const SizedBox(height: VivSpacing.space1),
                          _buildNavItem(
                            icon: LucideIcons.folderEdit,
                            title: 'Édition de programme',
                            index: 2,
                            selectedIndex: selectedIndex,
                            isCompact: isCompact,
                          ),
                          const SizedBox(height: VivSpacing.space5),
                          if (!isCompact)
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: VivSpacing.space3,
                                vertical: VivSpacing.space2,
                              ),
                              child: Text(
                                'SYSTÈME',
                                style: TextStyle(
                                  color: VivColors.gray500,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),
                          _buildNavItem(
                            icon: LucideIcons.settings,
                            title: 'Paramètres',
                            index: 3,
                            selectedIndex: selectedIndex,
                            isCompact: isCompact,
                          ),
                        ],
                      ),
                    ),

                    // Footer Profile Placeholder
                    Padding(
                      padding: const EdgeInsets.only(
                        left: VivSpacing.space3,
                        right: VivSpacing.space3,
                        top: VivSpacing.space3,
                        bottom: VivSpacing.space5,
                      ),
                      child: isCompact
                          ? const Center(
                              child: CircleAvatar(
                                radius: 14,
                                backgroundColor: VivColors.lime,
                                child: Text(
                                  'VF',
                                  style: TextStyle(
                                    color: VivColors.black,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              padding: const EdgeInsets.all(VivSpacing.space3),
                              decoration: BoxDecoration(
                                color: VivColors.gray100.withValues(
                                  alpha: 0.05,
                                ),
                                borderRadius: BorderRadius.circular(
                                  VivSpacing.radiusMd,
                                ),
                                border: Border.all(
                                  color: VivColors.gray100.withValues(
                                    alpha: 0.1,
                                  ),
                                ),
                              ),
                              child: const Row(
                                children: [
                                  CircleAvatar(
                                    radius: 14,
                                    backgroundColor: VivColors.lime,
                                    child: Text(
                                      'VF',
                                      style: TextStyle(
                                        color: VivColors.black,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: VivSpacing.space3),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'VIV Formation',
                                          style: TextStyle(
                                            color: VivColors.paper,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          'Boîte à outils locale',
                                          style: TextStyle(
                                            color: VivColors.gray500,
                                            fontSize: 10,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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
    switch (index) {
      case 0:
        return 'Tableau de bord';
      case 1:
        return 'Création de programme';
      case 2:
        return 'Édition de programme';
      case 3:
        return 'Paramètres du système';
      default:
        return 'Tableau de bord';
    }
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
          padding: EdgeInsets.all(
            isCompact ? VivSpacing.space2 : VivSpacing.space3,
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
}
