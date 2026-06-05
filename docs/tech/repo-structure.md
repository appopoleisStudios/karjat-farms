# GroundWork — Repository Structure

**Status:** draft — outline only (Moraen to complete)  
**Phase:** 0 P0

---

## 1. Top-level layout

<!-- Document the target repo tree. Example:

```
karjat-farms/
├── index.html              # HTML5 prototype (reference only)
├── sprites3/               # Pixel art (reference)
├── groundwork-unity/       # Unity 2022.3 LTS project (Phase 1+)
├── docs/                   # All documentation
├── supabase/               # Migrations, Edge Functions (Phase 2+)
├── scripts/                # Dev/ops scripts
└── README.md
```

Source: plan §12 folder structure -->

## 2. Unity project layout (`groundwork-unity/`)

<!-- Farming Engine import location
     Resources/KarjatData/ for ScriptableObjects + JSON
     Scenes/, Prefabs/, Scripts/ conventions -->

## 3. Documentation layout (`docs/`)

<!-- Link to docs/README.md manifest; phase-gated doc creation -->

## 4. Prototype assets (`index.html`, `sprites3/`)

<!-- Keep as reference; do not delete. Not shipped in Unity build. -->

## 5. What never to commit

<!-- List:
     - .env, credentials, Supabase service keys
     - Unity Library/, Temp/, Logs/
     - Private SSH keys
     - APK/IPA builds (use CI artifacts)
     - Large binary assets without LFS -->

## 6. Branch strategy

<!-- main = stable
     docs/phase0-p0 = current Phase 0 work
     feature/* = Phase 1+ features -->

## 7. Cursor / IDE setup

<!-- Remote SSH to moraen-Home for docs
     Unity Editor on Mac Mini locally -->
