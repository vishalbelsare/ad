{-# LANGUAGE Rank2Types #-}
{-# LANGUAGE FlexibleContexts #-}
-----------------------------------------------------------------------------
-- |
-- Copyright   : (c) Edward Kmett 2010-2021
-- License     : BSD3
-- Maintainer  : ekmett@gmail.com
-- Stability   : experimental
-- Portability : GHC only
--
-- First order dense forward mode using 'Representable' functors
--
-----------------------------------------------------------------------------

module Numeric.AD.Mode.Dense.Representable
  ( AD, Repr, auto
  -- * Dense Gradients
  , grad
  , grad'
  , gradWith
  , gradWith'

  -- * Dense Jacobians (synonyms)
  , jacobian
  , jacobian'
  , jacobianWith
  , jacobianWith'
  ) where

import Data.Functor.Rep
import Numeric.AD.Internal.Dense.Representable (Repr)
import qualified Numeric.AD.Rank1.Dense.Representable as Rank1
import Numeric.AD.Internal.Type
import Numeric.AD.Mode

-- $setup
-- >>> :set -XDeriveGeneric -XDeriveFunctor
-- >>> import GHC.Generics (Generic1)
-- >>> import Data.Distributive (Distributive (..))
-- >>> import Data.Functor.Rep (Representable, distributeRep)
-- >>> data V3 a = V3 a a a deriving (Generic1, Functor, Show)
-- >>> instance Representable V3; instance Distributive V3 where distribute = distributeRep

-- | The 'grad' function calculates the gradient of a non-scalar-to-scalar function with dense-mode AD in a single pass.
--
-- >>> grad (\(V3 x y z) -> x*y+z) (V3 1 2 3)
-- V3 2 1 1
--
grad :: (Representable f, Eq (Rep f), Num a) => (forall s. f (AD s (Repr f a)) -> AD s (Repr f a)) -> f a -> f a
grad f = Rank1.grad (runAD.f.fmap AD)
{-# INLINE grad #-}

grad' :: (Representable f, Eq (Rep f), Num a) => (forall s. f (AD s (Repr f a)) -> AD s (Repr f a)) -> f a -> (a, f a)
grad' f = Rank1.grad' (runAD.f.fmap AD)
{-# INLINE grad' #-}

gradWith :: (Representable f, Eq (Rep f), Num a) => (a -> a -> b) -> (forall s. f (AD s (Repr f a)) -> AD s (Repr f a)) -> f a -> f b
gradWith g f = Rank1.gradWith g (runAD.f.fmap AD)
{-# INLINE gradWith #-}

gradWith' :: (Representable f, Eq (Rep f), Num a) => (a -> a -> b) -> (forall s. f (AD s (Repr f a)) -> AD s (Repr f a)) -> f a -> (a, f b)
gradWith' g f = Rank1.gradWith' g (runAD.f.fmap AD)
{-# INLINE gradWith' #-}

jacobian :: (Representable f, Eq (Rep f), Functor g, Num a) => (forall s. f (AD s (Repr f a)) -> g (AD s (Repr f a))) -> f a -> g (f a)
jacobian f = Rank1.jacobian (fmap runAD.f.fmap AD)
{-# INLINE jacobian #-}

jacobian' :: (Representable f, Eq (Rep f), Functor g, Num a) => (forall s. f (AD s (Repr f a)) -> g (AD s (Repr f a))) -> f a -> g (a, f a)
jacobian' f = Rank1.jacobian' (fmap runAD.f.fmap AD)
{-# INLINE jacobian' #-}

jacobianWith :: (Representable f, Eq (Rep f), Functor g, Num a) => (a -> a -> b) -> (forall s. f (AD s (Repr f a)) -> g (AD s (Repr f a))) -> f a -> g (f b)
jacobianWith g f = Rank1.jacobianWith g (fmap runAD.f.fmap AD)
{-# INLINE jacobianWith #-}

jacobianWith' :: (Representable f, Eq (Rep f), Functor g, Num a) => (a -> a -> b) -> (forall s. f (AD s (Repr f a)) -> g (AD s (Repr f a))) -> f a -> g (a, f b)
jacobianWith' g f = Rank1.jacobianWith' g (fmap runAD.f.fmap AD)
{-# INLINE jacobianWith' #-}
