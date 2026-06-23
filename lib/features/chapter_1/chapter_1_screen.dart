import 'package:flutter/material.dart';

import '../../core/data/mock_chapters_data.dart';

import '../../core/widgets/chapter_scaffold.dart';

class Chapter1Screen extends StatelessWidget {
  final String? targetModuleId;

  const Chapter1Screen({
    super.key,
    this.targetModuleId,
  });

  @override
  Widget build(BuildContext context) {
    return ChapterScaffold(
      title: 'Chapitre 1',
      modules: chapter1Modules,
      targetModuleId: targetModuleId,
      branchIndex: 4,
    );
  }
}
