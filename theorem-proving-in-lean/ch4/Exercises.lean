variables (α : Type) (p q : α → Prop)

-- 1

example : (∀ x, p x ∧ q x) ↔ (∀ x, p x) ∧ (∀ x, q x) :=
  iff.intro
    (assume h : ∀ x, p x ∧ q x,
     show (∀ x, p x) ∧ (∀ x, q x),
       from and.intro
         (take x, and.left (h x)) (take x, and.right (h x)))
    (assume h : (∀ x, p x) ∧ (∀ x, q x),
     show  ∀ x, p x ∧ q x,
       from take x, and.intro (and.left h x) (and.right h x))

example : (∀ x, p x → q x) → (∀ x, p x) → (∀ x, q x) :=
  assume hpq : ∀ x, p x → q x,
  assume hp : ∀ x, p x,
  take x, show q x, from hpq x (hp x)

example : (∀ x, p x) ∨ (∀ x, q x) → ∀ x, p x ∨ q x :=
  assume h : (∀ x, p x) ∨ (∀ x, q x),
  take x : α, show  p x ∨ q x,
    from or.elim h
      (assume hp : ∀ x, p x, or.intro_left (q x) (hp x))
      (assume hq : ∀ x, q x, or.intro_right (p x) (hq x))