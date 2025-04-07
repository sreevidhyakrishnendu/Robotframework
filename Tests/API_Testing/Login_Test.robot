*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    BuiltIn
Resource    ../../Resources/LoginActions.resource
Resource    ../../Resources/commonapi.resource

*** Variables ***
${Login_endpoint}    /api/v1/login


*** Test Cases ***
List All Projects
    Login with valid credentials
#    Verify all Projects user has access to

*** Keywords ***

Login with valid credentials
    [Documentation]    Test to validate login
    Create Session    mysession        ${base-url}
    ${body}=    Create Dictionary    username=${user_name}    password=${valid_password}
    ${header}=    Create Dictionary    Content-Type=application/json
    ${response}=    Post Request                mysession       ${Login_endpoint}     data=${body}    headers=${header}
    Should Be Equal As Strings    ${response.status_code}    200
    Log    Response:${response}    console=True
    ${Token}=    Get From Dictionary    ${response.json()}    token
    Log    ${Token}    console=True



