*** Settings ***
Library  Selenium2Library
Library  Dialogs
Library  String


*** Variables ***
#string values
${FIVE_STAR_RATING_VALUE}           5
${REVIEW_TITLE_VALUE}               Cool Dress !
${REVIEW_CONTENT_VALUE}             I bought this dress for my wife, and she is very happy !


# locators
${PRODUCT_NAME}                         css=.pb-center-column.col-xs-12.col-sm-4>h1
${ADD_TO_CART_BUTTON}                   name=Submit
${MORE_BUTTON}                          css=.button.lnk_view.btn.btn-default
${WRITE_REVIEW_BUTTON}                  id=new_comment_tab_btn
${REVIEW_TITLE}                         id=comment_title
${STAR_RATING_PICKER}                   xpath=//div[@class='star_content']//a[@title='{placeholder}']
${REVIEW_CONTENT}                       id=content
${SEND_REVIEW_BUTTON}                   id=submitNewMessage
${REVIEW_CONFIRMATION_TEXT}             xpath=//div[@class='fancybox-inner']/p[1]
${REVIEW_CONFIRMATION_OK_BUTTON}        css=.button.btn-default.button-medium
${REVIEW_CONFIRMATION_POPUP}            css=.fancybox-inner
${SIZE_DROP_DOWN}                       id=group_1
${QUANTITY_FIELD}                       id=quantity_wanted
${QUANTITY_FIELD_VALUE}                 xpath=//input[@id='quantity_wanted']@value
${QUANTITY_MINUS_ICON}                  css=.icon-minus
${QUANTITY_PLUS_ICON}                   css=.icon-plus
${WISHLIST_BUTTON}                      id=wishlist_button
${WISHLIST_CONFIRMATION_POPUP_TEXT}     css=.fancybox-error
${WISHLIST_CLOSE_CONFIRMATION_BUTTON}   css=.fancybox-item.fancybox-close
${VIEW_LARGER_BUTTON}                   css=.span_link.no-print
${IMAGE_THUMBNAIL}                      //img[starts-with(@id,'thumb')]
${NEXT_IMAGE_ICON}                      css=.fancybox-nav.fancybox-next>span
${IMAGE_RIGHT_SECTION}                  css=.fancybox-nav.fancybox-next
${FULL_SIZE_IMAGE}                      css=.fancybox-nav.fancybox-next
${COLOUR_PICKER}                        xpath=//ul[@id="color_to_pick_list"]//a[@title="{placeholder}"]





*** Keywords ***
Verify Page is Loaded for Product ${product}
    Wait Until Element Is Visible  ${PRODUCT_NAME}
    Element Text Should Be  ${PRODUCT_NAME}  ${product}


Add to Shopping Cart
    Wait Until Element Is Visible  ${ADD_TO_CART_BUTTON}
    Click Button  ${ADD_TO_CART_BUTTON}


Click 'Write Review' Button
    Wait Until Element Is Visible  ${WRITE_REVIEW_BUTTON}
    Click Element  ${WRITE_REVIEW_BUTTON}


Select Star Rating
    [Arguments]  ${stars}
    ${star_locator} =  Replace String  ${STAR_RATING_PICKER}  {placeholder}  ${stars}
    Wait Until Element Is Visible  ${star_locator}
    Click Element  ${star_locator}


Enter Review Title
    [Arguments]  ${title}
    Wait Until Element Is Visible  ${REVIEW_TITLE}
    Input Text  ${REVIEW_TITLE}  ${title}


Enter Review Content
    [Arguments]  ${content}
    Wait Until Element Is Visible  ${REVIEW_CONTENT}
    Input Text  ${REVIEW_CONTENT}  ${content}


Submit The Review
    Wait Until Element Is Visible  ${SEND_REVIEW_BUTTON}
    Click Button  ${SEND_REVIEW_BUTTON}


Verify Review Submitted Successfully
    Wait Until Element Is Visible  ${REVIEW_CONFIRMATION_TEXT}
    Element Text Should Be  ${REVIEW_CONFIRMATION_TEXT}  Your comment has been added and will be available once approved by a moderator


Click 'Ok' On Review Confirmation Popup
    Click Button  ${REVIEW_CONFIRMATION_OK_BUTTON}
    Element Should Not Be Visible  ${REVIEW_CONFIRMATION_POPUP}


Select Size Value
    [Arguments]  ${size}
    Wait Until Element Is Visible  ${SIZE_DROP_DOWN}
    Select From List By Label  ${SIZE_DROP_DOWN}  ${size}


Enter Quantity Value
    [Arguments]  ${quantity}
    Wait Until Element Is Visible  ${QUANTITY_FIELD}
    Input Text  ${QUANTITY_FIELD}  ${quantity}


Click Quantity 'Plus' icon
    Wait Until Element Is Visible  ${QUANTITY_PLUS_ICON}
    Click Element  ${QUANTITY_PLUS_ICON}


Click Quantity 'Minus' icon
    Wait Until Element Is Visible  ${QUANTITY_MINUS_ICON}
    Click Element  ${QUANTITY_MINUS_ICON}


Click 'Add to wishlist'
    Wait Until Element Is Visible  ${WISHLIST_BUTTON}
    Click Link  ${WISHLIST_BUTTON}


Verify 'Wishlist Confirmation Popup' Displayed
    Wait Until Element Is Visible  ${WISHLIST_CONFIRMATION_POPUP_TEXT}
    Element Text Should Be  ${WISHLIST_CONFIRMATION_POPUP_TEXT}  Added to your wishlist.


Page is unlocked
    [Documentation]  This keyword is to support waiting until page is unlocked after closing 'Add to wishlist' popup
    ${attr} =  Get Element Attribute  css=html@class
    Should Be Equal As Strings  ${attr}  ${EMPTY}
    # left for demo
    # Log To Console  ${\n}
    # Log To Console  ${attr}


Close 'Wishlist Confirmation Popup'
    Wait Until Element Is Visible  ${WISHLIST_CLOSE_CONFIRMATION_BUTTON}
    Click Link  ${WISHLIST_CLOSE_CONFIRMATION_BUTTON}
    # In DOM, html tag has 'class' attribute with empty value: html class=""
    # when you click 'Add to wishlist', the whole page gets locked and 'class' attribue takes new value - class="fancybox-margin fancybox-lock".
    # to make sure the page is unlocked - you need to wait until 'class' attribute again has value class=""
    Wait Until Keyword Succeeds  10 sec  0.2 sec  Page Is Unlocked


Click 'View Larger' button
    Wait Until Element Is Visible  ${VIEW_LARGER_BUTTON}
    Click Element  ${VIEW_LARGER_BUTTON}
    Wait Until Element Is Visible  ${FULL_SIZE_IMAGE}


Get Count Of Images
    # don't use 'xpath=' with this keyword
    ${count} =  Get Matching Xpath Count  ${IMAGE_THUMBNAIL}
    [Return]  ${count}


View Next Image
    Wait Until Element Is Visible  ${IMAGE_RIGHT_SECTION}
    Mouse Over  ${IMAGE_RIGHT_SECTION}
    Wait Until Element Is Visible  ${NEXT_IMAGE_ICON}
    Click Element  ${NEXT_IMAGE_ICON}
    Wait Until Element Is Visible  ${FULL_SIZE_IMAGE}
    Element Should Be Visible  ${FULL_SIZE_IMAGE}


Select Colour Value
    [Arguments]  ${colour}
    ${locator} =  Replace String  ${COLOUR_PICKER}  {placeholder}  ${colour}
    Click Element  ${locator}





