*** Settings ***
Documentation   Test to validate homepage actions
Library           SeleniumLibrary
Test Setup        open the browser with the url
Test Teardown    Close Browser
Resource        ../Resources/LoginActions.robot


#Resource        ../Resources/Variables.robot

*** Test Cases ***
Validate Successful Login
    Fill the login form  ${user_name}        ${valid_password}
    Wait until it checks message        ${Welcome_Message}
    verify landing message is correct
    #sleep for some time


*** Keywords ***
verify landing message is correct
    ${welcome_text}=    Get Text    ${Welcome_Message}
    Should Be Equal As Strings    ${welcome_text}    Hi ${user_name}!