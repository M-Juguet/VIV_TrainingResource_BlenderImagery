## 1. Les deux moteurs de rendu : EEVEE et Cycles

### À quoi sert un moteur de rendu ?
Une scène 3D n'est, en mémoire, qu'un ensemble de données : des géométries, des matériaux, des lampes et une caméra. Le **moteur de rendu** est le programme qui transforme ces données en une image finie, en calculant, pixel par pixel, la lumière qui parvient à la caméra. Blender embarque deux moteurs aux philosophies opposées et complémentaires : **EEVEE** et **Cycles**. Bien comprendre leurs différences est le point de départ de tout travail de rendu.

### EEVEE : le temps réel enrichi
EEVEE est un moteur de **rastérisation** : il privilégie la vitesse et l'interactivité, produisant une image quasi instantanée. C'est l'outil idéal pour ajuster ses matériaux et son éclairage en voyant le résultat se mettre à jour en direct. Dans cette version de Blender, EEVEE a gagné un véritable **raytracing**, qui améliore nettement la qualité de ses reflets, de ses ombres et de son occlusion. Il reste néanmoins un moteur orienté rapidité, parfait pour le LookDev, la prévisualisation et les rendus stylisés.

### Cycles : le path tracing physique
Cycles est un moteur de **lancer de rayons** (*path tracing*) : il simule physiquement le trajet des rayons de lumière qui rebondissent dans la scène. Plus lent qu'EEVEE, il offre en contrepartie un réalisme supérieur — éclairage global authentique, réfraction exacte du verre, ombres douces naturelles, caustiques. C'est le moteur du rendu final photoréaliste, lorsque la qualité prime sur la vitesse.

### Le workflow hybride
La force de Blender est de pouvoir combiner les deux. La pratique professionnelle consiste à travailler toute la phase de mise au point — matériaux, éclairage, cadrage — sous **EEVEE**, pour profiter de son immédiateté, puis à basculer sur **Cycles** au moment du rendu final. Comme les deux moteurs partagent exactement les mêmes matériaux PBR et les mêmes lampes, ce passage se fait sans rien reconstruire. Le changement de moteur s'opère dans les propriétés de rendu, via le menu *Render Engine*.

```side-by-side
layout: "textLeft"
imagePath: "assets/images/placeholder_render_engine_dropdown_blender.jpg"
caption: "Figure 1.1 : Le sélecteur de moteur de rendu dans les propriétés de rendu (EEVEE / Cycles)."
title: "Basculer d'un moteur à l'autre"
---
La capture isole le menu Render Engine, en haut des propriétés de rendu, qui permet de choisir entre EEVEE et Cycles. Comme la scène, ses matériaux et ses lampes sont communs aux deux moteurs, on peut passer de l'un à l'autre à tout moment pour comparer rapidité et fidélité.
```

> [!TIP]
> Ne confondez pas le moteur de rendu et le mode d'affichage de la vue 3D. Le mode **Material Preview** (icône de sphère) affiche toujours un aperçu rapide basé sur EEVEE avec un éclairage d'étude neutre, tandis que le mode **Rendered** affiche la scène avec le moteur réellement sélectionné. Pour juger un rendu Cycles, passez bien la vue en mode Rendered.

```quiz
question: "Dans le workflow hybride recommandé, quel moteur utilise-t-on pour la mise au point interactive de l'éclairage et des matériaux ?"
options:
  - "Cycles, car il est plus précis"
  - "EEVEE, pour son retour quasi instantané"
  - "Aucun, on travaille à l'aveugle"
  - "Les deux simultanément en permanence"
correctIndices:
  - 1
explanation: "On réserve **EEVEE** à la phase interactive (LookDev, réglage des lumières) grâce à sa rapidité, puis on bascule sur **Cycles** uniquement pour le rendu final photoréaliste. Les matériaux et lampes étant partagés, le passage est immédiat."
```

## 2. Les sources de lumière dans Blender

### Ajouter une lampe à la scène
Sans source de lumière, une scène rendue sous Cycles reste noire. On ajoute une lampe via le menu **Add > Light**, puis on choisit son type. Chaque type de lampe imite un comportement physique différent, et le choix du bon type est la première décision d'un éclairage réussi.

