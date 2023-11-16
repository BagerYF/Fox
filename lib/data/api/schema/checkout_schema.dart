class CheckoutSchemas {
  static const String checkoutCommonFragment = r'''
    id
    webUrl
    lineItems(first: 5) {
      edges {
        node {
          id
          title
          quantity
        }
      }
    }
    currencyCode
    paymentDueV2 {
      amount
      currencyCode    
    }
    subtotalPriceV2 {
      amount
      currencyCode
    }
    totalPriceV2 {
      amount
      currencyCode
    }
    totalTaxV2 {
      amount
      currencyCode
    }
    totalDuties {
      amount
      currencyCode
    }
    lineItemsSubtotalPrice {
      amount
      currencyCode
    }
    taxExempt
    taxesIncluded
''';

  static const String checkoutCreate = '''
mutation checkoutCreate(\$input: CheckoutCreateInput!) {
  checkoutCreate(input: \$input) {
    checkout {
      $checkoutCommonFragment
    }
    checkoutUserErrors {
      code
      field
      message
    }
    queueToken
  }
}
''';

  static const String checkoutShippingAddressUpdate = '''
mutation checkoutShippingAddressUpdateV2(\$checkoutId: ID!, \$shippingAddress: MailingAddressInput!) {
  checkoutShippingAddressUpdateV2(checkoutId: \$checkoutId, shippingAddress: \$shippingAddress) {
    checkout {
      $checkoutCommonFragment
      availableShippingRates {
        ready
        shippingRates {
          handle
          priceV2 {
            amount
            currencyCode
          }
          title
        }
      }
    }
    checkoutUserErrors {
      code
      field
      message
    }
  }
}

''';

  static const String checkoutShippingLines = '''
query checkoutShippingLines(\$id: ID!) {
  node(id: \$id) {
    ... on Checkout {
      id
      webUrl
      availableShippingRates {
        ready
        shippingRates {
          handle
          priceV2 {
            amount
            currencyCode
          }
          title
        }
      }
    }
  }
}
''';

  static const String checkoutShippingLineUpdate = '''
mutation checkoutShippingLineUpdate(\$checkoutId: ID!, \$shippingRateHandle: String!) {
  checkoutShippingLineUpdate(checkoutId: \$checkoutId, shippingRateHandle: \$shippingRateHandle) {
    checkout {
      $checkoutCommonFragment
      availableShippingRates {
        ready
        shippingRates {
          handle
          priceV2 {
            amount
            currencyCode
          }
          title
        }
      }
      shippingLine {
        handle
        priceV2 {
          amount
          currencyCode
        }
        title
      }
    }
    checkoutUserErrors {
      code
      field
      message
    }
  }
}
''';

  static const String checkoutDiscountCodeApplyV2 = '''
mutation checkoutDiscountCodeApplyV2(\$checkoutId: ID!, \$discountCode: String!) {
  checkoutDiscountCodeApplyV2(checkoutId: \$checkoutId, discountCode: \$discountCode) {
    checkout {
      $checkoutCommonFragment
      availableShippingRates {
        ready
        shippingRates {
          handle
          priceV2 {
            amount
            currencyCode
          }
          title
        }
      }
      shippingLine {
        handle
        priceV2 {
          amount
          currencyCode
        }
        title
      }
    }
    checkoutUserErrors {
      code
      field
      message
    }
  }
}

''';

  static const String checkoutDiscountCodeRemove = '''
mutation checkoutDiscountCodeRemove(\$checkoutId: ID!) {
  checkoutDiscountCodeRemove(checkoutId: \$checkoutId) {
    checkout {
      $checkoutCommonFragment
      availableShippingRates {
        ready
        shippingRates {
          handle
          priceV2 {
            amount
            currencyCode
          }
          title
        }
      }
      shippingLine {
        handle
        priceV2 {
          amount
          currencyCode
        }
        title
      }
    }
    checkoutUserErrors {
      code
      field
      message
    }
  }
}

''';

  static const String checkoutCustomerAssociateV2 = '''
mutation checkoutCustomerAssociateV2(\$checkoutId: ID!, \$customerAccessToken: String!) {
  checkoutCustomerAssociateV2(checkoutId: \$checkoutId, customerAccessToken: \$customerAccessToken) {
    checkout {
      $checkoutCommonFragment
      availableShippingRates {
        ready
        shippingRates {
          handle
          priceV2 {
            amount
            currencyCode
          }
          title
        }
      }
      shippingLine {
        handle
        priceV2 {
          amount
          currencyCode
        }
        title
      }
    }
    checkoutUserErrors {
      code
      field
      message
    }
    customer {
      id
    }
  }
}

''';

  static const String checkoutCompleteFree = '''
mutation checkoutCompleteFree(\$checkoutId: ID!) {
  checkoutCompleteFree(checkoutId: \$checkoutId) {
    checkout {
      $checkoutCommonFragment
      availableShippingRates {
        ready
        shippingRates {
          handle
          priceV2 {
            amount
            currencyCode
          }
          title
        }
      }
      shippingLine {
        handle
        priceV2 {
          amount
          currencyCode
        }
        title
      }
    }
    checkoutUserErrors {
      code
      field
      message
    }
  }
}

''';

  static const String checkoutCompleteWithCreditCardV2 = '''
mutation checkoutCompleteWithCreditCardV2(\$checkoutId: ID!, \$payment: CreditCardPaymentInputV2!) {
  checkoutCompleteWithCreditCardV2(checkoutId: \$checkoutId, payment: \$payment) {
    checkout {
      $checkoutCommonFragment
      availableShippingRates {
        ready
        shippingRates {
          handle
          priceV2 {
            amount
            currencyCode
          }
          title
        }
      }
      shippingLine {
        handle
        priceV2 {
          amount
          currencyCode
        }
        title
      }
    }
    checkoutUserErrors {
      code
      field
      message
    }
    payment {
      id
    }
  }
}

''';
}
