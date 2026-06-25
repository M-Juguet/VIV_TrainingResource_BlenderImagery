## 1. Installation et configuration

### Télécharger la bonne version
Blender se télécharge gratuitement depuis le site officiel, blender.org. Vous y trouverez deux pistes de téléchargement. La version **LTS** (*Long Term Support*) est une version stabilisée, maintenue sur le long terme : c'est le choix de la sérénité, idéal en production. La version **récente** apporte les dernières fonctionnalités, au prix d'une stabilité parfois un peu moindre. Pour suivre cette formation, le plus simple est d'installer la version utilisée tout au long du parcours afin que votre interface corresponde exactement aux captures et aux libellés présentés.

### Installer sous Windows
Deux formats d'installation existent. L'**installeur** classique (`.msi`) intègre Blender au système comme n'importe quel logiciel, avec un raccourci dans le menu Démarrer. La version **portable** (`.zip`) ne s'installe pas : on la décompresse dans un dossier et on lance l'exécutable directement. Cette seconde option est précieuse lorsqu'on ne dispose pas des droits administrateur, ou pour transporter Blender sur une clé USB.

### Premier lancement et fichier de démarrage
Au premier démarrage, un écran d'accueil (*splash screen*) propose quelques réglages rapides. Une fois passé, vous arrivez sur le **fichier de démarrage** par défaut, qui contient systématiquement trois éléments : un cube, une caméra et une lampe. Ce fichier sert de point de départ neuf à chaque nouveau projet ; vous pourrez plus tard le personnaliser pour qu'il corresponde à vos habitudes.

### Configurer les préférences essentielles
Les préférences s'ouvrent via le menu *Edit > Preferences*. Trois réglages méritent votre attention dès le départ. Dans l'onglet **Interface**, vous pouvez choisir la **langue** de l'affichage. Dans l'onglet **System**, à la rubrique *Cycles Render Devices*, vous sélectionnez le **backend GPU** correspondant à votre carte graphique — CUDA ou OptiX pour une carte NVIDIA, HIP pour une carte AMD, oneAPI pour une puce Intel — puis vous cochez votre carte. Enfin, l'onglet **Add-ons** permet d'activer des extensions fournies avec Blender. Les préférences sont enregistrées automatiquement.

```side-by-side
layout: "textLeft"
imagePath: "assets/images/placeholder_preferences_system_gpu_blender.jpg"
caption: "Figure 1.1 : L'onglet System des préférences, avec la sélection du backend GPU pour Cycles."
title: "Activer le GPU pour le rendu"
---
La capture montre la rubrique Cycles Render Devices dans l'onglet System. On y choisit d'abord le backend adapté à sa carte graphique, puis on coche la carte dans la liste. Sans cette étape, Cycles calcule sur le processeur, bien plus lentement : c'est l'un des tout premiers réglages à effectuer.
```

> [!IMPORTANT]
> Pensez à activer votre carte graphique dans les préférences avant tout travail de rendu. Si ce réglage est oublié, le moteur Cycles utilisera par défaut le processeur (CPU), avec des temps de calcul souvent plusieurs fois plus longs. Ce réglage conditionne tout le confort du Bloc 3 consacré au rendu.

> [!TIP]
> En contexte professionnel ou pédagogique, privilégiez une version **LTS**. Sa stabilité garantie sur la durée évite les mauvaises surprises liées à un changement de comportement entre deux mises à jour, ce qui est précieux quand plusieurs personnes doivent travailler sur les mêmes fichiers.

```quiz
question: "Pourquoi est-il important d'activer sa carte graphique dans les préférences de Blender ?"
options:
  - "Pour changer la langue de l'interface"
  - "Pour accélérer fortement les calculs de rendu avec Cycles"
  - "Pour pouvoir sauvegarder ses fichiers"
  - "Pour afficher le cube de départ"
correctIndices:
  - 1
explanation: "Activer le **backend GPU** dans *System > Cycles Render Devices* permet à Cycles de calculer sur la carte graphique plutôt que sur le processeur, ce qui réduit considérablement les temps de rendu."
```

