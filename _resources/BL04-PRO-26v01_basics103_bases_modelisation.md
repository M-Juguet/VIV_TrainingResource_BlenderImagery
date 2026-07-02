## 1. Le maillage et le Mode Édition

### L'anatomie d'un maillage
Tout objet modélisé dans Blender est un **maillage** (*mesh*), constitué de trois éléments fondamentaux. Les **sommets** (*vertices*) sont des points dans l'espace. Les **arêtes** (*edges*) sont les segments qui relient deux sommets. Les **faces** sont les surfaces délimitées par des arêtes, le plus souvent par trois ou quatre d'entre elles. Modéliser, ce n'est rien d'autre que manipuler ces trois éléments — les déplacer, en ajouter, en supprimer — pour façonner une forme.

### Entrer et sortir du Mode Édition
La sculpture de la géométrie se fait dans le **Mode Édition**. On y bascule depuis le Mode Objet avec la touche `Tab`, et l'on en ressort de la même façon. Le rappel est utile : le Mode Objet manipule l'objet dans son ensemble, tandis que le Mode Édition ouvre son maillage pour en modifier l'intérieur. Le sélecteur de mode, dans l'en-tête de la vue, indique toujours où vous vous trouvez.

### Les trois modes de sélection
Une fois en Mode Édition, un choix s'impose : sur quel type d'élément voulez-vous agir ? Trois boutons dans l'en-tête, accessibles par les touches `1`, `2` et `3`, basculent entre les modes de sélection.

```side-by-side
layout: "textRight"
imagePath: "assets/images/placeholder_select_modes_blender.jpg"
caption: "Figure 1.1 : Les trois modes de sélection en Mode Édition — Sommets, Arêtes, Faces."
title: "Sommets, arêtes, faces"
---
La capture montre les trois boutons de l'en-tête. La touche `1` active la sélection par **sommets**, la `2` par **arêtes** et la `3` par **faces**. On passe de l'un à l'autre en permanence selon l'opération : sélectionner une boucle d'arêtes pour la biseauter, une face pour l'extruder, un sommet pour l'ajuster finement.
```

### Sélectionner efficacement en édition
Le Mode Édition offre des méthodes de sélection bien plus riches que le simple clic. Les maîtriser fait gagner un temps considérable :
- **Clic** pour sélectionner, `Maj + clic` pour ajouter ou retirer, boîte (`B`) et cercle (`C`) pour des sélections multiples.
- `Alt + clic` sur une arête sélectionne toute la **boucle d'arêtes** (*edge loop*) qui en fait le tour — l'outil le plus rentable de l'édition.
- `Ctrl + Alt + clic` sélectionne l'**anneau** (*edge ring*) perpendiculaire.
- `L` sélectionne tout l'**îlot** connecté sous le curseur.
- `Ctrl + Pavé +` et `Ctrl + Pavé -` **agrandissent** ou **réduisent** la sélection de proche en proche.

> [!TIP]
> Le raccourci `Alt + clic` pour sélectionner une boucle d'arêtes complète est sans doute le geste le plus rentable du Mode Édition. Plutôt que de cliquer une à une les dizaines d'arêtes qui font le tour d'un cylindre, un seul `Alt + clic` les sélectionne toutes d'un coup. À intégrer dès vos premières manipulations.

```quiz
question: "En Mode Édition, quel raccourci permet de sélectionner d'un coup toute une boucle d'arêtes qui fait le tour d'une forme ?"
options:
  - "Un clic simple"
  - "Alt + clic sur une arête"
  - "La touche B"
  - "La touche 3"
correctIndices:
  - 1
explanation: "`Alt + clic` sur une arête sélectionne l'ensemble de la **boucle d'arêtes** (*edge loop*). C'est l'un des gestes les plus efficaces de la modélisation, qui évite de sélectionner les arêtes une par une."
```

## 2. Les outils de modélisation essentiels

