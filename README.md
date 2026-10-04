[![CI](https://github.com/alessandrocandolini/notes-hypergeometric/actions/workflows/ci.yml/badge.svg)](https://github.com/alessandrocandolini/notes-hypergeometric/actions/workflows/ci.yml)

# Notes on the hypergeometric functions

This is an attempt to port, modernise, and evolve this legacy repo of mine: https://github.com/alessandrocandolini/handout_hypergeometric

Eventually, I might port back the code changes to the old repo, but for now I'm using a different repo to experiment with GitHub Actions compilation of LaTeX documents, etc.

## Compile

Assuming a standard LaTeX distribution (eg, [TeX Live](https://tug.org/texlive/) or [MacTeX](https://www.tug.org/mactex/)) is installed,
```bash
latexmk -pdflatex hypergeometric.tex
```

Alternatively, use the pinned [Nix](https://nixos.org/) environment:
```bash
nix develop
```
This includes the full TeX Live distribution, Asymptote, and BibTool.

To compile directly using the pinned environment, run
```bash
nix develop --no-update-lock-file --command latexmk -pdf -interaction=nonstopmode -halt-on-error hypergeometric.tex
```

## Bibliography

Edit `Qhe.bib`, then regenerate `bibliography.bib` using the rules in `bibtoolrsc`:
```bash
nix develop --no-update-lock-file --command bibtool -r bibtoolrsc -i Qhe.bib -o bibliography.bib
```

After compiling, export only cited entries from `bibliography.bib`:
```bash
nix develop --no-update-lock-file --command biber --output-format=bibtex --output-resolve --output-file=bibliography.bib hypergeometric.bcf
```

## CI/CD

GitHub Actions compiles the PDF using the pinned Nix environment. The standard Nix store is cached using [nix-community/cache-nix-action](https://github.com/nix-community/cache-nix-action), with a key based on the runner OS, architecture, and hashes of `flake.nix` and `flake.lock`.

The PDF is published in the release tags on `main`.
