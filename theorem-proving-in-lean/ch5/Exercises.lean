-- https://leanprover.github.io/theorem_proving_in_lean/tactics.html#exercises

-- 1

section three
  open classical
  
  variables p q r s : Prop
  
  -- commutativity of ∧ and ∨
  example : p ∧ q ↔ q ∧ p := by simp
  example : p ∨ q ↔ q ∨ p := by simp
  
  -- associativity of ∧ and ∨
  example : (p ∧ q) ∧ r ↔ p ∧ (q ∧ r) := by simp
  example : (p ∨ q) ∨ r ↔ p ∨ (q ∨ r) := by simp
  
  -- distributivity
  example : p ∧ (q ∨ r) ↔ (p ∧ q) ∨ (p ∧ r) :=
  begin
    apply iff.intro,
    {
      intro h,
      cases h.right with hq hr,
      {
        show (p ∧ q) ∨ (p ∧ r),
        exact or.inl ⟨h.left, hq⟩
      },
      {
        show (p ∧ q) ∨ (p ∧ r),
        exact or.inr ⟨h.left, hr⟩
      },
    },
    {
      intro h,
      cases h with hpq hpr,
      {
        show p ∧ (q ∨ r),
        exact ⟨hpq.left, or.inl hpq.right⟩
      },
      {
        show p ∧ (q ∨ r),
        exact ⟨hpr.left, or.inr hpr.right⟩
      }
    }
  end
  
  example : p ∨ (q ∧ r) ↔ (p ∨ q) ∧ (p ∨ r) := sorry
  
  -- other properties
  example : (p → (q → r)) ↔ (p ∧ q → r) := sorry
  example : ((p ∨ q) → r) ↔ (p → r) ∧ (q → r) := sorry
  example : ¬(p ∨ q) ↔ ¬p ∧ ¬q := sorry
  example : ¬p ∨ ¬q → ¬(p ∧ q) := sorry
  example : ¬(p ∧ ¬p) := by simp
  example : p ∧ ¬q → ¬(p → q) := sorry
  example : ¬p → (p → q) := sorry
  example : (¬p ∨ q) → (p → q) := sorry
  example : p ∨ false ↔ p := by simp
  example : p ∧ false ↔ false := by simp
  example : ¬(p ↔ ¬p) := by simp
  example : (p → q) → (¬q → ¬p) := sorry
  
  -- these require classical reasoning
  example : (p → r ∨ s) → ((p → r) ∨ (p → s)) := sorry
  example : ¬(p ∧ q) → ¬p ∨ ¬q := sorry
  example : ¬(p → q) → p ∧ ¬q := sorry
  example : (p → q) → (¬p ∨ q) := sorry
  example : (¬q → ¬p) → (p → q) := sorry
  example : p ∨ ¬p := sorry
  example : (((p → q) → p) → p) := sorry
end three

section four
  variables (α : Type) (p q : α → Prop)
  
  example : (∀ x, p x ∧ q x) ↔ (∀ x, p x) ∧ (∀ x, q x) := sorry
  example : (∀ x, p x → q x) → (∀ x, p x) → (∀ x, q x) := sorry
  example : (∀ x, p x) ∨ (∀ x, q x) → ∀ x, p x ∨ q x := sorry
  
  variable r : Prop
  
  example : α → ((∀ x : α, r) ↔ r) := sorry
  example : (∀ x, p x ∨ r) ↔ (∀ x, p x) ∨ r := sorry
  example : (∀ x, r → p x) ↔ (r → ∀ x, p x) := sorry
  
  variables (men : Type) (barber : men)
  variable  (shaves : men → men → Prop)
  
  example (h : ∀ x : men, shaves barber x ↔ ¬ shaves x x) :
    false := sorry
end four

-- 2

example (p q r : Prop) (hp : p) :
(p ∨ q ∨ r) ∧ (q ∨ p ∨ r) ∧ (q ∨ r ∨ p) :=
by admit