## 1. Le compositing : retoucher l'image dans Blender

### Qu'est-ce que la post-production ?
Un rendu, même soigné, constitue rarement l'image finale. La **post-production** est l'étape qui consiste à retoucher cette image après le calcul : ajuster l'exposition, renforcer le contraste, corriger les couleurs, ajouter une lueur autour des zones brillantes ou créer une impression de profondeur. Réaliser ces retouches directement dans Blender, plutôt que d'exporter vers un logiciel externe, évite les allers-retours et permet d'affiner le résultat en restant dans un seul outil. Cette retouche par nœuds s'appelle le **compositing**.

### L'espace de travail Compositing
Blender réunit ces outils dans l'onglet **Compositing**, en haut de la fenêtre. Il faut y activer le compositeur pour commencer à travailler. L'écran présente alors un éditeur de nœuds dédié à l'image, dans lequel on construit le graphe de retouche, ainsi qu'un fond (*backdrop*) qui affiche le résultat des opérations.

### Le flux de base : de la scène à l'image finale
Le compositing suit une logique identique à celle des matériaux : un réseau de nœuds, parcouru de la source vers la sortie. Le nœud **Render Layers** est la source : il fournit l'image rendue (et, nous le verrons, ses différentes passes). On intercale ensuite des nœuds d'effet, puis on aboutit au nœud **Group Output**, qui produit l'image finale. Un nœud **Viewer** permet à tout moment d'afficher un résultat intermédiaire sur le fond pour juger une étape.

```side-by-side
layout: "textLeft"
imagePath: "assets/images/placeholder_compositor_node_flow_blender.jpg"
caption: "Figure 1.1 : Le flux de compositing, du nœud Render Layers vers le Group Output."
title: "Le réseau de compositing"
---
La capture montre la chaîne minimale : le nœud Render Layers, à gauche, fournit l'image rendue ; elle traverse un ou plusieurs nœuds d'effet, puis rejoint le nœud Group Output, à droite, qui définit l'image finale. C'est entre ces deux extrémités que viendront s'insérer toutes les retouches de ce bloc.
```

### Une retouche non destructive
L'atout majeur du compositing est son caractère **non destructif** : le rendu d'origine n'est jamais altéré. On empile des ajustements que l'on peut modifier, désactiver ou supprimer à tout instant. Mieux encore, modifier le compositing ne nécessite pas de relancer le calcul complet de la scène : Blender ne recalcule que le réseau de nœuds, ce qui rend les essais quasi instantanés.

> [!NOTE]
> Tant que vous ne touchez qu'au compositing, inutile de refaire un rendu complet de la scène. Blender conserve l'image rendue et n'applique que vos nouveaux nœuds. Vous pouvez ainsi tester dix variantes d'exposition ou de bloom en quelques secondes, sans attendre un nouveau calcul.

```quiz
question: "Quel nœud sert de source à l'image rendue dans le compositeur ?"
options:
  - "Le nœud Group Output"
  - "Le nœud Render Layers"
  - "Le nœud Viewer"
  - "Le nœud Glare"
correctIndices:
  - 1
explanation: "Le nœud **Render Layers** fournit l'image rendue (et ses passes) au compositeur. Les effets s'intercalent ensuite jusqu'au **Group Output**, qui produit l'image finale."
```

## 2. Exposition, contraste et bloom

### Gérer l'exposition
L'exposition se règle à deux niveaux complémentaires. Au niveau de la scène, le panneau **Color Management** (dans les propriétés de rendu) propose un curseur *Exposure* qui éclaircit ou assombrit globalement l'image, ainsi qu'une **View Transform** qui convertit le rendu, calculé sur une large plage dynamique, en une image affichable. Au niveau du compositeur, le nœud **Exposure** permet d'ajuster localement la luminosité en valeurs d'exposition (*stops*), comme sur un appareil photo.

### La View Transform et le Look
Dans cette version de Blender, la View Transform par défaut est **AgX**. Elle gère élégamment les très hautes lumières en évitant les zones blanches « brûlées » et restitue des couleurs agréables, là où l'ancienne transformation Filmic était moins douce. Le menu **Look** y ajoute des préréglages de contraste (du plus neutre au plus marqué). À l'inverse, la transformation *Standard* n'applique aucune correction de tonalité : on la réserve aux usages techniques.

```side-by-side
layout: "textRight"
imagePath: "assets/images/placeholder_color_management_exposure_blender.jpg"
caption: "Figure 2.1 : Le panneau Color Management avec la View Transform AgX, l'Exposure et le Look."
title: "La gestion des couleurs"
---
La capture met en évidence la View Transform réglée sur AgX, le curseur Exposure et le menu Look. Ces trois réglages gouvernent l'aspect tonal global de l'image avant même tout compositing : un bon point de départ d'exposition ici facilite ensuite toutes les retouches fines.
```