### Les quatre types de lampes
Blender propose quatre sources, chacune adaptée à un usage :
- **Point** : émet dans toutes les directions depuis un point, comme une ampoule nue. Réglée par sa puissance (*Power*, en watts) et son *Radius*, qui définit sa taille apparente.
- **Sun** (Soleil) : envoie des rayons parallèles depuis l'infini, quelle que soit sa position ; seule son orientation compte. Réglée par sa *Strength* et son *Angle*, qui simule le diamètre apparent du soleil.
- **Spot** : projette un cône de lumière, comme un projecteur de théâtre. Son *Spot Size* fixe l'angle du cône et son *Blend* la douceur du bord.
- **Area** (Surface) : émet depuis une surface (carrée, rectangulaire ou en disque), à la manière d'une fenêtre ou d'un *softbox* de studio. C'est la lampe de prédilection pour le LookDev.

### Le principe fondamental : taille de la source et douceur des ombres
S'il ne fallait retenir qu'une seule règle d'éclairage, ce serait celle-ci : **plus une source de lumière est grande, plus ses ombres sont douces**. Une source minuscule, presque ponctuelle, projette des ombres aux bords nets et tranchés. Une grande surface lumineuse enveloppe les objets et produit des ombres progressives, aux contours estompés. C'est exactement ce que contrôlent le *Radius* d'une Point, l'*Angle* d'une Sun ou la *Size* d'une Area.

```side-by-side
layout: "textRight"
imagePath: "assets/images/placeholder_light_size_shadow_softness_blender.jpg"
caption: "Figure 2.1 : Une même sphère éclairée par une petite source (ombre nette) puis par une grande source (ombre douce)."
title: "La taille gouverne l'ombre"
---
À gauche, une source de petite taille projette une ombre aux bords francs et durs. À droite, en augmentant simplement la taille de la même lampe, l'ombre devient progressive et son contour s'adoucit. Ce seul réglage transforme radicalement l'ambiance d'une scène : il mérite d'être maîtrisé avant toute autre considération.
```

> [!IMPORTANT]
> La douceur d'une ombre ne dépend pas d'un réglage nommé « douceur », mais bien de la **taille physique de la source**. Pour adoucir une ombre trop dure, agrandissez la lampe (son *Size*, *Radius* ou *Angle*) plutôt que de chercher un paramètre dédié. C'est le réflexe qui distingue un éclairage crédible d'un éclairage artificiel.

### Puissance et couleur
Deux réglages complètent toute lampe : la **puissance** (*Power*), exprimée en watts, qui détermine l'intensité lumineuse, et la **couleur**, qui teinte la lumière émise. Jouer sur la couleur permet de simuler une lumière chaude (tons orangés d'une lampe domestique) ou froide (tons bleutés d'un ciel d'ombre), élément essentiel de l'ambiance d'une scène.

```quiz
question: "Une ombre est trop dure et tranchée à votre goût. Quel réglage permet de l'adoucir ?"
options:
  - "Baisser la puissance de la lampe"
  - "Augmenter la taille de la source (Size, Radius ou Angle)"
  - "Changer la couleur de la lampe"
  - "Éloigner la caméra"
correctIndices:
  - 1
explanation: "La douceur des ombres dépend de la **taille physique de la source**. Agrandir la lampe élargit la zone de pénombre et adoucit le contour de l'ombre. La puissance, elle, ne modifie que l'intensité, pas la dureté."
```

## 3. L'éclairage de studio : révéler formes et surfaces (CMF)

### L'objectif d'un éclairage de présentation
En présentation de produit comme en LookDev, l'éclairage a une double mission : révéler la **forme** de l'objet (ses volumes, ses contours, son relief) et donner à lire son **état de surface**. Ce second point se résume souvent par l'acronyme **CMF**, pour Couleur, Matière et Finition. Un bon éclairage de studio doit rendre évidente la différence entre une finition mate et une finition brillante, entre un métal et un plastique.

```resource
title: "Scène de studio prête à l'emploi"
description: "Fichier de projet contenant un fond infini (cyclorama) et un objet de démonstration, prêt à recevoir votre montage de lampes pour vous exercer à l'éclairage trois points."
fileName: "scene_studio_cyclorama.blend (11.2 Mo)"
downloadUrl: "https://example.com/files/scene-studio-cyclorama"
```

### L'éclairage trois points
Le montage de référence du studio repose sur trois lampes aux rôles complémentaires :
- La **lumière principale** (*Key light*) : la source dominante, la plus puissante, placée à environ 45° du sujet. Elle définit l'éclairage général et la direction des ombres.
- La **lumière de complément** (*Fill light*) : plus douce et moins intense, placée du côté opposé, elle débouche les ombres pour qu'elles ne soient pas trop noires, sans créer de seconde ombre marquée.
- Le **contre-jour** (*Rim ou Back light*) : placé derrière le sujet, il dessine un liseré lumineux sur ses contours et le détache du fond.