### Partir d'une primitive
On ne modélise presque jamais à partir de rien : on part d'une **primitive** — un cube, un cylindre, un plan — que l'on ajoute via le menu *Add* (`Maj + A`), puis que l'on façonne progressivement. Cette approche, dite « modélisation par boîte » (*box modeling*), consiste à partir d'une forme simple et à la sculpter avec les outils d'édition jusqu'à obtenir l'objet voulu.

```resource
title: "Scène d'exercices - Primitives"
description: "Fichier contenant plusieurs primitives de départ et quelques formes cibles à reproduire, pour vous entraîner aux outils d'édition de cette section."
fileName: "exercices_modelisation_primitives.blend (3.6 Mo)"
downloadUrl: "https://example.com/files/exercices-modelisation-primitives"
```

### Extrude : l'outil fondamental
L'**extrusion** (`E`) est l'outil de modélisation par excellence. Il tire de la nouvelle géométrie à partir d'une sélection : une face extrudée engendre un volume, une arête extrudée prolonge une surface. On appuie sur `E`, on déplace la souris, puis on clique pour valider. C'est ainsi que l'on fait pousser un objet, face après face.

```side-by-side
layout: "textLeft"
imagePath: "assets/images/placeholder_extrude_tool_blender.jpg"
caption: "Figure 2.1 : Extrusion d'une face pour créer un nouveau volume."
title: "L'extrusion"
---
Sur la capture, une face sélectionnée est extrudée vers le haut : Blender crée de nouvelles arêtes reliant la face d'origine à sa copie déplacée, formant un volume. Répéter cette opération dans différentes directions est la base de la construction d'un objet complexe à partir d'une simple primitive.
```

### Inset et Bevel
Deux outils affinent les faces et les arêtes. L'**Inset** (`I`) crée une face plus petite à l'intérieur d'une face existante, idéale pour préparer un renfoncement ou un bouton. Le **Bevel** (`Ctrl + B`) chanfreine ou arrondit une arête vive ; en faisant tourner la molette pendant l'opération, on ajoute des segments pour passer d'un simple chanfrein à un arrondi lisse.

### Loop Cut et Subdivide
Pour ajouter de la résolution là où on en a besoin, deux outils s'imposent. Le **Loop Cut** (`Ctrl + R`) insère une boucle d'arêtes continue tout autour du maillage, ce qui permet de le plier ou de le détailler à cet endroit précis. La **Subdivision** (*Subdivide*) découpe les faces sélectionnées en plusieurs, augmentant la densité localement.

### Fusionner et couper
Enfin, deux outils complètent la panoplie de base. Le **Merge** (`M`) fusionne plusieurs sommets en un seul, utile pour refermer une forme ou nettoyer une géométrie. Le **couteau** (*Knife*, `K`) permet de tracer des découpes personnalisées directement sur la surface.

> [!WARNING]
> Piège classique de l'extrusion : après avoir appuyé sur `E`, si vous annulez le déplacement avec `Échap` ou un clic droit, l'extrusion **n'est pas annulée** — seul le déplacement l'est. La nouvelle géométrie reste alors superposée exactement sur l'ancienne, créant des faces en double invisibles. Pour tout annuler, utilisez plutôt `Ctrl + Z`.

> [!TIP]
> Après un Bevel ou une Subdivision, pensez au panneau **« Ajuster la dernière opération » (`F9`)** vu dans Basics 102 : il vous laisse régler après coup le nombre de segments ou de coupes, sans refaire l'opération.

```quiz
question: "Quel outil permet de faire pousser un nouveau volume à partir d'une face sélectionnée ?"
options:
  - "L'Inset (I)"
  - "L'Extrude (E)"
  - "Le Loop Cut (Ctrl + R)"
  - "Le Merge (M)"
correctIndices:
  - 1
explanation: "L'**Extrude** (`E`) tire de la nouvelle géométrie à partir de la sélection : une face extrudée engendre un volume. C'est l'outil fondamental de la modélisation."
```

## 3. La modélisation non destructive : les modificateurs

