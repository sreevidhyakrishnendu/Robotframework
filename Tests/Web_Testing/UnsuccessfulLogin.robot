*** Settings ***
Documentation   Test to validate homepage actions
Library           SeleniumLibrary
Test Setup        open the browser with the url
Test Teardown    Close Browser
Resource        ../Resources/LoginActions.robot


*** Test Cases ***
Validate UnSuccessful Login
    Fill the login form   ${user_name}        ${wrong_password}
    Wait until it checks message        ${Error_Message_Login}
    verify Unsuccessful message is correct
#    sleep for some time



*** Keywords ***

#Wait until it checks and display error message
#    Wait Until Element Is Visible    ${Error_Message_Login}    10s

verify Unsuccessful message is correct
    ${result}=    Get Text    ${Error_Message_Login}
    Should Be Equal As Strings    ${result}    Wrong username or password.



#sleep for some time
#    Sleep    10s
