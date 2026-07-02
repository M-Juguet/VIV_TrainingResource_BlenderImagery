import 'package:flutter/material.dart';

import '../../core/data/mock_chapters_data.dart';
import '../../core/widgets/chapter_scaffold.dart';

class Basics103Screen extends StatelessWidget {
  final String? targetModuleId;

  const Basics103Screen({
    super.key,
    this.targetModuleId,
  });

  @override
  Widget build(BuildContext context) {
    return ChapterScaffold(
      title: 'Basics 103',
      modules: basics103Modules,
      targetModuleId: targetModuleId,
      branchIndex: 5,
    );
  }
}
