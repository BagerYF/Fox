class LoginSchema {
  static const String customerCreate = r'''
mutation customerCreate($input: CustomerCreateInput!) {
  customerCreate(input: $input) {
    customerUserErrors {
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

  static const String customerAccessTokenCreate = r'''
mutation customerAccessTokenCreate($input: CustomerAccessTokenCreateInput!) {
  customerAccessTokenCreate(input: $input) {
    customerUserErrors {
      code
      field
      message
    }
    customerAccessToken {
      accessToken
      expiresAt
    }
  }
}

''';

  static const String customer = r'''
query customer($customerAccessToken: String!) {
  customer(customerAccessToken: $customerAccessToken) {
    id
    acceptsMarketing
    displayName
    email
    firstName
    lastName
    phone
    addresses(first: 100) {
      edges {
          node {
            id
            address1
            address2
            city
            country
            countryCodeV2
            firstName
            lastName
            name
            phone
            province
            provinceCode
            zip
          }
      }
    }
    orders(first: 100) {
      edges {
          node {
            id
            orderNumber
            processedAt
            email
            name
            phone
            originalTotalPrice  {
              amount
              currencyCode
            }
            subtotalPriceV2  {
              amount
              currencyCode
            }
            totalPriceV2  {
              amount
              currencyCode
            }
            totalShippingPriceV2  {
              amount
              currencyCode
            }
            totalTaxV2  {
              amount
              currencyCode
            }
            currentSubtotalPrice {
              amount
              currencyCode
            }
            currentTotalPrice {
              amount
              currencyCode
            }
            currentTotalTax {
              amount
              currencyCode
            }
            shippingAddress {
              id
              address1
              address2
              city
              country
              countryCodeV2
              firstName
              lastName
              name
              phone
              province
              provinceCode
              zip
            }
            processedAt
            lineItems(first: 100) {
              edges {
                  node {
                    variant {
                      image {
                        url
                      }
                      title
                      price {
                        amount
                        currencyCode
                      }
                      selectedOptions {
                        name
                        value
                      }
                      product {
                        productType
                      }
                    }
                    title
                    quantity
                    originalTotalPrice  {
                      amount
                      currencyCode
                    }
                  }
              }
            }
          }
      }
    }
  }
}
''';
}
