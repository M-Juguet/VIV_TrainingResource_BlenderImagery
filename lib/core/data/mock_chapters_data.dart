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
    title: 'Fondamentaux du Shading & LookDev',
  ),
  TitleModule(
    id: 'ch1_sec1_title',
    title: '1. Le shading physique (PBR) : principes fondamentaux',
  ),
  TextModule(
    id: 'ch1_sec1_txt1',
    title: 'Du modèle nu à la matière',
    content: 'Lorsque vous avez modélisé un objet, vous n\'avez défini que sa forme : une géométrie « nue », sans couleur ni reflet. Le *shading* est l\'étape qui décrit **comment la surface de cet objet réagit à la lumière** — sa couleur, son éclat, sa rugosité, sa transparence, sa façon de refléter l\'environnement. L\'ensemble de ces propriétés est regroupé dans une donnée appelée **matériau** (*material*).\n\nDans Blender, un matériau n\'est pas une simple teinte appliquée à un objet. C\'est un petit réseau de calculs qui détermine, pour chaque rayon de lumière atteignant la surface, la quantité et la direction de la lumière renvoyée vers la caméra. Ce calcul porte le nom de *shader*. Comprendre le shading, c\'est donc apprendre à piloter ce dialogue entre la surface et la lumière.',
  ),
  TextModule(
    id: 'ch1_sec1_txt2',
    title: 'Qu\'est-ce que le PBR ?',
    content: 'PBR est l\'abréviation de *Physically Based Rendering*, le « rendu basé sur la physique ». Il s\'agit d\'une approche dans laquelle les matériaux sont décrits à partir de propriétés mesurables du monde réel plutôt que de réglages arbitraires. Une surface n\'est plus définie par « 30 % de reflet et une couleur un peu brillante », mais par des grandeurs cohérentes : est-elle conductrice ou isolante ? Quelle est la micro-rugosité de sa surface ? Quel est son indice de réfraction ?\n\nL\'intérêt majeur de cette approche est la **cohérence**. Un matériau PBR correctement réglé conserve un aspect crédible quel que soit l\'éclairage : en pleine lumière, à l\'ombre, sous un ciel nuageux ou face à une lampe de studio. Dans Blender, les deux moteurs de rendu Eevee et Cycles partagent le même modèle PBR : un matériau aura donc le même comportement dans l\'aperçu temps-réel et dans le rendu final, ce qui fluidifie énormément le travail.',
  ),
  InfoModule(
    id: 'ch1_sec1_info1',
    type: InfoType.info,
    text: 'Le terme **LookDev** (*Look Development*) désigne l\'activité consistant à mettre au point l\'apparence d\'un objet : définir ses matériaux et les évaluer sous un éclairage neutre et contrôlé avant de les confronter à la scène finale. C\'est précisément ce que vous apprenez à faire dans ce premier bloc.',
  ),
  TextModule(
    id: 'ch1_sec1_txt3',
    title: 'Le workflow Métallique / Rugosité',
    content: 'Deux paramètres dominent toute la logique PBR : le caractère métallique et la rugosité. Les maîtriser, c\'est déjà savoir reproduire l\'immense majorité des matières.\n\nLe paramètre **Metallic** (Métallique) répond à une question binaire : la surface est-elle un métal brut ou non ? Un métal (or, acier, cuivre, aluminium) conduit l\'électricité et réfléchit la lumière d\'une manière très particulière, en teintant ses reflets avec sa propre couleur. Tous les autres matériaux — plastique, bois, peau, pierre, verre, céramique — sont des *diélectriques* (isolants) et se comportent différemment. C\'est pourquoi cette valeur se règle presque toujours sur `0` (diélectrique) ou `1` (métal), sans intermédiaire.\n\nLe paramètre **Roughness** (Rugosité) décrit l\'état microscopique de la surface. Une valeur de `0` correspond à une surface parfaitement lisse, comme un miroir, qui renvoie des reflets nets et concentrés. Une valeur de `1` correspond à une surface très accidentée à l\'échelle microscopique, qui éparpille la lumière dans toutes les directions et produit un aspect mat et diffus. La rugosité est, visuellement, le réglage le plus important d\'un matériau : c\'est elle qui distingue un métal poli d\'un métal sablé, ou un plastique laqué d\'un plastique mat.',
  ),
  SideBySideModule(
    id: 'ch1_sec1_side1',
    title: 'L\'effet de la rugosité',
    content: 'Observez comment le reflet évolue de gauche à droite. À gauche, la rugosité nulle donne un reflet net, presque spéculaire, qui agit comme un miroir. À mesure que la rugosité augmente, le reflet s\'élargit, perd en intensité et finit par disparaître dans un aspect totalement mat à droite. C\'est exactement ce phénomène que vous reproduisez en ajustant une seule valeur dans le shader.',
    imagePath: 'assets/images/placeholder_roughness_gradient_spheres_blender.jpg',
    caption: 'Figure 1.1 : Sept sphères identiques dont la rugosité croît de 0 (gauche) à 1 (droite), sous un même éclairage HDRI de studio.',
    layout: ContentLayout.textLeft,
  ),
  InfoModule(
    id: 'ch1_sec1_tip1',
    type: InfoType.tip,
    text: 'Gardez le réflexe de régler **Metallic** uniquement sur `0` ou `1`. Les valeurs intermédiaires ne correspondent à aucun matériau réel et produisent des résultats incohérents. La seule exception légitime est la transition entre deux matières, par exemple une zone de rouille où le métal redevient progressivement un oxyde non métallique.',
  ),
  TextModule(
    id: 'ch1_sec1_txt4',
    title: 'La conservation de l\'énergie',
    content: 'Le mot « physique » du PBR repose sur un principe simple mais fondamental : **une surface ne peut pas renvoyer plus de lumière qu\'elle n\'en reçoit**. C\'est la conservation de l\'énergie. Quand une surface devient plus rugueuse, elle ne réfléchit pas moins de lumière au total : elle répartit simplement cette même quantité de lumière sur une zone plus large, ce qui rend chaque reflet individuel plus faible.\n\nCette règle, gérée automatiquement par les shaders de Blender, a une conséquence pratique très libératrice : vous n\'avez plus besoin de « tricher » avec vos réglages. En partant de valeurs physiquement plausibles, vous obtenez un résultat crédible sans bricolage. C\'est tout l\'esprit du LookDev moderne.',
  ),
  QuizModule(
    id: 'ch1_sec1_quiz1',
    question: 'Dans le workflow PBR, quelle valeur de Metallic faut-il attribuer à un objet en plastique rouge ?',
    options: [
      '1, car le plastique est brillant',
      '0, car le plastique est un diélectrique (isolant)',
      '0.5, pour un rendu équilibré',
      'Cela dépend uniquement de la couleur choisie',
    ],
    correctIndices: [1],
    explanation: 'Le plastique est un matériau **diélectrique** (non conducteur). Son caractère métallique doit donc rester à `0`. Sa brillance se règle ensuite uniquement avec la **rugosité**, jamais avec le paramètre Metallic.',
  ),

  TitleModule(
    id: 'ch1_sec2_title',
    title: '2. L\'éditeur de nœuds et la structure d\'un matériau',
  ),
  TextModule(
    id: 'ch1_sec2_txt1',
    title: 'L\'espace de travail Shading',
    content: 'Pour construire et observer vos matériaux dans de bonnes conditions, Blender propose un espace de travail dédié. Cliquez sur l\'onglet **Shading** dans la barre d\'onglets située tout en haut de la fenêtre. La disposition de l\'écran change alors automatiquement pour réunir les outils utiles au travail des matières.\n\nCet espace réorganise la fenêtre en plusieurs zones : la vue 3D occupe la partie haute et bascule en mode d\'affichage *Material Preview*, qui montre les matériaux éclairés en temps réel ; le **Shader Editor** (éditeur de nœuds des matériaux) prend toute la partie basse ; un navigateur de fichiers et un éditeur d\'image complètent l\'ensemble pour importer facilement des textures.',
  ),
  SideBySideModule(
    id: 'ch1_sec2_side1',
    title: 'L\'espace de travail Shading',
    content: 'La capture met en évidence l\'onglet *Shading* sélectionné dans la barre supérieure. La vue 3D du haut affiche l\'objet en mode *Material Preview*, tandis que le Shader Editor du bas présente le réseau de nœuds du matériau actif. C\'est dans cette configuration que se déroule l\'essentiel du travail de ce bloc.',
    imagePath: 'assets/images/placeholder_shading_workspace_blender.jpg',
    caption: 'Figure 2.1 : L\'espace de travail Shading, avec la vue 3D en haut et le Shader Editor en bas.',
    layout: ContentLayout.textRight,
  ),
  TextModule(
    id: 'ch1_sec2_txt2',
    title: 'Créer et assigner un matériau',
    content: 'Un objet ne possède pas de matériau par défaut : il faut lui en attribuer un. Sélectionnez votre objet, ouvrez l\'onglet **Material Properties** dans le panneau des propriétés (icône en forme de sphère à damier), puis cliquez sur le bouton **New**. Blender crée alors un matériau de base, déjà constitué d\'un nœud Principled BSDF relié à une sortie. C\'est ce matériau que vous allez sculpter.\n\nUn même objet peut recevoir plusieurs matériaux grâce au système de **slots** (emplacements). Chaque slot pointe vers un matériau, et vous pouvez assigner un slot donné à une sélection de faces précises : il suffit de passer en mode Édition, de sélectionner les faces concernées, de choisir le slot voulu, puis de cliquer sur **Assign**. C\'est ainsi qu\'un seul objet peut combiner, par exemple, une partie métallique et une partie caoutchouc.',
  ),
  TextModule(
    id: 'ch1_sec2_txt3',
    title: 'Le nœud Material Output et le Principled BSDF',
    content: 'Tout matériau dans Blender se lit comme un circuit qui se termine par un nœud final : le **Material Output**. Ce nœud représente la surface telle qu\'elle sera rendue. Il possède plusieurs entrées, dont les principales sont *Surface* (l\'apparence de la surface), *Volume* (pour les matières comme la fumée ou le brouillard) et *Displacement* (pour déformer réellement la géométrie).\n\nSur l\'entrée *Surface* vient se brancher un *shader*. Dans l\'écrasante majorité des cas, ce shader est le **Principled BSDF**, un nœud universel capable à lui seul de représenter presque toutes les matières courantes. Le réseau de base d\'un matériau se résume donc à une chaîne très simple : le Principled BSDF dont la sortie *BSDF* alimente l\'entrée *Surface* du Material Output.',
  ),
  SideBySideModule(
    id: 'ch1_sec2_side2',
    title: 'La chaîne minimale d\'un matériau',
    content: 'On distingue à gauche le nœud Principled BSDF et sa sortie verte *BSDF*, reliée par un câble à l\'entrée *Surface* du nœud Material Output, à droite. Tout matériau, aussi complexe soit-il, se résume à cette structure : une succession de nœuds qui aboutit à la sortie. La couleur verte des connecteurs indique qu\'il s\'agit ici de données de type *shader*.',
    imagePath: 'assets/images/placeholder_principled_to_output_blender.jpg',
    caption: 'Figure 2.2 : La chaîne de base d\'un matériau, du Principled BSDF vers le Material Output.',
    layout: ContentLayout.textLeft,
  ),
  TextModule(
    id: 'ch1_sec2_txt4',
    title: 'Naviguer et ajouter des nœuds',
    content: 'Le Shader Editor se manipule comme la vue 3D : la molette de la souris effectue un zoom, et un clic maintenu sur la molette permet de se déplacer dans le réseau. Pour ajouter un nouveau nœud, ouvrez le menu **Add** (ou utilisez le raccourci `Maj + A`) : les nœuds y sont rangés par catégories (Input, Texture, Color, Vector, Converter, Shader…). Un champ de recherche en haut de ce menu permet de retrouver un nœud par son nom.\n\nLes nœuds communiquent par des **connecteurs** (*sockets*) reliés par des câbles. Pour créer une liaison, cliquez sur le connecteur de sortie d\'un nœud et glissez le câble jusqu\'au connecteur d\'entrée d\'un autre nœud. La couleur de chaque connecteur indique le type de donnée qu\'il transporte, ce qui aide à savoir ce qui peut se brancher où.',
  ),
  SideBySideModule(
    id: 'ch1_sec2_side3',
    title: 'Le code couleur des connecteurs',
    content: 'La capture isole quatre nœuds dont les connecteurs illustrent chaque type de donnée. Le jaune transporte une couleur (Color), le gris une valeur numérique unique (Value, par exemple une rugosité), le bleu ou violet un vecteur (Vector, comme des coordonnées de texture ou une normale), et le vert un shader complet. Relier deux connecteurs de couleurs différentes reste possible : Blender effectue alors une conversion automatique.',
    imagePath: 'assets/images/placeholder_socket_colors_blender.jpg',
    caption: 'Figure 2.3 : Les couleurs de connecteurs dans le Shader Editor (jaune, gris, bleu/violet, vert).',
    layout: ContentLayout.textRight,
  ),
  InfoModule(
    id: 'ch1_sec2_warning1',
    type: InfoType.warning,
    text: 'L\'entrée *Surface* du Material Output n\'accepte qu\'**un seul** shader à la fois. Si vous souhaitez combiner deux aspects (par exemple un vernis sur une base mate), vous ne branchez pas deux shaders en force : vous utilisez un nœud de mélange prévu à cet effet, ou les panneaux internes du Principled BSDF que nous détaillerons à la section suivante.',
  ),
  QuizModule(
    id: 'ch1_sec2_quiz1',
    question: 'Quel nœud constitue toujours la sortie finale d\'un matériau de surface ?',
    options: [
      'Le nœud Principled BSDF',
      'Le nœud Texture Coordinate',
      'Le nœud Material Output',
      'Le nœud Color Ramp',
    ],
    correctIndices: [2],
    explanation: 'Le **Material Output** est le point d\'arrivée obligatoire de tout matériau. C\'est sur son entrée *Surface* que vient se brancher le shader, le plus souvent un Principled BSDF.',
  ),

  TitleModule(
    id: 'ch1_sec3_title',
    title: '3. Le Principled BSDF en détail',
  ),
  TextModule(
    id: 'ch1_sec3_txt1',
    title: 'Un seul shader pour presque tout',
    content: 'Le **Principled BSDF** est le shader universel de Blender. L\'acronyme BSDF (*Bidirectional Scattering Distribution Function*) désigne la fonction qui décrit comment la lumière est diffusée et réfléchie par une surface. « Principled » signifie que ce nœud regroupe, sous une interface unifiée et cohérente, l\'ensemble des phénomènes physiques nécessaires pour représenter la grande majorité des matériaux : du métal au verre, du plastique à la peau, du tissu à la peau, du tissu à la peinture laquée.\n\nSa force pédagogique est immense : plutôt que d\'assembler une dizaine de nœuds différents, vous travaillez un seul nœud dont vous ajustez les paramètres. Dans la version 5.1, ce nœud expose six entrées principales, toujours visibles, complétées par huit panneaux repliables qui regroupent les propriétés plus avancées.',
  ),
  SideBySideModule(
    id: 'ch1_sec3_side1',
    title: 'Anatomie du Principled BSDF',
    content: 'En haut figurent les six entrées toujours visibles : Base Color, Metallic, Roughness, IOR, Alpha et Normal. En dessous, huit panneaux repliables (signalés par une petite flèche) regroupent les fonctions avancées : Diffuse, Subsurface, Specular, Transmission, Coat, Sheen, Emission et Thin Film. Replier ces panneaux garde le nœud lisible tant que vous n\'en avez pas besoin.',
    imagePath: 'assets/images/placeholder_principled_bsdf_node_blender.jpg',
    caption: 'Figure 3.1 : Le nœud Principled BSDF de Blender 5.1, avec ses six entrées principales et ses huit panneaux repliables.',
    layout: ContentLayout.textLeft,
  ),
  TextModule(
    id: 'ch1_sec3_txt2',
    title: 'Le trio essentiel : Base Color, Metallic, Roughness',
    content: 'Trois entrées suffisent à définir l\'aspect de la plupart des matières, et ce sont celles que vous ajusterez en premier.\n\n**Base Color** (couleur de base) définit la teinte fondamentale de la surface. Pour un diélectrique, c\'est la couleur diffuse classique (le rouge d\'un plastique, le brun d\'un bois). Pour un métal, cette couleur prend un rôle particulier : elle teinte directement les reflets, ce qui explique l\'aspect doré de l\'or ou rosé du cuivre.\n\n**Metallic** et **Roughness** reprennent le workflow vu à la section précédente : le premier bascule la surface entre diélectrique (`0`) et métal (`1`), le second contrôle la netteté des reflets, du miroir parfait (`0`) au mat absolu (`1`). À eux trois, ces paramètres couvrent déjà une part considérable des matériaux du quotidien.',
  ),
  TextModule(
    id: 'ch1_sec3_txt3',
    title: 'IOR, Alpha et Normal',
    content: 'Les trois autres entrées principales interviennent dans des cas plus spécifiques.\n\n**IOR** (*Index Of Refraction*, indice de réfraction) décrit la façon dont la lumière se courbe en pénétrant la surface. Sa valeur par défaut de `1.5` correspond à la plupart des matériaux courants. Elle devient déterminante pour les surfaces transparentes comme le verre ou l\'eau, où elle gouverne l\'intensité des reflets et la déviation des rayons.\n\n**Alpha** gère l\'opacité de la surface : `1` pour une surface pleine, une valeur inférieure pour une transparence de type « découpe » (utile pour le feuillage à partir d\'une image, par exemple). Attention à ne pas confondre cette transparence avec celle du verre, qui relève de la réfraction (panneau *Transmission*).\n\n**Normal** permet de brancher une carte de relief (*normal map*) afin de simuler des détails de surface — rainures, grain, bosses — sans alourdir la géométrie. La surface reste plate, mais réagit à la lumière comme si elle était sculptée.',
  ),
  InfoModule(
    id: 'ch1_sec3_info1',
    type: InfoType.warning,
    text: 'L\'entrée **IOR** et le réglage **Specular IOR Level** (situé dans le panneau Specular) sont liés et déjà calibrés pour des valeurs réalistes. Pour un matériau standard, laissez l\'IOR à `1.5` et le Specular IOR Level à `0.5` : ces valeurs par défaut produisent l\'intensité de reflet physiquement correcte. Ne les modifiez que pour des cas précis et documentés.',
  ),
  ListModule(
    id: 'ch1_sec3_list1',
    title: 'Les huit panneaux repliables',
    intro: 'Au-delà du trio essentiel, le Principled BSDF cache ses fonctions avancées dans des panneaux que l\'on déplie au besoin. Voici à quoi sert chacun d\'eux :',
    items: [
      '**Diffuse** : contient *Diffuse Roughness*, qui ajuste l\'aspect de la composante diffuse pour reproduire des surfaces poudreuses ou très mates (effet de type Oren-Nayar).',
      '**Subsurface** : active la diffusion sous la surface (*Subsurface Weight*, *Radius*, *Scale*), indispensable pour la peau, la cire, le marbre, le lait ou le jade, où la lumière pénètre légèrement la matière avant de ressortir.',
      '**Specular** : regroupe *Specular IOR Level* et *Specular Tint*, qui affinent l\'intensité et la teinte du reflet spéculaire des diélectriques.',
      '**Transmission** : avec *Transmission Weight*, rend la surface réfractive pour simuler le verre, l\'eau et les liquides transparents.',
      '**Coat** : ajoute une couche de vernis transparent par-dessus la matière (*Coat Weight*, *Roughness*, *IOR*, *Tint*), comme sur une carrosserie laquée ou un plastique verni.',
      '**Sheen** : crée un reflet rasant et velouté sur les bords (*Sheen Weight*, *Roughness*, *Tint*), parfait pour les tissus, le velours ou un dépôt de poussière.',
      '**Emission** : fait émettre de la lumière à la surface via *Emission Color* et *Emission Strength*, utile pour les écrans, néons et témoins lumineux.',
      '**Thin Film** : simule les interférences de couche mince (*Thickness*, *IOR*), responsables des irisations d\'une bulle de savon ou d\'un traitement optique.',
    ],
    outro: 'Vous n\'utiliserez jamais tous ces panneaux en même temps : chaque matière n\'en mobilise généralement qu\'un ou deux. L\'art du shading consiste justement à identifier lequel correspond au phénomène que vous voulez reproduire.',
  ),
  InfoModule(
    id: 'ch1_sec3_info2',
    type: InfoType.info,
    text: 'Le panneau **Thin Film** est une addition récente du Principled BSDF. Il ouvre la porte à des effets jusque-là difficiles à obtenir simplement, comme les reflets irisés des surfaces savonneuses, des ailes d\'insectes ou des revêtements anti-reflets.',
  ),
  QuizModule(
    id: 'ch1_sec3_quiz1',
    question: 'Vous souhaitez créer une surface en verre transparent. Quel panneau du Principled BSDF devez-vous activer ?',
    options: [
      'Le panneau Coat',
      'Le panneau Transmission',
      'Le panneau Sheen',
      'Le panneau Emission',
    ],
    correctIndices: [1],
    explanation: 'La transparence réfractive du verre s\'obtient via le panneau **Transmission** (en montant *Transmission Weight* à 1). L\'entrée *Alpha*, elle, ne produit qu\'une transparence de découpe sans réfraction, ce qui n\'est pas adapté au verre.',
  ),

  TitleModule(
    id: 'ch1_sec4_title',
    title: '4. Créer des finitions industrielles types',
  ),
  TextModule(
    id: 'ch1_sec4_txt1',
    title: 'Une méthode commune à toutes les matières',
    content: 'Avant de plonger dans les recettes, retenez une démarche systématique qui s\'applique à n\'importe quelle matière. Posez-vous toujours les questions dans cet ordre : la surface est-elle un métal ou un diélectrique (réglage de *Metallic*) ? Quelle est sa couleur de base (*Base Color*) ? Est-elle plutôt brillante ou mate (*Roughness*) ? A-t-elle un comportement particulier — transparence, vernis, émission — qui appellerait un panneau spécifique ? En répondant à ces quatre questions, vous tenez déjà 90 % du résultat.',
  ),
  ResourceModule(
    id: 'ch1_sec4_res1',
    title: 'Scène d\'atelier - Finitions industrielles',
    description: 'Fichier de projet contenant les objets de démonstration (plaque, vis, flacon, boîtier) prêts à recevoir vos matériaux pour suivre les manipulations de cette section.',
    fileName: 'atelier_finitions_industrielles.blend (9.3 Mo)',
    downloadUrl: 'https://example.com/files/atelier-finitions-industrielles',
  ),
  TextModule(
    id: 'ch1_sec4_txt2',
    title: 'Le métal poli et le métal brossé',
    content: 'Un métal poli est l\'une des matières les plus simples à obtenir. Réglez *Metallic* sur `1`, donnez à *Base Color* la teinte du métal voulu (un blanc légèrement bleuté pour l\'acier, un jaune chaud pour l\'or, un rose orangé pour le cuivre), puis baissez la *Roughness* vers `0.1` ou `0.2` pour un éclat franc.\n\nLe métal **brossé** ajoute une difficulté : ses fines stries directionnelles étirent les reflets dans un seul sens. Cet effet s\'obtient grâce au panneau *Specular*, plus précisément avec les réglages d\'anisotropie accessibles dans le nœud (*Anisotropic* et *Anisotropic Rotation*). L\'anisotropie suit la direction des *tangentes* de la surface, lesquelles s\'appuient par défaut sur la carte UV de l\'objet.',
  ),
  ListModule(
    id: 'ch1_sec4_list1',
    title: 'Régler un métal brossé',
    intro: 'Pour reproduire un aluminium brossé de manière contrôlée, procédez dans cet ordre :',
    items: [
      'Réglez *Metallic* sur `1` et choisissez une *Base Color* gris clair neutre.',
      'Fixez une *Roughness* moyenne, autour de `0.3` à `0.4`, qui sert de base à l\'étirement.',
      'Montez la valeur *Anisotropic* vers `0.8` pour étirer fortement les reflets.',
      'Ajustez *Anisotropic Rotation* pour orienter les stries selon l\'axe souhaité.',
    ],
    outro: 'Vérifiez le résultat en orientant l\'objet sous l\'éclairage : les reflets doivent s\'étirer perpiculairement aux stries simulées.',
  ),
  InfoModule(
    id: 'ch1_sec4_warning1',
    type: InfoType.warning,
    text: 'L\'anisotropie a besoin d\'un dépliage UV propre et cohérent pour orienter ses stries de façon prévisible. Sur un objet sans UV ou mal déplié, la direction des reflets brossés peut sembler aléatoire ou tourbillonnante. Pensez donc à déplier votre objet avant de travailler un métal brossé.',
  ),
  TextModule(
    id: 'ch1_sec4_txt3',
    title: 'Les plastiques techniques',
    content: 'Le plastique est un diélectrique : *Metallic* reste à `0`. Sa couleur se règle librement dans *Base Color*, souvent avec une teinte saturée. C\'est la rugosité qui distingue les variantes : un plastique mat technique se règle vers `0.5` à `0.7`, tandis qu\'un plastique laqué descend vers `0.1`.\n\nPour un plastique au fini « verni » de qualité, activez le panneau *Coat* et montez *Coat Weight* à `1`. Vous ajoutez ainsi une fine couche transparente brillante par-dessus la couleur mate, ce qui produit l\'effet caractéristique des boîtiers d\'appareils haut de gamme : une base profonde recouverte d\'un reflet net et indépendant.',
  ),
  SideBySideModule(
    id: 'ch1_sec4_side1',
    title: 'Trois finitions plastiques',
    content: 'À gauche, un plastique mat (rugosité élevée, sans Coat) à l\'aspect doux et diffus. Au centre, un plastique brillant obtenu par simple baisse de la rugosité. À droite, un plastique verni dont le panneau Coat ajoute un reflet de surface net et distinct, donnant cette impression de profondeur typique des coques laquées.',
    imagePath: 'assets/images/placeholder_plastic_finishes_blender.jpg',
    caption: 'Figure 4.1 : Trois échantillons de plastique : mat, brillant, et verni (avec couche Coat).',
    layout: ContentLayout.textRight,
  ),
  TextModule(
    id: 'ch1_sec4_txt4',
    title: 'Le verre',
    content: 'Le verre repose sur le panneau *Transmission*. Montez *Transmission Weight* à `1`, baissez la *Roughness* vers `0` pour un verre parfaitement clair (ou montez-la légèrement pour un verre dépoli), et conservez un *IOR* d\'environ `1.45` à `1.5`. Le rendu correct du verre exige le moteur Cycles, qui calcule réellement la réfraction des rayons.',
  ),
  ListModule(
    id: 'ch1_sec4_list2',
    title: 'Indices de réfraction de référence',
    intro: 'Pour donner à vos transparents une apparence crédible, appuyez-vous sur les valeurs d\'IOR mesurées dans la réalité :',
    items: [
      'Eau : environ `1.33`.',
      'Verre courant : entre `1.45` et `1.52`.',
      'Saphir : environ `1.77`.',
      'Diamant : environ `2.42`.',
    ],
    outro: 'Ces valeurs ne sont pas anecdotiques : un IOR juste est ce qui distingue un verre crédible d\'un transparent « en plastique ».',
  ),
  InfoModule(
    id: 'ch1_sec4_tip2',
    type: InfoType.tip,
    text: 'Si votre verre apparaît opaque ou noir dans le rendu Cycles, le nombre de rebonds de lumière est probablement insuffisant. Augmentez la valeur des rebonds de transmission dans les propriétés de rendu (section *Light Paths*) pour laisser la lumière traverser plusieurs parois de verre successives.',
  ),
  TextModule(
    id: 'ch1_sec4_txt5',
    title: 'Les surfaces mates',
    content: 'Les matières mates — béton, plâtre, caoutchouc, peinture mate — se caractérisent par une rugosité élevée (`0.7` à `1`) et un caractère diélectrique (*Metallic* à `0`). Le reflet y est quasi absent, la lumière étant diffusée dans toutes les directions. Pour une matière textile veloutée, le panneau *Sheen* ajoute en complément un léger halo lumineux sur les bords, qui parachève l\'illusion du tissu.',
  ),
  QuizModule(
    id: 'ch1_sec4_quiz1',
    question: 'Quel réglage est indispensable pour orienter correctement les reflets étirés d\'un métal brossé ?',
    options: [
      'Augmenter l\'IOR au-delà de 2',
      'Disposer d\'un dépliage UV propre sur l\'objet',
      'Activer le panneau Emission',
      'Régler le Metallic sur 0',
    ],
    correctIndices: [1],
    explanation: 'L\'anisotropie suit la direction des tangentes de la surface, qui s\'appuient sur la carte UV. Sans **dépliage UV propre**, la direction des stries du métal brossé devient imprévisible.',
  ),

  TitleModule(
    id: 'ch1_sec5_title',
    title: '5. Les nœuds de réglage : ajuster couleurs et textures en temps réel',
  ),
  TextModule(
    id: 'ch1_sec5_txt1',
    title: 'Le principe : intercaler un nœud',
    content: 'Les nœuds de réglage ne créent pas de matière : ils **transforment une donnée** (le plus souvent une couleur ou une texture) avant qu\'elle n\'arrive à destination. On les intercale entre deux nœuds existants. Dans le Shader Editor, glissez simplement un nœud de réglage par-dessus un câble déjà branché : le câble se met en surbrillance, et lâcher le nœud à cet endroit l\'insère automatiquement dans la chaîne.\n\nL\'avantage décisif de cette approche est qu\'elle est **non destructive** et **temps réel**. Tant que la vue 3D est en mode *Material Preview* ou *Rendered*, chaque modification d\'un curseur se répercute instantanément à l\'écran, sans jamais altérer la texture d\'origine. Vous pouvez donc expérimenter librement.',
  ),
  TextModule(
    id: 'ch1_sec5_txt2',
    title: 'Hue/Saturation/Value',
    content: 'Le nœud **Hue/Saturation/Value** ajuste la teinte, la saturation et la luminosité d\'une couleur entrante. C\'est l\'outil idéal pour décliner une même texture en plusieurs variantes : faire virer un bois du brun au gris, désaturer une matière trop criarde, ou réchauffer une teinte. Son entrée *Color* reçoit la donnée à corriger, et sa sortie *Color* fournit le résultat ajusté.',
  ),
  TextModule(
    id: 'ch1_sec5_txt3',
    title: 'Brightness/Contrast',
    content: 'Le nœud **Brightness/Contrast** propose deux réglages directs : *Brightness* (luminosité) éclaircit ou assombrit globalement, tandis que *Contrast* écarte ou rapproche les valeurs claires et sombres. Très utile pour redonner du punch à une texture trop plate ou, au contraire, adoucir une carte trop dure avant de l\'utiliser comme masque.',
  ),
  TextModule(
    id: 'ch1_sec5_txt4',
    title: 'Color Ramp',
    content: 'Le nœud **Color Ramp** (interne : *ValToRGB*) est l\'un des plus polyvalents. Il transforme une valeur d\'entrée (de 0 à 1) en une couleur lue sur un dégradé que vous définissez à l\'aide de marqueurs (*stops*). Vous pouvez ainsi recolorer un dégradé en noir et blanc, créer des transitions franches en rapprochant deux marqueurs, ou choisir un mode d\'interpolation (linéaire, constant…). Au-delà de la simple recoloration, ce nœud est un outil clé pour fabriquer des masques, comme nous le verrons à la section suivante.',
  ),
  SideBySideModule(
    id: 'ch1_sec5_side1',
    title: 'Le nœud Color Ramp',
    content: 'La capture montre la barre de dégradé du nœud, sur laquelle deux marqueurs définissent une transition du noir au blanc. En déplaçant ces marqueurs l\'un vers l\'autre, on resserre la transition jusqu\'à obtenir une coupure nette : c\'est exactement ce mécanisme qui sert à transformer une texture floue en masque tranché.',
    imagePath: 'assets/images/placeholder_color_ramp_node_blender.jpg',
    caption: 'Figure 5.1 : Le nœud Color Ramp et sa barre de dégradé éditable avec ses marqueurs.',
    layout: ContentLayout.textLeft,
  ),
  TextModule(
    id: 'ch1_sec5_txt5',
    title: 'RGB Curves, Gamma et Invert Color',
    content: 'Trois autres nœuds complètent la boîte à outils. **RGB Curves** offre un contrôle fin de la luminosité par courbes, canal par canal, à la manière d\'un logiciel de retouche photo. **Gamma** corrige la luminosité moyenne d\'une image par une simple valeur de puissance. **Invert Color** inverse les couleurs ou les valeurs — opération précieuse pour retourner un masque (ce qui était blanc devient noir) sans avoir à le refabriquer.',
  ),
  TextModule(
    id: 'ch1_sec5_txt6',
    title: 'Le nœud Mix (Color)',
    content: 'Le nœud **Mix**, réglé sur le type de données *Color*, mélange deux couleurs ou deux textures. Son entrée *Factor* dose la proportion du mélange, et un menu de modes de fusion (Mix, Multiply, Overlay, Screen…) reproduit les calculs familiers de la retouche d\'image. C\'est le couteau suisse de la composition de matières : superposer une salissure sur une base, teinter une texture, combiner deux motifs.',
  ),
  InfoModule(
    id: 'ch1_sec5_info1',
    type: InfoType.info,
    text: 'Dans Blender 5.1, le nœud à utiliser est le nouveau **Mix** (avec son sélecteur de type de données réglé sur *Color*). L\'ancien nœud, désormais nommé **Mix (Legacy)**, n\'est conservé que pour la compatibilité des anciens fichiers : préférez toujours le nœud Mix actuel pour vos nouveaux travaux.',
  ),
  InfoModule(
    id: 'ch1_sec5_tip1',
    type: InfoType.tip,
    text: 'Pour profiter pleinement de l\'aspect temps réel, basculez la vue 3D en mode d\'affichage **Material Preview** (icône de sphère dans le coin supérieur droit de la vue). Vos réglages de couleur s\'affichent alors immédiatement, sans attendre un rendu complet.',
  ),
  QuizModule(
    id: 'ch1_sec5_quiz1',
    question: 'Quel nœud permet de transformer une valeur (de 0 à 1) en une couleur lue sur un dégradé personnalisable ?',
    options: [
      'Brightness/Contrast',
      'Color Ramp',
      'Invert Color',
      'Gamma',
    ],
    correctIndices: [1],
    explanation: 'Le nœud **Color Ramp** convertit une valeur d\'entrée en couleur à l\'aide d\'un dégradé à marqueurs. C\'est aussi un outil central pour fabriquer des masques nets à partir de textures.',
  ),

  TitleModule(
    id: 'ch1_sec6_title',
    title: '6. Introduction aux masques procéduraux : usure et poussière',
  ),
  TextModule(
    id: 'ch1_sec6_txt1',
    title: 'Qu\'est-ce qu\'un masque ?',
    content: 'Un masque est une simple information en niveaux de gris — du noir au blanc — qui sert à **doser le mélange entre deux aspects**. Branché dans l\'entrée *Factor* d\'un nœud Mix, un masque indique où afficher la première matière (zones noires) et où afficher la seconde (zones blanches). Pour vieillir un objet, l\'idée est donc toujours la même : préparer un aspect « neuf » et un aspect « usé », puis fabriquer un masque qui décide où l\'usure apparaît. Tout l\'enjeu consiste à générer ce masque automatiquement, sans le peindre à la main.',
  ),
  TextModule(
    id: 'ch1_sec6_txt2',
    title: 'Masque par les arêtes : Geometry et Pointiness',
    content: 'L\'usure réelle se concentre sur les arêtes saillantes, là où la matière frotte et s\'écaille. Le nœud **Geometry** possède une sortie nommée **Pointiness** qui mesure précisément la convexité de la surface : elle renvoie des valeurs claires sur les arêtes saillantes et sombres dans les creux. En faisant passer cette sortie dans un nœud Color Ramp, vous isolez nettement les arêtes pour y faire apparaître un métal mis à nu.',
  ),
  ListModule(
    id: 'ch1_sec6_list1',
    title: 'Fabriquer une usure d\'arêtes',
    intro: 'Pour révéler du métal sur les arêtes d\'un objet peint, enchaînez les nœuds ainsi :',
    items: [
      'Ajoutez un nœud Geometry et repérez sa sortie *Pointiness*.',
      'Branchez *Pointiness* dans l\'entrée *Factor* d\'un nœud Color Ramp.',
      'Resserrez les marqueurs du Color Ramp pour ne garder que les arêtes les plus saillantes en blanc.',
      'Reliez la sortie du Color Ramp au *Factor* d\'un nœud Mix qui combine la peinture (entrée A) et le métal nu (entrée B).',
    ],
    outro: 'Vous obtenez ainsi une usure qui suit naturellement la forme de l\'objet et se met à jour si vous le déformez.',
  ),
  SideBySideModule(
    id: 'ch1_sec6_side1',
    title: 'L\'usure des arêtes',
    content: 'Sur l\'objet, la peinture sombre cède la place à un métal clair précisément sur les angles vifs, tandis que les surfaces planes restent intactes. Cet effet n\'a pas été peint : il est calculé en temps réel à partir de la sortie Pointiness du nœud Geometry, filtrée par un Color Ramp.',
    imagePath: 'assets/images/placeholder_pointiness_edge_wear_blender.jpg',
    caption: 'Figure 6.1 : Un objet peint dont les arêtes laissent apparaître le métal, via un masque Pointiness.',
    layout: ContentLayout.textRight,
  ),
  TextModule(
    id: 'ch1_sec6_txt3',
    title: 'Masque par cavités : Ambient Occlusion',
    content: 'La poussière et la saleté, à l\'inverse, s\'accumulent dans les creux et les recoins. Le nœud **Ambient Occlusion** mesure exactement cet enfoncement : sa sortie renvoie des valeurs sombres dans les cavités protégées et claires sur les zones exposées. Inversé au besoin, ce signal devient un excellent masque pour déposer une teinte de poussière au fond des reliefs, là où elle se loge réellement.',
  ),
  TextModule(
    id: 'ch1_sec6_txt4',
    title: 'Masque par bruit : Noise Texture',
    content: 'Pour casser toute uniformité et donner une variation naturelle, le nœud **Noise Texture** génère un motif aléatoire et organique. Passé dans un Color Ramp, il fournit des taches irrégulières utiles pour moduler la rugosité (zones plus ou moins polies), parsemer des salissures ou mélanger deux teintes proches. C\'est l\'ingrédient qui éloigne une matière de l\'aspect « parfait » trahissant la synthèse.',
  ),
  InfoModule(
    id: 'ch1_sec6_info1',
    type: InfoType.idea,
    text: 'Combinez plusieurs masques pour gagner en réalisme : multipliez par exemple un masque Pointiness (les arêtes) avec un masque Noise Texture (l\'irrégularité). L\'usure cesse alors d\'être uniforme le long des arêtes et apparaît par plaques irrégulières, exactement comme dans la réalité.',
  ),
  InfoModule(
    id: 'ch1_sec6_challenge1',
    type: InfoType.challenge,
    text: 'Défi d\'application : à partir de la scène d\'atelier, créez un boîtier métallique peint et usé. Préparez une peinture mate colorée et un métal poli, reliez-les par un nœud Mix, puis pilotez ce mélange avec un masque Pointiness pour révéler le métal sur les arêtes. Ajoutez enfin une légère poussière dans les creux à l\'aide d\'un masque Ambient Occlusion. Comparez votre réseau de nœuds avec celui d\'un voisin : il existe souvent plusieurs chemins valables pour un même résultat.',
  ),
  QuizModule(
    id: 'ch1_sec6_quiz1',
    question: 'Vous voulez faire apparaître de la poussière qui s\'accumule au fond des creux d\'un objet. Quel nœud génère le masque le plus adapté ?',
    options: [
      'Geometry (sortie Pointiness)',
      'Ambient Occlusion',
      'Emission',
      'Brightness/Contrast',
    ],
    correctIndices: [1],
    explanation: 'Le nœud **Ambient Occlusion** détecte les cavités et zones protégées de la surface. C\'est le masque idéal pour y déposer poussière et salissures, là où elles s\'accumulent naturellement. Le masque Pointiness, lui, cible au contraire les arêtes saillantes.',
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
