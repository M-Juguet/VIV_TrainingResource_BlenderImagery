## 1. Sélectionner et transformer les objets

### Sélectionner dans la vue 3D
Avant d'agir sur un objet, il faut le sélectionner. Un **clic gauche** sélectionne l'objet sous le curseur, qui devient alors l'**objet actif**, signalé par un contour clair. Maintenir `Maj` en cliquant **ajoute ou retire** des objets de la sélection. Pour des sélections multiples rapides, la sélection rectangulaire (touche `B` ou simple glissé) et la sélection circulaire (`C`) sont précieuses. Enfin, `A` sélectionne tout, et `Alt + A` désélectionne tout.

La distinction entre **sélection** et **objet actif** est importante : on peut avoir plusieurs objets sélectionnés, mais un seul est actif (le dernier cliqué). Certaines opérations s'appliquent à toute la sélection, d'autres uniquement à l'objet actif.

### Les trois transformations : déplacer, tourner, redimensionner
Toute la manipulation d'objets repose sur trois actions, associées à trois touches faciles à mémoriser : `G` pour déplacer (*Grab*), `R` pour tourner (*Rotate*) et `S` pour redimensionner (*Scale*). Le principe est toujours le même : on appuie sur la touche, on bouge la souris pour ajuster, puis on **clique gauche pour valider** ou l'on appuie sur `Échap` (ou clic droit) pour annuler. Ces trois raccourcis sont le geste fondateur de la pratique Blender, à acquérir en tout premier.

```side-by-side
layout: "textLeft"
imagePath: "assets/images/placeholder_grab_rotate_scale_blender.jpg"
caption: "Figure 1.1 : Les trois transformations de base appliquées à un objet : déplacer (G), tourner (R), redimensionner (S)."
title: "Déplacer, tourner, redimensionner"
---
La capture illustre les trois transformations fondamentales. Une fois la touche pressée, l'objet suit la souris, et un retour visuel indique la transformation en cours. Ce trio G/R/S, combiné aux contraintes d'axe vues juste après, couvre l'immense majorité des manipulations du quotidien.
```

### Contrainte d'axe et saisie numérique
La vraie puissance de ces transformations vient de deux compléments. Après avoir appuyé sur `G`, `R` ou `S`, presser `X`, `Y` ou `Z` **contraint** le mouvement à l'axe choisi. Et plutôt que d'ajuster à la souris, on peut **taper une valeur précise** au clavier. Cette combinaison rend chaque geste exact et reproductible :
- `G` puis `X` puis `2` puis `Entrée` : déplace l'objet de 2 mètres le long de l'axe X.
- `R` puis `Z` puis `90` puis `Entrée` : effectue une rotation de 90° autour de l'axe Z.
- `S` puis `2` puis `Entrée` : double la taille de l'objet sur tous les axes.
- `Maj + Z` après `G` : déplace dans le plan XY en **excluant** l'axe Z.

### Annuler et refaire
Toute erreur se corrige sans crainte : `Ctrl + Z` annule la dernière action, et `Ctrl + Maj + Z` la rétablit. Cette filet de sécurité permet d'expérimenter librement. À côté des raccourcis, des **gizmos** interactifs (les poignées colorées des outils Déplacer, Tourner et Redimensionner, dans la barre d'outils de gauche) offrent une alternative visuelle pour qui préfère la souris au clavier.

> [!TIP]
> Prenez tôt l'habitude de la **saisie numérique** pendant une transformation. Taper `G X 1` est plus rapide et infiniment plus précis que d'essayer de glisser l'objet pile au bon endroit. C'est ce réflexe qui sépare une manipulation approximative d'un travail rigoureux et propre.

```quiz
question: "Comment déplacer un objet d'exactement 3 mètres le long de l'axe Y ?"
options:
  - "G puis 3 puis Entrée"
  - "G puis Y puis 3 puis Entrée"
  - "S puis Y puis 3 puis Entrée"
  - "R puis Y puis 3 puis Entrée"
correctIndices:
  - 1
explanation: "On presse `G` (déplacer), puis `Y` pour **contraindre** le mouvement à l'axe Y, puis on tape `3` et `Entrée` pour la **valeur exacte**. C'est la combinaison transformation + axe + saisie numérique."
```

