# TS-Languages

[![Build Status](https://travis-ci.com/thoughtstem/TS-Languages.svg?branch=master)](https://travis-ci.com/thoughtstem/TS-Languages)

This repository organizes various teaching language implementations used at ThoughtSTEM.

Languages in this repo must follow our Kata-based curriculum organizational conventions.
Languages must also follow our Language Design Guidelines.

API Docs should be present for any languages in this repo.
Use inline docs with the `define/contract/doc` form.

To make a new language:

```
raco new-language NAME-OF-Language
```

To test examples for a langauge:

```
raco build-lang-examples
```

To run a specific example, run `examples.rkt` in DrRacket, then for running a specific example:

```
(run-example avatar-1)
```