### Le contraste
Pour ajuster le contraste, deux nœuds se complètent. Le nœud **Brightness/Contrast** offre un réglage direct et immédiat. Le nœud **RGB Curves** donne un contrôle bien plus fin : en traçant une légère courbe en S, on accentue le contraste de façon nuancée — les ombres s'assombrissent, les hautes lumières s'éclaircissent — tout en maîtrisant précisément chaque zone de tonalité.

### Le bloom grâce au nœud Glare
Le **bloom** est cette douce lueur qui déborde des zones très lumineuses : sources de lumière, écrans émissifs, reflets éclatants. Dans cette version de Blender, il ne se règle plus dans EEVEE mais se crée au compositing, à l'aide du nœud **Glare**. On ajoute le nœud, on choisit le mode **Bloom**, puis on dose l'effet : le *Threshold* (seuil) détermine quels pixels sont assez lumineux pour rayonner, tandis que la taille et la force règlent l'étendue et l'intensité du halo. Le même nœud propose d'autres modes, comme *Streaks* (traînées) ou *Fog Glow*, pour des effets plus stylisés.

```side-by-side
layout: "textLeft"
imagePath: "assets/images/placeholder_glare_bloom_node_blender.jpg"
caption: "Figure 2.2 : Le nœud Glare en mode Bloom, avec son réglage de seuil (Threshold)."
title: "Créer le bloom au compositing"
---
La capture montre le nœud Glare inséré entre le Render Layers et la sortie, son mode réglé sur Bloom. Le réglage Threshold est le plus important : trop bas, toute l'image se met à briller ; bien réglé, seules les zones réellement lumineuses rayonnent, pour une lueur crédible.
```

> [!IMPORTANT]
> Si vous cherchez en vain une case « Bloom » dans les réglages d'EEVEE, c'est normal : elle a été retirée. Le bloom se produit désormais **exclusivement dans le compositeur**, via le nœud Glare en mode Bloom. C'est un changement récent qu'il faut avoir en tête en passant d'une ancienne version à celle-ci.

> [!TIP]
> Le réglage *Threshold* du nœud Glare est votre meilleur allié pour un bloom propre. Montez-le suffisamment pour que seules les sources vraiment lumineuses rayonnent : un seuil trop bas fait briller des zones de luminosité moyenne et donne une image laiteuse et peu crédible.

```quiz
question: "Dans cette version de Blender, comment crée-t-on un effet de bloom ?"
options:
  - "En cochant la case Bloom dans les réglages d'EEVEE"
  - "Avec le nœud Glare en mode Bloom, dans le compositeur"
  - "En augmentant la puissance de toutes les lampes"
  - "En changeant la View Transform pour Standard"
correctIndices:
  - 1
explanation: "Le bloom n'est plus un réglage d'EEVEE : il se crée au compositing avec le nœud **Glare** réglé en mode **Bloom**, dont le seuil (*Threshold*) contrôle quelles zones lumineuses rayonnent."
```

## 3. Les passes de rendu : isoler pour affiner

### Qu'est-ce qu'une passe de rendu ?
Par défaut, un rendu produit une seule image « tout compris ». Une **passe de rendu** isole au contraire une composante précise de cette image dans une couche séparée : la profondeur, les seuls reflets, la seule émission, l'occlusion des recoins… Au lieu d'un résultat unique et figé, on dispose des ingrédients séparément, ce qui permet de retoucher chacun indépendamment au compositing, sans toucher aux autres.

### Activer les passes
Les passes s'activent dans les propriétés du **View Layer**, à la rubrique *Passes*. On ne coche que celles dont on a besoin, car chacune ajoute un peu de temps de calcul et de mémoire. Parmi les passes simples les plus utiles :
- **Combined** : l'image complète habituelle, toutes composantes réunies.
- **Z / Depth** : la distance de chaque pixel à la caméra, précieuse pour les effets de profondeur.
- **Mist** : une version normalisée de la profondeur, idéale pour ajouter de la brume.
- **Ambient Occlusion** : l'ombrage des creux et recoins.
- **Emission** : la seule lumière émise par les matériaux émissifs.
- **Glossy** et **Diffuse** : respectivement les reflets et la composante diffuse, séparés.

### Exploiter les passes au compositing
Ces passes ouvrent un contrôle fin sur l'image. La passe **Mist** ou **Z** permet d'ajouter une brume atmosphérique qui estompe les objets lointains et creuse la profondeur. La passe **Glossy** se renforce isolément pour intensifier les reflets sans modifier le reste de l'image. La passe **Emission** sert à piloter précisément le bloom. La passe **Ambient Occlusion**, enfin, accentue les ombres de contact pour ancrer les objets.

