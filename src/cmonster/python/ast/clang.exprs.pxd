# vim: set filetype=pyrex:

# Copyright (c) 2011 Andrew Wilkins <axwalk@gmail.com>
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from clang.statements cimport Stmt
from clang.types cimport QualType
from clang.decls cimport ValueDecl
from llvm cimport APInt

cdef extern from "clang/AST/OperationKinds.h" namespace "clang":
    cdef enum UnaryOperatorKind:
        UO_PostInc
        UO_PostDec
        UO_PreInc
        UO_PreDec
        UO_AddrOf
        UO_Deref
        UO_Plus
        UO_Minus
        UO_Not
        UO_LNot
        UO_Real
        UO_Imag
        UO_Extension

cdef extern from "clang/AST/Expr.h" namespace "clang::CastExpr":
    cdef enum CastKind:
        pass

cdef extern from "clang/AST/Expr.h" namespace "clang":
    cdef cppclass Expr(Stmt):
        QualType getType()

    cdef cppclass CastExpr(Expr):
        CastKind getCastKind()
        char* getCastKindName()
        Expr* getSubExpr()

    cdef cppclass DeclRefExpr(Expr):
        ValueDecl* getDecl()

    cdef cppclass ImplicitCastExpr(CastExpr):
        pass

    cdef cppclass IntegerLiteral(Expr):
        APInt getValue()

    cdef cppclass UnaryOperator(Expr):
        UnaryOperatorKind getOpcode()
        Expr* getSubExpr()