Ce trio constitue une base universelle que l'on adapte ensuite à chaque sujet et à chaque intention.

```side-by-side
layout: "textLeft"
imagePath: "assets/images/placeholder_three_point_lighting_blender.jpg"
caption: "Figure 3.1 : Vue de dessus d'un montage trois points autour d'un sujet (Key, Fill, Rim)."
title: "Le montage trois points"
---
Le schéma situe les trois lampes autour de l'objet : la principale à 45° à l'avant, le complément du côté opposé, et le contre-jour à l'arrière. Cette disposition révèle simultanément le volume du sujet et le détache de son arrière-plan. C'est le squelette de la plupart des éclairages de présentation.
```

### Les lampes Area en softbox
La lampe **Area** est l'outil maître du studio, car elle reproduit fidèlement les *softbox* de la photographie : de grandes surfaces lumineuses qui diffusent une lumière douce et enveloppante. Plus la lampe Area est large, plus la lumière épouse les formes en douceur et révèle les dégradés subtils d'une surface — ce qui est précisément ce que l'on recherche pour montrer une finition.

### Lire la finition grâce aux reflets
Le secret pour révéler une finition brillante tient dans le **reflet de la source** sur l'objet. Sur une surface lisse, la lampe Area se reflète sous forme d'une traînée lumineuse nette : c'est cette traînée qui signale à l'œil le caractère poli de la matière. À l'inverse, sur une surface mate, la même lampe ne produit qu'un dégradé doux. Positionner les lampes pour que leurs reflets balayent les surfaces clés est donc l'essence du LookDev de présentation.

> [!TIP]
> Pour mettre en valeur un objet brillant, orientez une grande lampe Area de sorte que son reflet glisse le long de la surface vers la caméra. Cette traînée lumineuse, parfois appelée *highlight*, est ce qui donne instantanément l'impression de brillance et révèle la qualité de la finition.

```quiz
question: "Dans un éclairage trois points, quel est le rôle de la lumière de complément (Fill light) ?"
options:
  - "Créer l'ombre principale du sujet"
  - "Détacher le sujet du fond par un liseré"
  - "Adoucir et déboucher les ombres créées par la lumière principale"
  - "Éclairer uniquement l'arrière-plan"
correctIndices:
  - 2
explanation: "La **Fill light**, plus douce et opposée à la principale, vient **déboucher les ombres** pour éviter qu'elles soient trop sombres, sans projeter de seconde ombre dure. La principale crée l'éclairage dominant, et le contre-jour détache le sujet du fond."
```

## 4. L'éclairage par HDRI : un éclairage global cohérent

### Qu'est-ce qu'un HDRI ?
Un **HDRI** (*High Dynamic Range Image*) est une image panoramique à 360° qui enregistre les intensités lumineuses réelles d'un lieu, sur une plage dynamique très étendue. Utilisée comme environnement de la scène, elle remplit deux fonctions d'un seul coup : elle **éclaire** tous les objets avec la lumière captée sur place, et elle fournit des **reflets** réalistes de ce même environnement. C'est la façon la plus rapide d'obtenir un éclairage naturel et cohérent.

### Le World et le nœud Environment Texture
L'environnement d'une scène est défini par le **World**. Par défaut, sa surface utilise un simple nœud *Background* d'une couleur unie. Pour passer à un HDRI, on ouvre les propriétés du World, on ajoute un nœud **Environment Texture**, on y charge le fichier `.hdr` ou `.exr`, puis on relie sa sortie à l'entrée *Color* du nœud Background. La scène entière est alors baignée par cette lumière panoramique.

```side-by-side
layout: "textRight"
imagePath: "assets/images/placeholder_environment_texture_world_blender.jpg"
caption: "Figure 4.1 : Le nœud Environment Texture relié au nœud Background dans le World."
title: "Brancher un HDRI dans le World"
---
La capture montre le réseau de nœuds du World : l'Environment Texture, qui charge le fichier HDRI, alimente l'entrée Color du nœud Background, lui-même relié à la sortie du World. C'est ce branchement minimal qui suffit à éclairer toute la scène et à fournir des reflets cohérents.
```

