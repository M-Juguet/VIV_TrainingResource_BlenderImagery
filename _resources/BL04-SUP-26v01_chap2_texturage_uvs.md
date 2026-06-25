## 1. Comprendre les UV : du volume 3D à l'image 2D

### Le problème de fond : poser une image plate sur un volume
Une texture est une image : un rectangle plat, en deux dimensions. Un objet 3D, lui, possède un volume, des courbes, des faces orientées dans toutes les directions. Se pose alors une question simple mais centrale : comment Blender sait-il quel pixel de l'image doit se poser sur quelle partie de la surface ? La réponse tient dans les **coordonnées UV**.

Les lettres U et V désignent les deux axes d'un système de coordonnées propre à la texture : U pour l'horizontale, V pour la verticale (on emploie U et V plutôt que X et Y, déjà utilisés par l'espace 3D). Chaque point du maillage se voit attribuer une position sur cette grille 2D. Le dépliage UV (*UV unwrapping*) est l'opération qui consiste à « aplatir » la surface de l'objet sur ce plan, afin que l'image puisse s'y appliquer sans confusion.

### Une analogie : déplier un emballage
Pour visualiser le dépliage, imaginez un emballage en carton que l'on déplie à plat, ou un patron de couture. La boîte en volume devient une forme étalée, découpée à certains endroits pour pouvoir reposer entièrement sur la table. C'est exactement ce que fait Blender avec la surface d'un objet : il la découpe le long de lignes choisies, puis l'étale sur le plan UV. L'image se pose ensuite sur cette version aplatie, et l'objet « rhabillé » la porte sur son volume.

### L'espace de travail UV Editing
Blender propose un espace de travail dédié à cette tâche : l'onglet **UV Editing**, dans la barre supérieure. Il divise l'écran en deux : à gauche, l'**éditeur UV** affiche le dépliage à plat (et l'image qui s'y applique) ; à droite, la vue 3D montre l'objet en mode Édition. Pour voir et manipuler les UV, vous devez entrer en **mode Édition** (touche `Tab`) et sélectionner des faces : leur dépliage apparaît alors dans l'éditeur de gauche.

```side-by-side
layout: "textRight"
imagePath: "assets/images/placeholder_uv_editing_workspace_blender.jpg"
caption: "Figure 1.1 : L'espace de travail UV Editing, avec l'éditeur UV à gauche et la vue 3D en mode Édition à droite."
title: "L'espace de travail UV Editing"
---
La capture met en évidence l'onglet UV Editing sélectionné. À gauche, l'éditeur UV présente le dépliage à plat des faces sélectionnées dans la vue 3D de droite. Toute modification du dépliage se reflète immédiatement sur l'objet, et inversement. C'est l'atelier dans lequel se déroule tout le travail sur les coordonnées.
```

### Coutures et îlots
Pour déplier une surface fermée, Blender a besoin de savoir où la « découper ». Ces lignes de découpe s'appellent des **coutures** (*seams*). On les définit en mode Édition : sélectionnez les arêtes voulues, puis utilisez le menu *Edge* ou le raccourci `Ctrl + E`, et choisissez **Mark Seam**. Les arêtes marquées apparaissent en rouge. Après dépliage, la surface se sépare en morceaux distincts appelés **îlots** (*islands*), chacun étant une portion étalée à plat dans l'éditeur UV.

La qualité d'un dépliage se mesure à sa faible **déformation** : un bon placement de coutures permet d'étaler la surface presque sans étirement, comme un tissu posé bien à plat. À l'inverse, de mauvaises coutures forcent la matière et déforment l'image appliquée.

> [!TIP]
> Pour repérer instantanément les déformations, appliquez temporairement une texture en damier sur votre objet. Si les carreaux apparaissent réguliers et carrés partout, votre dépliage est sain ; s'ils sont étirés ou tordus à certains endroits, c'est le signe d'un étirement à corriger.

```quiz
question: "À quoi sert une couture (seam) dans le dépliage UV ?"
options:
  - "À renforcer la solidité du maillage"
  - "À indiquer à Blender où découper la surface pour l'aplatir"
  - "À augmenter la résolution de la texture"
  - "À fusionner deux objets"
correctIndices:
  - 1
explanation: "Une **couture** marque les arêtes le long desquelles Blender « découpe » la surface pour pouvoir l'étaler à plat sur le plan UV, exactement comme les découpes d'un patron de couture ou d'un emballage en carton."
```

## 2. Le dépliage automatique : Smart UV Project

### Pourquoi automatiser le dépliage ?
Placer manuellement des coutures sur un objet simple est rapide. Mais sur une pièce mécanique complexe, un objet aux multiples facettes ou un maillage très dense, ce travail devient long et fastidieux. Heureusement, Blender propose des méthodes de dépliage **automatisées** qui analysent la géométrie et produisent un résultat exploitable en un clic. C'est tout l'esprit du « texturage agile » : obtenir vite un dépliage propre, sans intervention manuelle lourde.

```resource
title: "Objets de test - Dépliage UV"
description: "Lot d'objets de complexité croissante (écrou, boîtier électronique, garde-corps) pour vous entraîner aux différentes méthodes de dépliage automatique de cette section."
fileName: "objets_test_depliage_uv.blend (7.8 Mo)"
downloadUrl: "https://example.com/files/objets-test-depliage-uv"
```

### Smart UV Project, la méthode passe-partout
**Smart UV Project** est la méthode automatique de référence. En mode Édition, sélectionnez toutes les faces (touche `A`), ouvrez le menu de dépliage avec `U`, puis choisissez **Smart UV Project**. Blender analyse alors l'angle entre les faces voisines et crée automatiquement des coutures là où la surface change brusquement de direction. Une fenêtre d'options s'affiche pour affiner le résultat.

```side-by-side
layout: "textLeft"
imagePath: "assets/images/placeholder_smart_uv_project_options_blender.jpg"
caption: "Figure 2.1 : La fenêtre d'options de Smart UV Project (Angle Limit, Island Margin, etc.)."
title: "Les options de Smart UV Project"
---
La fenêtre regroupe les réglages clés. *Angle Limit* fixe le seuil d'angle au-delà duquel une nouvelle découpe est créée : plus la valeur est basse, plus le dépliage se fragmente en petits îlots. *Island Margin* définit l'espace laissé entre les îlots pour éviter qu'ils ne se chevauchent. Ces deux réglages suffisent dans la grande majorité des cas.
```

### Mettre en œuvre un dépliage automatique
Pour déplier un objet complexe en quelques secondes, suivez cette séquence :
- Passez en mode Édition et sélectionnez toutes les faces avec `A`.
- Ouvrez le menu `U` et choisissez Smart UV Project.
- Réglez *Angle Limit* (autour de 66° par défaut convient à la plupart des pièces dures).
- Augmentez légèrement *Island Margin* pour éviter tout chevauchement entre îlots.
- Validez : le dépliage apparaît dans l'éditeur UV, prêt à recevoir une texture.

### Les autres méthodes rapides
Smart UV Project n'est pas la seule option du menu `U`. La méthode **Unwrap** déplie en s'appuyant sur les coutures que vous avez posées vous-même, avec un choix d'algorithmes (*Angle Based*, *Conformal*, *Minimum Stretch*) selon le compromis recherché entre fidélité des angles et limitation de l'étirement. Les projections **Cube**, **Cylinder** et **Sphere Project** conviennent aux objets dont la forme s'approche de ces volumes simples. Enfin, **Pack Islands** réorganise et tasse les îlots existants pour exploiter au mieux la surface disponible de la texture.

> [!WARNING]
> Smart UV Project est rapide et idéal pour les objets « durs » (mécaniques, architecturaux). Sur un modèle organique destiné à être vu de près — un visage, un personnage — il a tendance à fragmenter la surface en de nombreux petits îlots, ce qui complique la peinture de texture. Pour ces cas, un placement manuel des coutures suivi d'un *Unwrap* reste préférable.

```quiz
question: "Sur quel critère Smart UV Project décide-t-il automatiquement de créer une nouvelle couture ?"
options:
  - "La couleur des faces"
  - "L'angle entre les faces voisines (Angle Limit)"
  - "Le nombre total de sommets"
  - "La taille du fichier de texture"
correctIndices:
  - 1
explanation: "Smart UV Project analyse l'**angle entre les faces adjacentes** : au-delà du seuil défini par *Angle Limit*, il crée une découpe. C'est ce qui lui permet de déplier automatiquement une pièce complexe sans coutures posées à la main."
```

## 3. Texturer sans UV : la projection Box (triplanaire)

### Et si l'on se passait du dépliage ?
Le dépliage UV n'est pas toujours nécessaire. Pour de nombreuses surfaces — un mur, un rocher, un terrain, un maillage dense issu d'un scan — déplier proprement coûterait beaucoup de temps pour un bénéfice nul. Dans ces situations, on peut **projeter** la texture directement sur la géométrie à partir de sa position dans l'espace, sans aucune coordonnée UV. C'est le workflow « sans UV », instantané et particulièrement efficace.

### Le mode Box du nœud Image Texture
Le nœud Image Texture possède un menu déroulant **Projection** offrant quatre modes : *Flat* (le mode par défaut, qui s'appuie sur les UV), *Box*, *Sphere* et *Tube*. Le mode **Box** correspond à la projection dite **triplanaire** : la texture est projetée simultanément depuis les trois axes (X, Y, Z), chaque face de l'objet recevant l'image depuis la direction qui lui fait le plus face. Plus besoin de déplier : la texture se pose d'elle-même, où que se trouve la géométrie.

### Le paramètre Blend, clé d'une projection propre
Dès que le mode Box est sélectionné, un curseur **Blend** apparaît sous le menu de projection. Il contrôle la zone de fondu entre les trois projections. À `0`, les jonctions entre les axes sont franches et laissent apparaître des coupures nettes. En montant la valeur vers `0.2` ou `0.3`, ces transitions se fondent en douceur, ce qui efface les démarcations sur les faces inclinées. C'est le réglage qui transforme une projection visiblement « plaquée » en un habillage convaincant.

```side-by-side
layout: "textRight"
imagePath: "assets/images/placeholder_box_projection_blend_blender.jpg"
caption: "Figure 3.1 : Effet du curseur Blend en projection Box, de 0 (coupures visibles) à 0.3 (transitions fondues)."
title: "Le curseur Blend de la projection Box"
---
À gauche de l'illustration, avec un Blend à 0, on devine les arêtes où deux projections se rencontrent : la texture présente des cassures nettes. À droite, avec un Blend modéré, les trois projections se mélangent progressivement et l'objet semble entièrement et naturellement recouvert. Une valeur faible mais non nulle suffit presque toujours.
```

### Quelles coordonnées alimenter la projection ?
Puisque l'on se passe d'UV, il faut indiquer au nœud quelle référence spatiale utiliser. On branche pour cela un nœud **Texture Coordinate** dont les sorties *Object* ou *Generated* conviennent à la projection Box. La sortie *Generated* s'appuie sur la boîte englobante normalisée de l'objet, tandis que *Object* utilise son espace local : la première suit les proportions de l'objet, la seconde reste stable même si l'objet est déformé.

> [!TIP]
> La projection Box est l'outil rêvé pour habiller en quelques secondes des rochers, des terrains, des murs ou tout maillage dense où le dépliage serait pénible. Associez-la systématiquement à une texture *seamless* (sans raccord) pour un résultat impeccable.

> [!NOTE]
> La projection Box a ses limites : sur les faces fortement inclinées (autour de 45°), un léger étirement ou un mélange de deux orientations peut apparaître. Elle offre aussi moins de contrôle qu'un vrai dépliage UV pour placer un motif précis, comme un logo. C'est un compromis rapidité/précision à assumer selon l'objet.

```quiz
question: "Quel mode de projection du nœud Image Texture permet d'habiller un objet sans aucun dépliage UV ?"
options:
  - "Flat"
  - "Box"
  - "Sphere"
  - "Tube"
correctIndices:
  - 1
explanation: "Le mode **Box** réalise une projection triplanaire (depuis les axes X, Y et Z) qui pose la texture directement sur la géométrie, sans coordonnées UV. Le mode *Flat*, lui, s'appuie au contraire sur le dépliage UV existant."
```

## 4. Maîtriser le Mapping : échelle, répétition, orientation

### Le duo Texture Coordinate + Mapping
Une fois la texture posée, encore faut-il la placer correctement : à la bonne taille, au bon endroit, dans la bonne orientation. Ce contrôle se fait en amont du nœud Image Texture, grâce à deux nœuds qui travaillent ensemble. Le nœud **Texture Coordinate** fournit le système de coordonnées (UV, Generated, Object…), et le nœud **Mapping** transforme ces coordonnées avant qu'elles n'atteignent la texture. La chaîne type est donc : Texture Coordinate, puis Mapping, puis Image Texture.

```side-by-side
layout: "textLeft"
imagePath: "assets/images/placeholder_mapping_chain_blender.jpg"
caption: "Figure 4.1 : La chaîne Texture Coordinate vers Mapping vers Image Texture."
title: "Piloter le placement d'une texture"
---
La capture montre les trois nœuds reliés dans l'ordre : la sortie de coordonnées du Texture Coordinate alimente l'entrée Vector du Mapping, dont la sortie nourrit à son tour l'entrée Vector de l'Image Texture. Tout ajustement effectué dans le nœud Mapping se répercute en temps réel sur la texture affichée.
```

### Le nœud Mapping en détail
Le nœud Mapping expose trois réglages, chacun disponible aussi en entrée connectable : **Location** déplace la texture sur la surface, **Rotation** l'oriente, et **Scale** ajuste son échelle. Un point souvent contre-intuitif mérite l'attention : augmenter la valeur de *Scale* **réduit** la taille apparente du motif et le fait se répéter davantage. En effet, on agrandit la grille de coordonnées, donc la texture se densifie. À l'inverse, une valeur de *Scale* inférieure à 1 agrandit le motif.

### Le carrelage et les modes d'extension
Lorsqu'une texture se répète sur une grande surface, son comportement aux bords est régi par le menu **Extension** du nœud Image Texture, qui propose quatre modes. **Repeat** répète la texture à l'identique dans toutes les directions : c'est le mode du carrelage classique, qui exige une texture *seamless* pour éviter les raccords visibles. **Mirror** répète en inversant une fois sur deux, ce qui masque astucieusement les jointures. **Extend** étire les pixels du bord au-delà de l'image, et **Clip** n'affiche qu'une seule occurrence, le reste devenant transparent.

```resource
title: "Pack de textures seamless"
description: "Sélection de textures sans raccord (béton, métal, bois, tissu) prêtes à être carrelées pour vous exercer au Mapping et aux modes d'extension."
fileName: "pack_textures_seamless.zip (24.6 Mo)"
downloadUrl: "https://example.com/files/pack-textures-seamless"
```

### Casser la répétition visible
Sur de très grandes surfaces, même une texture seamless finit par trahir son motif répété : l'œil repère les éléments qui reviennent à intervalles réguliers. Plusieurs réflexes limitent cet effet : utiliser le mode *Mirror*, mélanger une seconde texture à grande échelle pour introduire des variations lentes de teinte, ou faire varier subtilement l'orientation. L'objectif est toujours de tromper la perception de la régularité.

> [!TIP]
> Retenez la logique du Scale : pour qu'un motif paraisse **deux fois plus petit** et se répète deux fois plus, doublez la valeur de *Scale* dans le nœud Mapping. C'est l'erreur la plus fréquente des débutants, qui s'attendent à l'effet inverse.

```quiz
question: "Dans le nœud Mapping, quel est l'effet d'une augmentation de la valeur Scale sur une texture ?"
options:
  - "Le motif devient plus grand et se répète moins"
  - "Le motif devient plus petit et se répète davantage"
  - "La texture pivote sur elle-même"
  - "La texture change de couleur"
correctIndices:
  - 1
explanation: "Augmenter *Scale* agrandit la grille de coordonnées, ce qui **réduit** la taille apparente du motif et le fait se **répéter davantage**. C'est un effet contre-intuitif qu'il faut mémoriser."
```

## 5. Habiller vite une géométrie dense : choisir la bonne méthode

### Il n'existe pas une seule bonne méthode
Le texturage agile ne consiste pas à appliquer toujours la même technique, mais à **choisir la méthode adaptée à chaque objet**. Un dépliage UV soigné est parfois indispensable ; ailleurs, il serait une perte de temps pure. Savoir arbitrer, c'est gagner des heures sans rien sacrifier à la qualité visible. Cette section ne présente pas de nouvel outil : elle vous donne le raisonnement qui relie tous les précédents.

### L'arbre de décision
Face à un objet à texturer, posez-vous les bonnes questions dans l'ordre :
- L'objet sera vu de près et exige un placement précis (un personnage, un visage, une étiquette, un objet héros) : optez pour un **dépliage UV**, manuel ou via Smart UV Project.
- L'objet est grand, uniforme et répétitif (mur, sol, rocher, terrain) : préférez la **projection Box** ou un carrelage UV avec texture seamless, sans dépliage manuel.
- Le maillage est dense ou issu d'une sculpture ou d'un scan, sans topologie propre : la **projection Box** vous épargne des heures de pose de coutures.
- La forme est proche d'un volume simple (boîte, cylindre, sphère) : une **projection Cube, Cylinder ou Sphere** donne un résultat immédiat.
En résumé : on déplie ce qui doit être précis, on projette tout le reste.

### Le réflexe seamless
La clé de l'habillage rapide des grandes géométries tient en un mot : *seamless*. Une texture sans raccord, même de petite taille, peut couvrir une surface immense en se répétant sans jointure apparente. Associée au nœud Mapping pour l'échelle et au mode d'extension Repeat ou Mirror, elle permet d'habiller un mur entier ou un sol complet à partir d'un seul fichier léger.

### Gagner du temps sans sacrifier la qualité
La règle d'or du workflow agile est de **ne pas soigner ce qui ne sera pas vu**. Inutile de déplier méticuleusement l'arrière d'un objet caché ou une surface lointaine. Commencez toujours par la méthode la plus rapide qui donne un résultat acceptable, puis n'investissez du temps de dépliage manuel que sur les zones réellement exposées au regard. C'est ce tri permanent qui distingue un workflow efficace d'un travail laborieux.

> [!IDEA]
> Faites l'expérience sur un même objet dense : habillez-le une première fois en projection Box, puis une seconde fois via Smart UV Project suivi d'un carrelage. Comparez le temps passé et le rendu final. Vous mesurerez concrètement dans quels cas chaque méthode vaut son investissement.

```quiz
question: "Vous devez texturer rapidement un grand rocher au maillage dense, sans topologie propre. Quelle méthode est la plus indiquée ?"
options:
  - "Un dépliage UV manuel face par face"
  - "La projection Box avec une texture seamless"
  - "Le mode d'extension Clip"
  - "Aucune, il faut remodéliser l'objet"
correctIndices:
  - 1
explanation: "Sur un maillage dense sans topologie exploitable, la **projection Box** associée à une texture seamless habille l'objet instantanément, sans le moindre dépliage manuel. C'est l'application type du texturage agile."
```

## 6. Constituer sa bibliothèque de matériaux : l'Asset Browser

### Pourquoi se constituer une bibliothèque ?
Recréer les mêmes matériaux d'un projet à l'autre est une perte de temps considérable. Le métal, le verre ou le plastique que vous avez patiemment réglés méritent d'être réutilisés. L'**Asset Browser** (navigateur d'assets) répond exactement à ce besoin : il stocke vos matériaux — mais aussi vos objets ou vos groupes de nœuds — dans une bibliothèque accessible depuis n'importe quel fichier, par un simple glisser-déposer.

### Marquer un matériau comme asset
Pour qu'un matériau rejoigne la bibliothèque, il faut le **marquer comme asset**. Faites un clic droit sur le matériau, dans la liste des matériaux ou directement dans l'Asset Browser, puis choisissez **Mark as Asset**. Blender génère alors automatiquement un aperçu miniature et range le matériau parmi les assets disponibles. L'opération inverse, *Clear Asset*, le retire de la bibliothèque.

```side-by-side
layout: "textLeft"
imagePath: "assets/images/placeholder_mark_as_asset_blender.jpg"
caption: "Figure 6.1 : Le menu contextuel Mark as Asset appliqué à un matériau, et l'aperçu généré."
title: "Marquer un matériau comme asset"
---
La capture montre le clic droit sur un matériau faisant apparaître l'option Mark as Asset. Une fois validée, une vignette d'aperçu est créée et le matériau devient disponible dans l'Asset Browser. C'est cette vignette qui permettra plus tard de le reconnaître d'un coup d'œil dans la bibliothèque.
```

### Mettre en place et parcourir sa bibliothèque
L'**éditeur Asset Browser** s'ouvre dans son propre espace ou en remplaçant une zone existante. Pour qu'il affiche vos assets entre plusieurs fichiers, désignez un dossier de bibliothèque dans les préférences de Blender, à la rubrique des chemins de fichiers (*File Paths*, section *Asset Libraries*). Tous les fichiers .blend rangés dans ce dossier exposeront alors leurs assets dans le navigateur. Appliquer un matériau devient immédiat : il suffit de le faire glisser depuis le navigateur jusqu'à l'objet dans la vue 3D.

### Organiser avec des catalogues
Une bibliothèque qui grossit doit rester rangée. L'Asset Browser permet de créer des **catalogues**, sortes de dossiers thématiques (Métaux, Plastiques, Verres…), et d'ajouter à chaque asset des étiquettes et une description. Un classement clair fait toute la différence le jour où la bibliothèque compte des dizaines de matières.

> [!TIP]
> Réservez un fichier .blend dédié, par exemple nommé *bibliotheque_materiaux.blend*, pour y rassembler tous vos matériaux marqués comme assets. Vous disposerez ainsi d'un point unique à entretenir, que tous vos projets pourront piloter via les préférences.

> [!CAUTION]
> **Défi d'application :** à partir des matières travaillées au Bloc 1, constituez votre première bibliothèque personnelle. Créez cinq matériaux (un métal poli, un verre, un plastique technique, un métal usé et un tissu mat), marquez-les comme assets, soignez leurs aperçus, puis rangez-les dans un catalogue nommé d'après le cours. Vous repartirez de la formation avec une base réutilisable immédiatement.

```quiz
question: "Quelle action rend un matériau disponible dans l'Asset Browser pour être réutilisé entre plusieurs fichiers ?"
options:
  - "Renommer le matériau"
  - "Le marquer comme asset (Mark as Asset)"
  - "Augmenter sa résolution de texture"
  - "Le brancher deux fois au Material Output"
correctIndices:
  - 1
explanation: "C'est la commande **Mark as Asset** qui intègre le matériau à la bibliothèque, génère son aperçu et le rend accessible par glisser-déposer depuis l'Asset Browser, y compris dans d'autres fichiers."
```
