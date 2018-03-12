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

-- 2
def add_tuple : (ℕ × ℕ) → ℕ :=  λ x, x.1 + x.2
#eval add_tuple (2, 3)

def curry (α β γ : Type) (f : α × β → γ) : α → β → γ :=
  λ x y, f (x, y)

#check curry ℕ ℕ ℕ add_tuple
#eval (curry ℕ ℕ ℕ add_tuple) 2 3

def uncurry (α β γ : Type) (f : α → β → γ) : α × β → γ :=
  λ (x : α ×  β), f x.1 x.2

#check uncurry ℕ ℕ ℕ (curry ℕ ℕ ℕ add_tuple)
#eval uncurry ℕ ℕ ℕ (curry ℕ ℕ ℕ add_tuple) (2, 3)

-- 3
universe u
constant vec : Type u → ℕ → Type u

constant vec_add :
  Π (α : Type) (n : ℕ), vec α n → vec α n → vec α n
 
constant vec_reserve :
  Π (α : Type) (n : ℕ), vec α n → vec α n

variables v1 v2: vec ℕ 3
#check vec_add ℕ 3 v1 v2
#check vec_reserve ℕ 3 v1

-- 4  
constant matrix : Type u → ℕ → ℕ → Type u

constant matrix_add :
  Π (α : Type) (n : ℕ) (m : ℕ),
    matrix α n m → matrix α n m → matrix α n m
    
constant matrix_mul :
  Π (α : Type) (n : ℕ) (m : ℕ) (p : ℕ),
    matrix α n m → matrix α m p → matrix α n p
    
variables m1 m2 : matrix ℕ 2 3
variable m3 : matrix ℕ 3 4
#check matrix_add ℕ 2 3 m1 m2
#check matrix_mul ℕ 2 3 4 m1 m3