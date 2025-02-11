module Test.Expect exposing (expectFailure, expectSuccess)

{-| Functions for asserting things about expectations.
-}

import Expect exposing (Expectation)
import Test.Runner


expectSuccess : Expectation -> Expectation
expectSuccess actualResult =
    case Test.Runner.getFailureReason actualResult of
        Nothing ->
            Expect.pass

        Just actualInfo ->
            Expect.fail ("expectSuccess: Expected a success, but got a failure:\n" ++ actualInfo.description)


expectFailure : List String -> Expectation -> Expectation
expectFailure expectedFailureMessage actualResult =
    case Test.Runner.getFailureReason actualResult of
        Nothing ->
            Expect.fail "Expected a failure, but got a pass"

        Just actualInfo ->
            actualInfo.description
                |> Expect.equal (String.join "\n" expectedFailureMessage)
