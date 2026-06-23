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
      title: 'Chapitre 2',
      modules: chapter2Modules,
      targetModuleId: targetModuleId,
      branchIndex: 5,
    );
  }
}
