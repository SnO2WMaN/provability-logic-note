@default_files = ('main.tex');

$latex     = 'uplatex %O -synctex=1 -interaction=nonstopmode %S';
$dvipdf    = 'dvipdfmx %O -o %D %S';
$makeindex = 'upmendex %O -o %D %S';
# $biber     = 'biber %O --bblencoding=utf8 -u -U --output_safechars %B';
$bibtex    = 'upbibtex %O %B';
$pdf_mode  = 3; 