### Contrôler la rotation et l'intensité
Deux ajustements rendent l'HDRI réellement exploitable. Pour **faire pivoter** l'environnement — et ainsi choisir d'où vient la lumière principale — on ajoute en amont un nœud Texture Coordinate (sortie *Generated*) et un nœud Mapping, dont on relie la sortie à l'entrée *Vector* de l'Environment Texture ; il suffit ensuite d'ajuster la rotation sur l'axe Z. Pour **régler l'intensité** globale, on modifie la valeur *Strength* du nœud Background.

### Pourquoi l'HDRI produit un résultat cohérent
La cohérence visuelle d'un objet éclairé par HDRI vient d'un principe simple : la lumière qui l'éclaire et les reflets qu'il renvoie proviennent de la **même source**. Un objet métallique reflète donc exactement l'environnement qui l'illumine, ce qui le fait paraître naturellement intégré. C'est ce qui fait de l'HDRI un excellent point de départ pour tout LookDev, avant même d'ajouter la moindre lampe.

> [!NOTE]
> HDRI et lampes ne s'opposent pas, ils se complètent. Une pratique courante consiste à poser d'abord un HDRI pour l'ambiance et les reflets généraux, puis à ajouter une lampe Area en lumière principale afin de garder un contrôle précis sur la direction et l'intensité de l'éclairage clé.

```quiz
question: "Pourquoi un objet éclairé par un HDRI s'intègre-t-il de façon particulièrement cohérente ?"
options:
  - "Parce que l'HDRI désactive les ombres"
  - "Parce que la lumière et les reflets proviennent de la même source environnementale"
  - "Parce qu'il force l'usage de Cycles"
  - "Parce qu'il augmente automatiquement la résolution"
correctIndices:
  - 1
explanation: "Avec un HDRI, l'éclairage et les reflets d'un objet sont issus du **même environnement panoramique**. L'objet renvoie donc exactement la scène qui l'illumine, ce qui produit une intégration naturelle et cohérente."
```

## 5. Paramétrer les moteurs : temps réel contre fidélité physique

### Le compromis fondamental : qualité contre temps
Tout réglage de rendu revient à arbitrer entre la **qualité de l'image** et le **temps de calcul**. Augmenter le nombre d'échantillons ou de rebonds de lumière produit une image plus propre et plus fidèle, mais allonge le rendu. Savoir doser ces paramètres selon le besoin — une simple prévisualisation ou un visuel final — est une compétence à part entière.

### Régler EEVEE
Les réglages d'EEVEE se trouvent dans les propriétés de rendu. Le **Sampling** (*Render Samples*, ou *taa* pour l'anti-crénelage temporel) lisse l'image et réduit le scintillement : on l'augmente pour un rendu final. Le panneau **Raytracing**, activable, améliore reflets et ombres en lançant de vrais rayons, avec une méthode *Screen-Trace* qui s'appuie sur ce qui est visible à l'écran. Les réglages d'**ombres** affinent leur précision. EEVEE restant rapide, on peut monter ses échantillons sans exploser le temps de rendu.

### Régler Cycles
Cycles demande quelques réglages spécifiques pour tirer le meilleur compromis :
- **Samples** : le nombre de rayons calculés par pixel. Plus il est élevé, moins l'image est bruitée, mais plus le rendu est long.
- **Denoising** (débruitage) : un filtre, comme OpenImageDenoise, qui nettoie le bruit résiduel. Il permet d'obtenir une image propre avec beaucoup moins d'échantillons.
- **Light Paths > Max Bounces** : le nombre de rebonds de lumière, réglable globalement et par type (diffus, brillant, transmission). C'est lui qui autorise la lumière à traverser plusieurs surfaces.

```side-by-side
layout: "textLeft"
imagePath: "assets/images/placeholder_cycles_sampling_denoise_blender.jpg"
caption: "Figure 5.1 : Le panneau Sampling de Cycles avec le débruitage (Denoising) activé."
title: "Échantillonnage et débruitage Cycles"
---
La capture met en évidence le réglage des Samples et l'option Denoising. La logique gagnante consiste à viser un nombre d'échantillons modéré, puis à laisser le débruiteur nettoyer le bruit restant : on obtient ainsi une image propre en une fraction du temps qu'exigerait un rendu sans débruitage.
```

### Quand utiliser quel moteur ?
EEVEE est imbattable pour itérer, prévisualiser une animation, produire des rendus stylisés ou tenir des délais serrés. Cycles s'impose pour les visuels finaux exigeants, les rendus de produit, et tout ce qui repose sur une physique de la lumière exacte — verre, liquides, caustiques, éclairage indirect subtil.

