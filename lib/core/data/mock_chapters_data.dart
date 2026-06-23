import '../models/content_module.dart';

const List<ContentModule> basics101Modules = [
  TitleModule(
    id: 'basics_title',
    title: 'Fondations et Concepts fondamentaux',
  ),
  TextModule(
    id: 'basics_intro',
    title: '1. Introduction aux prérequis',
    content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\n\nDuis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
  ),
  InfoModule(
    id: 'basics_tip',
    type: InfoType.tip,
    text: 'Ceci est un conseil expert fictif. Dans une application réelle, cet encart contiendra des recommandations spécifiques aux fondamentaux ou des astuces d\'apprentissage.',
  ),
  ListModule(
    id: 'basics_list',
    title: '2. Objectifs d\'apprentissage',
    intro: 'Avant de poursuivre, assurez-vous de maîtriser les concepts suivants :',
    items: [
      'Concept de base A et sa mise en œuvre',
      'Concept de base B et ses implications directes',
      'Concept de base C et sa validation technique',
      'Concept de base D et son automatisation',
    ],
    outro: 'Chacun de ces points sera validé lors de l\'auto-évaluation ci-dessous.',
  ),
  QuizModule(
    id: 'basics_quiz',
    question: 'Quelle est la définition générique d\'un concept de base ?',
    options: [
      'Option de réponse A (Incorrecte)',
      'Option de réponse B (Correcte - à sélectionner)',
      'Option de réponse C (Incorrecte)',
      'Option de réponse D (Incorrecte)',
    ],
    correctIndices: [1],
    explanation: 'Ceci est l\'explication pédagogique détaillée de la réponse. Dans un vrai module, elle justifie pourquoi l\'option B est la bonne réponse en s\'appuyant sur le cours ci-dessus.',
  ),
];

const List<ContentModule> chapter1Modules = [
  TitleModule(
    id: 'ch1_title',
    title: 'Chapitre 1 : Introduction et Mise en place',
  ),
  TextModule(
    id: 'ch1_text1',
    title: '1. Analyse globale',
    content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin nec lectus eget urna venenatis imperdiet. Suspendisse potenti. Nam pretium, turpis et elementum accumsan, ante sem laoreet metus, eget tempor sapien erat a lacus.\n\nNullam hendrerit convallis scelerisque. Cras tristique facilisis nisl, in feugiat arcu iaculis elementum.',
  ),
  SideBySideModule(
    id: 'ch1_side',
    title: '2. Représentation visuelle',
    content: 'Ce module scindé côte à côte illustre comment associer un paragraphe explicatif à une figure ou un schéma technique. L\'image se trouve à droite et le texte à gauche (la disposition est modifiable via le code du module).\n\nLe texte se prête à des explications pas à pas de diagrammes ou de captures d\'écran de l\'outil étudié.',
    imagePath: 'assets/images/placeholder_ch1.png',
    caption: 'Figure 1.1 : Légende descriptive de l\'image fictive.',
    layout: ContentLayout.textLeft,
  ),
  InfoModule(
    id: 'ch1_info',
    type: InfoType.info,
    text: 'Ceci est un encart d\'information standard. Il sert à attirer l\'attention sur une définition importante ou une précision de cours.',
  ),
];

const List<ContentModule> chapter2Modules = [
  TitleModule(
    id: 'ch2_title',
    title: 'Chapitre 2 : Approfondissement et Modélisation',
  ),
  TextModule(
    id: 'ch2_text1',
    content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non risus. Suspendisse lectus tortor, dignissim sit amet, tempor in, pretium eget, arcu. Integer vel sem. Nullam pretium sem ut metus. Ut varius tincidunt libero.\n\nPhasellus iaculis lorem vel sem. Morbi ac orci et nisl hendrerit mollis. Suspendisse ut massa.',
  ),
  FullMediaModule(
    id: 'ch2_media',
    imagePath: 'assets/images/placeholder_ch2.png',
    caption: 'Figure 2.1 : Illustration pleine largeur de l\'interface ou d\'un modèle technique.',
  ),
  InfoModule(
    id: 'ch2_warning',
    type: InfoType.warning,
    text: 'Attention : Il s\'agit d\'un encart d\'avertissement fictif. Utilisez ce type de module pour signaler des erreurs courantes des apprenants, des risques de plantage du logiciel, ou des consignes de sécurité.',
  ),
  ResourceModule(
    id: 'ch2_resource',
    title: 'Ressource d\'accompagnement',
    fileName: 'template_exercices_pratiques.zip',
    description: 'Téléchargez les fichiers sources et les exercices d\'application pour ce chapitre.',
    downloadUrl: 'https://github.com/M-Juguet/VIV_TrainingResource_BlenderImagery',
  ),
];

const List<ContentModule> chapter3Modules = [
  TitleModule(
    id: 'ch3_title',
    title: 'Chapitre 3 : Rendu et Synthèse',
  ),
  TextModule(
    id: 'ch3_text1',
    title: '1. Synthèse des acquis',
    content: 'Morbi in sem quis dui placerat ornare. Pellentesque odio nisi, euismod in, pharetra a, ultricies in, diam. Sed arcu. Cras consequat. Praesent est ligula, porttitor eget, consequat nec, auctor quis, purus.\n\nAccumsan lacus vel facilisis. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus.',
  ),
  InfoModule(
    id: 'ch3_challenge',
    type: InfoType.challenge,
    text: 'Défi fil rouge : Cet encart présente le projet final à réaliser par l\'apprenant pour valider le chapitre. Dans notre template, il résume les étapes de validation finale.',
  ),
  QuizModule(
    id: 'ch3_quiz',
    question: 'Quel est l\'intérêt principal d\'un template modulaire en Flutter ?',
    options: [
      'Séparer le contenu et le rendu pour simplifier les futures mises à jour (Correct)',
      'Accélérer la vitesse de compilation de Flutter',
      'Réduire la taille de l\'application finale sur l\'OS',
      'Forcer un design sombre uniquement',
    ],
    correctIndices: [0],
    explanation: 'Le fait de séparer le contenu (la structure des classes de modules) du rendu visuel (les Widgets de rendu) permet de modifier le design system de l\'application ultérieurement sans avoir à retoucher aux données des chapitres.',
  ),
];
