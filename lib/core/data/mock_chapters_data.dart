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
    title: 'Texturage Agile & Gestion Simplifiée des UVs',
  ),
  TitleModule(
    id: 'ch2_sec1_title',
    title: '1. Comprendre les UV : du volume 3D à l\'image 2D',
  ),
  TextModule(
    id: 'ch2_sec1_txt1',
    title: 'Le problème de fond : poser une image plate sur un volume',
    content: 'Une texture est une image : un rectangle plat, en deux dimensions. Un objet 3D, lui, possède un volume, des courbes, des faces orientées dans toutes les directions. Se pose alors une question simple mais centrale : comment Blender sait-il quel pixel de l\'image doit se poser sur quelle partie de la surface ? La réponse tient dans les **coordonnées UV**.\n\nLes lettres U et V désignent les deux axes d\'un système de coordonnées propre à la texture : U pour l\'horizontale, V pour la verticale (on emploie U et V plutôt que X et Y, déjà utilisés par l\'espace 3D). Chaque point du maillage se voit attribuer une position sur cette grille 2D. Le dépliage UV (*UV unwrapping*) est l\'opération qui consiste à « aplatir » la surface de l\'objet sur ce plan, afin que l\'image puisse s\'y appliquer sans confusion.',
  ),
  TextModule(
    id: 'ch2_sec1_txt2',
    title: 'Une analogie : déplier un emballage',
    content: 'Pour visualiser le dépliage, imaginez un emballage en carton que l\'on déplie à plat, ou un patron de couture. La boîte en volume devient une forme étalée, découpée à certains endroits pour pouvoir reposer entièrement sur la table. C\'est exactement ce que fait Blender avec la surface d\'un objet : il la découpe le long de lignes choisies, puis l\'étale sur le plan UV. L\'image se pose ensuite sur cette version aplatie, et l\'objet « rhabillé » la porte sur son volume.',
  ),
  TextModule(
    id: 'ch2_sec1_txt3',
    title: 'L\'espace de travail UV Editing',
    content: 'Blender propose un espace de travail dédié à cette tâche : l\'onglet **UV Editing**, dans la barre supérieure. Il divise l\'écran en deux : à gauche, l\'**éditeur UV** affiche le dépliage à plat (et l\'image qui s\'y applique) ; à droite, la vue 3D montre l\'objet en mode Édition. Pour voir et manipuler les UV, vous devez entrer en **mode Édition** (touche `Tab`) et sélectionner des faces : leur dépliage apparaît alors dans l\'éditeur de gauche.',
  ),
  SideBySideModule(
    id: 'ch2_sec1_side1',
    title: 'L\'espace de travail UV Editing',
    content: 'La capture met en évidence l\'onglet UV Editing sélectionné. À gauche, l\'éditeur UV présente le dépliage à plat des faces sélectionnées dans la vue 3D de droite. Toute modification du dépliage se reflète immédiatement sur l\'objet, et inversement. C\'est l\'atelier dans lequel se déroule tout le travail sur les coordonnées.',
    imagePath: 'assets/images/placeholder_uv_editing_workspace_blender.jpg',
    caption: 'Figure 1.1 : L\'espace de travail UV Editing, avec l\'éditeur UV à gauche et la vue 3D en mode Édition à droite.',
    layout: ContentLayout.textRight,
  ),
  TextModule(
    id: 'ch2_sec1_txt4',
    title: 'Coutures et îlots',
    content: 'Pour déplier une surface fermée, Blender a besoin de savoir où la « découper ». Ces lignes de découpe s\'appellent des **coutures** (*seams*). On les définit en mode Édition : sélectionnez les arêtes voulues, puis utilisez le menu *Edge* ou le raccourci `Ctrl + E`, et choisissez **Mark Seam**. Les arêtes marquées apparaissent en rouge. Après dépliage, la surface se sépare en morceaux distincts appelés **îlots** (*islands*), chacun étant une portion étalée à plat dans l\'éditeur UV.\n\nLa qualité d\'un dépliage se mesure à sa faible **déformation** : un bon placement de coutures permet d\'étaler la surface presque sans étirement, comme un tissu posé bien à plat. À l\'inverse, de mauvaises coutures forcent la matière et déforment l\'image appliquée.',
  ),
  InfoModule(
    id: 'ch2_sec1_tip1',
    type: InfoType.tip,
    text: 'Pour repérer instantanément les déformations, appliquez temporairement une texture en damier sur votre objet. Si les carreaux apparaissent réguliers et carrés partout, votre dépliage est sain ; s\'ils sont étirés ou tordus à certains endroits, c\'est le signe d\'un étirement à corriger.',
  ),
  QuizModule(
    id: 'ch2_sec1_quiz1',
    question: 'À quoi sert une couture (seam) dans le dépliage UV ?',
    options: [
      'À renforcer la solidité du maillage',
      'À indiquer à Blender où découper la surface pour l\'aplatir',
      'À augmenter la résolution de la texture',
      'À fusionner deux objets',
    ],
    correctIndices: [1],
    explanation: 'Une **couture** marque les arêtes le long desquelles Blender « découpe » la surface pour pouvoir l\'étaler à plat sur le plan UV, exactement comme les découpes d\'un patron de couture ou d\'un emballage en carton.',
  ),

  TitleModule(
    id: 'ch2_sec2_title',
    title: '2. Le dépliage automatique : Smart UV Project',
  ),
  TextModule(
    id: 'ch2_sec2_txt1',
    title: 'Pourquoi automatiser le dépliage ?',
    content: 'Placer manuellement des coutures sur un objet simple est rapide. Mais sur une pièce mécanique complexe, un objet aux multiples facettes ou un maillage très dense, ce travail devient long et fastidieux. Heureusement, Blender propose des méthodes de dépliage **automatisées** qui analysent la géométrie et produisent un résultat exploitable en un clic. C\'est tout l\'esprit du « texturage agile » : obtenir vite un dépliage propre, sans intervention manuelle lourde.',
  ),
  ResourceModule(
    id: 'ch2_sec2_res1',
    title: 'Objets de test - Dépliage UV',
    description: 'Lot d\'objets de complexité croissante (écrou, boîtier électronique, garde-corps) pour vous entraîner aux différentes méthodes de dépliage automatique de cette section.',
    fileName: 'objets_test_depliage_uv.blend (7.8 Mo)',
    downloadUrl: 'https://example.com/files/objets-test-depliage-uv',
  ),
  TextModule(
    id: 'ch2_sec2_txt2',
    title: 'Smart UV Project, la méthode passe-partout',
    content: 'Smart UV Project est la méthode automatique de référence. En mode Édition, sélectionnez toutes les faces (touche `A`), ouvrez le menu de dépliage avec `U`, puis choisissez **Smart UV Project**. Blender analyse alors l\'angle entre les faces voisines et crée automatiquement des coutures là où la surface change brusquement de direction. Une fenêtre d\'options s\'affiche pour affiner le résultat.',
  ),
  SideBySideModule(
    id: 'ch2_sec2_side1',
    title: 'Les options de Smart UV Project',
    content: 'La fenêtre regroupe les réglages clés. *Angle Limit* fixe le seuil d\'angle au-delà duquel une nouvelle découpe est créée : plus la valeur est basse, plus le dépliage se fragmente en petits îlots. *Island Margin* définit l\'espace laissé entre les îlots pour éviter qu\'ils ne se chevauchent. Ces deux réglages suffisent dans la grande majorité des cas.',
    imagePath: 'assets/images/placeholder_smart_uv_project_options_blender.jpg',
    caption: 'Figure 2.1 : La fenêtre d\'options de Smart UV Project (Angle Limit, Island Margin, etc.).',
    layout: ContentLayout.textLeft,
  ),
  ListModule(
    id: 'ch2_sec2_list1',
    title: 'Mettre en œuvre un dépliage automatique',
    intro: 'Pour déplier un objet complexe en quelques secondes, suivez cette séquence :',
    items: [
      'Passez en mode Édition et sélectionnez toutes les faces avec `A`.',
      'Ouvrez le menu `U` et choisissez Smart UV Project.',
      'Réglez *Angle Limit* (autour de 66° par défaut convient à la plupart des pièces dures).',
      'Augmentez légèrement *Island Margin* pour éviter tout chevauchement entre îlots.',
      'Validez : le dépliage apparaît dans l\'éditeur UV, prêt à recevoir une texture.',
    ],
  ),
  TextModule(
    id: 'ch2_sec2_txt3',
    title: 'Les autres méthodes rapides',
    content: 'Smart UV Project n\'est pas la seule option du menu `U`. La méthode **Unwrap** déplie en s\'appuyant sur les coutures que vous avez posées vous-même, avec un choix d\'algorithmes (*Angle Based*, *Conformal*, *Minimum Stretch*) selon le compromis recherché entre fidélité des angles et limitation de l\'étirement. Les projections **Cube**, **Cylinder** et **Sphere Project** conviennent aux objets dont la forme s\'approche de ces volumes simples. Enfin, **Pack Islands** réorganise et tasse les îlots existants pour exploiter au mieux la surface disponible de la texture.',
  ),
  InfoModule(
    id: 'ch2_sec2_warning1',
    type: InfoType.warning,
    text: 'Smart UV Project est rapide et idéal pour les objets « durs » (mécaniques, architecturaux). Sur un modèle organique destiné à être vu de près — un visage, un personnage — il a tendance à fragmenter la surface en de nombreux petits îlots, ce qui complique la peinture de texture. Pour ces cas, un placement manuel des coutures suivi d\'un *Unwrap* reste préférable.',
  ),
  QuizModule(
    id: 'ch2_sec2_quiz1',
    question: 'Sur quel critère Smart UV Project décide-t-il automatiquement de créer une nouvelle couture ?',
    options: [
      'La couleur des faces',
      'L\'angle entre les faces voisines (Angle Limit)',
      'Le nombre total de sommets',
      'La taille du fichier de texture',
    ],
    correctIndices: [1],
    explanation: 'Smart UV Project analyse l\'**angle entre les faces adjacentes** : au-delà du seuil défini par *Angle Limit*, il crée une découpe. C\'est ce qui lui permet de déplier automatiquement une pièce complexe sans coutures posées à la main.',
  ),

  TitleModule(
    id: 'ch2_sec3_title',
    title: '3. Texturer sans UV : la projection Box (triplanaire)',
  ),
  TextModule(
    id: 'ch2_sec3_txt1',
    title: 'Et si l\'on se passait du dépliage ?',
    content: 'Le dépliage UV n\'est pas toujours nécessaire. Pour de nombreuses surfaces — un mur, un rocher, un terrain, un maillage dense issu d\'un scan — déplier proprement coûterait beaucoup de temps pour un bénéfice nul. Dans ces situations, on peut **projeter** la texture directement sur la géométrie à partir de sa position dans l\'espace, sans aucune coordonnée UV. C\'est le workflow « sans UV », instantané et particulièrement efficace.',
  ),
  TextModule(
    id: 'ch2_sec3_txt2',
    title: 'Le mode Box du nœud Image Texture',
    content: 'Le mode Box du nœud Image Texture possède un menu déroulant **Projection** offrant quatre modes : *Flat* (le mode par défaut, qui s\'appuie sur les UV), *Box*, *Sphere* et *Tube*. Le mode **Box** correspond à la projection dite **triplanaire** : la texture est projetée simultanément depuis les trois axes (X, Y, Z), chaque face de l\'objet recevant l\'image depuis la direction qui lui fait le plus face. Plus besoin de déplier : la texture se pose d\'elle-même, où que se trouve la géométrie.',
  ),
  TextModule(
    id: 'ch2_sec3_txt3',
    title: 'Le paramètre Blend, clé d\'une projection propre',
    content: 'Dès que le mode Box est sélectionné, un curseur **Blend** apparaît sous le menu de projection. Il contrôle la zone de fondu entre les trois projections. À `0`, les jonctions entre les axes sont franches et laissent apparaître des coupures nettes. En montant la valeur vers `0.2` ou `0.3`, ces transitions se fondent en douceur, ce qui efface les démarcations sur les faces inclinées. C\'est le réglage qui transforme une projection visiblement « plaquée » en un habillage convaincant.',
  ),
  SideBySideModule(
    id: 'ch2_sec3_side1',
    title: 'Le curseur Blend de la projection Box',
    content: 'À gauche de l\'illustration, avec un Blend à 0, on devine les arêtes où deux projections se rencontrent : la texture présente des cassures nettes. À droite, avec un Blend modéré, les trois projections se mélangent progressivement et l\'objet semble entièrement et naturellement recouvert. Une valeur faible mais non nulle suffit presque toujours.',
    imagePath: 'assets/images/placeholder_box_projection_blend_blender.jpg',
    caption: 'Figure 3.1 : Effet du curseur Blend en projection Box, de 0 (coupures visibles) à 0.3 (transitions fondues).',
    layout: ContentLayout.textRight,
  ),
  TextModule(
    id: 'ch2_sec3_txt4',
    title: 'Quelles coordonnées alimenter la projection ?',
    content: 'Puisque l\'on se passe d\'UV, il faut indiquer au nœud quelle référence spatiale utiliser. On branche pour cela un nœud **Texture Coordinate** dont les sorties *Object* ou *Generated* conviennent à la projection Box. La sortie *Generated* s\'appuie sur la boîte englobante normalisée de l\'objet, tandis que *Object* utilise son espace local : la première suit les proportions de l\'objet, la seconde reste stable même si l\'objet est déformé.',
  ),
  InfoModule(
    id: 'ch2_sec3_tip1',
    type: InfoType.tip,
    text: 'La projection Box est l\'outil rêvé pour habiller en quelques secondes des rochers, des terrains, des murs ou tout maillage dense où le dépliage serait pénible. Associez-la systématiquement à une texture *seamless* (sans raccord) pour un résultat impeccable.',
  ),
  InfoModule(
    id: 'ch2_sec3_info1',
    type: InfoType.info,
    text: 'La projection Box a ses limites : sur les faces fortement inclinées (autour de 45°), un léger étirement ou un mélange de deux orientations peut apparaître. Elle offre aussi moins de contrôle qu\'un vrai dépliage UV pour placer un motif précis, comme un logo. C\'est un compromis rapidité/précision à assumer selon l\'objet.',
  ),
  QuizModule(
    id: 'ch2_sec3_quiz1',
    question: 'Quel mode de projection du nœud Image Texture permet d\'habiller un objet sans aucun dépliage UV ?',
    options: [
      'Flat',
      'Box',
      'Sphere',
      'Tube',
    ],
    correctIndices: [1],
    explanation: 'Le mode **Box** réalise une projection triplanaire (depuis les axes X, Y et Z) qui pose la texture directement sur la géométrie, sans coordonnées UV. Le mode *Flat*, lui, s\'appuie au contraire sur le dépliage UV existant.',
  ),

  TitleModule(
    id: 'ch2_sec4_title',
    title: '4. Maîtriser le Mapping : échelle, répétition, orientation',
  ),
  TextModule(
    id: 'ch2_sec4_txt1',
    title: 'Le duo Texture Coordinate + Mapping',
    content: 'Une fois la texture posée, encore faut-il la placer correctement : à la bonne taille, au bon endroit, dans la bonne orientation. Ce contrôle se fait en amont du nœud Image Texture, grâce à deux nœuds qui travaillent ensemble. Le nœud **Texture Coordinate** fournit le système de coordonnées (UV, Generated, Object…), et le nœud **Mapping** transforme ces coordonnées avant qu\'elles n\'atteignent la texture. La chaîne type est donc : Texture Coordinate, puis Mapping, puis Image Texture.',
  ),
  SideBySideModule(
    id: 'ch2_sec4_side1',
    title: 'Piloter le placement d\'une texture',
    content: 'La capture montre les trois nœuds reliés dans l\'ordre : la sortie de coordonnées du Texture Coordinate alimente l\'entrée Vector du Mapping, dont la sortie nourrit à son tour l\'entrée Vector de l\'Image Texture. Tout ajustement effectué dans le nœud Mapping se répercute en temps réel sur la texture affichée.',
    imagePath: 'assets/images/placeholder_mapping_chain_blender.jpg',
    caption: 'Figure 4.1 : La chaîne Texture Coordinate vers Mapping vers Image Texture.',
    layout: ContentLayout.textLeft,
  ),
  TextModule(
    id: 'ch2_sec4_txt2',
    title: 'Le nœud Mapping en détail',
    content: 'Le nœud Mapping expose trois réglages, chacun disponible aussi en entrée connectable : **Location** déplace la texture sur la surface, **Rotation** l\'oriente, et **Scale** ajuste son échelle. Un point souvent contre-intuitif mérite l\'attention : augmenter la valeur de *Scale* **réduit** la taille apparente du motif et le fait se répéter davantage. En effet, on agrandit la grille de coordonnées, donc la texture se densifie. À l\'inverse, une valeur de *Scale* inférieure à 1 agrandit le motif.',
  ),
  TextModule(
    id: 'ch2_sec4_txt3',
    title: 'Le carrelage et les modes d\'extension',
    content: 'Lorsqu\'une texture se répète sur une grande surface, son comportement aux bords est régi par le menu **Extension** du nœud Image Texture, qui propose quatre modes. **Repeat** répète la texture à l\'identique dans toutes les directions : c\'est le mode du carrelage classique, qui exige une texture *seamless* pour éviter les raccords visibles. **Mirror** répète en inversant une fois sur deux, ce qui masque astucieusement les jointures. **Extend** étire les pixels du bord au-delà de l\'image, et **Clip** n\'affiche qu\'une seule occurrence, le reste devenant transparent.',
  ),
  ResourceModule(
    id: 'ch2_sec4_res1',
    title: 'Pack de textures seamless',
    description: 'Sélection de textures sans raccord (béton, métal, bois, tissu) prêtes à être carrelées pour vous exercer au Mapping et aux modes d\'extension.',
    fileName: 'pack_textures_seamless.zip (24.6 Mo)',
    downloadUrl: 'https://example.com/files/pack-textures-seamless',
  ),
  TextModule(
    id: 'ch2_sec4_txt4',
    title: 'Casser la répétition visible',
    content: 'Sur de très grandes surfaces, même une texture seamless finit par trahir son motif répété : l\'œil repère les éléments qui reviennent à intervalles réguliers. Plusieurs réflexes limitent cet effet : utiliser le mode *Mirror*, mélanger une seconde texture à grande échelle pour introduire des variations lentes de teinte, ou faire varier subtilement l\'orientation. L\'objectif est toujours de tromper la perception de la régularité.',
  ),
  InfoModule(
    id: 'ch2_sec4_tip1',
    type: InfoType.tip,
    text: 'Retenez la logique du Scale : pour qu\'un motif paraisse **deux fois plus petit** et se répète deux fois plus, doublez la valeur de *Scale* dans le nœud Mapping. C\'est l\'erreur la plus fréquente des débutants, qui s\'attendent à l\'effet inverse.',
  ),
  QuizModule(
    id: 'ch2_sec4_quiz1',
    question: 'Dans le nœud Mapping, quel est l\'effet d\'une augmentation de la valeur Scale sur une texture ?',
    options: [
      'Le motif devient plus grand et se répète moins',
      'Le motif devient plus petit et se répète davantage',
      'La texture pivote sur elle-même',
      'La texture change de couleur',
    ],
    correctIndices: [1],
    explanation: 'Augmenter *Scale* agrandit la grille de coordonnées, ce qui **réduit** la taille apparente du motif et le fait se **répéter davantage**. C\'est un effet contre-intuitif qu\'il faut mémoriser.',
  ),

  TitleModule(
    id: 'ch2_sec5_title',
    title: '5. Habiller vite une géométrie dense : choisir la bonne méthode',
  ),
  TextModule(
    id: 'ch2_sec5_txt1',
    title: 'Il n\'existe pas une seule bonne méthode',
    content: 'Le texturage agile ne consiste pas à appliquer toujours la même technique, mais à **choisir la méthode adaptée à chaque objet**. Un dépliage UV soigné est parfois indispensable ; ailleurs, il serait une perte de temps pure. Savoir arbitrer, c\'est gagner des heures sans rien sacrifier à la qualité visible. Cette section ne présente pas de nouvel outil : elle vous donne le raisonnement qui relie tous les précédents.',
  ),
  ListModule(
    id: 'ch2_sec5_list1',
    title: 'L\'arbre de décision',
    intro: 'Face à un objet à texturer, posez-vous les bonnes questions dans l\'ordre :',
    items: [
      'L\'objet sera vu de près et exige un placement précis (un personnage, un visage, une étiquette, un objet héros) : optez pour un **dépliage UV**, manuel ou via Smart UV Project.',
      'L\'objet est grand, uniforme et répétitif (mur, sol, rocher, terrain) : préférez la **projection Box** ou un carrelage UV avec texture seamless, sans dépliage manuel.',
      'Le maillage est dense ou issu d\'une sculpture ou d\'un scan, sans topologie propre : la **projection Box** vous épargne des heures de pose de coutures.',
      'La forme est proche d\'un volume simple (boîte, cylindre, sphère) : une **projection Cube, Cylinder ou Sphere** donne un résultat immédiat.',
    ],
    outro: 'En résumé : on déplie ce qui doit être précis, on projette tout le reste.',
  ),
  TextModule(
    id: 'ch2_sec5_txt2',
    title: 'Le réflexe seamless',
    content: 'La clé de l\'habillage rapide des grandes géométries tient en un mot : *seamless*. Une texture sans raccord, même de petite taille, peut couvrir une surface immense en se répétant sans jointure apparente. Associée au nœud Mapping pour l\'échelle et au mode d\'extension Repeat ou Mirror, elle permet d\'habiller un mur entier ou un sol complet à partir d\'un seul fichier léger.',
  ),
  TextModule(
    id: 'ch2_sec5_txt3',
    title: 'Gagner du temps sans sacrifier la qualité',
    content: 'La règle d\'or du workflow agile est de **ne pas soigner ce qui ne sera pas vu**. Inutile de déplier méticuleusement l\'arrière d\'un objet caché ou une surface lointaine. Commencez toujours par la méthode la plus rapide qui donne un résultat acceptable, puis n\'investissez du temps de dépliage manuel que sur les zones réellement exposées au regard. C\'est ce tri permanent qui distingue un workflow efficace d\'un travail laborieux.',
  ),
  InfoModule(
    id: 'ch2_sec5_idea1',
    type: InfoType.idea,
    text: 'Faites l\'expérience sur un même objet dense : habillez-le une première fois en projection Box, puis une seconde fois via Smart UV Project suivi d\'un carrelage. Comparez le temps passé et le rendu final. Vous mesurerez concrètement dans quels cas chaque méthode vaut son investissement.',
  ),
  QuizModule(
    id: 'ch2_sec5_quiz1',
    question: 'Vous devez texturer rapidement un grand rocher au maillage dense, sans topologie propre. Quelle méthode est la plus indiquée ?',
    options: [
      'Un dépliage UV manuel face par face',
      'La projection Box avec une texture seamless',
      'Le mode d\'extension Clip',
      'Aucune, il faut remodéliser l\'objet',
    ],
    correctIndices: [1],
    explanation: 'Sur un maillage dense sans topologie exploitable, la **projection Box** associée à une texture seamless habille l\'objet instantanément, sans le moindre dépliage manuel. C\'est l\'application type du texturage agile.',
  ),

  TitleModule(
    id: 'ch2_sec6_title',
    title: '6. Constituer sa bibliothèque de matériaux : l\'Asset Browser',
  ),
  TextModule(
    id: 'ch2_sec6_txt1',
    title: 'Pourquoi se constituer une bibliothèque ?',
    content: 'Recréer les mêmes matériaux d\'un projet à l\'autre est une perte de temps considérable. Le métal, le verre ou le plastique que vous avez patiemment réglés méritent d\'être réutilisés. L\'**Asset Browser** (navigateur d\'assets) répond exactement à ce besoin : il stocke vos matériaux — mais aussi vos objets ou vos groupes de nœuds — dans une bibliothèque accessible depuis n\'importe quel fichier, par un simple glisser-déposer.',
  ),
  TextModule(
    id: 'ch2_sec6_txt2',
    title: 'Marquer un matériau comme asset',
    content: 'Pour qu\'un matériau rejoigne la bibliothèque, il faut le **marquer comme asset**. Faites un clic droit sur le matériau, dans la liste des matériaux ou directement dans l\'Asset Browser, puis choisissez **Mark as Asset**. Blender génère alors automatiquement un aperçu miniature et range le matériau parmi les assets disponibles. L\'opération inverse, *Clear Asset*, le retire de la bibliothèque.',
  ),
  SideBySideModule(
    id: 'ch2_sec6_side1',
    title: 'Marquer un matériau comme asset',
    content: 'La capture montre le clic droit sur un matériau faisant apparaître l\'option Mark as Asset. Une fois validée, une vignette d\'aperçu est créée et le matériau devient disponible dans l\'Asset Browser. C\'est cette vignette qui permettra plus tard de le reconnaître d\'un coup d\'œil dans la bibliothèque.',
    imagePath: 'assets/images/placeholder_mark_as_asset_blender.jpg',
    caption: 'Figure 6.1 : Le menu contextuel Mark as Asset appliqué à un matériau, et l\'aperçu généré.',
    layout: ContentLayout.textLeft,
  ),
  TextModule(
    id: 'ch2_sec6_txt3',
    title: 'Mettre en place et parcourir sa bibliothèque',
    content: 'L\'éditer Asset Browser s\'ouvre dans son propre espace ou en remplaçant une zone existante. Pour qu\'il affiche vos assets entre plusieurs fichiers, désignez un dossier de bibliothèque dans les préférences de Blender, à la rubrique des chemins de fichiers (*File Paths*, section *Asset Libraries*). Tous les fichiers .blend rangés dans ce dossier exposeront alors leurs assets dans le navigateur. Appliquer un matériau devient immédiat : il suffit de le faire glisser depuis le navigateur jusqu\'à l\'objet dans la vue 3D.',
  ),
  TextModule(
    id: 'ch2_sec6_txt4',
    title: 'Organiser avec des catalogues',
    content: 'Une bibliothèque qui grossit doit rester rangée. L\'Asset Browser permet de créer des **catalogues**, sortes de dossiers thématiques (Métaux, Plastiques, Verres…), et d\'ajouter à chaque asset des étiquettes et une description. Un classement clair fait toute la différence le jour où la bibliothèque compte des dizaines de matières.',
  ),
  InfoModule(
    id: 'ch2_sec6_tip1',
    type: InfoType.tip,
    text: 'Réservez un fichier .blend dédié, par exemple nommé *bibliotheque_materiaux.blend*, pour y rassembler tous vos matériaux marqués comme assets. Vous disposerez ainsi d\'un point unique à entretenir, que tous vos projets pourront piloter via les préférences.',
  ),
  InfoModule(
    id: 'ch2_sec6_challenge1',
    type: InfoType.challenge,
    text: '**Défi d\'application :** à partir des matières travaillées au Bloc 1, constituez votre première bibliothèque personnelle. Créez cinq matériaux (un métal poli, un verre, un plastique technique, un métal usé et un tissu mat), marquez-les comme assets, soignez leurs aperçus, puis rangez-les dans un catalogue nommé d\'après le cours. Vous repartirez de la formation avec une base réutilisable immédiatement.',
  ),
  QuizModule(
    id: 'ch2_sec6_quiz1',
    question: 'Quelle action rend un matériau disponible dans l\'Asset Browser pour être réutilisé entre plusieurs fichiers ?',
    options: [
      'Renommer le matériau',
      'Le marquer comme asset (Mark as Asset)',
      'Augmenter sa résolution de texture',
      'Le brancher deux fois au Material Output',
    ],
    correctIndices: [1],
    explanation: 'C\'est la commande **Mark as Asset** qui intègre le matériau à la bibliothèque, génère son aperçu et le rend accessible par glisser-déposer depuis l\'Asset Browser, y compris dans d\'autres fichiers.',
  ),
];