```side-by-side
layout: "textRight"
imagePath: "assets/images/placeholder_mist_pass_depth_blender.jpg"
caption: "Figure 3.1 : Ajout d'une brume de profondeur à l'aide de la passe Mist."
title: "Creuser la profondeur avec la passe Mist"
---
La capture illustre l'usage de la passe Mist : les objets proches restent nets et contrastés, tandis que les plans lointains se fondent progressivement dans une légère brume. Cet effet, impossible à doser sur une image plate, devient simple et réglable une fois la profondeur isolée dans sa propre passe.
```

### Affiner sans tout refaire
Tout l'intérêt des passes est là : si les reflets vous paraissent trop discrets, vous renforcez la seule passe Glossy au compositing, en quelques secondes, plutôt que de modifier les matériaux et de relancer un rendu complet. Cette capacité à corriger chirurgicalement un effet précis est ce qui distingue un workflow de finalisation professionnel.

> [!TIP]
> Pour des sélections d'objets très précises au compositing, explorez la passe **Cryptomatte**. Elle génère des masques par objet ou par matériau, ce qui permet d'isoler un seul élément de l'image pour le retoucher séparément. C'est une porte d'entrée idéale vers un compositing plus avancé.

```quiz
question: "Vos reflets sont trop discrets sur le rendu final. Quelle approche est la plus efficace en post-production ?"
options:
  - "Recommencer tout le rendu avec des matériaux plus brillants"
  - "Renforcer isolément la passe Glossy au compositing"
  - "Augmenter l'exposition globale de l'image"
  - "Changer le format de sortie"
correctIndices:
  - 1
explanation: "En isolant les reflets dans la passe **Glossy**, on peut les renforcer seuls au compositing, sans modifier le reste de l'image ni relancer un rendu complet. C'est tout l'intérêt des passes de rendu."
```

## 4. Exporter en haute définition : web et impression

### Les réglages de sortie
La taille et la destination de l'image se définissent dans les propriétés de sortie (*Output*). On y fixe la **résolution** en pixels (largeur et hauteur), ainsi qu'un **pourcentage de résolution** très pratique : régler ce dernier à 50 % accélère les rendus de test, avant de repasser à 100 % pour le rendu définitif, sans avoir à retoucher les dimensions.

### Choisir le format selon la destination
Le menu *File Format* du panneau de sortie détermine le type de fichier produit. Le choix dépend avant tout de l'usage final :
- **PNG** : sans perte, gère la transparence ; le format polyvalent par excellence pour le web.
- **JPEG** : compressé, plus léger, sans transparence ; adapté aux partages rapides et aux pages web.
- **WEBP** : moderne, excellent rapport qualité/poids pour le web.
- **TIFF** : sans perte et de haute qualité ; un standard pour l'impression.
- **OpenEXR** : conserve toute la plage dynamique du rendu ; idéal pour l'archivage et un compositing ultérieur.

### La profondeur de couleur
Le réglage **Color Depth** fixe la finesse des dégradés. Le **8 bits** suffit pour le web et l'affichage écran. Le **16 bits**, plus lourd, restitue des dégradés bien plus doux et évite l'apparition de bandes (*banding*) dans les transitions subtiles, ce qui en fait le choix de référence pour l'impression de grande taille.

### Web ou impression : deux logiques
Les deux destinations n'obéissent pas aux mêmes contraintes. Pour le **web**, on vise des fichiers légers : sRGB, 8 bits, format PNG, JPEG ou WEBP, et une résolution calée sur la taille d'affichage. Pour l'**impression**, on raisonne en taille physique finale multipliée par une densité (DPI) : une page A4 à 300 DPI réclame ainsi environ 3508 × 2480 pixels. On y privilégie le 16 bits et un format sans perte comme le TIFF.

```side-by-side
layout: "textLeft"
imagePath: "assets/images/placeholder_output_properties_format_blender.jpg"
caption: "Figure 4.1 : Le panneau de sortie avec le format de fichier et la profondeur de couleur."
title: "Régler la sortie de l'image"
---
La capture présente les réglages de format et de profondeur de couleur. C'est ici que se joue la compatibilité finale de votre image : un mauvais format ou une profondeur inadaptée peut ruiner un beau rendu une fois imprimé ou publié. Le réflexe est d'ajuster ces paramètres en fonction de la destination, avant de lancer le rendu définitif.
```