> [!WARNING]
> Si un objet en verre apparaît noir sous Cycles, la cause est presque toujours un nombre de rebonds de **transmission** insuffisant. Augmentez la valeur correspondante dans *Light Paths* pour laisser la lumière traverser les parois successives. C'est le même piège que celui rencontré lors de la création des matériaux transparents.

```quiz
question: "Quel réglage de Cycles permet d'obtenir une image propre tout en limitant fortement le nombre d'échantillons nécessaires ?"
options:
  - "Augmenter le nombre de rebonds de transmission"
  - "Activer le débruitage (Denoising)"
  - "Réduire la taille du capteur de la caméra"
  - "Passer la vue en mode Material Preview"
correctIndices:
  - 1
explanation: "Le **débruitage** (Denoising) nettoie le bruit résiduel après le calcul, ce qui autorise un nombre d'échantillons bien plus faible pour une qualité équivalente. C'est le levier le plus efficace pour accélérer un rendu Cycles."
```

## 6. La caméra physique : focale, profondeur de champ et mise au point

### L'objet caméra
Le rendu d'une scène se fait toujours à travers une **caméra**. On en ajoute une via *Add > Camera*, et l'on observe son cadrage en regardant à travers elle (pavé numérique `0`). La caméra de Blender se comporte comme un appareil photo réel : ses réglages reprennent ceux de l'optique et de la prise de vue, ce qui permet de penser le cadrage en termes photographiques.

### La focale et le capteur
La **focale** (*Focal Length*, en millimètres) détermine l'angle de vue et la perspective. Une focale courte, par exemple 18 mm, offre un grand angle aux perspectives accentuées, qui exagère les volumes et la profondeur. Une focale longue, de 85 à 135 mm, resserre le cadre et **comprime** la perspective, ce qui aplatit les déformations et flatte particulièrement les produits et les portraits. La taille du **capteur** (*Sensor*) influe également sur le champ couvert.

```side-by-side
layout: "textRight"
imagePath: "assets/images/placeholder_focal_length_perspective_blender.jpg"
caption: "Figure 6.1 : Un même objet vu à 18 mm (perspective accentuée) puis à 85 mm (perspective comprimée)."
title: "L'effet de la focale"
---
À gauche, la focale courte de 18 mm dilate l'espace et déforme les proportions par une perspective marquée. À droite, la focale longue de 85 mm aplatit la perspective et restitue des proportions plus fidèles. Le choix de la focale n'est donc pas qu'un cadrage : c'est un choix esthétique qui façonne la lecture des volumes.
```

### La profondeur de champ
La **profondeur de champ** (*Depth of Field*) reproduit le flou des plans hors mise au point, signature des optiques photographiques. On l'active dans le panneau dédié de la caméra, puis on règle trois éléments :
- Le **point de netteté**, défini soit par une distance (*Focus Distance*), soit en désignant un objet à suivre (*Focus Object*).
- L'**ouverture** (*F-Stop*), qui dose l'intensité du flou : une faible valeur comme f/1.4 produit un flou prononcé et une zone nette très mince, tandis qu'une valeur élevée comme f/16 garde presque tout net.
- Le cadrage et la distance à la caméra, qui modulent l'étendue de la zone floue.

### La mise au point artistique
Au-delà de la technique, la profondeur de champ est un puissant outil de composition. En floutant l'arrière-plan, elle isole le sujet et guide irrésistiblement le regard vers la zone nette : c'est l'effet recherché en photographie de produit et de portrait. Désigner un **Focus Object** plutôt qu'une distance fixe garantit en outre que la netteté reste verrouillée sur le sujet, même s'il se déplace.

> [!TIP]
> Pour une mise au point fiable, préférez le réglage *Focus Object* : placez un objet (par exemple un Empty) sur la zone à garder nette et désignez-le comme cible. La caméra restera parfaitement focalisée sur ce point, sans avoir à recalculer une distance à chaque ajustement de la scène.

```quiz
question: "Quel réglage de la caméra contrôle l'intensité du flou de profondeur de champ ?"
options:
  - "La focale (Focal Length)"
  - "L'ouverture (F-Stop)"
  - "La taille du capteur"
  - "Le nombre d'échantillons"
correctIndices:
  - 1
explanation: "C'est l'**ouverture** (F-Stop) qui dose le flou : une faible valeur (f/1.4) crée une zone nette très mince et un arrière-plan très flou, tandis qu'une valeur élevée (f/16) conserve une grande profondeur de champ nette."
```
