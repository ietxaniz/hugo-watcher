# 🕵️ hugo-watcher

This container watches Hugo theme or layout folders and triggers a safe reload of the site by briefly rewriting a content file.

## ✅ Why Use This

Hugo's livereload often misses layout or Tailwind CSS changes — especially inside Docker. This watcher safely triggers a Hugo rebuild by rewriting an existing content file, without altering its content.

## 🐳 Usage

Include it in your `docker-compose.yml`:

```yaml
watcher:
  image: inigoetxaniz/hugo-watcher
  volumes:
    - ./web:/site
  user: "${UID}:${GID}"
  environment:
    - RELOAD_DELAY_MS=200
```

Make sure Hugo and this watcher use the same UID/GID to avoid permission issues.

## 🔧 Environment Variables

| Name             | Default                              | Description                          |
|------------------|--------------------------------------|--------------------------------------|
| `WATCH_PATHS`    | `/site/layouts /site/themes`         | Folders to watch                     |
| `TOUCH_FILE`     | `/site/content/_index.md`            | File to rewrite for reload trigger   |
| `TMP_FILE`       | `/tmp/.hugo-watcher-reload.md`       | Temporary file used for overwrite    |
| `RELOAD_DELAY_MS`| `200`                                | Delay in milliseconds before reload  |

