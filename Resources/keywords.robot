*** Settings ***
Resource            ../Resources/PO/HomePage.robot
Resource            ../Resources/PO/Search.robot
Resource            ../Resources/PO/SignIn.robot
Resource            ../Resources/PO/MyAccount.robot


*** Keywords ***
Navigate To Home Page
    HomePage.Load
    HomePage.Verify Page Loaded

Sign In
    [Arguments]  ${email}  ${password}
    Navigate To Home Page
    HomePage.Click Sign In Link
    SignIn.Verify Page Loaded
    SignIn.Enter Email  ${email}
    SignIn.Enter Password  ${password}
    SignIn.Submit Credentials

Sign Out
    MyAccount.Click Sign Out Link
    SignIn.Verify Page Loaded

Invalid Sign In
    [Arguments]  ${email}  ${password}
    Sign In  ${email}  ${password}
    Verify Invalid Credentials Message

Verify Successful Sign In
    MyAccount.Verify Page Loaded

Verify Successful Sign Out
    Signin.Verify Page Loaded

Verify Email Required Message
    SignIn.Validation Message Should Be  ${EMAIL_REQUIRED_MSQ}

Verify Password Required Message
    SignIn.Validation Message Should Be  ${PASSWORD_REQUIRED_MSG}

Verify Empty Credentials Message
    SignIn.Validation Message Should Be  ${EMAIL_REQUIRED_MSQ}

Verify Invalid Credentials Message
    SignIn.Validation Message Should Be  ${INVALID_CRED_MSG}





Verify Empty Search Message
    Search.Verify Empty Search Message

Verify No Search Results Message
    Search.Verify No Search Results Message

Verify Search Results
    [Arguments]  ${message}  ${count}