## 2. Curseur 3D, pivots et opérations courantes

### Le curseur 3D
Ce petit repère en forme de cible, visible au centre de la scène par défaut, est le **curseur 3D**. Il joue deux rôles. D'abord, c'est le **point d'apparition** des nouveaux objets : tout ce que vous ajoutez se crée là où il se trouve. Ensuite, il peut servir de **point de pivot** pour les transformations. On le déplace avec `Maj + clic droit`, et `Maj + C` le réinitialise au centre du monde (origine).

### Le point de pivot
Lorsqu'on tourne ou redimensionne, encore faut-il savoir **autour de quoi**. C'est le rôle du point de pivot, sélectionnable dans l'en-tête de la vue 3D. Plusieurs options existent : *Median Point* (le centre de la sélection, par défaut), *Bounding Box Center* (le centre de la boîte englobante), *3D Cursor* (le curseur 3D), *Individual Origins* (chaque objet pivote sur lui-même) et *Active Element* (autour de l'objet actif). Le même geste de rotation produit des résultats radicalement différents selon ce choix.

```side-by-side
layout: "textRight"
imagePath: "assets/images/placeholder_pivot_points_blender.jpg"
caption: "Figure 2.1 : Le menu de sélection du point de pivot dans l'en-tête de la vue 3D."
title: "Choisir le point de pivot"
---
La capture montre le menu déroulant des points de pivot. Comprendre cette option évite bien des surprises : une rotation autour du curseur 3D fait tourner les objets « en orbite », tandis qu'avec Individual Origins chacun pivote sur place. C'est un réglage à vérifier dès qu'une rotation ne donne pas l'effet attendu.
```

### Ajouter, dupliquer et supprimer
On ajoute un élément via le menu **Add** (`Maj + A`) : maillages, lampes, caméras, etc. apparaissent à l'emplacement du curseur 3D. Pour copier un objet, deux commandes coexistent et ne font pas la même chose. `Maj + D` crée une **copie indépendante** (duplication réelle). `Alt + D` crée une **copie liée**, qui partage les mêmes données que l'original. Enfin, `X` ou `Suppr` supprime la sélection.

### Le panneau « Ajuster la dernière opération »
Après la plupart des opérations, un petit panneau apparaît en bas à gauche de la vue (on le rouvre avec `F9`). Il permet de **modifier après coup** les paramètres de l'action que vous venez d'effectuer. Vous venez d'ajouter une sphère ? Ce panneau vous laisse changer son rayon ou son nombre de segments sans la recréer. C'est un outil de confort majeur, à connaître dès le départ.

```side-by-side
layout: "textLeft"
imagePath: "assets/images/placeholder_adjust_last_operation_f9_blender.jpg"
caption: "Figure 2.2 : Le panneau Ajuster la dernière opération (F9) après l'ajout d'un objet."
title: "Le panneau F9"
---
La capture montre le panneau ouvert après l'ajout d'une primitive, exposant ses paramètres modifiables (rayon, segments, emplacement). Tant qu'aucune autre action n'est effectuée, ces réglages restent ajustables : un excellent moyen d'affiner sans refaire.
```

> [!NOTE]
> Retenez bien la différence entre `Maj + D` et `Alt + D`. La première produit une copie **totalement indépendante** : modifier l'une n'affecte pas l'autre. La seconde crée une copie **liée**, qui partage ses données avec l'original : modifier la géométrie de l'une transforme aussi toutes les autres. Ce comportement est au cœur de la notion de données partagées, abordée à la section suivante.

```quiz
question: "Quelle commande crée une copie qui partage ses données avec l'objet d'origine ?"
options:
  - "Maj + D (duplication)"
  - "Alt + D (duplication liée)"
  - "Maj + A (ajouter)"
  - "Maj + C (réinitialiser le curseur)"
correctIndices:
  - 1
explanation: "`Alt + D` crée une **copie liée** qui partage les mêmes données que l'original : modifier la géométrie de l'une affecte toutes les copies liées. `Maj + D`, au contraire, produit une copie totalement indépendante."
```

