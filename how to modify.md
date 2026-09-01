OK, voici les lignes directrices pour modifier le site param8 :

---

## Stack

- **Astro + Starlight** — framework de documentation statique
- Hébergé sur **GitHub Pages** (`kblivesolutions.github.io/param8`)
- Le contenu est en **Markdown/MDX**

## Structure

```
param8/
├── astro.config.mjs          ← config : sidebar, titre, logo
├── src/
│   ├── content/docs/docs/    ← LES PAGES (c'est ici que tu modifies)
│   │   ├── overview.md
│   │   ├── quick-start.md
│   │   ├── presets.md
│   │   ├── mixer-mode.md
│   │   ├── device-mode.md
│   │   ├── latch-revert.md
│   │   ├── editor.md
│   │   ├── layouts.md
│   │   ├── midi-map.md
│   │   └── sysex.md
│   ├── content/docs/index.mdx  ← page d'accueil
│   ├── assets/logo.svg
│   └── styles/custom.css        ← style perso
└── public/                      ← images, fichiers statiques
```

## Modifier une page

1. Ouvre un fichier `.md` dans `src/content/docs/docs/`
2. Le format est du **Markdown standard** avec un frontmatter YAML en haut :
   ```md
   ---
   title: Mixer Mode
   description: Comment utiliser le mode Mixer
   ---

   ## Section
   Texte ici...
   ```
3. Sauvegarde, c'est tout

## Ajouter une page

1. Crée un nouveau `.md` dans `src/content/docs/docs/`
2. Ajoute-le dans la **sidebar** dans `astro.config.mjs` :
   ```js
   { label: 'Ma Page', slug: 'docs/ma-page' },
   ```

## Ajouter des images

1. Mets l'image dans `public/` (ex: `public/images/photo.png`)
2. Référence-la en Markdown : `![alt](/param8/images/photo.png)` (le `/param8/` est le `base` path)

## Prévisualiser localement

```bash
cd param8
npm run dev
```
Puis ouvre `http://localhost:4321/param8/` dans le navigateur.

## Déployer

```bash
npm run build # génère dans dist/
```
Puis push sur GitHub — si un workflow GitHub Actions est configuré, ça se déploie automatiquement. Sinon, push le dossier `dist/` sur la branche `gh-pages`.

---

En gros : tu édites des fichiers Markdown, c'est tout. Starlight gère le rendu, la navigation, le responsive.