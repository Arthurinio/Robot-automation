*** Settings ***
Library  Selenium2Library


*** Variables ***
# credentials
${VALID_EMAIL}              arthur.m1199@gmail.com
${VALID_PASSWORD}           ArtPass123!
${INVALID_EMAIL}            arthur.m1199@gmail.co
${INVALID_PASSWORD}         ArtPass1

# string values
${SIGN_IN_PAGE_TITLE}          Login - My Store
${EMAIL_REQUIRED_MSQ}       An email address required.
${PASSWORD_REQUIRED_MSG}    Password is required.
${INVALID_CRED_MSG}         Authentication failed.

# locators
${EMAIL_FIELD}              id=email
${PASSWORD_FIELD}           id=passwd
${SIGN_IN_BUTTON}           id=SubmitLogin
${VALIDATION_MSG}           css=.alert.alert-danger>ol>li


*** Keywords ***
Verify Page Loaded
    Title Should Be  ${SIGN_IN_PAGE_TITLE}

Enter Email
    [Arguments]  ${email}
    Input Text  ${EMAIL_FIELD}  ${email}

Enter Password
    [Arguments]  ${password}
    Input Password  ${PASSWORD_FIELD}  ${password}

Submit Credentials
    Click Button  ${SIGN_IN_BUTTON}

Validation Message Should Be
    [Arguments]  ${message}
    Element Text Should Be  ${VALIDATION_MSG}  ${message}