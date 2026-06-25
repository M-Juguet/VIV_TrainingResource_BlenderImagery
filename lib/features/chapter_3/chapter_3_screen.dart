import 'package:flutter/material.dart';

import '../../core/data/mock_chapters_data.dart';

import '../../core/widgets/chapter_scaffold.dart';

class Chapter3Screen extends StatelessWidget {
  final String? targetModuleId;

  const Chapter3Screen({
    super.key,
    this.targetModuleId,
  });

  @override
  Widget build(BuildContext context) {
    return ChapterScaffold(
      title: 'Mise en lumière & Méthodes de Rendu',
      modules: chapter3Modules,
      targetModuleId: targetModuleId,
      branchIndex: 7,
    );
  }
}
