-- https://leanprover.github.io/theorem_proving_in_lean/dependent_type_theory.html

-- 1
def double : ℕ → ℕ := λ x, x + x
def square : ℕ → ℕ := λ x, x * x
def do_twice : (ℕ → ℕ) → ℕ → ℕ := λ f x, f (f x)

#eval do_twice double 2

def mul_by_8 : ℕ → ℕ := λ x, x * (do_twice double 2)

#eval mul_by_8 2

def Do_Twice : ((ℕ → ℕ) → (ℕ → ℕ)) → (ℕ → ℕ) → (ℕ → ℕ) :=
  λ g f, g f

#check Do_Twice do_twice
#reduce Do_Twice do_twice
#eval Do_Twice do_twice double 2