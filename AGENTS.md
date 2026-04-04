# AGENTS.md

## Project

Markdown-based resume for Jérémy Lixandre, built with pandoc and wkhtmltopdf via Docker.

## Files

- `resume.md` — content (edit this for text changes)
- `style.css` — all visual styling (edit this for design changes)
- `justfile` — build commands

## Build

```
just build
```

Outputs `out/resume.html` and `out/resume.pdf`. Requires Docker.

## Constraints

- Must fit on one page (PDF)
- `__PHONE_ENTRY__` in `resume.md` is a placeholder replaced at build time — do not remove it
- The markdown heading levels have fixed semantic roles: h1=name, h2=section, h3=company, h5=job title, h6=contact line