const List<ContentModule> chapter3Modules = [
  TitleModule(
    id: 'ch3_title',
    title: 'Mise en lumière & Méthodes de Rendu',
  ),
  TitleModule(
    id: 'ch3_sec1_title',
    title: '1. Les deux moteurs de rendu : EEVEE et Cycles',
  ),
  TextModule(
    id: 'ch3_sec1_txt1',
    title: 'À quoi sert un moteur de rendu ?',
    content: 'Une scène 3D n\'est, en mémoire, qu\'un ensemble de données : des géométries, des matériaux, des lampes et une caméra. Le **moteur de rendu** est le programme qui transforme ces données en une image finie, en calculant, pixel par pixel, la lumière qui parvient à la caméra. Blender embarque deux moteurs aux philosophies opposées et complémentaires : **EEVEE** et **Cycles**. Bien comprendre leurs différences est le point de départ de tout travail de rendu.',
  ),
  TextModule(
    id: 'ch3_sec1_txt2',
    title: 'EEVEE : le temps réel enrichi',
    content: 'EEVEE est un moteur de **rastérisation** : il privilégie la vitesse et l\'interactivité, produisant une image quasi instantanée. C\'est l\'outil idéal pour ajuster ses matériaux et son éclairage en voyant le résultat se mettre à jour en direct. Dans cette version de Blender, EEVEE a gagné un véritable **raytracing**, qui améliore nettement la qualité de ses reflets, de ses ombres et de son occlusion. Il reste néanmoins un moteur orienté rapidité, parfait pour le LookDev, la prévisualisation et les rendus stylisés.',
  ),
  TextModule(
    id: 'ch3_sec1_txt3',
    title: 'Cycles : le path tracing physique',
    content: 'Cycles est un moteur de **lancer de rayons** (*path tracing*) : il simule physiquement le trajet des rayons de lumière qui rebondissent dans la scène. Plus lent qu\'EEVEE, il offre en contrepartie un réalisme supérieur — éclairage global authentique, réfraction exacte du verre, ombres douces naturelles, caustiques. C\'est le moteur du rendu final photoréaliste, lorsque la qualité prime sur la vitesse.',
  ),
  TextModule(
    id: 'ch3_sec1_txt4',
    title: 'Le workflow hybride',
    content: 'La force de Blender est de pouvoir combiner les deux. La pratique professionnelle consiste à travailler toute la phase de mise au point — matériaux, éclairage, cadrage — sous **EEVEE**, pour profiter de son immédiateté, puis à basculer sur **Cycles** au moment du rendu final. Comme les deux moteurs partagent exactement les mêmes matériaux PBR et les mêmes lampes, ce passage se fait sans rien reconstruire. Le changement de moteur s\'opère dans les propriétés de rendu, via le menu *Render Engine*.',
  ),
  SideBySideModule(
    id: 'ch3_sec1_side1',
    title: 'Basculer d\'un moteur à l\'autre',
    content: 'La capture isole le menu Render Engine, en haut des propriétés de rendu, qui permet de choisir entre EEVEE et Cycles. Comme la scène, ses matériaux et ses lampes sont communs aux deux moteurs, on peut passer de l\'un à l\'autre à tout moment pour comparer rapidité et fidélité.',
    imagePath: 'assets/images/placeholder_render_engine_dropdown_blender.jpg',
    caption: 'Figure 1.1 : Le sélecteur de moteur de rendu dans les propriétés de rendu (EEVEE / Cycles).',
    layout: ContentLayout.textLeft,
  ),
  InfoModule(
    id: 'ch3_sec1_tip1',
    type: InfoType.tip,
    text: 'Ne confondez pas le moteur de rendu et le mode d\'affichage de la vue 3D. Le mode **Material Preview** (icône de sphère) affiche toujours un aperçu rapide basé sur EEVEE avec un éclairage d\'étude neutre, tandis que le mode **Rendered** affiche la scène avec le moteur réellement sélectionné. Pour juger un rendu Cycles, passez bien la vue en mode Rendered.',
  ),
  QuizModule(
    id: 'ch3_sec1_quiz1',
    question: 'Dans le workflow hybride recommandé, quel moteur utilise-t-on pour la mise au point interactive de l\'éclairage et des matériaux ?',
    options: [
      'Cycles, car il est plus précis',
      'EEVEE, pour son retour quasi instantané',
      'Aucun, on travaille à l\'aveugle',
      'Les deux simultanément en permanence',
    ],
    correctIndices: [1],
    explanation: 'On réserve **EEVEE** à la phase interactive (LookDev, réglage des lumières) grâce à sa rapidité, puis on bascule sur **Cycles** uniquement pour le rendu final photoréaliste. Les matériaux et lampes étant partagés, le passage est immédiat.',
  ),

  TitleModule(
    id: 'ch3_sec2_title',
    title: '2. Les sources de lumière dans Blender',
  ),
  TextModule(
    id: 'ch3_sec2_txt1',
    title: 'Ajouter une lampe à la scène',
    content: 'Sans source de lumière, une scène rendue sous Cycles reste noire. On ajoute une lampe via le menu **Add > Light**, puis on choisit son type. Chaque type de lampe imite un comportement physique différent, et le choix du bon type est la première décision d\'un éclairage réussi.',
  ),
  ListModule(
    id: 'ch3_sec2_list1',
    title: 'Les quatre types de lampes',
    intro: 'Blender propose quatre sources, chacune adaptée à un usage :',
    items: [
      '**Point** : émet dans toutes les directions depuis un point, comme une ampoule nue. Réglée par sa puissance (*Power*, en watts) et son *Radius*, qui définit sa taille apparente.',
      '**Sun** (Soleil) : envoie des rayons parallèles depuis l\'infini, quelle que soit sa position ; seule son orientation compte. Réglée par sa *Strength* et son *Angle*, qui simule le diamètre apparent du soleil.',
      '**Spot** : projette un cône de lumière, comme un projecteur de théâtre. Son *Spot Size* fixe l\'angle du cône et son *Blend* la douceur du bord.',
      '**Area** (Surface) : émet depuis une surface (carrée, rectangulaire ou en disque), à la manière d\'une fenêtre ou d\'un *softbox* de studio. C\'est la lampe de prédilection pour le LookDev.',
    ],
  ),
  TextModule(
    id: 'ch3_sec2_txt2',
    title: 'Le principe fondamental : taille de la source et douceur des ombres',
    content: 'S\'il ne fallait retenir qu\'une seule règle d\'éclairage, ce serait celle-ci : **plus une source de lumière est grande, plus ses ombres sont douces**. Une source minuscule, presque ponctuelle, projette des ombres aux bords nets et tranchés. Une grande surface lumineuse enveloppe les objets et produit des ombres progressives, aux contours estompés. C\'est exactement ce que contrôlent le *Radius* d\'une Point, l\'*Angle* d\'une Sun ou la *Size* d\'une Area.',
  ),
  SideBySideModule(
    id: 'ch3_sec2_side1',
    title: 'La taille gouverne l\'ombre',
    content: 'À gauche, une source de petite taille projette une ombre aux bords francs et durs. À droite, en augmentant simplement la taille de la même lampe, l\'ombre devient progressive et son contour s\'adoucit. Ce seul réglage transforme radicalement l\'ambiance d\'une scène : il mérite d\'être maîtrisé avant toute autre considération.',
    imagePath: 'assets/images/placeholder_light_size_shadow_softness_blender.jpg',
    caption: 'Figure 2.1 : Une même sphère éclairée par une petite source (ombre nette) puis par une grande source (ombre douce).',
    layout: ContentLayout.textRight,
  ),
  InfoModule(
    id: 'ch3_sec2_info1',
    type: InfoType.info,
    text: 'La douceur d\'une ombre ne dépend pas d\'un réglage nommé « douceur », mais bien de la **taille physique de la source**. Pour adoucir une ombre trop dure, agrandissez la lampe (son *Size*, *Radius* ou *Angle*) plutôt que de chercher un paramètre dédié. C\'est le réflexe qui distingue un éclairage crédible d\'un éclairage artificiel.',
  ),
  TextModule(
    id: 'ch3_sec2_txt3',
    title: 'Puissance et couleur',
    content: 'Deux réglages complètent toute lampe : la **puissance** (*Power*), exprimée en watts, qui détermine l\'intensité lumineuse, et la **couleur**, qui teinte la lumière émise. Jouer sur la couleur permet de simuler une lumière chaude (tons orangés d\'une lampe domestique) ou froide (tons bleutés d\'un ciel d\'ombre), élément essentiel de l\'ambiance d\'une scène.',
  ),
  QuizModule(
    id: 'ch3_sec2_quiz1',
    question: 'Une ombre est trop dure et tranchée à votre goût. Quel réglage permet de l\'adoucir ?',
    options: [
      'Baisser la puissance de la lampe',
      'Augmenter la taille de la source (Size, Radius ou Angle)',
      'Changer la couleur de la lampe',
      'Éloigner la caméra',
    ],
    correctIndices: [1],
    explanation: 'La douceur des ombres dépend de la **taille physique de la source**. Agrandir la lampe élargit la zone de pénombre et adoucit le contour de l\'ombre. La puissance, elle, ne modifie que l\'intensité, pas la dureté.',
  ),

  TitleModule(
    id: 'ch3_sec3_title',
    title: '3. L\'éclairage de studio : révéler formes et surfaces (CMF)',
  ),
  TextModule(
    id: 'ch3_sec3_txt1',
    title: 'L\'objectif d\'un éclairage de présentation',
    content: 'En présentation de produit comme en LookDev, l\'éclairage a une double mission : révéler la **forme** de l\'objet (ses volumes, ses contours, son relief) et donner à lire son **état de surface**. Ce second point se résume souvent par l\'acronyme **CMF**, pour Couleur, Matière et Finition. Un bon éclairage de studio doit rendre évidente la différence entre une finition mate et une finition brillante, entre un métal et un plastique.',
  ),
  ResourceModule(
    id: 'ch3_sec3_res1',
    title: 'Scène de studio prête à l\'emploi',
    description: 'Fichier de projet contenant un fond infini (cyclorama) et un objet de démonstration, prêt à recevoir votre montage de lampes pour vous exercer à l\'éclairage trois points.',
    fileName: 'scene_studio_cyclorama.blend (11.2 Mo)',
    downloadUrl: 'https://example.com/files/scene-studio-cyclorama',
  ),
  TextModule(
    id: 'ch3_sec3_txt2',
    title: 'L\'éclairage trois points',
    content: 'Le montage de référence du studio repose sur trois lampes aux rôles complémentaires :\n- La **lumière principale** (*Key light*) : la source dominante, la plus puissante, placée à environ 45° du sujet. Elle définit l\'éclairage général et la direction des ombres.\n- La **lumière de complément** (*Fill light*) : plus douce et moins intense, placée du côté opposé, elle débouche les ombres pour qu\'elles ne soient pas trop noires, sans créer de seconde ombre marquée.\n- Le **contre-jour** (*Rim ou Back light*) : placé derrière le sujet, il dessine un liseré lumineux sur ses contours et le détache du fond.\n\nCe trio constitue une base universelle que l\'on adapte ensuite à chaque sujet et à chaque intention.',
  ),
  SideBySideModule(
    id: 'ch3_sec3_side1',
    title: 'Le montage trois points',
    content: 'Le schéma situe les trois lampes autour de l\'objet : la principale à 45° à l\'avant, le complément du côté opposé, et le contre-jour à l\'arrière. Cette disposition révèle simultanément le volume du sujet et le détache de son arrière-plan. C\'est le squelette de la plupart des éclairages de présentation.',
    imagePath: 'assets/images/placeholder_three_point_lighting_blender.jpg',
    caption: 'Figure 3.1 : Vue de dessus d\'un montage trois points autour d\'un sujet (Key, Fill, Rim).',
    layout: ContentLayout.textLeft,
  ),
  TextModule(
    id: 'ch3_sec3_txt3',
    title: 'Les lampes Area en softbox',
    content: 'La lampe **Area** est l\'outil maître du studio, car elle reproduit fidèlement les *softbox* de la photographie : de grandes surfaces lumineuses qui diffusent une lumière douce et enveloppante. Plus la lampe Area est large, plus la lumière épouse les formes en douceur et révèle les dégradés subtils d\'une surface — ce qui est précisément ce que l\'on recherche pour montrer une finition.',
  ),
  TextModule(
    id: 'ch3_sec3_txt4',
    title: 'Lire la finition grâce aux reflets',
    content: 'Le secret pour révéler une finition brillante tient dans le **reflet de la source** sur l\'objet. Sur une surface lisse, la lampe Area se reflète sous forme d\'une traînée lumineuse nette : c\'est cette traînée qui signale à l\'œil le caractère poli de la matière. À l\'inverse, sur une surface mate, la même lampe ne produit qu\'un dégradé doux. Positionner les lampes pour que leurs reflets balayent les surfaces clés est donc l\'essence du LookDev de présentation.',
  ),
  InfoModule(
    id: 'ch3_sec3_tip1',
    type: InfoType.tip,
    text: 'Pour mettre en valeur un objet brillant, orientez une grande lampe Area de sorte que son reflet glisse le long de la surface vers la caméra. Cette traînée lumineuse, parfois appelée *highlight*, est ce qui donne instantanément l\'impression de brillance et révèle la qualité de la finition.',
  ),
  QuizModule(
    id: 'ch3_sec3_quiz1',
    question: 'Dans un éclairage trois points, quel est le rôle de la lumière de complément (Fill light) ?',
    options: [
      'Créer l\'ombre principale du sujet',
      'Détacher le sujet du fond par un liseré',
      'Adoucir et déboucher les ombres créées par la lumière principale',
      'Éclairer uniquement l\'arrière-plan',
    ],
    correctIndices: [2],
    explanation: 'La **Fill light**, plus douce et opposée à la principale, vient **déboucher les ombres** pour éviter qu\'elles soient trop sombres, sans projeter de seconde ombre dure. La principale crée l\'éclairage dominant, et le contre-jour détache le sujet du fond.',
  ),

  TitleModule(
    id: 'ch3_sec4_title',
    title: '4. L\'éclairage par HDRI : un éclairage global cohérent',
  ),
  TextModule(
    id: 'ch3_sec4_txt1',
    title: 'Qu\'est-ce qu\'un HDRI ?',
    content: 'Un **HDRI** (*High Dynamic Range Image*) est une image panoramique à 360° qui enregistre les intensités lumineuses réelles d\'un lieu, sur une plage dynamique très étendue. Utilisée comme environnement de la scène, elle remplit deux fonctions d\'un seul coup : elle **éclaire** tous les objets avec la lumière captée sur place, et elle fournit des **reflets** réalistes de ce même environnement. C\'est la façon la plus rapide d\'obtenir un éclairage naturel et cohérent.',
  ),
  TextModule(
    id: 'ch3_sec4_txt2',
    title: 'Le World et le nœud Environment Texture',
    content: 'L\'environnement d\'une scène est défini par le **World**. Par défaut, sa surface utilise un simple nœud *Background* d\'une couleur unie. Pour passer à un HDRI, on ouvre les propriétés du World, on ajoute un nœud **Environment Texture**, on y charge le fichier `.hdr` ou `.exr`, puis on relie sa sortie à l\'entrée *Color* du nœud Background. La scène entière est alors baignée par cette lumière panoramique.',
  ),
  SideBySideModule(
    id: 'ch3_sec4_side1',
    title: 'Brancher un HDRI dans le World',
    content: 'La capture montre le réseau de nœuds du World : l\'Environment Texture, qui charge le fichier HDRI, alimente l\'entrée Color du nœud Background, lui-même relié à la sortie du World. C\'est ce branchement minimal qui suffit à éclairer toute la scène et à fournir des reflets cohérents.',
    imagePath: 'assets/images/placeholder_environment_texture_world_blender.jpg',
    caption: 'Figure 4.1 : Le nœud Environment Texture relié au nœud Background dans le World.',
    layout: ContentLayout.textRight,
  ),
  TextModule(
    id: 'ch3_sec4_txt3',
    title: 'Contrôler la rotation et l\'intensité',
    content: 'Deux ajustements rendent l\'HDRI réellement exploitable. Pour **faire pivoter** l\'environnement — et ainsi choisir d\'où vient la lumière principale — on ajoute en amont un nœud Texture Coordinate (sortie *Generated*) et un nœud Mapping, dont on relie la sortie à l\'entrée *Vector* de l\'Environment Texture ; il suffit ensuite d\'ajuster la rotation sur l\'axe Z. Pour **régler l\'intensité** globale, on modifie la valeur *Strength* du nœud Background.',
  ),
  TextModule(
    id: 'ch3_sec4_txt4',
    title: 'Pourquoi l\'HDRI produit un résultat cohérent',
    content: 'La cohérence visuelle d\'un objet éclairé par HDRI vient d\'un principe simple : la lumière qui l\'éclaire et les reflets qu\'il renvoie proviennent de la **même source**. Un objet métallique reflète donc exactement l\'environnement qui l\'illumine, ce qui le fait paraître naturellement intégré. C\'est ce qui fait de l\'HDRI un excellent point de départ pour tout LookDev, avant même d\'ajouter la moindre lampe.',
  ),
  InfoModule(
    id: 'ch3_sec4_info1',
    type: InfoType.info,
    text: 'HDRI et lampes ne s\'opposent pas, ils se complètent. Une pratique courante consiste à poser d\'abord un HDRI pour l\'ambiance et les reflets généraux, puis à ajouter une lampe Area en lumière principale afin de garder un contrôle précis sur la direction et l\'intensité de l\'éclairage clé.',
  ),
  QuizModule(
    id: 'ch3_sec4_quiz1',
    question: 'Pourquoi un objet éclairé par un HDRI s\'intègre-t-il de façon particulièrement cohérente ?',
    options: [
      'Parce que l\'HDRI désactive les ombres',
      'Parce que la lumière et les reflets proviennent de la même source environnementale',
      'Parce qu\'il force l\'usage de Cycles',
      'Parce qu\'il augmente automatiquement la résolution',
    ],
    correctIndices: [1],
    explanation: 'Avec un HDRI, l\'éclairage et les reflets d\'un objet sont issus du **même environnement panoramique**. L\'objet renvoie donc exactement la scène qui l\'illumine, ce qui produit une intégration naturelle et cohérente.',
  ),

  TitleModule(
    id: 'ch3_sec5_title',
    title: '5. Paramétrer les moteurs : temps réel contre fidélité physique',
  ),
  TextModule(
    id: 'ch3_sec5_txt1',
    title: 'Le compromis fondamental : qualité contre temps',
    content: 'Tout réglage de rendu revient à arbitrer entre la **qualité de l\'image** et le **temps de calcul**. Augmenter le nombre d\'échantillons ou de rebonds de lumière produit une image plus propre et plus fidèle, mais allonge le rendu. Savoir doser ces paramètres selon le besoin — une simple prévisualisation ou un visuel final — est une compétence à part entière.',
  ),
  TextModule(
    id: 'ch3_sec5_txt2',
    title: 'Régler EEVEE',
    content: 'Les réglages d\'EEVEE se trouvent dans les propriétés de rendu. Le **Sampling** (*Render Samples*, ou *taa* pour l\'anti-crénelage temporel) lisse l\'image et réduit le scintillement : on l\'augmente pour un rendu final. Le panneau **Raytracing**, activable, améliore reflets et ombres en lançant de vrais rayons, avec une méthode *Screen-Trace* qui s\'appuie sur ce qui est visible à l\'écran. Les réglages d\'**ombres** affinent leur précision. EEVEE restant rapide, on peut monter ses échantillons sans exploser le temps de rendu.',
  ),
  TextModule(
    id: 'ch3_sec5_txt3',
    title: 'Régler Cycles',
    content: 'Cycles demande quelques réglages spécifiques pour tirer le meilleur compromis :\n- **Samples** : le nombre de rayons calculés par pixel. Plus il est élevé, moins l\'image est bruitée, mais plus le rendu est long.\n- **Denoising** (débruitage) : un filtre, comme OpenImageDenoise, qui nettoie le bruit résiduel. Il permet d\'obtenir une image propre avec beaucoup moins d\'échantillons.\n- **Light Paths > Max Bounces** : le nombre de rebonds de lumière, réglable globalement et par type (diffus, brillant, transmission). C\'est lui qui autorise la lumière à traverser plusieurs surfaces.',
  ),
  SideBySideModule(
    id: 'ch3_sec5_side1',
    title: 'Échantillonnage et débruitage Cycles',
    content: 'La capture met en évidence le réglage des Samples et l\'option Denoising. La logique gagnante consiste à viser un nombre d\'échantillons modéré, puis à laisser le débruiteur nettoyer le bruit restant : on obtient ainsi une image propre en une fraction du temps qu\'exigerait un rendu sans débruitage.',
    imagePath: 'assets/images/placeholder_cycles_sampling_denoise_blender.jpg',
    caption: 'Figure 5.1 : Le panneau Sampling de Cycles avec le débruitage (Denoising) activé.',
    layout: ContentLayout.textLeft,
  ),
  TextModule(
    id: 'ch3_sec5_txt4',
    title: 'Quand utiliser quel moteur ?',
    content: 'EEVEE est imbattable pour itérer, prévisualiser une animation, produire des rendus stylisés ou tenir des délais serrés. Cycles s\'impose pour les visuels finaux exigeants, les rendus de produit, et tout ce qui repose sur une physique de la lumière exacte — verre, liquides, caustiques, éclairage indirect subtil.',
  ),
  InfoModule(
    id: 'ch3_sec5_warning1',
    type: InfoType.warning,
    text: 'Si un objet en verre apparaît noir sous Cycles, la cause est presque toujours un nombre de rebonds de **transmission** insuffisant. Augmentez la valeur correspondante dans *Light Paths* pour laisser la lumière traverser les parois successives. C\'est le même piège que celui rencontré lors de la création des matériaux transparents.',
  ),
  QuizModule(
    id: 'ch3_sec5_quiz1',
    question: 'Quel réglage de Cycles permet d\'obtenir une image propre tout en limitant fortement le nombre d\'échantillons nécessaires ?',
    options: [
      'Augmenter le nombre de rebonds de transmission',
      'Activer le débruitage (Denoising)',
      'Réduire la taille du capteur de la caméra',
      'Passer la vue en mode Material Preview',
    ],
    correctIndices: [1],
    explanation: 'Le **débruitage** (Denoising) nettoie le bruit résiduel après le calcul, ce qui autorise un nombre d\'échantillons bien plus faible pour une qualité équivalente. C\'est le levier le plus efficace pour accélérer un rendu Cycles.',
  ),

  TitleModule(
    id: 'ch3_sec6_title',
    title: '6. La caméra physique : focale, profondeur de champ et mise au point',
  ),
  TextModule(
    id: 'ch3_sec6_txt1',
    title: 'L\'objet caméra',
    content: 'Le rendu d\'une scène se fait toujours à travers une **caméra**. On en ajoute une via *Add > Camera*, et l\'on observe son cadrage en regardant à travers elle (pavé numérique `0`). La caméra de Blender se comporte comme un appareil photo réel : ses réglages reprennent ceux de l\'optique et de la prise de vue, ce qui permet de penser le cadrage en termes photographiques.',
  ),
  TextModule(
    id: 'ch3_sec6_txt2',
    title: 'La focale et le capteur',
    content: 'La **focale** (*Focal Length*, en millimètres) détermine l\'angle de vue et la perspective. Une focale courte, par exemple 18 mm, offre un grand angle aux perspectives accentuées, qui exagère les volumes et la profondeur. Une focale longue, de 85 à 135 mm, resserre le cadre et **comprime** la perspective, ce qui aplatit les déformations et flatte particulièrement les produits et les portraits. La taille du **capteur** (*Sensor*) influe également sur le champ couvert.',
  ),
  SideBySideModule(
    id: 'ch3_sec6_side1',
    title: 'L\'effet de la focale',
    content: 'À gauche, la focale courte de 18 mm dilate l\'espace et déforme les proportions par une perspective marquée. À droite, la focale longue de 85 mm aplatit la perspective et restitue des proportions plus fidèles. Le choix de la focale n\'est donc pas qu\'un cadrage : c\'est un choix esthétique qui façonne la lecture des volumes.',
    imagePath: 'assets/images/placeholder_focal_length_perspective_blender.jpg',
    caption: 'Figure 6.1 : Un même objet vu à 18 mm (perspective accentuée) puis à 85 mm (perspective comprimée).',
    layout: ContentLayout.textRight,
  ),
  ListModule(
    id: 'ch3_sec6_list1',
    title: 'La profondeur de champ',
    intro: 'On l\'active dans le panneau dédié de la caméra, puis on règle trois éléments :',
    items: [
      'Le **point de netteté**, défini soit par une distance (*Focus Distance*), soit en désignant un objet à suivre (*Focus Object*).',
      'L\'**ouverture** (*F-Stop*), qui dose l\'intensité du flou : une faible valeur comme f/1.4 produit un flou prononcé et une zone nette très mince, tandis qu\'une valeur élevée comme f/16 garde presque tout net.',
      'Le cadrage et la distance à la caméra, qui modulent l\'étendue de la zone floue.',
    ],
  ),
  TextModule(
    id: 'ch3_sec6_txt3',
    title: 'La mise au point artistique',
    content: 'Au-delà de la technique, la profondeur de champ est un puissant outil de composition. En floutant l\'arrière-plan, elle isole le sujet et guide irrésistiblement le regard vers la zone nette : c\'est l\'effet recherché en photographie de produit et de portrait. Désigner un **Focus Object** plutôt qu\'une distance fixe garantit en outre que la netteté reste verrouillée sur le sujet, même s\'il se déplace.',
  ),
  InfoModule(
    id: 'ch3_sec6_tip1',
    type: InfoType.tip,
    text: 'Pour une mise au point fiable, préférez le réglage *Focus Object* : placez un objet (par exemple un Empty) sur la zone à garder nette et désignez-le comme cible. La caméra restera parfaitement focalisée sur ce point, sans avoir à recalculer une distance à chaque ajustement de la scène.',
  ),
  QuizModule(
    id: 'ch3_sec6_quiz1',
    question: 'Quel réglage de la caméra contrôle l\'intensité du flou de profondeur de champ ?',
    options: [
      'La focale (Focal Length)',
      'L\'ouverture (F-Stop)',
      'La taille du capteur',
      'Le nombre d\'échantillons',
    ],
    correctIndices: [1],
    explanation: 'C\'est l\'**ouverture** (F-Stop) qui dose le flou : une faible valeur (f/1.4) crée une zone nette très mince et un arrière-plan très flou, tandis qu\'une valeur élevée (f/16) conserve une grande profondeur de champ nette.',
  ),
];
