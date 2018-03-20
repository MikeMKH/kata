-- https://leanprover.github.io/theorem_proving_in_lean/quantifiers_and_equality.html#exercises

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
      
-- 2

variable r : Prop

example : α → ((∀ x : α, r) ↔ r) :=
  assume a : α,
  iff.intro
   (assume h : α → r, h a)
   (assume (r : r) (x : α), r)
   
example : (∀ x, p x ∨ r) ↔ (∀ x, p x) ∨ r :=
  have h₁ : (∀ x, p x ∨ r) → (∀ x, p x) ∨ r, from
    assume hx : ∀ x, p x ∨ r, sorry,
  have h₂ : (∀ x, p x) ∨ r → (∀ x, p x ∨ r), from
    assume hx : (∀ x, p x) ∨ r,
    take x : α, or.elim hx
      (assume hp : ∀ x, p x, or.intro_left r (hp x))
      or.inr,
  iff.intro h₁ h₂
  
example : (∀ x, r → p x) ↔ (r → ∀ x, p x) :=
  have h₁ : (∀ x, r → p x) → (r → ∀ x, p x), from
    assume (hx : ∀ x, r → p x) r,
    take x : α, hx x r,
  have h₂ : (r → ∀ x, p x) → (∀ x, r → p x), from
    assume hr : r → ∀ x, p x,
    take x : α, assume r, hr r x,
  iff.intro h₁ h₂
  
-- 3

section barber
  variables (men : Type) (barber : men)
  variable  (shaves : men → men → Prop)
  
  example (h : ∀ x : men, shaves barber x ↔ ¬ shaves x x) : false :=
    have h' : shaves barber barber ↔ ¬shaves barber barber,
      from h barber,
    have barber_does_not_shaves_self : ¬shaves barber barber,
      from assume barber_shaves_self : shaves barber barber,
      iff.elim_left h' barber_shaves_self barber_shaves_self,
    barber_does_not_shaves_self (iff.elim_right h' barber_does_not_shaves_self)
end barber

-- 4

namespace hide

  def divides (m n : ℕ) : Prop := ∃ k, m * k = n
  
  instance : has_dvd nat := ⟨divides⟩
  
  def even (n : ℕ) : Prop := 2 ∣ n
  
  section
    variables m n : ℕ
  
    #check m ∣ n
    #check m^n
    #check even (m^n +3)
  end
  
end hide

def prime (n : ℕ) : Prop :=
  n ≥ 2 ∧ ∀ x, x ∣ n → x = 1 ∨ x = n

def infinitely_many_primes : Prop := sorry

def Fermat_prime (n : ℕ) : Prop := sorry

def infinitely_many_Fermat_primes : Prop := sorry

def goldbach_conjecture : Prop := sorry

def Goldbach's_weak_conjecture : Prop := sorry

def Fermat's_last_theorem : Prop := sorry
