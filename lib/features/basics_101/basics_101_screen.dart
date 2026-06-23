import 'package:flutter/material.dart';

import '../../core/data/mock_chapters_data.dart';

import '../../core/widgets/chapter_scaffold.dart';

class Basics101Screen extends StatelessWidget {
  final String? targetModuleId;

  const Basics101Screen({
    super.key,
    this.targetModuleId,
  });

  @override
  Widget build(BuildContext context) {
    return ChapterScaffold(
      title: 'Basics 101',
      modules: basics101Modules,
      targetModuleId: targetModuleId,
      branchIndex: 3,
    );
  }
}
