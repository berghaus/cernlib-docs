(TeX-add-style-hook "zebrahtml2"
 (function
  (lambda ()
    (TeX-add-symbols "FZfile" "RZfile" "IQUEST" "QUEST")
    (LaTeX-add-environments "landscapebody")
    (TeX-run-style-hooks "cernman12" "12pt" "epsfig" "makeidx" "cernman"
			 "zebfront" "zebintr" "zebmz1" "zebmz2" "zebmz3"
			 "zebmz4" "zebmz5"))))

