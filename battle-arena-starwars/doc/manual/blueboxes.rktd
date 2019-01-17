370
((3) 0 () 1 ((q lib "battle-arena-starwars/main.rkt")) () (h ! (equal) ((c def c (c (? . 0) q starwars-game)) q (114 . 3)) ((c def c (c (? . 0) q twileck-jedi)) q (295 . 2)) ((c def c (c (? . 0) q custom-jedi)) q (0 . 3)) ((c def c (c (? . 0) q darth-vader)) q (212 . 2)) ((c def c (c (? . 0) q r2-d2)) q (241 . 2)) ((c def c (c (? . 0) q storm-trooper)) q (264 . 2))))
procedure
(custom-jedi [#:sprite sprite]) -> entity?
  sprite : sprite? = (sheet->sprite twileck-jedi)
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
