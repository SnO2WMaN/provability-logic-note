@default_files = ('main.tex');
# $lualatex = "lualatex %O -shell-escape %S";
$latex = 'platex';
$dvipdf = 'dvipdfmx %O -o %D %S';
$bibtex = 'pbibtex %O %B';
$pdf_mode = 3;