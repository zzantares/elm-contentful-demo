module SampleResponses exposing (..)


authorResponse =
    """
{
    "fields": {
        "name": "Marcus Finninga"
    },
    "sys": {
        "contentType": {
            "sys": {
                "id": "1kUEViTN4EmGiEaaeC6ouY",
                "linkType": "ContentType",
                "type": "Link"
            }
        },
        "createdAt": "2017-06-28T01:00:43.822Z",
        "id": "5OeB0vkBd6AWqKMgG66kim",
        "locale": "en-US",
        "revision": 1,
        "space": {
            "sys": {
                "id": "2bhe30qv7l7b",
                "linkType": "Space",
                "type": "Link"
            }
        },
        "type": "Entry",
        "updatedAt": "2017-06-28T01:00:43.822Z"
    }
}
"""


entryResponse =
    """
{
    "fields": {
        "author": [
            {
                "sys": {
                    "id": "5OeB0vkBd6AWqKMgG66kim",
                    "linkType": "Entry",
                    "type": "Link"
                }
            }
        ],
        "body": "This is the simplest seven tip post you'll read for elm",
        "comments": false,
        "slug": "seven-tips-from-ernest-hemingway-on-how-to-write-fiction",
        "title": "Seven Tips From Ernest Hemingway on How to Write Fiction"
    },
    "sys": {
        "contentType": {
            "sys": {
                "id": "2wKn6yEnZewu2SCCkus4as",
                "linkType": "ContentType",
                "type": "Link"
            }
        },
        "createdAt": "2017-06-28T00:56:49.843Z",
        "id": "A96usFSlY4G0W4kwAqswk",
        "locale": "en-US",
        "revision": 2,
        "space": {
            "sys": {
                "id": "2bhe30qv7l7b",
                "linkType": "Space",
                "type": "Link"
            }
        },
        "type": "Entry",
        "updatedAt": "2017-06-28T01:00:51.104Z"
    }
}
"""