## 2. L'interface : éditeurs, zones et workspaces

### Tout est éditeur
L'interface de Blender repose sur un principe simple : l'écran est divisé en **zones**, et chaque zone contient un **éditeur**. La grande fenêtre centrale est la vue 3D, mais l'Outliner, l'éditeur de propriétés ou la *Timeline* sont eux aussi des éditeurs occupant leur propre zone. Comprendre cette logique modulaire est la clé pour ne jamais se sentir perdu : il n'y a pas de fenêtres flottantes éparpillées, seulement un écran que l'on découpe à sa guise.

### L'en-tête et le sélecteur de type d'éditeur
Chaque éditeur possède un **en-tête** (*header*), une barre regroupant ses menus et options. Tout à gauche de cet en-tête se trouve une petite icône : c'est le **sélecteur de type d'éditeur**. En cliquant dessus, vous transformez la zone courante en n'importe quel autre éditeur. Une zone affichant la vue 3D peut ainsi devenir un éditeur d'image, un Outliner ou un Shader Editor en un clic.

```side-by-side
layout: "textRight"
imagePath: "assets/images/placeholder_editor_type_selector_blender.jpg"
caption: "Figure 2.1 : Le sélecteur de type d'éditeur, en haut à gauche de l'en-tête d'une zone."
title: "Changer le type d'un éditeur"
---
La capture met en évidence l'icône du sélecteur, à l'extrémité gauche de l'en-tête. Le menu déroulé révèle la liste des éditeurs disponibles. C'est ce mécanisme qui rend l'interface entièrement reconfigurable : chaque zone peut accueillir l'outil dont vous avez besoin à l'instant T.
```

### Diviser, fusionner et redimensionner les zones
Les zones se réorganisent à la souris. Pour **redimensionner**, glissez la bordure entre deux zones. Pour **diviser** une zone en deux, saisissez l'un de ses coins et tirez vers l'intérieur. Pour **fusionner**, faites glisser une bordure par-dessus la zone voisine jusqu'à ce qu'elle disparaisse. Avec un peu de pratique, on façonne en quelques secondes la disposition idéale pour une tâche donnée.

### Les workspaces
Plutôt que de tout reconfigurer manuellement, Blender propose des **workspaces** : des dispositions d'éditeurs préréglées pour chaque grande tâche. Ce sont les onglets alignés tout en haut de la fenêtre — Layout, Modeling, Sculpting, Shading, et ainsi de suite. Passer de l'un à l'autre est instantané et ne change rien à la scène : seul l'agencement de l'écran évolue. Vous en avez déjà utilisé plusieurs dans cette formation, comme Shading et UV Editing.

> [!NOTE]
> Un workspace n'est qu'un **agencement d'éditeurs**, pas un fichier ni une scène séparée. Quand vous passez de Layout à Shading, vous travaillez toujours sur les mêmes objets : vous changez simplement la disposition des outils affichés à l'écran. Rien n'est perdu en basculant d'un workspace à l'autre.

```quiz
question: "Que se passe-t-il lorsque vous cliquez sur un autre onglet de workspace (par exemple de Layout à Shading) ?"
options:
  - "Vous ouvrez un nouveau fichier vide"
  - "Vous changez l'agencement des éditeurs à l'écran, sans modifier la scène"
  - "Vous supprimez les objets non sélectionnés"
  - "Vous lancez un rendu"
correctIndices:
  - 1
explanation: "Un **workspace** est une simple disposition d'éditeurs préréglée. En changer modifie l'agencement de l'écran pour l'adapter à une tâche, mais la scène et ses objets restent rigoureusement identiques."
```

## 3. L'éditeur de propriétés et l'Outliner

