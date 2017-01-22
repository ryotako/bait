
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
test "echo abc | addb ABC"
    "abc" "ABC" = (echo abc | addb ABC)
end

# bait addb
test "echo abc | addt ABC"
    "ABC" "abc" = (echo abc | addt ABC)
end

# bait addl
test "echo abc | addl ABC"
    "ABCabc" = (echo abc | bait addl ABC)
end

# bait addr
test "echo abc | addr ABC"
    "abcABC" = (echo abc | bait addr ABC)
end

# bait dupl
test "echo A B C D | bait dupl 3"
    "A B C D" "A B C D" "A B C D" = (echo A B C D | bait dupl 3)
end