entriesResponse =
    """
{
    "includes": {
        "Asset": [
            {
                "fields": {
                    "file": {
                        "contentType": "image/gif",
                        "details": {
                            "image": {
                                "height": 610,
                                "width": 644
                            },
                            "size": 24238
                        },
                        "fileName": "alice-in-wonderland.gif",
                        "url": "//images.contentful.com/2bhe30qv7l7b/bXvdSYHB3Guy2uUmuEco8/9dd20cb9bcc9808e0eb19a180f16c362/alice-in-wonderland.gif"
                    },
                    "title": "Alice in Wonderland"
                },
                "sys": {
                    "createdAt": "2017-06-28T00:56:42.732Z",
                    "id": "bXvdSYHB3Guy2uUmuEco8",
                    "locale": "en-US",
                    "revision": 1,
                    "space": {
                        "sys": {
                            "id": "2bhe30qv7l7b",
                            "linkType": "Space",
                            "type": "Link"
                        }
                    },
                    "type": "Asset",
                    "updatedAt": "2017-06-28T00:56:42.732Z"
                }
            }
        ],
        "Entry": [
            {
                "fields": {
                    "name": "Marcus Finninga"
                },
                "sys": {
                    "contentType": {
                        "sys": {
                            "id": "1kUEViTN4EmGiEaaeC6ouY",
                            "linkType": "ContentType",
                            "type": "Link"
                        }
                    },
                    "createdAt": "2017-06-28T01:00:43.822Z",
                    "id": "5OeB0vkBd6AWqKMgG66kim",
                    "locale": "en-US",
                    "revision": 1,
                    "space": {
                        "sys": {
                            "id": "2bhe30qv7l7b",
                            "linkType": "Space",
                            "type": "Link"
                        }
                    },
                    "type": "Entry",
                    "updatedAt": "2017-06-28T01:00:43.822Z"
                }
            },
            {
                "fields": {
                    "title": "Off topic"
                },
                "sys": {
                    "contentType": {
                        "sys": {
                            "id": "5KMiN6YPvi42icqAUQMCQe",
                            "linkType": "ContentType",
                            "type": "Link"
                        }
                    },
                    "createdAt": "2017-06-29T17:23:17.239Z",
                    "id": "5asNcV4mQ02EqI0goGoQcE",
                    "locale": "en-US",
                    "revision": 1,
                    "space": {
                        "sys": {
                            "id": "2bhe30qv7l7b",
                            "linkType": "Space",
                            "type": "Link"
                        }
                    },
                    "type": "Entry",
                    "updatedAt": "2017-06-29T17:23:17.239Z"
                }
            }
        ]
    },
    "items": [
        {
            "fields": {
                "author": [
                    {
                        "sys": {
                            "id": "5OeB0vkBd6AWqKMgG66kim",
                            "linkType": "Entry",
                            "type": "Link"
                        }
                    }
                ],
                "body": "This is the simplest seven tip post you'll read for elm",
                "category": [
                    {
                        "sys": {
                            "id": "5asNcV4mQ02EqI0goGoQcE",
                            "linkType": "Entry",
                            "type": "Link"
                        }
                    }
                ],
                "comments": false,
                "slug": "seven-tips-from-ernest-hemingway-on-how-to-write-fiction",
                "title": "Seven Tips From Ernest Hemingway on How to Write Fiction"
            },
            "sys": {
                "contentType": {
                    "sys": {
                        "id": "2wKn6yEnZewu2SCCkus4as",
                        "linkType": "ContentType",
                        "type": "Link"
                    }
                },
                "createdAt": "2017-06-28T00:56:49.843Z",
                "id": "A96usFSlY4G0W4kwAqswk",
                "locale": "en-US",
                "revision": 3,
                "space": {
                    "sys": {
                        "id": "2bhe30qv7l7b",
                        "linkType": "Space",
                        "type": "Link"
                    }
                },
                "type": "Entry",
                "updatedAt": "2017-06-29T17:24:34.737Z"
            }
        },
        {
            "fields": {
                "author": [
                    {
                        "sys": {
                            "id": "5OeB0vkBd6AWqKMgG66kim",
                            "linkType": "Entry",
                            "type": "Link"
                        }
                    }
                ],
                "body": "Alice was beginning to get very tired of sitting by her sister on the bank, and of having nothing to do: once or twice she had peeped into the book her sister was reading, but it had no pictures or conversations in it, 'and what is the use of a book,' thought Alice 'without pictures or conversation?'",
                "category": [
                    {
                        "sys": {
                            "id": "5asNcV4mQ02EqI0goGoQcE",
                            "linkType": "Entry",
                            "type": "Link"
                        }
                    }
                ],
                "comments": false,
                "date": "1865-11-26",
                "featuredImage": {
                    "sys": {
                        "id": "bXvdSYHB3Guy2uUmuEco8",
                        "linkType": "Asset",
                        "type": "Link"
                    }
                },
                "slug": "down-the-rabbit-hole",
                "tags": [
                    "Literature",
                    "fantasy",
                    "children",
                    "novel",
                    "fiction",
                    "animals",
                    "rabbit",
                    "girl"
                ],
                "title": "Down the Rabbit Hole"
            },
            "sys": {
                "contentType": {
                    "sys": {
                        "id": "2wKn6yEnZewu2SCCkus4as",
                        "linkType": "ContentType",
                        "type": "Link"
                    }
                },
                "createdAt": "2017-06-28T00:56:49.850Z",
                "id": "1asN98Ph3mUiCYIYiiqwko",
                "locale": "en-US",
                "revision": 3,
                "space": {
                    "sys": {
                        "id": "2bhe30qv7l7b",
                        "linkType": "Space",
                        "type": "Link"
                    }
                },
                "type": "Entry",
                "updatedAt": "2017-06-29T17:24:18.410Z"
            }
        }
    ],
    "limit": 100,
    "skip": 0,
    "sys": {
        "type": "Array"
    },
    "total": 2
}
"""


spaceResponse =
    """
{
    "sys": {
        "type": "Space",
        "id": "71rop70dkqaj"
    },
    "name": "Documentation examples",
    "locales": [
         {
             "code": "en-US",
             "default": true,
             "name": "U.S. English",
             "fallbackCode": null
         }
    ]
}
"""
