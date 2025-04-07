*** Settings ***
Documentation   Script to list all project names and their IDs
Library         SeleniumLibrary
Library         Collections
Test Setup        open the browser with the url
Test Teardown    Close Browser
Resource        ../Resources/LoginActions.robot
Resource        ../Resources/Generic.resource

*** Variables ***
${PROJECT_BUTTON}      xpath=//a[@href="/projects"]
${PROJECT_LINK}    xpath=//a[@href="/projects/new"]
${CreatePrj_BTN}    css:.base-button.base-button--type-button.button.is-primary.ml-2
${project_window}    css:.card.has-no-shadow.has-text-left
${PROJECT_TITLE}    xpath=//h1[@class="project-title"] 


*** Test Cases ***
List All Projects
    Fill the login form  ${user_name}        ${valid_password}
    Click on Projects
    Verify Project is shown   ${project_window}
    Input Project Title And Click Create    ${project_name}
    Verify Project is shown   ${PROJECT_TITLE}

    

*** Keywords ***
Click on Projects
    Wait Until Element Is Visible    ${PROJECT_BUTTON}       30s
    Click Element       ${PROJECT_BUTTON}
    Log    click project:   console=True
    Wait And Click Project Link    ${PROJECT_LINK}

Wait And Click Project Link
    [Arguments]    ${PROJECT}
    Wait Until Element Is Visible    ${PROJECT}    60s
    Click Element    ${PROJECT}
    
Verify Project is shown
    [Arguments]    ${Project_info}
    Wait Until Element Is Visible    ${Project_info}    20s
    Log    Project visible: ${Project_info}    console=True

Input Project Title And Click Create
    [Arguments]    ${project_name}
    Wait Until Element Is Visible    xpath=//input[@name="projectTitle"]    30s
    Input Text    xpath=//input[@name="projectTitle"]    ${project_name}
    Wait And Click Project Link  ${CreatePrj_BTN}
    Log    Project Created   console=True