## 3. Mode Objet, Mode Édition et données partagées

### Deux modes pour deux niveaux d'action
Blender distingue deux modes de travail principaux, que l'on bascule avec la touche `Tab`. Le **Mode Objet** manipule les objets dans leur ensemble : on les déplace, on les tourne, on les organise les uns par rapport aux autres. Le **Mode Édition** ouvre l'objet pour en modifier la **géométrie interne** : ses sommets, ses arêtes et ses faces. Le sélecteur de mode, dans l'en-tête de la vue, indique en permanence où vous vous trouvez.

### Un aperçu du Mode Édition
En Mode Édition, on choisit ce que l'on manipule grâce aux touches `1`, `2` et `3` (sommets, arêtes, faces), puis on déplace ces éléments avec les mêmes `G`, `R`, `S` que les objets. Nous n'entrons pas ici dans la modélisation proprement dite : l'objectif est seulement de comprendre que c'est dans ce mode que se sculpte la forme, par opposition au Mode Objet où l'on agit sur l'objet entier.

```side-by-side
layout: "textRight"
imagePath: "assets/images/placeholder_object_vs_edit_mode_blender.jpg"
caption: "Figure 3.1 : Un même cube en Mode Objet (à gauche) et en Mode Édition (à droite), sommets visibles."
title: "Mode Objet et Mode Édition"
---
À gauche, en Mode Objet, le cube se manipule comme un bloc unique. À droite, en Mode Édition, sa géométrie est exposée : sommets, arêtes et faces deviennent sélectionnables et modifiables. La touche Tab fait passer de l'un à l'autre instantanément.
```

### Objet et données : le concept à ne pas manquer
Voici l'idée la plus structurante de tout ce chapitre. Un **objet** n'est qu'un conteneur qui porte une position, une rotation et une échelle ; il **pointe vers des données** (un *data-block*) qui décrivent réellement son contenu — pour un maillage, ce sont ses sommets et faces. L'objet et son maillage sont donc deux choses distinctes. C'est exactement ce que reflète l'Outliner, où chaque objet peut être déplié pour révéler les données qu'il contient.

### Les données partagées
Conséquence directe : **plusieurs objets peuvent pointer vers les mêmes données**. C'est précisément ce que produit la duplication liée (`Alt + D`). Modifier la géométrie partagée se répercute alors sur tous les objets concernés. Un compteur, affiché à côté du nom des données, indique combien d'objets les utilisent ; cliquer dessus crée une copie indépendante (*single-user*) pour rompre le partage. Maîtriser cette mécanique évite l'une des plus grandes confusions du débutant.

> [!IMPORTANT]
> Ne confondez jamais un **objet** et ses **données**. Renommer un objet ne renomme pas son maillage, et supprimer un objet ne supprime pas forcément ses données si un autre objet les utilise encore. Garder à l'esprit cette séparation — l'objet est le contenant, les données sont le contenu — clarifie une grande partie du fonctionnement de Blender.

```quiz
question: "Que se passe-t-il si vous modifiez la géométrie d'un maillage partagé par plusieurs objets (créés via Alt + D) ?"
options:
  - "Seul l'objet actif est modifié"
  - "Tous les objets partageant ces données sont modifiés"
  - "Rien, les données partagées sont verrouillées"
  - "Un nouveau fichier est créé"
correctIndices:
  - 1
explanation: "Des objets qui **partagent les mêmes données** sont tous affectés par une modification de la géométrie. Pour n'en modifier qu'un seul, il faut d'abord en faire une copie indépendante (single-user) via le compteur d'utilisateurs."
```

## 4. Organiser et sauvegarder son travail

### Les collections
À mesure qu'une scène grossit, les **collections** permettent de la ranger, à la manière de dossiers ou de calques. On crée une collection, on y déplace des objets (touche `M`, ou par glissé dans l'Outliner), et l'on contrôle sa visibilité dans la vue comme dans le rendu. Une scène bien organisée en collections — par exemple « Décor », « Éclairage », « Sujet » — reste lisible et agréable à manipuler, même avec des dizaines d'objets.

