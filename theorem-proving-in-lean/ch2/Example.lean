constant m : nat
constant n : nat
constants b1 b2 : bool

#check m
-- m : ℕ
#check n
-- n : ℕ
#check n + 0
-- n + 0 : ℕ
#check m * (n + 0)
-- m * (n + 0) : ℕ
#check b1
-- b1 : bool
#check b1 && b2
-- b1 && b2 : bool
#check b1 || b2
-- b1 || b2 : bool
#check tt
-- tt : bool

#check nat → nat
-- ℕ → ℕ : Type
#check id
-- id : ?M_1 → ?M_1

constant f : nat -> nat
constant f' : nat → nat
constant f'' : ℕ → ℕ
constant p : ℕ × ℕ 
constant q : prod nat nat
constant g : ℕ → ℕ → ℕ
constant g' : ℕ → (ℕ → ℕ)
constant h : ℕ × ℕ → ℕ

constant F : (ℕ → ℕ) → ℕ

#check f
-- f : ℕ → ℕ
#check f n
-- f n : ℕ
#check g m n
-- g m n : ℕ
#check g m
-- g m : ℕ → ℕ
#check (m, n)
-- (m, n) : ℕ × ℕ
#check p.1
-- p.fst : ℕ
#check p.2
-- p.snd : ℕ
#check (m, n).1
-- (m, n).fst : ℕ
#check F f
-- F f : ℕ

#check ℕ
-- ℕ : Type
#check bool
-- bool : Type
#check ℕ → bool
-- ℕ → bool : Type
#check ℕ × bool
-- ℕ × bool : Type
#check ℕ → ℕ
-- ℕ → ℕ : Type
