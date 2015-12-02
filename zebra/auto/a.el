(TeX-add-style-hook "a"
 (function
  (lambda ()
    (TeX-add-symbols
     '("HTML" 1)
     '("notHTML" 1))
    (TeX-run-style-hooks "art12" "12pt" "article" "b"))))

