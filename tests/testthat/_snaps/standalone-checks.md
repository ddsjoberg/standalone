# check functions work

    Code
      myfunc(1)
    Condition
      Error in `myfunc()`:
      ! The `x` argument must be class <character>, not a number.

---

    Code
      myfunc(1)
    Condition
      Error in `myfunc()`:
      ! The `x` argument must be class <data.frame>, not a number.

---

    Code
      myfunc(1)
    Condition
      Error in `myfunc()`:
      ! The `x` argument must be class <logical>, not a number.

---

    Code
      myfunc(c(TRUE, FALSE))
    Condition
      Error in `myfunc()`:
      ! The `x` argument must be a scalar with class <logical>, not a logical vector.

---

    Code
      myfunc(1)
    Condition
      Error in `myfunc()`:
      ! The `x` argument must be a string, not a number.

---

    Code
      myfunc()
    Condition
      Error in `myfunc()`:
      ! The `x` argument cannot be missing.

---

    Code
      myfunc(1:10, 5)
    Condition
      Error in `myfunc()`:
      ! The `x` argument must be length 5.

---

    Code
      myfunc(c(TRUE, FALSE))
    Condition
      Error in `myfunc()`:
      ! The `x` argument must be length 1.

---

    Code
      myfunc(1, c(0, 1))
    Condition
      Error in `myfunc()`:
      ! The `x` argument must be in the interval `(0, 1)`.

---

    Code
      myfunc(1, c(0, 1))
    Condition
      Error in `myfunc()`:
      ! The `x` argument must be in the interval `(0, 1)` and length 1.

---

    Code
      myfunc(c(0, 1, 2))
    Condition
      Error in `myfunc()`:
      ! Expecting `x` to be either <logical> or <numeric/integer> coded as 0 and 1.

---

    Code
      myfunc(1)
    Condition
      Error in `myfunc()`:
      ! The `x` argument must be a named list, list of formulas, or a single formula.
      i Review ?syntax (`?cards::syntax()`) for examples and details.

---

    Code
      myfunc(letters)
    Condition
      Error in `myfunc()`:
      ! The `x` argument must have 2 levels.

---

    Code
      myfunc(pi)
    Condition
      Error in `myfunc()`:
      ! The `x` argument must an integer vector.

---

    Code
      myfunc(pi)
    Condition
      Error in `myfunc()`:
      ! The `x` argument must an scalar integer.

---

    Code
      myfunc(my_iris)
    Condition
      Error in `myfunc()`:
      ! Factors with NA levels are not allowed, which are present in column "Species".

---

    Code
      myfunc(my_iris)
    Condition
      Error in `myfunc()`:
      ! Factors with empty "levels" attribute are not allowed, which was identified in column "bad_fct_col".

---

    Code
      myfunc("a")
    Condition
      Error in `myfunc()`:
      ! The `x` argument must be numeric.

