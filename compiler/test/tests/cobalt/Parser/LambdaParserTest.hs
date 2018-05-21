module Parser.LambdaParserTest where

import Test.HUnit

import TestUtil.ParserTestUtil
import AST.AST
import Parser.Parser

testLambdaParser :: Test
testLambdaParser = do

    let codeInline = "fun x -> x"
    let testInline = testParseSuccess codeInline (Lambda [Field {fieldName = Name "x", fieldType = Nothing, fieldInit = Nothing}] (Inline (Identifier (Name "x")))) statementParser

    let codeInlineType = "fun (x:Int) -> x"
    let testInlineType = testParseSuccess codeInlineType (Lambda [Field {fieldName = Name "x", fieldType = Just (TypeRef (RefLocal (Name "Int"))), fieldInit = Nothing}] (Inline (Identifier (Name "x")))) statementParser

    let codeInlineMultiple = "fun (x,y,z) -> x"
    let testInlineMultiple = testParseSuccess codeInlineMultiple (Lambda [Field {fieldName = Name "x", fieldType = Nothing, fieldInit = Nothing},Field {fieldName = Name "y", fieldType = Nothing, fieldInit = Nothing},Field {fieldName = Name "z", fieldType = Nothing, fieldInit = Nothing}] (Inline (Identifier (Name "x")))) statementParser

    let codeInlineTypeMultiple = "fun (x:Int, y:Int, z:Int) -> x"
    let testInlineTypeMultiple = testParseSuccess codeInlineTypeMultiple (Lambda [Field {fieldName = Name "x", fieldType = Just (TypeRef (RefLocal (Name "Int"))), fieldInit = Nothing},Field {fieldName = Name "y", fieldType = Just (TypeRef (RefLocal (Name "Int"))), fieldInit = Nothing},Field {fieldName = Name "z", fieldType = Just (TypeRef (RefLocal (Name "Int"))), fieldInit = Nothing}] (Inline (Identifier (Name "x")))) statementParser

    let codeDoBlock = unlines [ "fun x -> do"
                              , "    x"
                              , "    y"
                              ]
    let testDoBlock = testParseSuccess codeDoBlock (Lambda [Field {fieldName = Name "x", fieldType = Nothing, fieldInit = Nothing}] (DoBlock $ BlockStmt [ExprAsStmt (Identifier (Name "x")),ExprAsStmt (Identifier (Name "y"))])) statementParser

    let codeDoBlockType = unlines [ "fun (x:Int) -> do"
                              , "    x"
                              , "    y"
                              ]
    let testDoBlockType = testParseSuccess codeDoBlockType (Lambda [Field {fieldName = Name "x", fieldType = Just (TypeRef (RefLocal (Name "Int"))), fieldInit = Nothing}] (DoBlock $ BlockStmt [ExprAsStmt (Identifier (Name "x")),ExprAsStmt (Identifier (Name "y"))])) statementParser

    let codeDoBlockMultiple = unlines [ "fun (x,y,z) -> do"
                              , "    x"
                              , "    y"
                              ]
    let testDoBlockMultiple = testParseSuccess codeDoBlockMultiple (Lambda [Field {fieldName = Name "x", fieldType = Nothing, fieldInit = Nothing},Field {fieldName = Name "y", fieldType = Nothing, fieldInit = Nothing},Field {fieldName = Name "z", fieldType = Nothing, fieldInit = Nothing}] (DoBlock $ BlockStmt [ExprAsStmt (Identifier (Name "x")),ExprAsStmt (Identifier (Name "y"))])) statementParser

    let codeDoBlockTypeMultiple = unlines [ "fun (x:Int, y: Int, z: Int) -> do"
                              , "    x"
                              , "    y"
                              ]
    let testDoBlockTypeMultiple = testParseSuccess codeDoBlockTypeMultiple (Lambda [Field {fieldName = Name "x", fieldType = Just (TypeRef (RefLocal (Name "Int"))), fieldInit = Nothing},Field {fieldName = Name "y", fieldType = Just (TypeRef (RefLocal (Name "Int"))), fieldInit = Nothing},Field {fieldName = Name "z", fieldType = Just (TypeRef (RefLocal (Name "Int"))), fieldInit = Nothing}] (DoBlock $ BlockStmt [ExprAsStmt (Identifier (Name "x")),ExprAsStmt (Identifier (Name "y"))])) statementParser

    TestList [ testInline
             , testInlineType
             , testDoBlock
             , testDoBlockType
             , testInlineMultiple
             , testInlineTypeMultiple
             , testDoBlockMultiple
             , testDoBlockTypeMultiple
             ]
