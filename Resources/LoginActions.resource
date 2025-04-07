*** Settings ***
Documentation        Resource file with reusable keywords and variables
Library        SeleniumLibrary

*** Variables ***
${url}    http://99.79.54.41:3456/login
${api_url}    http://99.79.54.41:3456/api/v1
${user_name}           sree
${valid_password}      T3st12345
${wrong_password}      Test1232322
${Error_Message_Login}    css:.message.danger
${Welcome_Message}        css:h2[data-v-ae1a1185]


*** Keywords ***
open the browser with the url
    Create Webdriver    Chrome
    Go to    ${url}
    Maximize Browser Window
    Wait Until Element Is Visible    id:api-url    10s
    Clear Element Text    id:api-url
    Input Text    id:api-url    ${api_url}
    Click Element    css:.base-button.base-button--type-button.button.is-primary

Fill the login form
    [Arguments]    ${username}    ${password}
    Wait Until Element Is Visible    id:username    10s
    Input Text    id:username    ${username}
    Input Text    id:password    ${password}
    Click Element    css:.base-button.base-button--type-button.button.is-primary

Wait until it checks message
    [Arguments]     ${Message_Login}
    Wait Until Element Is Visible    ${Message_Login}    10s