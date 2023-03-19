;;; build-site.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2023 Lukas Leuba
;;
;; Author: Lukas Leuba <lukas.leuba@hotmail.ch>
;; Maintainer: Lukas Leuba <lukas.leuba@hotmail.ch>
;; Created: March 05, 2023
;; Modified: March 05, 2023
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex tools unix vc wp
;; Homepage: https://github.com/lkslba/build-site
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;;; Code:
;;;
;; Load the publishing system
(require 'package)
(setq package-user-dir (expand-file-name "./.packages"))
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;; Initialize the package system
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install dependencies
(package-install 'htmlize)

;; Load the publishing system
(require 'ox-publish)

;; Customize the HTML output
(setq org-html-validation-link nil            ;; Don't show validation link
      org-src-fontify-natively t
      org-html-head-include-scripts nil       ;; Use our own scripts
      org-html-head-include-default-style nil ;; Use our own styles
      org-html-doctype "html5"
      org-html-html5-fancy t
      org-export-allow-bind-keywords t)

;; Define the publishing project
(setq org-publish-project-alist
      (list
       (list "index"
             :recursive nil
             :base-directory "./content"
             :base-extension "org"
             :publishing-function 'org-html-publish-to-html
             :publishing-directory "./public"
             :with-author nil           ;; Don't include author name
             :with-creator t            ;; Include Emacs and Org versions in footer
             :with-toc nil                ;; Include a table of contents
             :section-numbers nil       ;; Don't include section numbersi
             :html-head "<link rel=\"stylesheet\" href=\"style.css\" type=\"text/css\"/> <link rel=\"icon\" href=\"img_doc/favicon.png\" type=\"image/x-icon\"/>"
             :html-preamble "<div id=\"updated\">Updated: %C</div>"
             :time-stamp-file nil)
       (list "blog"
             :recursive nil
             :base-directory "./content/blog"
             :base-extension "org"
             :publishing-function 'org-html-publish-to-html
             :publishing-directory "./public/blog"
             :with-author nil           ;; Don't include author name
             :with-creator t            ;; Include Emacs and Org versions in footer
             :with-toc nil                ;; Include a table of contents
             :section-numbers nil       ;; Don't include section numbers
             :html-head "<link rel=\"stylesheet\" href=\"../style.css\" type=\"text/css\"/> <link rel=\"icon\" href=\"../img_doc/favicon.png\" type=\"image/x-icon\"/>"
             :html-preamble  "<nav>
  <a href=\"../index.html\">&lt; Home</a>
</nav>
<div id=\"updated\">Updated: %C</div>"
             :time-stamp-file nil
             :auto-sitemap t
             :sitemap-title "Blog"
             :sitemap-filename "blog.org"
             :sitemap-sort-files 'anti-chronologically)
       (list "static"
             :recursive t
             :base-directory "./content"
             :base-extension "css\\|txt\\|pdf\\|jpg\\|jpeg\\|gif\\|png"
             :publishing-function 'org-publish-attachment
             :publishing-directory "./public")))    ;; Don't include time stamp in file
;; Generate the site output
(org-publish-all t)

(message "Build complete!")
;;; build-site.el ends here
