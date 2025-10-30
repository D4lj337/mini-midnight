;;; mini-midnight-theme.el --- Minimal modern dark theme with package face support -*- lexical-binding: t; -*-

;; Copyright (C) 2025, D4lj337
;; Author: D4lj337
;; Version: 1.0
;; Package-Requires: ((emacs "26.1"))
;; URL: https://github.com/d4lj337/Mini-midnight
;; Keywords: faces, theme, dark

;;; Commentary:
;; Mini-midnight is a compact, modern dark theme derived from a minimal
;; palette. It aims to be readable, low-contrast, and compatible
;; with stock Emacs and common packages.
;;
;; Highlights:
;; - Consolidated palette and helper utilities for consistent faces.
;; - Adds faces for common packages: vundo, vertico, marginalia, corfu,
;;   corfu-popupinfo, consult, doom-modeline, flycheck, flymake, eshell,
;;   term/vterm, org code blocks, magit, company-like UIs, and more.
;; - Provides guarded refresh hooks to update external icon/caches on theme
;;   activation (kind-icon, corfu, vterm, all-the-icons).
;;
;; Installation:
;; Place this file on your `custom-theme-load-path` (for example:
;; ~/.emacs.d/themes/), then enable with:
;;   (load-theme 'mini-midnight t)
;;
;;; Code:

(defgroup mini-midnight nil
  "Mini-Midnight - Minimal modern dark theme."
  :group 'faces)

(require 'cl-lib)

(deftheme mini-midnight
  "Mini-midnight: a compact, readable dark theme.")

;; Palette
(let* ((mm-class '((class color) (min-colors 89)))
       (mm-palette
        (list :bg "#0b0b0b"
              :bg-alt "#161616"
              :surface "#1d1f21"
              :muted "#909090"
              :fg "#c6c6c6"
              :fg-dim "#9ea0a0"
              :accent-blue "#6ea0ff"
              :accent-cyan "#5fd7d7"
              :accent-green "#8bd48b"
              :accent-yellow "#e5c07b"
              :accent-orange "#ff9e64"
              :accent-red "#ff6b6b"
              :accent-magenta "#d16bb0"
              :builtin "#e6e6e6")))

  (cl-destructuring-bind (&key bg bg-alt surface fg fg-dim muted
                               accent-blue accent-cyan accent-green
                               accent-yellow accent-orange accent-red
                               accent-magenta builtin)
      mm-palette

    (custom-theme-set-faces
     'mini-midnight

     ;; Core faces
     `(default ((,mm-class :foreground ,fg :background ,bg)))
     `(cursor ((,mm-class :background ,accent-cyan)))
     `(fringe ((,mm-class :background ,bg-alt :foreground ,fg-dim)))
     `(region ((,mm-class :background ,accent-blue :foreground ,bg)))
     `(highlight ((,mm-class :background ,surface :foreground ,fg)))
     `(shadow ((,mm-class :foreground ,fg-dim)))
     `(link ((,mm-class :foreground ,accent-yellow :underline t)))
     `(minibuffer-prompt ((,mm-class :foreground ,accent-blue :weight bold)))
     `(vertical-border ((,mm-class :foreground ,muted)))
     `(mode-line ((,mm-class :foreground ,fg :background ,bg-alt :box (:line-width 1 :color ,surface))))
     `(mode-line-inactive ((,mm-class :foreground ,fg-dim :background ,bg :box (:line-width 1 :color ,bg-alt))))
     `(linum ((,mm-class :foreground ,fg-dim :background ,bg)))
     `(line-number ((,mm-class :foreground ,fg-dim :background ,bg)))
     `(line-number-current-line ((,mm-class :foreground ,fg :background ,bg-alt :weight bold)))

     ;; Font lock
     `(font-lock-builtin-face ((,mm-class :foreground ,builtin)))
     `(font-lock-comment-face ((,mm-class :foreground ,muted :slant italic)))
     `(font-lock-constant-face ((,mm-class :foreground ,accent-magenta)))
     `(font-lock-function-name-face ((,mm-class :foreground ,accent-cyan)))
     `(font-lock-keyword-face ((,mm-class :foreground ,accent-blue :weight bold)))
     `(font-lock-string-face ((,mm-class :foreground ,accent-green)))
     `(font-lock-type-face ((,mm-class :foreground ,accent-yellow)))
     `(font-lock-variable-name-face ((,mm-class :foreground ,fg)))
     `(font-lock-warning-face ((,mm-class :foreground ,accent-red :weight bold)))

     ;; Search & navigation
     `(isearch ((,mm-class :background ,accent-orange :foreground ,bg :weight bold)))
     `(lazy-highlight ((,mm-class :background ,surface :foreground ,fg)))
     `(match ((,mm-class :background ,accent-yellow :foreground ,bg)))
     `(next-error ((,mm-class :background ,surface :foreground ,fg)))

     ;; Org (including code blocks)
     `(org-block ((,mm-class :background ,surface :foreground ,fg-dim :extend t)))
     `(org-block-begin-line ((,mm-class :foreground ,fg-dim :background ,bg-alt :slant italic)))
     `(org-block-end-line ((,mm-class :foreground ,fg-dim :background ,bg-alt :slant italic)))
     `(org-code ((,mm-class :foreground ,accent-cyan)))
     `(org-ellipsis ((,mm-class :foreground ,fg-dim)))
     `(org-link ((,mm-class :foreground ,accent-yellow :underline t)))
     `(org-level-1 ((,mm-class :foreground ,accent-blue :weight bold :height 1.1)))
     `(org-level-2 ((,mm-class :foreground ,accent-cyan :weight bold)))
     `(org-level-3 ((,mm-class :foreground ,accent-green)))
     `(org-todo ((,mm-class :foreground ,accent-red :weight bold)))
     `(org-done ((,mm-class :foreground ,accent-green :weight bold)))

     ;; Completion UI (vertico, marginalia, consult)
     `(vertico-current ((,mm-class :background ,bg-alt :foreground ,fg)))
     `(vertico-group-title ((,mm-class :foreground ,fg-dim)))
     `(marginalia-key ((,mm-class :foreground ,fg-dim)))
     `(marginalia-file ((,mm-class :foreground ,accent-cyan)))
     `(consult-preview-line ((,mm-class :background ,surface :foreground ,fg-dim)))

     ;; Corfu / completion popups
     `(corfu-default ((,mm-class :background ,bg-alt :foreground ,fg)))
     `(corfu-current ((,mm-class :background ,accent-blue :foreground ,bg)))
     `(corfu-border ((,mm-class :background ,surface)))
     `(corfu-tooltip ((,mm-class :background ,bg-alt :foreground ,fg-dim)))
     `(corfu-echo ((,mm-class :foreground ,fg-dim)))

     ;; Kind icon / popupinfo (used by corfu-kind, kind-icon)
     `(corfu-popupinfo-border ((,mm-class :background ,surface)))
     `(corfu-popupinfo ((,mm-class :background ,bg-alt :foreground ,fg-dim)))

     ;; Company compatibility
     `(company-tooltip ((,mm-class :background ,bg-alt :foreground ,fg)))
     `(company-tooltip-selection ((,mm-class :background ,accent-blue :foreground ,bg)))
     `(company-tooltip-annotation ((,mm-class :foreground ,fg-dim)))

     ;; Minibuffer/icomplete/ivy/embark style
     `(icompletep-determined ((,mm-class :foreground ,accent-blue)))
     `(icompletep-vertical ((,mm-class :background ,bg-alt)))

     ;; Flycheck / Flymake diagnostics
     `(flycheck-error ((,mm-class :underline (:style wave :color ,accent-red))))
     `(flycheck-warning ((,mm-class :underline (:style wave :color ,accent-orange))))
     `(flycheck-info ((,mm-class :underline (:style wave :color ,accent-cyan))))
     `(flycheck-fringe-error ((,mm-class :foreground ,accent-red)))
     `(flycheck-fringe-warning ((,mm-class :foreground ,accent-orange)))
     `(flycheck-fringe-info ((,mm-class :foreground ,accent-cyan)))

     `(flymake-error ((,mm-class :underline (:style wave :color ,accent-red))))
     `(flymake-warning ((,mm-class :underline (:style wave :color ,accent-yellow))))
     `(flymake-note ((,mm-class :underline (:style wave :color ,accent-cyan))))

     ;; Doom-modeline
     `(doom-modeline-bar ((,mm-class :background ,accent-blue)))
     `(doom-modeline-buffer-path ((,mm-class :foreground ,accent-cyan)))
     `(doom-modeline-buffer-file ((,mm-class :foreground ,fg)))
     `(doom-modeline-info ((,mm-class :foreground ,accent-green)))

     ;; Magit
     `(magit-section-heading ((,mm-class :foreground ,accent-blue :weight bold)))
     `(magit-diff-added ((,mm-class :foreground ,accent-green)))
     `(magit-diff-removed ((,mm-class :foreground ,accent-red)))
     `(magit-hunk-heading ((,mm-class :background ,bg-alt)))

     ;; Vundo
     `(vundo-default ((,mm-class :inherit shadow)))
     `(vundo-highlight ((,mm-class :inherit bold :foreground ,accent-red)))
     `(vundo-last-saved ((,mm-class :foreground ,accent-blue :weight bold)))
     `(vundo-saved ((,mm-class :foreground ,accent-cyan)))

     ;; Term / vterm colors
     `(term-color-black   ((,mm-class :foreground ,fg-dim :background ,bg)))
     `(term-color-red     ((,mm-class :foreground ,accent-red :background ,accent-red)))
     `(term-color-green   ((,mm-class :foreground ,accent-green :background ,accent-green)))
     `(term-color-yellow  ((,mm-class :foreground ,accent-yellow :background ,accent-yellow)))
     `(term-color-blue    ((,mm-class :foreground ,accent-blue :background ,accent-blue)))
     `(term-color-magenta ((,mm-class :foreground ,accent-magenta :background ,accent-magenta)))
     `(term-color-cyan    ((,mm-class :foreground ,accent-cyan :background ,accent-cyan)))
     `(term-color-white   ((,mm-class :foreground ,fg :background ,fg)))

     ;; Eshell
     `(eshell-prompt ((,mm-class :foreground ,accent-blue :weight bold)))
     `(eshell-ls-directory ((,mm-class :foreground ,accent-cyan)))
     `(eshell-ls-executable ((,mm-class :foreground ,accent-green)))
     `(eshell-ls-symlink ((,mm-class :foreground ,accent-magenta)))

     ;; Misc useful faces
     `(success ((,mm-class :foreground ,accent-green)))
     `(error ((,mm-class :foreground ,accent-red)))
     `(warning ((,mm-class :foreground ,accent-orange)))

     ;; Yasnippet highlight
     `(yas-field-highlight-face ((,mm-class :background ,surface)))

     ;; Rainbow delimiters (fallbacks)
     `(rainbow-delimiters-depth-1-face ((,mm-class :foreground ,fg)))
     `(rainbow-delimiters-depth-2-face ((,mm-class :foreground ,accent-blue)))
     `(rainbow-delimiters-depth-3-face ((,mm-class :foreground ,accent-cyan)))
     `(rainbow-delimiters-depth-4-face ((,mm-class :foreground ,accent-green)))
     `(rainbow-delimiters-depth-5-face ((,mm-class :foreground ,accent-yellow)))
     `(rainbow-delimiters-depth-6-face ((,mm-class :foreground ,accent-magenta)))
     `(rainbow-delimiters-unmatched-face ((,mm-class :foreground ,accent-red :weight bold)))
     )

    ;; ANSI / terminal color vector for shells and term emulators
    (custom-theme-set-variables
     'mini-midnight
     `(ansi-color-names-vector
       [,bg ,accent-red ,accent-green ,accent-yellow ,accent-blue ,accent-magenta ,accent-cyan ,fg]))))

;;; Theme refresh helpers
(defun mini-midnight--refresh-external-caches ()
  "Call package-specific refreshers if available."
  (when (fboundp 'kind-icon-reset-cache)
    (ignore-errors (kind-icon-reset-cache)))
  (when (fboundp 'all-the-icons-revert-cache)
    (ignore-errors (all-the-icons-revert-cache)))
  (when (fboundp 'corfu-reset)
    (ignore-errors (corfu-reset)))
  (when (fboundp 'vterm-invalidate-table)
    (ignore-errors (vterm-invalidate-table)))
  ;; Force mode-line redraw and redisplay
  (force-mode-line-update t)
  (redisplay))

;; Run refresher after loading or enabling the theme
(advice-add 'enable-theme :after
            (lambda (&rest _)
              (when (and (boundp 'custom-enabled-themes)
                         custom-enabled-themes
                         (eq (car custom-enabled-themes) 'mini-midnight))
                (mini-midnight--refresh-external-caches))))

(advice-add 'load-theme :after
            (lambda (&rest _)
              (when (and (boundp 'custom-enabled-themes)
                         (member 'mini-midnight custom-enabled-themes))
                (mini-midnight--refresh-external-caches))))

;;;###autoload
(when load-file-name
  ;; Add the directory to `custom-theme-load-path' so `load-theme' can find it.
  (add-to-list 'custom-theme-load-path (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'mini-midnight)
;;; mini-midnight-theme.el ends here
