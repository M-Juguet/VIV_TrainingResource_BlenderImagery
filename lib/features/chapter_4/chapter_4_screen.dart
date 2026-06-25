import 'package:flutter/material.dart';

import '../../core/data/mock_chapters_data.dart';

import '../../core/widgets/chapter_scaffold.dart';

class Chapter4Screen extends StatelessWidget {
  final String? targetModuleId;

  const Chapter4Screen({
    super.key,
    this.targetModuleId,
  });

  @override
  Widget build(BuildContext context) {
    return ChapterScaffold(
      title: 'Post-production & Finalisation de l\'Image',
      modules: chapter4Modules,
      targetModuleId: targetModuleId,
      branchIndex: 8,
    );
  }
}
