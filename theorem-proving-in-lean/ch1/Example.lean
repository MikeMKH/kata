theorem and_communitive (p q : Prop) : p ∧ q → q ∧ p :=
assume hpq : p ∧ q,
have hp : p, from and.left hpq,
have hq : q, from and.right hpq,
show q ∧ p, from and.intro hq hp

#check and_communitive
-- and_communitive : ∀ (p q : Prop), p ∧ q → q ∧ p