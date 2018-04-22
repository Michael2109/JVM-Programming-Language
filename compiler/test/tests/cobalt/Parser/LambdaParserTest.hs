module Parser.LambdaParserTest where

import Test.HUnit
import Text.Megaparsec

import AST.AST
import Parser.ExprParser

testLambdaParser :: Test
testLambdaParser = do

    let codeInline = "fun x -> x"
    let testInline = TestCase $ assertEqual codeInline
                    (Lambda (Identifier $ Name "x") Nothing (Block [Identifier $ Name "x"]))
                    (case (parse (lambdaParser) "" codeInline) of
                         Left  e -> error $ show e
                         Right x -> x)

    let codeInlineType = "fun (x:Int) -> x"
    let testInlineType = TestCase $ assertEqual codeInlineType
                    (Lambda (Identifier (Name "x")) (Just (TypeRef (RefLocal (Name "Int")))) (Block [Identifier (Name "x")]))
                    (case (parse (lambdaParser) "" codeInlineType) of
                         Left  e -> error $ show e
                         Right x -> x)

    let codeInlineMultiple = "fun x y z -> x"
    let testInlineMultiple = TestCase $ assertEqual codeInlineMultiple
                    (Lambda (Identifier $ Name "x") Nothing (Block [Identifier $ Name "x"]))
                    (case (parse (lambdaParser) "" codeInlineMultiple) of
                         Left  e -> error $ show e
                         Right x -> x)

    let codeInlineTypeMultiple = "fun (x:Int, y: Int, z: Int) -> x"
    let testInlineTypeMultiple = TestCase $ assertEqual codeInlineTypeMultiple
                    (Lambda (Identifier (Name "x")) (Just (TypeRef (RefLocal (Name "Int")))) (Block [Identifier (Name "x")]))
                    (case (parse (lambdaParser) "" codeInlineTypeMultiple) of
                         Left  e -> error $ show e
                         Right x -> x)

    let codeDoBlock = unlines [ "fun x -> do"
                              , "    x"
                              , "    y"
                              , ""
                              ]
    let testDoBlock = TestCase $ assertEqual codeDoBlock
                    (Lambda (Identifier (Name "x")) Nothing (Block [Identifier (Name "x"),Identifier (Name "y")]))
                    (case (parse (lambdaParser) "" codeDoBlock) of
                         Left  e -> error $ show e
                         Right x -> x)

    let codeDoBlockType = unlines [ "fun (x:Int) -> do"
                              , "    x"
                              , "    y"
                              , ""
                              ]
    let testDoBlockType = TestCase $ assertEqual codeDoBlockType
                    (Lambda (Identifier (Name "x")) (Just (TypeRef (RefLocal (Name "Int")))) (Block [Identifier (Name "x"),Identifier (Name "y")]))
                    (case (parse (lambdaParser) "" codeDoBlockType) of
                         Left  e -> error $ show e
                         Right x -> x)

    let codeDoBlockMultiple = unlines [ "fun x y z -> do"
                              , "    x"
                              , "    y"
                              , ""
                              ]
    let testDoBlockMultiple = TestCase $ assertEqual codeDoBlockMultiple
                    (Lambda (Identifier (Name "x")) Nothing (Block [Identifier (Name "x"),Identifier (Name "y")]))
                    (case (parse (lambdaParser) "" codeDoBlockMultiple) of
                         Left  e -> error $ show e
                         Right x -> x)

    let codeDoBlockTypeMultiple = unlines [ "fun (x:Int, y: Int, z: Int) -> do"
                              , "    x"
                              , "    y"
                              , ""
                              ]
    let testDoBlockTypeMultiple = TestCase $ assertEqual codeDoBlockTypeMultiple
                    (Lambda (Identifier (Name "x")) (Just (TypeRef (RefLocal (Name "Int")))) (Block [Identifier (Name "x"),Identifier (Name "y")]))
                    (case (parse (lambdaParser) "" codeDoBlockTypeMultiple) of
                         Left  e -> error $ show e
                         Right x -> x)

    TestList [testInline, testInlineType, testDoBlock, testDoBlockType]