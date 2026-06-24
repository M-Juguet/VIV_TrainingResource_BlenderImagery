# Guide de Rédaction et de Structuration E-Learning pour l'IA (Format Markdown & YAML)

Ce guide définit les règles de structuration strictes, de style et de balisage pour la génération automatique de contenus pédagogiques. Il sert de spécification technique de référence pour l'IA de rédaction (System Prompt Annex) afin de produire des fichiers de cours au format **Markdown (.md)** directement parsables sans erreur.

---

## 1. Principes de Fonctionnement du Parseur de l'Application

Le parseur de l'application découpe le fichier Markdown de haut en bas en identifiant les blocs de contenu. Pour chaque bloc identifié, il instancie un module Flutter spécifique.

Il est crucial de respecter exactement les délimiteurs décrits dans ce document (titres, blocs de code, listes) car toute déviation provoquera une erreur d'interprétation.

---

## 2. Spécification Technique des Modules de Contenu

### 1. Titre de Section (`TitleModule`)
Crée une séparation majeure dans le cours.
*   **Syntaxe** : Titre de niveau 2 (`## `) en début de ligne.
*   **Schéma** :
    ```markdown
    ## <Numéro>. <Titre de la section>
    ```
*   **Exemple** :
    ```markdown
    ## 1. Configuration de l'environnement de travail
    ```

### 2. Paragraphe de Texte (`TextModule`)
Module de lecture de base. Peut optionnellement inclure un sous-titre de niveau 3 (`### `).
*   **Syntaxe** : Texte libre Markdown. Peut contenir du gras (`**`), de l'italique (`*`), du code en ligne (`` ` ``).
*   **Schéma** :
    ```markdown
    ### [Sous-titre optionnel]
    <Texte du paragraphe sur une ou plusieurs lignes>
    ```
*   **Exemple** :
    ```markdown
    ### L'Inspecteur de propriétés
    L'espace de travail dispose d'un panneau nommé **Inspecteur** situé sur la droite. Cet outil permet de modifier les valeurs numériques et les états des objets sélectionnés.
    ```

### 3. Module Côte-à-Côte (`SideBySideModule`)
Associe un bloc textuel et une image de manière juxtaposée.
*   **Syntaxe** : Bloc de code délimité par ````side-by-side` contenant des paramètres YAML, suivi du séparateur `---`, puis du texte du paragraphe.
*   **Schéma des paramètres YAML** :
    - `layout` (String, requis) : `"textLeft"` (texte à gauche, image à droite) ou `"textRight"` (texte à droite, image à gauche).
    - `imagePath` (String, requis) : Chemin de l'image (voir section 3 pour les placeholders).
    - `caption` (String, requis) : Légende affichée sous l'image.
    - `title` (String, optionnel) : Titre du module.
*   **Exemple** :
````markdown
```side-by-side
layout: "textLeft"
imagePath: "assets/images/placeholder_inspector_panel.jpg"
caption: "Figure 1.1 : Panneau latéral d'ajustement des paramètres."
title: "Propriétés d'éléments"
---
Sélectionnez n'importe quel élément pour afficher ses options dans le panneau latéral. C'est ici que vous ajusterez les coordonnées de position, l'échelle et les styles graphiques appliqués.
```
````

### 4. Média Pleine Largeur (`FullMediaModule`)
Affiche une image ou une capture d'écran sur toute la largeur disponible.
*   **Syntaxe** : Syntaxe d'image Markdown standard en début de ligne.
*   **Schéma** :
    ```markdown
    ![<Légende de l'image>](<Chemin de l'image>)
    ```
*   **Exemple** :
    ```markdown
    ![Figure 1.2 : Architecture globale des dossiers du projet.](assets/images/placeholder_folder_structure.jpg)
    ```

### 5. Note et Alerte (`InfoModule`)
Affiche un encart thématique coloré pour attirer l'attention de l'apprenant.
*   **Syntaxe** : Blockquote standard Markdown avec un tag de type d'alerte spécifique (style GitHub).
*   **Types supportés (sensibles à la casse)** :
    - `> [!TIP]` : Astuce / Raccourci / Conseil productivité.
    - `> [!WARNING]` : Attention / Piège fréquent à éviter.
    - `> [!NOTE]` : Complément d'information / Contexte historique.
    - `> [!IMPORTANT]` : Règle fondamentale / Objectif clé.
    - `> [!CAUTION]` : Défi / Exercice d'application immédiate.
    - `> [!IDEA]` : Idée d'expérimentation.
*   **Exemple** :
    ```markdown
    > [!TIP]
    > Utilisez toujours le raccourci `Ctrl + Shift + S` pour sauvegarder tous les fichiers modifiés d'un coup.
    ```

### 6. Fichier Ressource (`ResourceModule`)
Affiche un composant interactif permettant de télécharger un fichier lié au cours.
*   **Syntaxe** : Bloc de code délimité par ````resource` contenant des paramètres YAML.
*   **Schéma des paramètres YAML** :
    - `title` (String, requis) : Nom ou titre de la ressource.
    - `description` (String, requis) : Description courte de l'utilité du fichier.
    - `fileName` (String, requis) : Nom du fichier avec son extension et sa taille indicative.
    - `downloadUrl` (String, requis) : Lien de téléchargement.
*   **Exemple** :
````markdown
```resource
title: "Kit d'assets de démarrage"
description: "Téléchargez les fichiers sources requis pour suivre les manipulations pratiques du chapitre."
fileName: "assets_starter_pack.zip (12.4 Mo)"
downloadUrl: "https://example.com/files/starter-pack"
```
````

