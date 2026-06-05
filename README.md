# Karjat Farms (GroundWork)

Stardew Valley–style farm game for [farms.appopoleis.com](https://farms.appopoleis.com).

## Stack

- Single-page HTML5 Canvas game (vanilla JS, no build step)
- Pixel sprites in `sprites3/` (current) and `sprites/` (legacy)

## Local dev

```bash
python3 -m http.server 8088
# open http://localhost:8088
```

## Production (Linux PC)

- Source served from `/home/arsalan/karjat-farms/`
- Cloudflare tunnel: `farms.appopoleis.com` → `localhost:8088`
- Static server: `python3 -m http.server 8088 --directory /home/arsalan/karjat-farms`

## Status

Imported from live server (Jun 2026). Known issues: player sprites not embedded, world layout coords exceed 30×20 grid.
