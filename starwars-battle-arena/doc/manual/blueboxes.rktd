370
((3) 0 () 1 ((q lib "starwars-battle-arena/main.rkt")) () (h ! (equal) ((c def c (c (? . 0) q storm-trooper)) q (260 . 2)) ((c def c (c (? . 0) q darth-vader)) q (208 . 2)) ((c def c (c (? . 0) q twileck-jedi)) q (291 . 2)) ((c def c (c (? . 0) q custom-jedi)) q (0 . 3)) ((c def c (c (? . 0) q r2-d2)) q (237 . 2)) ((c def c (c (? . 0) q starwars-game)) q (110 . 3))))
procedure
(custom-jedi [#:sprite sprite]) -> entity?
  sprite : any/c = (circle 10 'solid 'blue)
procedure
(starwars-game [#:avatar avatar]) -> game?
  avatar : entity? = (custom-jedi)
value
darth-vader : image?
value
r2-d2 : image?
value
storm-trooper : image?
value
twileck-jedi : image?
