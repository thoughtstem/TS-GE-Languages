# TS-Languages

This repository organizes various teaching language implementations used at ThoughtSTEM.

## Installation

First install `ts-kata-util` in `TS-Kata-Collections` repo.

Then

```
git clone https://github.com/thoughtstem/TS-Languages.git
cd TS-Languages
raco install-all-here
```

## Making new languages

Languages in this repo must follow our Kata-based curriculum organizational conventions.
Languages must also follow our Language Design Guidelines.

API Docs should be present for any languages in this repo.
Use inline docs with the `define/contract/doc` form.

To make a new language:

```
raco new-language NAME-OF-Language
```