### Le principe de la pile
Un **modificateur** applique un effet sur le maillage **sans en altérer la géométrie de base**. On les gère dans l'onglet *Modifiers* de l'éditeur de propriétés (icône de clé à molette), où ils s'empilent en une **pile** (*stack*) évaluée de haut en bas. L'atout est double : le maillage d'origine reste modifiable à tout moment sous le modificateur, et l'on peut régler ou retirer l'effet quand on veut. C'est le pendant, en modélisation, de la retouche non destructive vue au compositing.

```side-by-side
layout: "textRight"
imagePath: "assets/images/placeholder_subdivision_surface_blender.jpg"
caption: "Figure 3.1 : Un cube avec un modificateur Subdivision Surface, lissé en forme arrondie."
title: "Le modificateur Subdivision Surface"
---
À gauche de l'illustration, le maillage de base (une simple cage cubique) reste modifiable ; à droite, le modificateur Subdivision Surface l'affiche lissé et arrondi. On sculpte la cage grossière, et le modificateur se charge du lissage en temps réel — l'essence même de la modélisation non destructive.
```

### Les modificateurs clés de la modélisation
Quelques modificateurs reviennent en permanence et méritent d'être connus dès le départ :
- **Subdivision Surface** : lisse et arrondit le maillage en ajoutant de la résolution (raccourci `Ctrl + 1`, `Ctrl + 2`…). C'est le modificateur roi pour les formes douces.
- **Mirror** : modélise une moitié et reflète automatiquement l'autre selon un axe. On divise le travail par deux et l'on garantit une symétrie parfaite.
- **Array** : répète l'objet en copies régulières, parfait pour une clôture, un escalier ou une rangée.
- **Solidify** : donne une épaisseur à une surface plane, transformant un plan en volume.
- **Bevel** (modificateur) : arrondit globalement toutes les arêtes vives, sans avoir à les biseauter une à une.
- **Boolean** : combine, soustrait ou intersecte deux objets, pour percer un trou ou fusionner des formes.

### L'ordre compte, et l'application
Dans la pile, **l'ordre des modificateurs change le résultat**. Un Mirror placé avant une Subdivision Surface ne produit pas le même effet que l'inverse : chaque modificateur agit sur le résultat du précédent. On peut, à tout moment, activer ou désactiver leur affichage dans la vue. Et lorsqu'on a besoin de figer l'effet en véritable géométrie — pour l'exporter ou continuer à l'éditer manuellement — on **applique** le modificateur.

> [!NOTE]
> Tant qu'un modificateur n'est pas appliqué, tous ses réglages restent modifiables : niveau de subdivision, axe de miroir, nombre de copies d'un Array… C'est cette souplesse qui fait tout l'intérêt de l'approche non destructive. N'appliquez un modificateur que lorsque vous êtes certain de ne plus vouloir revenir sur ses paramètres.

```quiz
question: "Quel est le principal avantage de la modélisation par modificateurs ?"
options:
  - "Elle rend le maillage impossible à modifier"
  - "Elle applique des effets sans altérer le maillage de base, réglables à tout moment"
  - "Elle supprime automatiquement les sommets en double"
  - "Elle ne fonctionne qu'en Mode Objet"
correctIndices:
  - 1
explanation: "Les modificateurs sont **non destructifs** : ils appliquent leurs effets par-dessus le maillage de base, qui reste intact et modifiable. Leurs réglages restent ajustables tant qu'on ne les a pas appliqués."
```

## 4. Topologie, normales et bonnes pratiques

### Quads, triangles et n-gons
Une face peut avoir un nombre variable de côtés. Une face à quatre côtés est un **quad**, à trois un **triangle** (*tri*), à cinq ou plus un **n-gon**. La règle d'or de la modélisation propre est de **privilégier les quads** : ils se subdivisent proprement, se déforment bien et se déplient plus facilement en UV. Les triangles et n-gons sont tolérables sur des surfaces planes, mais à éviter sur les zones courbes ou destinées à être lissées, où ils provoquent des artefacts.

