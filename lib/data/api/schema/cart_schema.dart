class CartSchema {
  static const String cartCommonFragment = r'''
fragment CartCommon on Cart {
  id
  totalQuantity
    createdAt
    updatedAt
    lines(first: 10) {
      edges {
        node {
          id
          quantity
          cost {
            totalAmount {
              amount
              currencyCode
            }
            subtotalAmount {
              amount
              currencyCode
            }
          }
          merchandise {
            ... on ProductVariant {
              id
              compareAtPrice {
                  amount
                  currencyCode
              }
              title
              price {
                  amount
                  currencyCode
              }
              quantityAvailable
              image {
                  id
                  url
              }
              priceV2 {
                  amount
                  currencyCode
              }
              product{
                  title
                  vendor
                  productType
              }
            }
          }
          attributes {
            key
            value
          }
        }
      }
    }
    attributes {
      key
      value
    }
    cost {
      totalAmount {
        amount
        currencyCode
      }
      subtotalAmount {
        amount
        currencyCode
      }
      totalTaxAmount {
        amount
        currencyCode
      }
      totalDutyAmount {
        amount
        currencyCode
      }
    }
    buyerIdentity {
      email
      phone
      customer {
        id
      }
      countryCode
    }
}
''';

  static const String queryCart = '''
query queryCart(\$id: ID!) {
  cart(id: \$id) {
    ...CartCommon
  }
}
$cartCommonFragment
''';

  static const String createCart = '''
mutation createCart(\$input: CartInput!){
  cartCreate (input: \$input) {
    cart{
      ...CartCommon
    }
  }
}
$cartCommonFragment
''';

  static const String addProductsToCart = '''
mutation addProductsToCart(\$cartId: ID!, \$lines: [CartLineInput!]!){
  cartLinesAdd(cartId: \$cartId, lines: \$lines) {
    cart{
      ...CartCommon
    }
  }
}
$cartCommonFragment
''';

  static const String updateProductQuantityInCart = '''
mutation updateProductQuantityInCart(\$cartId: ID!, \$lines: [CartLineUpdateInput!]!){
  cartLinesUpdate(cartId: \$cartId, lines: \$lines) {
    cart{
      ...CartCommon
    }
  }
}
$cartCommonFragment
''';

  static const String removeProductFromCart = '''
mutation removeProductFromCart(\$cartId: ID!, \$lineIds: [ID!]!){
  cartLinesRemove(cartId: \$cartId, lineIds: \$lineIds) {
    cart{
      ...CartCommon
    }
  }
}
$cartCommonFragment
''';
}
