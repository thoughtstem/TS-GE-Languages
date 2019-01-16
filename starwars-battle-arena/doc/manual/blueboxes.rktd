174
((3) 0 () 1 ((q lib "language-pkg-name-here/main.rkt")) () (h ! (equal) ((c def c (c (? . 0) q custom-jedi)) q (0 . 3)) ((c def c (c (? . 0) q starwars-game)) q (110 . 3))))
procedure
(custom-jedi [#:sprite sprite]) -> entity?
  sprite : any/c = (circle 10 'solid 'blue)
procedure
(starwars-game [#:avatar avatar]) -> game?
  avatar : entity? = (custom-jedi)
