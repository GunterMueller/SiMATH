(defun extract-C ()
  "Extract keys from from ASCII style documentation"
  (interactive)

   (sit-for 0 500)

  (next-line 1)
  (beginning-of-line)
  (setq p1 (point))
  (end-of-line)
  (setq p2 (point))
  (write-region p1 p2 "/tmp/ARGS")

  (search-forward "\"")
  (setq p1 (point))
  (search-forward "\"")
  (backward-char)
  (setq p2 (point))
  (write-region p1 p2 "/tmp/NAME"))
