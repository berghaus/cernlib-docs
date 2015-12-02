(TeX-add-style-hook "c"
 (function
  (lambda ()
    (TeX-add-symbols
     '("HTML" 1)
     '("notHTML" 1) "Ptitle" "Ptitle")
    (TeX-run-style-hooks "art12" "12pt" "article"))))

