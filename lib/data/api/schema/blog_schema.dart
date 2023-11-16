class BlogSchema {
  static const String blogs = r'''
query blogs($first: Int!) {
  blogs(first: $first, reverse: true) {
    edges {
      node {
          id
          handle
          title
          authors {
              name
          }
          onlineStoreUrl
          articles(first: 10) {
              edges {
                  node {
                      title
                      content
                      contentHtml
                      onlineStoreUrl
                  }
              }
          }
      }
    }
    pageInfo {
      endCursor
      hasNextPage
      hasPreviousPage
      startCursor
    }
  }
}
''';
}
