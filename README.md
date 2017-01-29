[![Build Status][travis-badge]][travis-link]
[![Slack Room][slack-badge]][slack-link]

# fishbait

A clone of [egzact](https://github.com/greymd/egzact) written in pure fish-shell
script.

Strengthen the weak points of fish with fish!


## Install

With [fisherman]

```
fisher ryotako/fishbait
```

## Usage
```
bait [COMMAND] [OPTIONS] [N or STR]
```

Generate new commands to feed for fish.
 
```
# mkdir folder{1..9}
seq 9 | bait addl "mkdir folder" | fish
```

```
# zip-matryoshka
echo "sardine" > mytext
seq 100 | bait addr ".zip" | bait addt "mytext" | bait conv 2 | bait mirror | bait addl "zip " | fish
```

```
# approximation of Napier's Constant
seq 10 | bait flat | bait stairl --ofs "\*" | bait flat | bait wrap '1/\(*\)' --ofs "+" | bait addl "math -s9 1+" | fish
```

You can see [more examples](https://github.com/greymd/egzact/blob/master/doc/example.md) for egzact.

## Command
`bait` command provides the egzact's commands as subcommands.

- [addb](https://github.com/greymd/egzact/blob/master/README.md#-addb) (Add `STR` to the bottom)
- [addl](https://github.com/greymd/egzact/blob/master/README.md#-addl) (Add `STR` to the left side)
- [addr](https://github.com/greymd/egzact/blob/master/README.md#-addr) (Add `STR` to the right side)
- [addt](https://github.com/greymd/egzact/blob/master/README.md#-addt) (Add `STR` to the top)
- [comb](https://github.com/greymd/egzact/blob/master/README.md#-comb) (Get combinations of length `N`)
- [conv](https://github.com/greymd/egzact/blob/master/README.md#-conv) (Get Convolutions of length `N`)
- [crops](https://github.com/greymd/egzact/blob/master/README.md#-crops) (Crop all the patterns matching `STR`)
- [cycle](https://github.com/greymd/egzact/blob/master/README.md#-cycle) (Get all circulated patterns)
- [dropl](https://github.com/greymd/egzact/blob/master/README.md#-dropl) (Remove the first `N` fields)
- [dropr](https://github.com/greymd/egzact/blob/master/README.md#-dropr) (Remove the last `N` fields)
- [dupl](https://github.com/greymd/egzact/blob/master/README.md#-dupl) (Duplicate to `N` records)
- [flat](https://github.com/greymd/egzact/blob/master/README.md#-flat) (Print all inputs or `N` fields per line)
- [grep](https://github.com/greymd/egzact/blob/master/README.md#-zrep) (Extract fields matching regular expression `STR`)
- [mirror](https://github.com/greymd/egzact/blob/master/README.md#-mirror) (Reverse the order of the fields. This is `zrep` command in egzact)
- [nestl](https://github.com/greymd/egzact/blob/master/README.md#-nestl) (Get nested records by eplacing * in `STR`. The first field becomes deepest)
- [nestr](https://github.com/greymd/egzact/blob/master/README.md#-nestr) (Get nested records by eplacing * in `STR`. The last field becomes deepest)
- [obrev](https://github.com/greymd/egzact/blob/master/README.md#-obrev) (Print given fields and reversed fields)
- [perm](https://github.com/greymd/egzact/blob/master/README.md#-perm) (Get permutations of length `N`)
- [slit](https://github.com/greymd/egzact/blob/master/README.md#-slit) (Divide inputs into `N` lines)
- [stairl](https://github.com/greymd/egzact/blob/master/README.md#-stairl) (Get sublist matching the left side on the input)
- [stairr](https://github.com/greymd/egzact/blob/master/README.md#-stairr) (Get sublist matching the right side on the input)
- [sublist](https://github.com/greymd/egzact/blob/master/README.md#-sublist) (Get all sublists)
- [subset](https://github.com/greymd/egzact/blob/master/README.md#-subset) (Get all subsets)
- [takel](https://github.com/greymd/egzact/blob/master/README.md#-takel) (Print the first `N` of the fields)
- [takelx](https://github.com/greymd/egzact/blob/master/README.md#-takelx) (Print fields from the first to one maching `STR`)
- [taker](https://github.com/greymd/egzact/blob/master/README.md#-taker) (Print the last `N` of the fields)
- [takerx](https://github.com/greymd/egzact/blob/master/README.md#-takerx) (Print the last field to the field matching `STR`)
- [uniq](https://github.com/greymd/egzact/blob/master/README.md#-zniq) (Remove duplicated fields. This is `zniq` command in egzact)
- [wrap](https://github.com/greymd/egzact/blob/master/README.md#-wrap) (Replace * in `STR`)

## Options
GNU style long options

- --fs  `STR` (Field separator. The default value is ' ')
- --ifs `STR` (Input field separator. The default value is ' ')
- --ofs `STR` (Output field separator. The default value is ' ')
- --eor `STR` (End of record. The default value is \\n)
- --eos `STR` (End of set. The default value is \\n)
- --each      (Manipulate input lines respectively. This option is available for flat, conv, and slit commands)

[travis-link]: https://travis-ci.org/ryotako/fishbait
[travis-badge]: https://img.shields.io/travis/ryotako/fishbait.svg
[slack-link]: https://fisherman-wharf.herokuapp.com
[slack-badge]: https://fisherman-wharf.herokuapp.com/badge.svg
[fisherman]: https://github.com/fisherman/fisherman

# License
This software is released under the MIT License.
See [LICENSE](./LICENSE)
