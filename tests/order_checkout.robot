*** Settings ***
Resource            ../resources/common.robot
Resource            ../resources/keywords/search_kw.robot
Resource            ../resources/keywords/order_checkout_kw.robot
Test Setup          Begin Web Test
Test Teardown       End Web Test


# robot -d results tests/order_checkout.robot



*** Variables ***
${URL} =  http://automationpractice.com/index.php
${BROWSER} =  Firefox


*** Test Cases ***
User is able to add a product to 'Shopping Cart' from 'Product Details'
    Sign In  ${VALID_EMAIL}  ${VALID_PASSWORD}
    Search and Add To Shopping Cart  ruffled dress
    Search  ${SIMPLE_TERM}
    Proceed to 'Product Details'
    Add Product to Shopping Cart
    Proceed to Order Checkout
    Verify Product Is In Shopping Cart  ${SIMPLE_TERM}


User is able to add a product to Shopping Cart from Search Results
    Sign In  ${VALID_EMAIL}  ${VALID_PASSWORD}
    Search  ${SIMPLE_TERM}
    Add Product to Shopping Cart from 'Search results'
    Verify 'Added to Cart' Confirmation Message


User is able to add a product to Shopping Cart from Quick View
    Sign In  ${VALID_EMAIL}  ${VALID_PASSWORD}
    Search  ${SIMPLE_TERM}
    Add Product to Shopping Cart from 'Quick View'
    Verify 'Added to Cart' Confirmation Message


User is able to remove a product from Shopping Cart
    Sign In  ${VALID_EMAIL}  ${VALID_PASSWORD}
    Search and Add To Shopping Cart  ruffled dress
    Search  ${SIMPLE_TERM}
    Proceed to 'Product Details'
    Add Product to Shopping Cart
    Proceed to Order Checkout
    Remove Product From Shopping Cart  ${SIMPLE_TERM}
    Verify Product Is Not In Shopping Cart  ${SIMPLE_TERM}
#
User is able to checkout a product
    Sign In  ${VALID_EMAIL}  ${VALID_PASSWORD}
    Search  ${SIMPLE_TERM}
    Proceed to 'Product Details'
    Add To Shopping Cart
    Proceed to Order Checkout
    Checkout The Order
    Verify Order Checkout Completed Successfully


User is not able to checkout a product without accepting 'Terms of service'
    Sign In  ${VALID_EMAIL}  ${VALID_PASSWORD}
    Search  ${SIMPLE_TERM}
    Proceed to 'Product Details'
    Add To Shopping Cart
    Proceed to Order Checkout
    Checkout The Order and Do Not Accept 'Terms of service'
    Verify User Is Not Allowed To Proceed To Payment


User is able to read 'Terms of service'
    Sign In  ${VALID_EMAIL}  ${VALID_PASSWORD}
    Search  ${SIMPLE_TERM}
    Proceed to 'Product Details'
    Add To Shopping Cart
    Proceed to Order Checkout
    Proceed to 'Order Shipping'
    Open 'Terms of service'
    Verify 'Terms of service' is opened successfully


User is able to specify quantity when buying a product
    Sign In  ${VALID_EMAIL}  ${VALID_PASSWORD}
    Search  ${SIMPLE_TERM}
    Proceed to 'Product Details'
    Enter Product Quantity  3
    Add To Shopping Cart
    Proceed to Order Checkout
    Proceed to 'Order Payment'
    Verify Product Quantity Is  3


User is able to increase quantity when buying a product
    Sign In  ${VALID_EMAIL}  ${VALID_PASSWORD}
    Search  ${SIMPLE_TERM}
    Proceed to 'Product Details'
    Increase Quantity By One
    Add To Shopping Cart
    Proceed to Order Checkout
    Proceed to 'Order Payment'
    Verify Product Quantity Is  2


User is able to decrease quantity when buying a product
    Sign In  ${VALID_EMAIL}  ${VALID_PASSWORD}
    Search  ${SIMPLE_TERM}
    Proceed to 'Product Details'
    Enter Product Quantity  3
    Decrease Quantity By One
    Add To Shopping Cart
    Proceed to Order Checkout
    Proceed to 'Order Payment'
    Verify Product Quantity Is  2


User is able to specify size when buying a product
    Sign In  ${VALID_EMAIL}  ${VALID_PASSWORD}
    Search  ${SIMPLE_TERM}
    Proceed to 'Product Details'
    Select Product Size  M
    Add To Shopping Cart
    Proceed to Order Checkout
    Proceed to 'Order Payment'
    Verify Product Size Is  M


