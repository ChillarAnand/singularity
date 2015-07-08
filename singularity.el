;;; singularity.el --- 
;; 
;; Filename: singularity.el
;; Description: 
;; Author: Anand
;; Maintainer: 
;; Created: Wed Jul  8 17:33:36 2015 (+0530)
;; Version: 
;; Package-Requires: ()
;; Last-Updated: 
;;           By: 
;;     Update #: 0
;; URL: 
;; Doc URL: 
;; Keywords: 
;; Compatibility: 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Commentary: 
;; 
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Change Log:
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or (at
;; your option) any later version.
;; 
;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;; 
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Code:

(require 'helm)
(require 'helm-files)
(require 'helm-dired)
(require 'helm-dired-recent-dirs)
(require 'helm-chrome)
(require 'helm-descbinds)
(require 'helm-github-stars)

(defvar singularity-github-username nil)

(defvar singularity-source-emacs-commands
  (helm-build-sync-source "Emacs commands"
    :candidates (lambda ()
                  (let ((cmds))
                    (mapatoms
                     (lambda (elt) (when (commandp elt) (push elt cmds))))
                    cmds))
    :coerce #'intern-soft
    :action #'command-execute)
  "A simple helm source for Emacs commands.")

(defvar singularity-source-emacs-commands-history
  (helm-build-sync-source "Emacs commands history"
    :candidates (lambda ()
                  (let ((cmds))
                    (dolist (elem extended-command-history)
                      (push (intern elem) cmds))
                    cmds))
    :coerce #'intern-soft
    :action #'command-execute)
  "Emacs commands history")

(defvar singularity-sources '(singularity-source-buffers-list
                              helm-source-recentf
                              helm-source-dired-recent-dirs
                              singularity-source-emacs-commands-history
                              singularity-source-emacs-commands
                              helm-chrome-source
                              hgs/helm-c-source-stars
                              hgs/helm-c-source-repos
                              helm-source-buffer-not-found
                              hgs/helm-c-source-search))


(defun singularity-make-source-buffers-list ()
  (setq singularity-source-buffers-list
        (helm-make-source "Buffers" 'helm-source-buffers)))

(defun singularity ()
  ""
  (interactive)
  (unless singularity-source-buffers-list
    (singularity-make-source-buffers-list))
  
  (let ((helm-ff-transformer-show-only-basename nil))
    (helm :sources singularity-sources
          :buffer "*helm mini*"
          :truncate-lines t)))






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; singularity.el ends here
