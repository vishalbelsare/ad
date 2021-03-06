{-# LANGUAGE CPP #-}

#define MODULE \
module Numeric.AD.Rank1.Kahn.Double

#define AD_EXPORT KahnDouble

#define IMPORTS \
import Numeric.AD.Internal.Kahn (Kahn); \
import qualified Numeric.AD.Rank1.Kahn as Kahn; \
import Numeric.AD.Internal.Kahn.Double

#define UNBINDWITH unbindWithUArray
#define GRAD Kahn.grad
#define JACOBIAN Kahn.jacobian

#define AD_TYPE KahnDouble
#define SCALAR_TYPE Double
#define BASE0_1(x)
#define BASE1_1(x,y) x
#define BASE2_1(x,y,z) (x,y)
#include "rank1_kahn.h"
