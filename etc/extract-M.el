(defun extract-M ()
  "Extract keys from from manual style documentation"
  (interactive)

  (sit-for 0 500)

  (search-forward ".SH")
  (next-line 1)
  (beginning-of-line)
  (search-forward " - ")
  (setq p1 (point))
  (search-forward ".SH")
  (beginning-of-line)
  (setq p2 (point))
  (write-region p1 p2 "/tmp/NAME")

  (search-forward "#include")
  (next-line 2)
  (beginning-of-line)
  (search-forward " ")
  (setq p1 (point))
  (end-of-line)
  (setq p2 (point))
  (write-region p1 p2 "/tmp/ARGS"))

