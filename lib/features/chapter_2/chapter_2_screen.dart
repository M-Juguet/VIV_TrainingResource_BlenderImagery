import 'package:flutter/material.dart';

import '../../core/data/mock_chapters_data.dart';

import '../../core/widgets/chapter_scaffold.dart';

class Chapter2Screen extends StatelessWidget {
  final String? targetModuleId;

  const Chapter2Screen({
    super.key,
    this.targetModuleId,
  });

  @override
  Widget build(BuildContext context) {
    return ChapterScaffold(
      title: 'Texturage Agile & Gestion Simplifiée des UVs',
      modules: chapter2Modules,
      targetModuleId: targetModuleId,
      branchIndex: 6,
    );
  }
}