> [!NOTE]
> Blender raisonne en pixels, jamais en centimètres. Pour une impression, calculez vous-même la résolution nécessaire : multipliez la taille physique voulue (en pouces) par la densité souhaitée (souvent 300 DPI). Anticiper ce calcul évite de découvrir trop tard qu'un rendu est trop petit pour être imprimé nettement.

```quiz
question: "Vous préparez un visuel destiné à une impression de grande taille. Quel couple de réglages est le plus adapté ?"
options:
  - "Format JPEG en 8 bits, basse résolution"
  - "Format TIFF en 16 bits, résolution calculée selon la taille et le DPI"
  - "Format WEBP en 8 bits, résolution d'écran"
  - "Peu importe, Blender adapte tout automatiquement"
correctIndices:
  - 1
explanation: "L'impression réclame un format sans perte comme le **TIFF**, une profondeur de **16 bits** pour des dégradés sans bandes, et une **résolution calculée** à partir de la taille physique et du DPI (par exemple 300 DPI). Le JPEG 8 bits convient au web, pas à un grand tirage."
```

## 5. Atelier de synthèse : une série de visuels « Beauté »

### L'objectif de l'atelier
Un visuel « Beauté » (*beauty shot*) est une image soignée qui montre un objet sous son meilleur jour : matériaux justes, éclairage de studio maîtrisé, cadrage réfléchi et finalisation au compositing. Cet atelier récapitulatif vous fait produire une **série cohérente** de tels visuels sur un même projet, en mobilisant l'ensemble des compétences des quatre blocs. C'est le moment où tout ce que vous avez appris se rejoint en une production complète.

```resource
title: "Projet de synthèse"
description: "Scène complète prête pour l'atelier final : un objet de présentation modélisé, à habiller, éclairer, cadrer et finaliser pour produire votre série de visuels Beauté."
fileName: "projet_synthese_beauty.blend (15.7 Mo)"
downloadUrl: "https://example.com/files/projet-synthese-beauty"
```

### Préparer la matière et la mise en scène
La fabrication d'un beauty shot suit un enchaînement logique qui reprend, dans l'ordre, les blocs précédents :
- Appliquez à l'objet des matériaux PBR justes, en soignant la finition (Bloc 1).
- Dépliez ou projetez ses textures selon la méthode la plus adaptée (Bloc 2).
- Montez un éclairage de studio, complété d'un HDRI pour des reflets cohérents (Bloc 3).
- Choisissez focale et profondeur de champ pour mettre l'objet en valeur (Bloc 3).
Chaque étape conditionne la suivante : un matériau mal réglé ne sera pas sauvé par l'éclairage, et inversement.

### Décliner la série
La force d'une série tient dans sa **variété maîtrisée**. À partir de la même scène et du même éclairage, produisez plusieurs cadrages complémentaires : une vue d'ensemble en trois-quarts qui présente l'objet, un gros plan sur un détail révélateur de la finition, et une vue plus graphique (de dessus ou en contre-plongée). L'éclairage et le traitement doivent rester constants d'une image à l'autre pour que la série forme un tout cohérent.

### Finaliser et exporter
Une fois les cadrages choisis, basculez sur Cycles pour le rendu final, puis finalisez chaque image au compositing : exposition, contraste, bloom et exploitation des passes. Exportez enfin la série en haute définition, dans le format adapté à sa destination. Veillez à appliquer le **même traitement** à toutes les images : c'est cette unité qui transforme trois rendus isolés en une véritable série professionnelle.

> [!IDEA]
> Pour enrichir votre série, explorez les variations : une déclinaison du même objet sous plusieurs coloris de matériau, ou une rotation complète présentée sous forme de plusieurs angles réguliers. Ces variantes, construites sur la même base, démultiplient la valeur d'un seul projet bien préparé.

> [!CAUTION]
> **Défi final :** réalisez une série de trois visuels Beauté de l'objet du projet de synthèse. Imposez-vous un éclairage et un traitement de compositing identiques sur les trois images, mais trois cadrages différents (ensemble, détail, vue graphique). Exportez le tout en haute définition, prêt pour le web. Cette série constituera la pièce maîtresse récapitulant l'ensemble de votre formation.

```quiz
question: "Qu'est-ce qui assure avant tout la cohérence d'une série de visuels Beauté ?"
options:
  - "Utiliser un format de fichier différent pour chaque image"
  - "Conserver un éclairage et un traitement de compositing identiques sur toute la série"
  - "Changer complètement de matériaux entre chaque vue"
  - "Augmenter la résolution à chaque nouvelle image"
correctIndices:
  - 1
explanation: "Une série professionnelle repose sur l'**unité** : un éclairage et un traitement de compositing constants d'une image à l'autre. Seuls les cadrages varient, ce qui relie les visuels entre eux tout en présentant l'objet sous plusieurs angles."
```
