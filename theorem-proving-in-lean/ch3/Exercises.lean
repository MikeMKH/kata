open classical

variables p q r s : Prop

-- commutativity of ∧ and ∨
example : p ∧ q ↔ q ∧ p :=
  iff.intro
    (assume hpq : p ∧ q,
     show q ∧ p, from and.intro (and.right hpq) (and.left hpq))
    (assume hqp : q ∧ p,
     show p ∧ q, from and.intro (and.right hqp) (and.left hqp))
example : p ∨ q ↔ q ∨ p :=
  iff.intro
    (assume hpq: p ∨ q,
     or.elim hpq
       (assume hp : p, or.inr hp)
       (assume hq : q, or.inl hq))
    (assume hpq : q ∨ p,
     or.elim hpq
       (assume hq : q, or.inr hq)
       (assume hq : p, or.inl hq))

-- associativity of ∧ and ∨
example : (p ∧ q) ∧ r ↔ p ∧ (q ∧ r) :=
  iff.intro
    (assume h : (p ∧ q) ∧ r,
     have hpq : p ∧ q, from and.left h,
     have hr : r, from and.right h,
     show p ∧ (q ∧ r),
       from and.intro (and.left hpq) (and.intro (and.right hpq) hr))
    (assume h : p ∧ (q ∧ r),
     have hp : p, from and.left h,
     have hqr : q ∧ r, from and.right h,
     show (p ∧ q) ∧ r,
       from and.intro (and.intro hp (and.left hqr)) (and.right hqr))
-- example : (p ∨ q) ∨ r ↔ p ∨ (q ∨ r) := sorry

-- -- distributivity
-- example : p ∧ (q ∨ r) ↔ (p ∧ q) ∨ (p ∧ r) := sorry
-- example : p ∨ (q ∧ r) ↔ (p ∨ q) ∧ (p ∨ r) := sorry

-- -- other properties
-- example : (p → (q → r)) ↔ (p ∧ q → r) := sorry
-- example : ((p ∨ q) → r) ↔ (p → r) ∧ (q → r) := sorry
-- example : ¬(p ∨ q) ↔ ¬p ∧ ¬q := sorry
-- example : ¬p ∨ ¬q → ¬(p ∧ q) := sorry
-- example : ¬(p ∧ ¬p) := sorry
-- example : p ∧ ¬q → ¬(p → q) := sorry
-- example : ¬p → (p → q) := sorry
-- example : (¬p ∨ q) → (p → q) := sorry
-- example : p ∨ false ↔ p := sorry
-- example : p ∧ false ↔ false := sorry
-- example : ¬(p ↔ ¬p) := sorry
-- example : (p → q) → (¬q → ¬p) := sorry

-- -- these require classical reasoning
-- example : (p → r ∨ s) → ((p → r) ∨ (p → s)) := sorry
-- example : ¬(p ∧ q) → ¬p ∨ ¬q := sorry
-- example : ¬(p → q) → p ∧ ¬q := sorry
-- example : (p → q) → (¬p ∨ q) := sorry
-- example : (¬q → ¬p) → (p → q) := sorry
-- example : p ∨ ¬p := sorry
-- example : (((p → q) → p) → p) := sorry