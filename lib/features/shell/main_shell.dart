import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:window_manager/window_manager.dart';

import '../../core/theme/viv_colors.dart';
import '../../core/theme/viv_spacing.dart';
import '../../core/theme/viv_typography.dart';
import '../../core/router/app_router.dart';
import '../../core/services/search_service.dart';

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

  bool _isSearchActive = false;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  List<SearchResult> _searchResults = [];

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  static const Map<int, String> _routeTitles = {
    0: 'Tableau de bord',
    1: 'Programme',
    2: 'Mes signets',
    3: 'Basics 101',
    4: 'Basics 102',
    5: 'Shading & LookDev',
    6: 'Texturage Agile & UVs',
    7: 'Lumière & Rendu',
    8: 'Post-prod & Finalisation',
    9: 'Paramètres',
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

    return Stack(
      children: [
        Scaffold(
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
                                        const SizedBox(height: VivSpacing.space1),
                                        _buildNavItem(
                                          icon: LucideIcons.hardHat,
                                          title: _routeTitles[4]!,
                                          index: 4,
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
                                          icon: LucideIcons.palette,
                                          title: _routeTitles[5]!,
                                          index: 5,
                                          selectedIndex: selectedIndex,
                                          isCompact: isCompact,
                                        ),
                                        const SizedBox(height: VivSpacing.space1),
                                        _buildNavItem(
                                          icon: LucideIcons.layers,
                                          title: _routeTitles[6]!,
                                          index: 6,
                                          selectedIndex: selectedIndex,
                                          isCompact: isCompact,
                                        ),
                                        const SizedBox(height: VivSpacing.space1),
                                        _buildNavItem(
                                          icon: LucideIcons.lightbulb,
                                          title: _routeTitles[7]!,
                                          index: 7,
                                          selectedIndex: selectedIndex,
                                          isCompact: isCompact,
                                        ),
                                        const SizedBox(height: VivSpacing.space1),
                                        _buildNavItem(
                                          icon: LucideIcons.sparkles,
                                          title: _routeTitles[8]!,
                                          index: 8,
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
                              title: _routeTitles[9]!,
                              index: 9,
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
                            _buildSearchField(context),
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
          ),
          if (_isSearchActive)
            _buildSearchOverlay(context),
        ],
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
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: InkWell(
        onTap: () => _goBranch(index),
        borderRadius: BorderRadius.circular(VivSpacing.radiusMd),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            horizontal: isCompact ? VivSpacing.space2 : VivSpacing.space3,
            vertical: isCompact ? VivSpacing.space2 : 6.0,
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
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(VivSpacing.radiusSm),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: VivSpacing.space3,
            vertical: 6.0,
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

  Widget _buildSearchField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: VivSpacing.space2),
      child: IconButton(
        onPressed: () {
          setState(() {
            _isSearchActive = true;
          });
        },
        icon: const Icon(
          LucideIcons.search,
          size: 20,
          color: VivColors.black,
        ),
        hoverColor: VivColors.gray100,
        splashRadius: 20,
      ),
    );
  }

  Widget _buildSearchOverlay(BuildContext context) {
    final groupedResults = <String, List<SearchResult>>{};
    for (var res in _searchResults) {
      groupedResults.putIfAbsent(res.chapterTitle, () => []).add(res);
    }

    return Positioned.fill(
      child: Stack(
        children: [
          // Blurred background
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isSearchActive = false;
                  _searchController.clear();
                  _searchResults.clear();
                });
              },
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  color: Colors.black.withValues(alpha: 0.4),
                ),
              ),
            ),
          ),
          // Dialog container
          Center(
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: 650,
                constraints: const BoxConstraints(maxHeight: 480),
                decoration: BoxDecoration(
                  color: VivColors.paper,
                  borderRadius: BorderRadius.circular(VivSpacing.radiusLg),
                  border: Border.all(color: VivColors.gray200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Search box header
                    Padding(
                      padding: const EdgeInsets.all(VivSpacing.space4),
                      child: Row(
                        children: [
                          const Icon(
                            LucideIcons.search,
                            color: VivColors.limeDeep,
                            size: 20,
                          ),
                          const SizedBox(width: VivSpacing.space3),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              focusNode: _searchFocusNode,
                              autofocus: true,
                              onChanged: (val) {
                                setState(() {
                                  _searchResults = SearchService.search(val);
                                });
                              },
                              style: const TextStyle(
                                color: VivColors.ink,
                                fontSize: 15,
                              ),
                              decoration: const InputDecoration(
                                hintText: 'Rechercher un mot-clé, un chapitre...',
                                hintStyle: TextStyle(
                                  color: VivColors.gray400,
                                  fontSize: 15,
                                ),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: const Icon(
                              LucideIcons.x,
                              color: VivColors.gray400,
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                _isSearchActive = false;
                                _searchController.clear();
                                _searchResults.clear();
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const Divider(color: VivColors.gray100, height: 1),
                    // Results or guide
                    Flexible(
                      child: SingleChildScrollView(
                        child: _searchController.text.trim().isEmpty
                            ? _buildSearchGuide(context)
                            : _searchResults.isEmpty
                                ? _buildEmptyState(context)
                                : _buildResultsList(context, groupedResults),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchGuide(BuildContext context) {
    final List<Map<String, dynamic>> quickChapters = [
      {
        'title': 'Découverte & Prise en main',
        'subtitle': 'Basics 101 • Notions et prérequis fondamentaux',
        'icon': LucideIcons.compass,
        'route': '/basics-101',
      },
      {
        'title': 'Chapitre 1',
        'subtitle': 'Fondamentaux du Shading & LookDev',
        'icon': LucideIcons.palette,
        'route': '/chapter-1',
      },
      {
        'title': 'Chapitre 2',
        'subtitle': 'Texturage Agile & Gestion Simplifiée des UVs',
        'icon': LucideIcons.layers,
        'route': '/chapter-2',
      },
      {
        'title': 'Chapitre 3',
        'subtitle': 'Mise en lumière & Méthodes de Rendu',
        'icon': LucideIcons.lightbulb,
        'route': '/chapter-3',
      },
      {
        'title': 'Chapitre 4',
        'subtitle': 'Post-production & Finalisation de l\'Image',
        'icon': LucideIcons.sparkles,
        'route': '/chapter-4',
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(VivSpacing.space5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'ACCÈS RAPIDE',
            style: TextStyle(
              color: VivColors.gray500,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: VivSpacing.space3),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            mainAxisSpacing: VivSpacing.space3,
            crossAxisSpacing: VivSpacing.space3,
            childAspectRatio: 2.8,
            physics: const NeverScrollableScrollPhysics(),
            children: quickChapters.map((ch) {
              return Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _isSearchActive = false;
                      _searchController.clear();
                      _searchResults.clear();
                    });
                    context.go(ch['route']);
                  },
                  borderRadius: BorderRadius.circular(VivSpacing.radiusMd),
                  hoverColor: VivColors.lime.withValues(alpha: 0.08),
                  child: Container(
                    padding: const EdgeInsets.all(VivSpacing.space3),
                    decoration: BoxDecoration(
                      border: Border.all(color: VivColors.gray200),
                      borderRadius: BorderRadius.circular(VivSpacing.radiusMd),
                    ),
                    child: Row(
                      children: [
                        Icon(ch['icon'], color: VivColors.limeDeep, size: 20),
                        const SizedBox(width: VivSpacing.space3),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                ch['title'],
                                style: const TextStyle(
                                  color: VivColors.ink,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                ch['subtitle'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: VivColors.gray500,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: VivSpacing.space5),
          const Center(
            child: Text(
              'Astuce : Cliquez en dehors de la boîte de recherche pour la fermer.',
              style: TextStyle(
                color: VivColors.gray400,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: VivSpacing.space8),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              LucideIcons.searchX,
              color: VivColors.gray300,
              size: 48,
            ),
            const SizedBox(height: VivSpacing.space4),
            Text(
              'Aucun résultat pour « ${_searchController.text} »',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: VivColors.ink,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: VivSpacing.space2),
            const Text(
              'Veuillez vérifier l\'orthographe ou essayer d\'autres mots-clés.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: VivColors.gray500,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsList(
    BuildContext context,
    Map<String, List<SearchResult>> groupedResults,
  ) {
    return Padding(
      padding: const EdgeInsets.all(VivSpacing.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: groupedResults.entries.map((entry) {
          final chapterTitle = entry.key;
          final items = entry.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: VivSpacing.space2,
                  horizontal: VivSpacing.space2,
                ),
                child: Text(
                  chapterTitle.toUpperCase(),
                  style: const TextStyle(
                    color: VivColors.limeDeep,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              ...items.map((item) => _buildResultItemCard(context, item)),
              const SizedBox(height: VivSpacing.space3),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildResultItemCard(BuildContext context, SearchResult item) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            setState(() {
              _isSearchActive = false;
              _searchController.clear();
              _searchResults.clear();
            });
            context.go('${item.routePath}?target=${item.moduleId}');
          },
          borderRadius: BorderRadius.circular(VivSpacing.radiusMd),
          hoverColor: VivColors.lime.withValues(alpha: 0.05),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: VivColors.gray100),
              borderRadius: BorderRadius.circular(VivSpacing.radiusMd),
            ),
            child: Row(
              children: [
                Icon(
                  _getIconForModuleType(item.moduleType),
                  color: VivColors.gray400,
                  size: 18,
                ),
                const SizedBox(width: VivSpacing.space3),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.moduleTitle,
                        style: const TextStyle(
                          color: VivColors.ink,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 4),
                      _buildHighlightText(item.snippet, _searchController.text),
                    ],
                  ),
                ),
                const SizedBox(width: VivSpacing.space2),
                const Icon(
                  LucideIcons.chevronRight,
                  color: VivColors.gray300,
                  size: 14,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHighlightText(String text, String query) {
    if (query.isEmpty) {
      return Text(
        text,
        style: const TextStyle(color: VivColors.gray500, fontSize: 12),
      );
    }
    final lowerText = text.toLowerCase();
    final lowerQuery = query.toLowerCase();
    final List<TextSpan> spans = [];

    int start = 0;
    int index = lowerText.indexOf(lowerQuery, start);

    while (index != -1) {
      if (index > start) {
        spans.add(TextSpan(
          text: text.substring(start, index),
          style: const TextStyle(color: VivColors.gray500),
        ));
      }
      spans.add(TextSpan(
        text: text.substring(index, index + query.length),
        style: const TextStyle(
          color: VivColors.black,
          backgroundColor: Color(0x60C1F903), // Translucent Lime
          fontWeight: FontWeight.bold,
        ),
      ));
      start = index + query.length;
      index = lowerText.indexOf(lowerQuery, start);
    }

    if (start < text.length) {
      spans.add(TextSpan(
        text: text.substring(start),
        style: const TextStyle(color: VivColors.gray500),
      ));
    }

    return RichText(
      text: TextSpan(
        children: spans,
        style: const TextStyle(fontSize: 12, height: 1.4),
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  IconData _getIconForModuleType(String type) {
    switch (type) {
      case 'title':
        return LucideIcons.heading;
      case 'text':
      case 'sideBySide':
        return LucideIcons.fileText;
      case 'media':
        return LucideIcons.image;
      case 'info':
        return LucideIcons.info;
      case 'resource':
        return LucideIcons.download;
      case 'list':
        return LucideIcons.list;
      case 'quiz':
        return LucideIcons.helpCircle;
      default:
        return LucideIcons.file;
    }
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
