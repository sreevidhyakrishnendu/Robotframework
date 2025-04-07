*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    BuiltIn



*** Test Cases ***
List All Projects
    Login with valid credentials
    Verify all Projects user has access to