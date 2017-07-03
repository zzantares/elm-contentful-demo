# elm-contentful : Simple GUI feeded by contentful content in Elm!

This attempts to be a simple GUI application that reads content
from [Contentful](https://contentful.com/).

## Getting started

In order to make this work you'll need to fill in the following things:

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

### 4. Personal Token

In order to create content via API we need to use the CMA (Content Management
API), this API uses a different token for authentication, you can generate your
personal token by following this steps:

- Go to [Contentful](https://app.contentful.com/).
- In the navigation menu go to `APIs`.
- Select the tab `Content Management Tokens`.
- Click on `Generate personal token` and input a name of your choice in the
  given field.
- Copy the generated token as you will only be able to see just once.

### 5. Author content type ID

In order to correctly manage authors you need to specify the ID of the content
type that matches your "Author" model. To get this ID follow this steps:

- Go to [Contentful](https://app.contentful.com/).
- In the navigation menu go to `Content Model`.
- From the list select your *author content type* (e.g. Author).
- In the sidebar you'll find the `Content Type ID`.

### 6. Default author ID

When an Post entry is submitted with no Author selected the post will be assigned
to the Author matching this ID, if you don't choose one entries will be created
but not published. To find an author ID follow this steps:

- Go to [Contentful](https://app.contentful.com/).
- In the navigation menu go to `Content`.
- From the list select your desired *author entry* (e.g. Marcus Finnigan).
- In the sidebar up right corner clice the `Info` button.
- In the now visible sidebar you'll see the `Entry ID`, this is the field you want.

## Configuration

Once you have these required tokens/ids place them in the `Auth.elm` file
like this:

```elm
module Auth exposing (spaceId, accessToken)

spaceId =
    "2bhe3lqv0l7o"

accessToken =
    "h7e65d3fa81437c017c7i2288a4c1cfac9fa22o70603dd39778889580e240142"

postContentTypeId =
    "1vNf6iFeZewu2ZCX9usYlo"

personalToken =
    "LFFPT-s9dcdc0f0b91b98bp5ff4190e06addedc2896fe4ced199v063bcee1144abd13b"

defaultAuthorId =
    "0MqB0vkBp6AWqKMgG66kja"

authorContentTypeId =
    "3nUEViTN4EmGiEaxeK6zuU"
```

Please note that the keys shown above are for demonstration purposes only and
they won't work for you, you need to get them out from your Contentful account,
refer to the *Getting started* section for instructions in how to do this.

The `Auth.elm` file has been added to the `.gitignore` file, this means that if
you ever commit changes to this repo your API Keys will not be exposed by mistake.
