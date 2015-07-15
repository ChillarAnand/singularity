;;; singularity.el ---
;;
;; Filename: singularity.el
;; Description: Singularity is a  function in emacs, which is capable of doing anything! 
;; Author: ChillarAnand(Anand Reddy Pandikunta)
;; Maintainer: ChillarAnand(Anand Reddy Pandikunta)
;; Created: Wed Jul  8 17:33:36 2015 (+0530)
;; Version: 0.1
;; Package-Requires: ((helm "1.7.5") (helm-chrome "1.131226") (helm-github-stars "1.3.2") (helm-dired-recent-dirs "0.1") (key-chord "0.6"))

;; Last-Updated:
;;           By:
;;     Update #: 0
;; URL: https://github.com/ChillarAnand/singularity
;; Doc URL:
;; Keywords: helm convinience 
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
(require 'helm-chrome)
;; (require 'helm-descbinds)
(require 'helm-github-stars)
(require 'helm-dired-recent-dirs)
(require 'key-chord)


(defvar singularity-github-username nil)

(defvar singularity-source-emacs-commands
  (helm-build-sync-source "Emacs commands"
    :candidates (lambda ()
                  (let ((cmds))
                    (mapatoms
                     (lambda (elt)
                       (when (commandp elt) (push elt cmds))))
                    cmds))
    :coerce #'intern-soft
    :action #'command-execute)
  "Helm source for Emacs commands.")

(defvar singularity-source-emacs-commands-history
  (helm-build-sync-source "Emacs commands history"
    :candidates (lambda ()
                  (let ((cmds))
                    (dolist (elem extended-command-history)
                      (push (intern elem) cmds))
                    cmds))
    :coerce #'intern-soft
    :action #'command-execute)
  "Helm source for Emacs commands history")

(defvar singularity-sources '(helm-source-buffers-list
                              helm-source-recentf
                              helm-source-dired-recent-dirs
                              singularity-source-emacs-commands-history
                              singularity-source-emacs-commands
                              helm-chrome-source
                              hgs/helm-c-source-stars
                              hgs/helm-c-source-repos
                              helm-source-buffer-not-found
                              hgs/helm-c-source-search)) 

(defvar singularity-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-c C-s") 'singularity)
    (key-chord-define-global "fj" 'singularity)
    map)
  "Key map for Singularity")


;;;;;;;;;;;;;;;;;
;;; Singularity

(defun singularity ()
  ""
  (interactive)
  (let ((helm-ff-transformer-show-only-basename nil))
    (helm :sources singularity-sources
          :buffer "*helm mini*"
          :truncate-lines t)))


;;;###autoload
(define-minor-mode singularity-mode
  "Singularity"
  nil
  " S "
  singularity-mode-map)


(defun singularity-enable ()
  "Enable `singularity-mode`'"
  (singularity-mode 1))


(defun singularity-disable ()
  "Disable `singularity-mode`'"
  (singularity-mode 0))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; singularity.el ends here
