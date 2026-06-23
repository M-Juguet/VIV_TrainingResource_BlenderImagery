enum ContentLayout { textLeft, textRight }

abstract class ContentModule {
  final String id;
  const ContentModule({required this.id});
}

class TitleModule extends ContentModule {
  final String title;
  const TitleModule({required super.id, required this.title});
}

class TextModule extends ContentModule {
  final String? title;
  final String content;
  const TextModule({required super.id, this.title, required this.content});
}

class SideBySideModule extends ContentModule {
  final String? title;
  final String content;
  final String imagePath;
  final String? caption;
  final ContentLayout layout;

  const SideBySideModule({
    required super.id,
    this.title,
    required this.content,
    required this.imagePath,
    this.caption,
    required this.layout,
  });
}

class FullMediaModule extends ContentModule {
  final String imagePath;
  final String? caption;

  const FullMediaModule({
    required super.id,
    required this.imagePath,
    this.caption,
  });
}

enum InfoType { idea, tip, warning, info, objective, challenge }

class InfoModule extends ContentModule {
  final String text;
  final InfoType type;

  const InfoModule({
    required super.id,
    required this.text,
    this.type = InfoType.idea,
  });
}

class ResourceModule extends ContentModule {
  final String title;
  final String description;
  final String fileName;
  final String downloadUrl;

  const ResourceModule({
    required super.id,
    required this.title,
    required this.description,
    required this.fileName,
    required this.downloadUrl,
  });
}

class ListModule extends ContentModule {
  final String title;
  final String? intro;
  final List<String> items;
  final String? outro;

  const ListModule({
    required super.id,
    required this.title,
    this.intro,
    required this.items,
    this.outro,
  });
}

class QuizModule extends ContentModule {
  final String question;
  final List<String> options;
  final List<int> correctIndices;
  final String explanation;

  const QuizModule({
    required super.id,
    required this.question,
    required this.options,
    required this.correctIndices,
    required this.explanation,
  });
}
