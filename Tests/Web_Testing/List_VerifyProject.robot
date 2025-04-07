*** Settings ***
Documentation   Script to list all project names and their IDs
Library         SeleniumLibrary
Library         Collections
Test Setup        open the browser with the url
Test Teardown    Close Browser
Resource        ../../Resources/Generic.resource
Resource        ../../Resources/LoginActions.resource

*** Variables ***
${PROJECT_MENU}     xpath=//*[@id="app"]/div[2]/div/aside/nav[4]/menu
${PROJECT_BTN}      css:.router-link-active.router-link-exact-active
${condition}      ${False}


*** Test Cases ***
List All Projects
    Fill the login form  ${user_name}        ${valid_password}
    Click on Projects
    ${project_list}=    List All Projects
    ${PROJECT_EXISTS}   Verify project exist in the list of projects        ${project_name}
    Delete Project If Exists      ${project_name}
    sleep for some time

*** Keywords ***
Click on Projects
    Wait Until Element Is Visible    ${PROJECT_BTN}     60s
    Click Element    ${PROJECT_BTN}

List All Projects
    Wait Until Element Is Visible    ${PROJECT_MENU}    60s
    ${project_count}=    Get Element Count    ${PROJECT_MENU}/li
    Log    Project Count: ${project_count}    console=True
    ${end_index}=    Evaluate    ${project_count} + 1
    FOR    ${index}    IN RANGE    1    ${end_index}
        Log    Index: ${index}    console=True
        ${project_id}=    Get Element Attribute    xpath=//*[@id="app"]/div[2]/div/aside/nav[4]/menu/li[${index}]    data-project-id
        ${project_title}=    Get Text    xpath=//*[@id="app"]/div[2]/div/aside/nav[4]/menu/li[${index}]//span[@class="project-menu-title"]
        Log    Project ID: ${project_id}, Project Title: ${project_title}    console=True
        Append To List    ${PROJECT_LIST}    ${project_title}
    END


Verify project exist in the list of projects
    [Arguments]    ${search_title}
    ${title_exists}=    Evaluate    "${search_title}" in ${PROJECT_LIST}
    Log    Project Title Exists    console=True
    Return From Keyword If    ${title_exists}    True
    Log    Project Title not Exists    console=True
    Return From Keyword    False


Delete Project If Exists
    [Arguments]    ${prj_name}
    Wait Until Element Is Visible    ${PROJECT_MENU}    60s
    ${project_count}=    Get Element Count    ${PROJECT_MENU}/li
    Log    Project Count: ${project_count}    console=True
    ${end_index}=    Evaluate    ${project_count} + 1
    FOR    ${index}    IN RANGE    1    ${end_index}
        Log    Index: ${index}    console=True
        ${project_id}=    Get Element Attribute    xpath=//*[@id="app"]/div[2]/div/aside/nav[4]/menu/li[${index}]    data-project-id
        ${project_title}=    Get Text    xpath=//*[@id="app"]/div[2]/div/aside/nav[4]/menu/li[${index}]//span[@class="project-menu-title"]
        Log    Project ID: ${project_id}, Project Title: ${project_title}    console=True
        IF    '$project_title' == '$prj_name'
            Log    Project Title Exists    console=True
            Mouse Over    xpath=//span[text()="${project_title}"]
            Click Element    css:.base-button.base-button--type-button.button.is-primary.has-no-shadow
        ELSE
            Log    Project Title not Exists    console=True
        END
    END



sleep for some time
    Sleep    10s