User is able to specify colour when buying a product
    Sign In  ${VALID_EMAIL}  ${VALID_PASSWORD}
    Search  ${SIMPLE_TERM}
    Proceed to 'Product Details'
    Select Product Colour  White
    Add To Shopping Cart
    Proceed to Order Checkout
    Proceed to 'Order Payment'
    Verify Product Colour Is  White


User is able to choose 'Pay by bank wire' payment method
    Sign In  ${VALID_EMAIL}  ${VALID_PASSWORD}
    Search  ${SIMPLE_TERM}
    Proceed to 'Product Details'
    Add To Shopping Cart
    Proceed to Order Checkout
    Proceed to 'Order Payment'
    Select 'Pay by bank wire' Payment Method
    Verify Payment Method Is  Bank-wire payment.


User is able to choose 'Pay by check' payment method
    Sign In  ${VALID_EMAIL}  ${VALID_PASSWORD}
    Search  ${SIMPLE_TERM}
    Proceed to 'Product Details'
    Add To Shopping Cart
    Proceed to Order Checkout
    Proceed to 'Order Payment'
    Select 'Pay by check' Payment Method
    Verify Payment Method Is  Check payment


'Product Total Price' is calculated correctly
    Sign In  ${VALID_EMAIL}  ${VALID_PASSWORD}
    Search and Add To Shopping Cart  ruffled dress
    Search  ${SIMPLE_TERM}
    Proceed to 'Product Details'
    Enter Product Quantity  45
    Add To Shopping Cart
    Proceed to Order Checkout
    Proceed to 'Order Payment'
    Verify Product Total Price is Calculated Correctly  ${SIMPLE_TERM}


'Order Total Price' is calculated correctly
    Sign In  ${VALID_EMAIL}  ${VALID_PASSWORD}
    Search  ${SIMPLE_TERM}
    Proceed to 'Product Details'
    Add To Shopping Cart
    Proceed to Order Checkout
    Proceed to 'Order Payment'
    Verify Order Total Price is Calculated Correctly


User is able to create a shipping address
    Sign In  ${VALID_EMAIL}  ${VALID_PASSWORD}
    Go To 'My Addresses'
    Create A Shipping Address  TestAddress1
    Verify Shipping Address Is Created  TestAddress1
    # clear test results
    Delete Shipping Address  TestAddress1


User is able to delete a shipping address
    Sign In  ${VALID_EMAIL}  ${VALID_PASSWORD}
    Go To 'My Addresses'
    # create a shipping address to delete later
    Create A Shipping Address  TestAddress2
    Delete Shipping Address  TestAddress2
    Verify Shipping Address Is Deleted  TestAddress2


User without shipping address is able to add an address and proceed to checkout
    Sign In  ${VALID_EMAIL}  ${VALID_PASSWORD}
    Go To 'My Addresses'
    Delete All Shipping Addresses
    Search  ${SIMPLE_TERM}
    Proceed to 'Product Details'
    Add To Shopping Cart
    Proceed to Order Checkout
    Proceed to 'Order Address'
    Enter Shipping Address Values and Submit  MainAddress
    Verify Shipping Address Is Created  MainAddress
    Checkout The Order From Address
    Verify Order Checkout Completed Successfully


User is able to select shipping address add proceed to checkout
    Sign In  ${VALID_EMAIL}  ${VALID_PASSWORD}
    Go To 'My Addresses'
    Create A Shipping Address  TestAddress3
    Search  ${SIMPLE_TERM}
    Proceed to 'Product Details'
    Add To Shopping Cart
    Proceed to Order Checkout
    Proceed to 'Order Address'
    Select Shipping Address  TestAddress3
    Verify Shipping Address Is Selected  TestAddress3
    Checkout The Order From Address
    Verify Order Checkout Completed Successfully
    Proceed To 'My Account'
    Go To 'My Addresses'
    Delete Shipping Address  TestAddress3
    Verify Shipping Address Is Deleted  TestAddress3


Logged out user is prompted to login when trying to checkout a product
    # no sign in
    Search  ${SIMPLE_TERM}
    Proceed to 'Product Details'
    Add To Shopping Cart
    Proceed to Order Checkout
    Proceed to 'Order Address'
    User Is Prompted to Sign In
    Sign In and Proceed to 'Checkout Address'
    Checkout The Order From Address
    Verify Order Checkout Completed Successfully


Logged out user is able to login and checkout a product
    # no sign in
    Search  ${SIMPLE_TERM}
    Proceed to 'Product Details'
    Add To Shopping Cart
    Proceed to Order Checkout
    Proceed to 'Order Address'
    User Is Prompted to Sign In
    Sign In and Proceed to 'Checkout Address'
    Checkout The Order From Address
    Verify Order Checkout Completed Successfully