### L'éditeur de propriétés
À droite de l'écran, l'**éditeur de propriétés** rassemble la grande majorité des réglages d'une scène. Une colonne d'icônes verticale, sur son bord gauche, donne accès à ses différents onglets : *Render* (moteur et qualité), *Output* (sortie), *Scene*, *World* (environnement), *Object* (l'objet sélectionné), *Modifiers*, *Material*, et d'autres encore. Cet éditeur est **contextuel** : les onglets proposés dépendent de l'élément actif. Sélectionner une lampe ou une caméra n'affiche pas exactement les mêmes onglets qu'un maillage.

```side-by-side
layout: "textLeft"
imagePath: "assets/images/placeholder_properties_editor_tabs_blender.jpg"
caption: "Figure 3.1 : La colonne d'onglets de l'éditeur de propriétés (Render, Output, Object, Material…)."
title: "Les onglets des propriétés"
---
La capture détaille la colonne d'icônes qui structure l'éditeur de propriétés. Chaque icône ouvre une catégorie de réglages. Repérer rapidement le bon onglet — la clé à molette pour les modificateurs, la sphère à damier pour les matériaux — fait gagner un temps précieux au quotidien.
```

### Lire et modifier une valeur
Les champs numériques de Blender se manipulent de plusieurs façons. Un **clic** simple permet de saisir une valeur précise au clavier. Un **glissé** horizontal sur le champ fait varier la valeur de façon continue, ce qui est pratique pour ajuster à l'œil. On peut même cliquer-glisser verticalement sur une colonne de plusieurs champs pour les régler d'un coup. Ces gestes deviennent vite des automatismes.

### L'Outliner
En haut à droite, l'**Outliner** affiche l'arborescence complète de la scène : les collections, les objets qu'elles contiennent, et les données rattachées à chaque objet. On y **sélectionne** un élément d'un clic, on le **renomme** par un double-clic, et on contrôle sa visibilité à l'aide des icônes en bout de ligne — l'**œil** pour l'affichage dans la vue, l'icône d'**appareil photo** pour sa présence dans le rendu final.

```side-by-side
layout: "textRight"
imagePath: "assets/images/placeholder_outliner_hierarchy_blender.jpg"
caption: "Figure 3.2 : L'Outliner et son arborescence de collections, objets et données."
title: "L'Outliner, plan de la scène"
---
La capture présente l'arborescence de l'Outliner : les collections regroupent les objets, et chaque objet peut être déplié pour révéler ses données (maillage, matériau…). Les icônes de visibilité à droite de chaque ligne permettent de masquer un élément dans la vue ou de l'exclure du rendu.
```

### Le lien contexte, Outliner et propriétés
Ces deux éditeurs ne fonctionnent pas isolément : ils sont reliés par la notion d'**objet actif**. L'objet que vous sélectionnez devient l'objet actif ; l'Outliner le met en surbrillance, et l'éditeur de propriétés affiche aussitôt ses réglages. Saisir ce trio — sélection, Outliner, propriétés — est ce qui permet de toujours savoir « sur quoi » l'on agit, et constitue l'un des réflexes les plus structurants pour travailler sereinement.

> [!TIP]
> Ne confondez pas les deux principales icônes de visibilité de l'Outliner. L'**œil** masque ou affiche l'objet dans la vue 3D, sans rien changer au rendu. L'icône d'**appareil photo** contrôle au contraire sa présence dans l'image finale rendue. Un objet peut donc être visible à l'écran mais absent du rendu, et inversement.

```quiz
question: "Dans l'Outliner, à quoi sert l'icône en forme d'appareil photo placée à côté d'un objet ?"
options:
  - "À déplacer l'objet vers la caméra"
  - "À contrôler la présence de l'objet dans le rendu final"
  - "À masquer l'objet uniquement dans la vue 3D"
  - "À renommer l'objet"
correctIndices:
  - 1
explanation: "L'icône d'**appareil photo** détermine si l'objet apparaît dans le **rendu final**. Elle se distingue de l'**œil**, qui ne gère que la visibilité dans la vue 3D, sans incidence sur l'image rendue."
```

## 4. Naviguer dans la vue 3D

### Orbiter, faire un panoramique et zoomer
Trois gestes suffisent à se déplacer autour d'une scène. Le **bouton du milieu de la souris** (la molette pressée) maintenu fait **orbiter** la vue autour du point central. Combiné à la touche `Maj`, il réalise un **panoramique** (déplacement latéral). La rotation de la molette, enfin, **zoome** en avant ou en arrière. Ces trois mouvements forment le socle absolu de toute manipulation : tant qu'ils ne sont pas devenus naturels, le reste paraît laborieux.

### Le gizmo de navigation
Pour celles et ceux qui ne disposent pas d'une souris à trois boutons, un **gizmo de navigation** est affiché en haut à droite de la vue 3D. Il regroupe plusieurs aides : le petit repère d'axes coloré (cliquer sur un axe aligne instantanément la vue sur lui), une main pour le panoramique, une loupe pour le zoom, et une icône d'appareil photo pour basculer dans la vue de la caméra. C'est un filet de sécurité commode quand les raccourcis de souris ne sont pas disponibles.

```side-by-side
layout: "textLeft"
imagePath: "assets/images/placeholder_navigation_gizmo_blender.jpg"
caption: "Figure 4.1 : Le gizmo de navigation en haut à droite de la vue 3D."
title: "Le gizmo de navigation"
---
La capture isole le gizmo et ses commandes : le repère d'axes pour s'aligner sur une vue, la main pour le panoramique, la loupe pour le zoom et l'icône de caméra. Cliquer directement sur les lettres X, Y ou Z du repère est un moyen rapide et sans raccourci d'obtenir une vue de face, de côté ou de dessus.
```

### Les vues prédéfinies du pavé numérique
Le pavé numérique offre des raccourcis de vue extrêmement efficaces, à mémoriser en priorité :
- `1` : vue de face ; `Ctrl + 1` : vue de derrière.
- `3` : vue de droite ; `Ctrl + 3` : vue de gauche.
- `7` : vue de dessus ; `Ctrl + 7` : vue de dessous.
- `0` : vue à travers la caméra active.
- `5` : bascule entre projection perspective et orthographique.
- `.` (point) : recadre la vue sur l'objet sélectionné.
Ces raccourcis font gagner un temps considérable dès qu'on cherche à se positionner précisément.

### Perspective, orthographique et modes d'affichage
La touche `5` du pavé numérique bascule entre deux projections. La vue **perspective** imite l'œil humain : les lignes parallèles convergent au loin, ce qui donne une impression de profondeur. La vue **orthographique** conserve les lignes parallèles, sans déformation de distance, ce qui est idéal pour aligner des objets avec précision. Enfin, le coin supérieur droit de la vue propose quatre **modes d'affichage** — *Wireframe* (fil de fer), *Solid* (volumes mats), *Material Preview* (aperçu des matériaux) et *Rendered* (rendu réel du moteur) — que vous retrouverez et exploiterez pleinement dans le Bloc 3.

```resource
title: "Mémo de navigation et raccourcis"
description: "Fiche de référence récapitulant les gestes de navigation et les raccourcis du pavé numérique, à garder sous la main pendant vos premières heures de pratique."
fileName: "memo_navigation_blender.pdf (0.4 Mo)"
downloadUrl: "https://example.com/files/memo-navigation-blender"
```

> [!TIP]
> Sur un ordinateur portable dépourvu de pavé numérique ou de souris à trois boutons, activez les options *Emulate Numpad* et *Emulate 3 Button Mouse* dans les préférences (onglet *Input*). La première redirige les chiffres de la rangée principale vers les vues prédéfinies, la seconde remplace le bouton du milieu par une combinaison de touches. Indispensable pour travailler confortablement sur portable.

```quiz
question: "Quelle touche du pavé numérique permet de basculer entre vue perspective et vue orthographique ?"
options:
  - "La touche 0"
  - "La touche 1"
  - "La touche 5"
  - "La touche 7"
correctIndices:
  - 2
explanation: "La touche `5` du pavé numérique bascule entre la projection **perspective** (lignes convergentes, impression de profondeur) et la projection **orthographique** (lignes parallèles, idéale pour l'alignement précis)."
```
