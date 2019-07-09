{-# OPTIONS --universe-polymorphism #-}
module Categories.Kan where

-- Left and Right Kan extensions (known as Lan and Ran)

open import Level
open import Categories.Category using (Category)
open import Categories.Functor

private
  variable
    o₀ ℓ₀ e₀ o₁ ℓ₁ e₁ o₂ ℓ₂ e₂ : Level

module _ {A : Category o₀ ℓ₀ e₀} {B : Category o₁ ℓ₁ e₁} {C : Category o₂ ℓ₂ e₂}
           (F : Functor A B) (X : Functor A C) where
  open import Categories.NaturalTransformation using (NaturalTransformation; _≃_; _∘ʳ_; _∘ᵥ_)

  record Lan : Set (o₀ ⊔ ℓ₀ ⊔ e₀ ⊔ o₁ ⊔ ℓ₁ ⊔ e₁ ⊔ o₂ ⊔ ℓ₂ ⊔ e₂) where
    field
      L : Functor B C
      ε : NaturalTransformation X (L ∘F F)

      σ : (M : Functor B C) → (α : NaturalTransformation X (M ∘F F)) → NaturalTransformation L M

      σ-unique : {M : Functor B C} → {α : NaturalTransformation X (M ∘F F)} →
                  (σ′ : NaturalTransformation L M) → α ≃ (σ′ ∘ʳ F) ∘ᵥ ε → σ′ ≃ σ M α
      commutes : (M : Functor B C) → (α : NaturalTransformation X (M ∘F F)) → α ≃ (σ M α ∘ʳ F) ∘ᵥ ε

  record Ran : Set (o₀ ⊔ ℓ₀ ⊔ e₀ ⊔ o₁ ⊔ ℓ₁ ⊔ e₁ ⊔ o₂ ⊔ ℓ₂ ⊔ e₂) where
    field
      R : Functor B C
      η : NaturalTransformation (R ∘F F) X

      δ : (M : Functor B C) → (α : NaturalTransformation (M ∘F F) X) → NaturalTransformation M R

      δ-unique : {M : Functor B C} → {α : NaturalTransformation (M ∘F F) X} →
                  (δ′ : NaturalTransformation M R) → α ≃ η ∘ᵥ (δ′ ∘ʳ F) → δ′ ≃ δ M α
      commutes : (M : Functor B C) → (α : NaturalTransformation (M ∘F F) X) → α ≃ η ∘ᵥ (δ M α ∘ʳ F)
