# elm-contentful : Simple GUI feeded by contentful content in Elm!

This attempts to be a simple GUI application that reads content
from [Contentful](https://contentful.com/).

## Getting started

In order to make this work you'll need three things:

### 1. Space ID

When you create your account in contentful you'll be given a Space, this is
where all of your content models and content types reside, to find out what your
space ID is please follow this steps:

- Go to [Contentful](https://app.contentful.com/).
- In the navigation menu go to `APIs`.
- From the list click on your API name (e.g. `Test Api`).
- Under the `Access Tokens` area you'll find out the `Space ID`.


### 2. Access Token

Your space is given an Authorization token that should be used in all requests
made to contentful, you're given two access tokens, one for the *Content Delivery
API* and one for the *Content Preview API*, for this sample application does not
matter which one you use but I recommend using the *CDA Access Token*. In order
to get it please follow this steps:

- Go to [Contentful](https://app.contentful.com/).
- In the navigation menu go to `APIs`.
- From the list click on your API name (e.g. `Test Api`).
- Under the `Access Tokens` area you'll find out the `Content Delivery API Access Token`.

### 3. Post content type ID

In this simple application we try to fetch content type that matches a blog
post type, when requesting entries from contentful we get all the content types found
in your space and some of them will not have all the fields expected by elm to
display them as a blog post, this is why we need to know the content type ID of
your "blog post" content type. To get this ID please follow this steps:

- Go to [Contentful](https://app.contentful.com/).
- In the navigation menu go to `Content Model`.
- From the list select your *post content type* (e.g. Post).
- In the sidebar you'll find the `Content Type ID`.


## Configuration

Once you have the three required tokens/ids place them in the `Auth.elm` file
like this:

```elm
module Auth exposing (spaceId, accessToken)

spaceId =
    "2bhe3lqv0l7o"

accessToken =
    "h7e65d3fa81437c017c7i2288a4c1cfac9fa22o70603dd39778889580e240142"

postContentTypeId =
    "1vNf6iFeZewu2ZCX9usYlo"
```

Please note that the keys shown above are for demonstration purposes only and
they won't work for you, you need to get them out from your Contentful account,
refer to the *Getting started* section for instructions in how to do this.

The `Auth.elm` file has been added to the `.gitignore` file, this means that if
you ever commit changes to this repo your API Keys will not be exposed by mistake.