### Une topologie propre
La **topologie** désigne la manière dont les faces s'organisent sur la surface. Une bonne topologie présente un flux de quads régulier, dont les boucles d'arêtes suivent naturellement les formes de l'objet. Ce n'est pas qu'une question d'esthétique : une topologie propre conditionne la qualité du lissage, la facilité du dépliage UV et le bon comportement lors des déformations.

### Les normales
Chaque face possède une **normale** : un vecteur qui indique le côté vers lequel elle est orientée, son « extérieur ». Quand une normale est inversée (elle pointe vers l'intérieur), la face réagit mal à la lumière et produit des erreurs de rendu — zones sombres, reflets incohérents. On corrige cela avec **Recalculate Outside** (`Maj + N`), qui réoriente toutes les normales vers l'extérieur. L'overlay *Face Orientation* aide à repérer le problème : les faces correctes apparaissent en bleu, les inversées en rouge.

```side-by-side
layout: "textLeft"
imagePath: "assets/images/placeholder_face_orientation_blender.jpg"
caption: "Figure 4.1 : L'overlay Face Orientation — faces correctes en bleu, normales inversées en rouge."
title: "Vérifier les normales"
---
La capture montre un objet sous l'overlay Face Orientation : les faces bleues sont correctement orientées vers l'extérieur, les rouges ont leur normale inversée. Un simple `Maj + N` recalcule l'ensemble vers l'extérieur. Des normales saines sont indispensables à un shading correct, comme abordé dans le Bloc 1.
```

### Le point d'origine et l'application des transformations
Deux notions d'hygiène ferment ce chapitre. Le **point d'origine** (le petit point orange de l'objet) sert de référence à sa position, sa rotation et son échelle ; on peut le repositionner via *Object > Set Origin*. Surtout, il faut **appliquer les transformations** avec `Ctrl + A` — l'échelle en particulier. Un objet dont l'échelle n'a pas été appliquée conserve une déformation cachée qui perturbe de nombreux outils en aval.

### La checklist des bonnes pratiques
Avant de considérer un objet comme « terminé », prenez le réflexe de vérifier ces points :
- La géométrie privilégie les **quads**, surtout sur les zones courbes.
- Les **normales** sont recalculées vers l'extérieur (`Maj + N`).
- L'**échelle est appliquée** (`Ctrl + A > Scale`), affichant des valeurs de 1,000.
- Le **point d'origine** est placé de façon cohérente (souvent au centre ou à la base de l'objet).
- Les éventuels **sommets en double** ont été fusionnés (*Merge by Distance*).
Cette hygiène évite l'écrasante majorité des problèmes rencontrés plus tard.

> [!IMPORTANT]
> **Appliquez toujours l'échelle** (`Ctrl + A > Scale`) avant de déplier les UV ou d'ajouter un Bevel. Une échelle non appliquée fausse la taille des textures, produit des biseaux d'épaisseur irrégulière et perturbe les simulations physiques. C'est l'erreur numéro un du débutant, et elle a des répercussions directes sur le Bloc 1 (biseaux, métal brossé) et le Bloc 2 (dépliage UV).

> [!CAUTION]
> **Défi d'application :** modélisez un objet simple à partir d'une primitive — un mug, une table basse ou une clé USB. Imposez-vous d'y appliquer toutes les bonnes pratiques : rester en quads autant que possible, recalculer les normales, appliquer l'échelle et placer un point d'origine cohérent. Vous obtiendrez un objet réellement prêt à être texturé et rendu dans la suite de la formation.

```quiz
question: "Pourquoi faut-il appliquer l'échelle (Ctrl + A) avant de déplier les UV ou d'ajouter un Bevel ?"
options:
  - "Pour supprimer l'objet de la scène"
  - "Parce qu'une échelle non appliquée fausse les textures et les biseaux"
  - "Pour changer la couleur de l'objet"
  - "Cela n'a aucune importance"
correctIndices:
  - 1
explanation: "Une échelle non appliquée conserve une déformation cachée qui **fausse la taille des textures et l'épaisseur des biseaux**. Appliquer l'échelle (`Ctrl + A > Scale`) remet ces valeurs à 1,000 et garantit un comportement correct en aval."
```
