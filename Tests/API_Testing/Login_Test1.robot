*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    BuiltIn


*** Variables ***
${base-url}        http://99.79.54.41:3456
${Login_endpoint}    /api/v1/login
${user_name}           sree
${valid_password}      T3st12345


*** Test Cases ***
List All Projects
    Login with valid credentials
    Verify all Projects user has access to

*** Keywords ***

Login with valid credentials
    [Documentation]    Test to validate login
    Create Session    mysession        ${base-url}
    ${body}=    Create Dictionary    username=${user_name}    password=${valid_password}
    ${body_json}=    Evaluate    json.dumps(${body})    json
    Log    Request Body: ${body_json}    console=True
    ${header}=    Create Dictionary    Content-Type=application/json
    Log    Request Headers: ${header}    console=True
    ${response}=    POST On Session    mysession    ${Login_endpoint}    data=${body_json}    headers=${header}
    Log    Response Status Code: ${response.status_code}    console=True
    Log    Response Body: ${response.content}    console=True
    Should Be Equal As Strings    ${response.status_code}    200
    ${Token}=    Get From Dictionary    ${response.json()}    token
    Log    ${Token}    console=True
    Set Suite Variable    ${Token}



Verify all Projects user has access to
    [Documentation]    Test to verify all projects user has access to
    Create Session    my_session        ${base-url}
    ${header}=    Create Dictionary    Authorization=Bearer ${Token}
    ${response}=    GET On Session    my_session    /api/v1/projects    headers=${header}
    Log    Response Status Code: ${response.status_code}    console=True
    Log    Response Body: ${response.content}    console=True
    Should Be Equal As Strings    ${response.status_code}    200