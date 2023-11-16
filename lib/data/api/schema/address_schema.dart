class AddressSchema {
  static const String customerAddressCreate = r'''
mutation customerAddressCreate($address: MailingAddressInput!, $customerAccessToken: String!) {
  customerAddressCreate(address: $address, customerAccessToken: $customerAccessToken) {
    customerAddress {
      id
    }
    customerUserErrors {
      code
      field
      message
    }
  }
}

''';

  static const String customerAddressUpdate = r'''
mutation customerAddressUpdate($address: MailingAddressInput!, $customerAccessToken: String!, $id: ID!) {
  customerAddressUpdate(address: $address, customerAccessToken: $customerAccessToken, id: $id) {
    customerAddress {
      id
    }
    customerUserErrors {
      code
      field
      message
    }
  }
}

''';

  static const String customerAddressDelete = r'''
mutation customerAddressDelete($customerAccessToken: String!, $id: ID!) {
  customerAddressDelete(customerAccessToken: $customerAccessToken, id: $id) {
    customerUserErrors {
      code
      field
      message
    }
    deletedCustomerAddressId
  }
}

''';

  static const String getLocalizationList = r'''
query {
  localization {
      availableCountries {
          name
          currency {
              name
              symbol
              isoCode
          }
          isoCode
          unitSystem
          availableLanguages {
              name
              isoCode
              endonymName
          }
      }
  }
}

''';
}
