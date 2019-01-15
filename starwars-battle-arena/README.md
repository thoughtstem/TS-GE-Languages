# New TS-Langauge

This is a language with a collection of examples.  Use the following to generate the examples from their definitions in `examples/`.  This will ensure that all examples are actually valid and will prepare the examples for use in the creation of kata collections. 

```
raco build-lang-examples
```

Use this `README.md` for developer notes.  It gets displayed nicely on github, so phrase things here like you're talking to developers.

But this file is mostly for installation notes, gotchas, etc.
Things that differ from the norm.

For API documentation, write it in:

```
scribblings/
```

Or better yet, automatically document your langauge's api with `define/contract/doc`.

Either way, build the Scribble files with:

```
raco setup [this-language-name]
```

The language's definitions should go in:

```
lang/
```

Use `lang.rkt` to pull everything from `lang/` together with whatever else you want your language to provide

For todos, use Github tickets.
