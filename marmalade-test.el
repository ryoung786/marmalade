:;exec emacs -batch -Q -l "$0" -f marmalade-test "$@"

;; Test marmalade from the command line by attempting to install the
;; fakir package.

;; It's all done in a new temporary directory (based on the pid of the
;; emacs process) so it should be very isolated from any emacs you
;; have running.
(defun marmalade-test ()
  (interactive)
  (let ((dir (concat
              temporary-file-directory
              (format "marmalade-%d/" (emacs-pid)))))
    (when (file-exists-p dir)
      (delete-directory dir 't))
    (make-directory dir)

    (setq package-user-dir
        (concat
         dir
         ".elpa"))
    (setq package-archives
          '(("gnu" . "http://elpa.gnu.org/packages/")
            ("marmalade" . "http://marmalade-repo.org/packages/")))
    (package-initialize)
    (package-refresh-contents)
    (condition-case nil
        (package-install 'fakir)
      (error (message "failed to install package!")))))

;;; marmalade-test.el ends