### 7. Liste Spécifique (`ListModule`)
Affiche une liste ordonnée ou non avec une mise en forme soignée.
*   **Syntaxe** : Titre de niveau 3 (`### `) suivi d'une phrase d'introduction, d'une liste de puces (`- `) ou de numéros (`1. `), et d'une conclusion optionnelle.
*   **Exemple** :
    ```markdown
    ### Flux de travail de sauvegarde
    Pour assurer la sécurité de vos données, suivez cette séquence systématique :
    - Enregistrez le document actif via `Ctrl + S`.
    - Générez une copie de sauvegarde locale externe.
    - Poussez les modifications sur le serveur de stockage distant.
    Ce protocole évite toute perte de données en cas de panne matérielle.
    ```

### 8. Quiz d'Évaluation (`QuizModule`)
Permet de tester immédiatement la compréhension de l'apprenant.
*   **Syntaxe** : Bloc de code délimité par ````quiz` contenant des paramètres YAML.
*   **Schéma des paramètres YAML** :
    - `question` (String, requis) : La question posée.
    - `options` (List of Strings, requis) : Liste des choix de réponses possibles.
    - `correctIndices` (List of Integers, requis) : Indices des bonnes réponses (commençant par `0`).
    - `explanation` (String, requis) : Explication pédagogique affichée après la validation de la réponse.
*   **Exemple** :
````markdown
```quiz
question: "Quel module de l'interface permet de modifier l'échelle d'un objet sélectionné ?"
options:
  - "Le panneau de navigation"
  - "La console de log"
  - "L'Inspecteur de propriétés"
  - "La Timeline d'animation"
correctIndices:
  - 2
explanation: "C'est l'**Inspecteur de propriétés** qui regroupe les transformations d'échelle, de rotation et de position d'un objet."
```
````

---

## 3. Gestion des Assets et Placeholders

Pour toute image requise dans le cours dont l'URL réelle n'est pas encore connue :
- **Règle absolue** : Utiliser un chemin d'asset générique standardisé.
- **Format du chemin** : `assets/images/placeholder_<sujet_image>_<nom_logiciel>.jpg`
- Le `<sujet_image>` et le `<nom_logiciel>` doivent être écrits en minuscules, séparés par des underscores (`_`).
- Exemple : `assets/images/placeholder_viewport_navigation_editor.jpg`

---

## 4. Directives Strictes pour la Génération IA (Consignes Systèmes)

Pour garantir la compatibilité avec le parseur de l'application, l'IA génératrice doit respecter les règles suivantes :

1.  **Validité YAML** : Le YAML à l'intérieur des blocs de code (`side-by-side`, `resource`, `quiz`) doit être strictement valide. 
    - Utilisez des doubles guillemets (`"`) pour encapsuler les chaînes de caractères.
    - N'utilisez pas de caractères spéciaux non échappés dans les chaînes YAML.
    - Respectez scrupuleusement l'indentation YAML (2 espaces).
2.  **Aucun code HTML** : N'insérez jamais de balises HTML (ex: `<br>`, `<b>`, `<div>`) dans le texte Markdown ou dans les valeurs YAML.
3.  **Lignes Vides de Séparation** : Insérez **toujours** une ligne vide entre chaque module (par exemple entre la fin d'un bloc de code et le début d'un titre ou d'un paragraphe).
4.  **Pas d'imbrication de blocs de code** : Ne mettez jamais de blocs de code standard (```` ``` ````) à l'intérieur d'un bloc spécialisé comme `side-by-side`.
5.  **Zéro texte hors-module** : Tout le texte généré doit appartenir à l'un des 8 modules définis. Ne commencez pas le fichier par du bavardage ou des commentaires d'IA (ex: *"Voici le cours demandé..."*). Le fichier doit commencer directement par un titre ou un paragraphe.

---

## 5. Exemple Complet d'un Fichier Chapitre Markdown Conforme

Voici un modèle complet que l'IA doit reproduire en termes de structure et de formatage :

````markdown
## 1. Principes de la transformation d'objets

### Introduction au repère 3D
Dans tout espace tridimensionnel, les objets sont positionnés selon trois axes fondamentaux : l'axe X (largeur), l'axe Y (profondeur) et l'axe Z (hauteur). 

La modification de ces coordonnées s'effectue via des outils de transformation directe.

```side-by-side
layout: "textLeft"
imagePath: "assets/images/placeholder_gizmo_transformation.jpg"
caption: "Figure 1.1 : Le Gizmo de translation et ses trois axes colorés."
title: "Manipulation des coordonnées"
---
Le Gizmo est l'outil visuel qui apparaît lorsque vous sélectionnez un objet. Cliquer et glisser sur l'une des flèches limite le déplacement de l'élément à l'axe correspondant, assurant un positionnement précis.
```

> [!WARNING]
> Modifier la position globale d'un objet parent déplacera automatiquement tous ses objets enfants tout en conservant leur décalage local.

### Méthodes de modification
Pour ajuster précisément les dimensions d'un objet, vous disposez de deux méthodes complémentaires :
- Saisir manuellement les valeurs dans le panneau de propriétés.
- Utiliser les raccourcis clavier pour activer les outils de transformation visuelle.
- Effectuer des glisser-déplacer interactifs dans la zone de visualisation.

```resource
title: "Scène de démonstration"
description: "Téléchargez le fichier de projet contenant les scènes de test pour vous exercer aux manipulations d'axes."
fileName: "axes_test_scene.zip (4.2 Mo)"
downloadUrl: "https://example.com/assets/axes-test"
```

```quiz
question: "Quelle flèche du Gizmo de transformation représente généralement l'axe vertical (Z) ?"
options:
  - "La flèche rouge"
  - "La flèche verte"
  - "La flèche bleue"
  - "La flèche jaune"
correctIndices:
  - 2
explanation: "Par convention dans la majorité des outils de modélisation 3D, la flèche bleue représente l'axe vertical Z."
```
```
````