### L'hygiène de nommage
Le réflexe le plus simple et le plus rentable est de **nommer clairement** ses objets dans l'Outliner (double-clic pour renommer). Une scène où tout s'appelle « Cube.001 », « Cube.002 » devient vite illisible. Des noms parlants font gagner un temps précieux, à soi-même comme à toute personne qui reprendra le fichier.

### Sauvegarder un fichier .blend
Le travail se sauvegarde dans un fichier `.blend`, qui contient toute la scène. Quelques pratiques essentielles :
- `Ctrl + S` enregistre le fichier courant ; `Maj + Ctrl + S` ouvre *Save As* pour enregistrer sous un nouveau nom.
- Dans la fenêtre *Save As*, un bouton `+` **incrémente** automatiquement le numéro du fichier (projet_001, projet_002…), pour garder un historique de versions.
- En cas de plantage, Blender conserve des sauvegardes temporaires : on récupère son travail via *File > Recover > Auto Save*.
Prendre l'habitude de sauvegarder souvent et par versions met votre travail définitivement à l'abri.

### Chemins de fichiers et packing des textures
Point capital, en lien direct avec le travail des matériaux : par défaut, les textures **ne sont pas stockées dans le `.blend`**. Le fichier ne conserve que le **chemin** vers chaque image sur le disque. Déplacer le `.blend` ou l'envoyer sans les textures rompt ces liens, et les images apparaissent en rose (« texture manquante »). Deux outils du menu *File > External Data* résolvent ce problème : **Make Paths Relative** transforme les chemins en chemins relatifs (les liens survivent tant que tout reste dans le même dossier), et **Pack Resources** **embarque les textures à l'intérieur du `.blend`** lui-même — l'étape indispensable avant de partager ou d'archiver un projet.

```side-by-side
layout: "textLeft"
imagePath: "assets/images/placeholder_external_data_pack_blender.jpg"
caption: "Figure 4.1 : Le menu File > External Data avec les options Pack Resources et Make Paths Relative."
title: "Sécuriser ses textures"
---
La capture montre le menu External Data déroulé. L'option Pack Resources intègre toutes les textures dans le fichier .blend, garantissant qu'aucune image ne sera perdue lors d'un transfert. C'est le réflexe à adopter systématiquement avant d'envoyer un projet contenant des matériaux texturés.
```

```resource
title: "Modèle de projet organisé"
description: "Fichier .blend structuré en collections nommées, avec ses textures déjà empaquetées, à utiliser comme point de départ propre pour vos propres projets."
fileName: "modele_projet_organise.blend (5.1 Mo)"
downloadUrl: "https://example.com/files/modele-projet-organise"
```

### Append, Link et fichier de démarrage
Pour réutiliser des éléments d'un autre fichier, deux commandes existent. **Append** (*File > Append*) importe une **copie** d'une donnée — un objet, un matériau — dans votre fichier ; elle devient indépendante. **Link** crée au contraire un **lien** vers la donnée d'origine, qui se met à jour si le fichier source change. Enfin, vous pouvez figer votre propre scène de départ idéale via *File > Defaults > Save Startup File*, pour que chaque nouveau projet démarre selon vos habitudes.

> [!CAUTION]
> **Défi d'application :** préparez un projet propre de bout en bout. Rangez vos objets dans des collections nommées, donnez des noms clairs à chaque élément, sauvegardez votre travail en plusieurs versions incrémentales, puis empaquetez les textures via *Pack Resources* comme si vous deviez l'envoyer à un collègue. Vérifiez enfin qu'aucune texture n'apparaît en rose : c'est la garantie d'un projet réellement transférable.

```quiz
question: "Quelle opération garantit qu'aucune texture ne sera perdue en envoyant votre fichier .blend à quelqu'un d'autre ?"
options:
  - "Renommer les objets dans l'Outliner"
  - "Empaqueter les textures via File > External Data > Pack Resources"
  - "Sauvegarder avec Ctrl + S"
  - "Passer en Mode Édition"
correctIndices:
  - 1
explanation: "Par défaut, le `.blend` ne stocke que les chemins vers les textures. **Pack Resources** intègre les images directement dans le fichier, ce qui garantit qu'elles voyageront avec lui et n'apparaîtront pas en rose chez le destinataire."
```
