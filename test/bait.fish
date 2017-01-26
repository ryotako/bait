set -l got
set -l want

# -h / --help option

test "bait -h"
    (bait -h) = (__bait_usage)
end

test "bait --help"
    (bait -h) = (__bait_usage)
end

test "bait -help (illegal option)"
    -z (bait -help 2> /dev/null)
end

test "bait --h (illegal option)"
    -z (bait -help 2> /dev/null)
end

# These are not strict tests!! :
# The overloaded '=' in fishtape yields true when all items on the left
# exist at least once on the right side.

# bait addb
set want "abc" "ABC"
set got (echo abc | bait addb ABC)

test "echo abc | bait addb ABC"
    "$want" = "$got"
end

# bait addb
set want "ABC" "abc"
set got (echo abc | bait addt ABC)

test "echo abc | bait addt ABC"
    "$want" = "$got"
end

# bait addl
test "echo abc | bait addl ABC"
    "ABCabc" = (echo abc | bait addl ABC)
end

# bait addr
test "echo abc | bait addr ABC"
    "abcABC" = (echo abc | bait addr ABC)
end

# bait dupl
set want "A B C D,A B C D,A B C D"
set got (echo A B C D | bait dupl 3 --eor ,)
test "echo A B C D | bait dupl 3"
    "$want" = "$got"
end

