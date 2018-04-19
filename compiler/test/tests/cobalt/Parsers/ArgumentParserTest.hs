module Parsers.ArgumentParserTest where

import Test.HUnit
import Text.Megaparsec

import AST.Block
import Parsers.ExprParser

testArgumentParserIdentifier :: Test
testArgumentParserIdentifier = do
    let code = "Test"
    TestCase $ assertEqual code
        (Argument (BooleanExpr (Identifier "Test")))
        (case (parse (argumentParser) "" code) of
             Left  _ -> Error
             Right x -> x)

testArgumentParserBoolTrue :: Test
testArgumentParserBoolTrue = do
    let code = "True"
    TestCase $ assertEqual code
        (Argument (BooleanExpr $ BoolConst True))
        (case (parse (argumentParser) "" code) of
             Left  _ -> Error
             Right x -> x)

testArgumentParserBoolFalse :: Test
testArgumentParserBoolFalse = do
    let code = "False"
    TestCase $ assertEqual code
        (Argument (BooleanExpr $ BoolConst False))
        (case (parse (argumentParser) "" code) of
             Left  _ -> Error
             Right x -> x)

testArgumentParserObjectVar :: Test
testArgumentParserObjectVar = do
    let code = "anObject.variable"
    TestCase $ assertEqual code
        (Argument (ClassVariable "anObject" "variable"))
        (case (parse (argumentParser) "" code) of
             Left  _ -> Error
             Right x -> x)