class Spree::GraphQL::Schema::Types::Image < Spree::GraphQL::Schema::Types::BaseObject
  graphql_name 'Image'
  description %q{Represents an image resource.}
  include ::Spree::GraphQL::Types::Image
  field :alt_text, ::GraphQL::Types::String, null: true do
    description %q{A word or phrase to share the nature or contents of an image.}
  end
  field :id, ::GraphQL::Types::ID, null: true do
    description %q{A unique identifier for the image.}
  end
  field :original_src, ::Spree::GraphQL::Schema::Types::URL, null: false do
    description %q{The location of the original image as a URL.

If there are any existing transformations in the original source URL, they will remain and not be stripped.
}
  end
  field :src, ::Spree::GraphQL::Schema::Types::URL, null: false, deprecation_reason: %q{Previously an image had a single `src` field. This could either return the original image
location or a URL that contained transformations such as sizing or scale.

These transformations were specified by arguments on the parent field.

Now an image has two distinct URL fields: `originalSrc` and `transformedSrc`.

* `originalSrc` - the original unmodified image URL
* `transformedSrc` - the image URL with the specified transformations included

To migrate to the new fields, image transformations should be moved from the parent field to `transformedSrc`.

Before:
```graphql
{
  shop {
    productImages(maxWidth: 200, scale: 2) {
      edges {
        node {
          src
        }
      }
    }
  }
}
```

After:
```graphql
{
  shop {
    productImages {
      edges {
        node {
          transformedSrc(maxWidth: 200, scale: 2)
        }
      }
    }
  }
}
```
} do
    description %q{The location of the original (untransformed) image as a URL.}
  end
  field :transformed_src, ::Spree::GraphQL::Schema::Types::URL, null: false do
    description %q{The location of the transformed image as a URL.

All transformation arguments are considered "best-effort". If they can be applied to an image, they will be.
Otherwise any transformations which an image type does not support will be ignored.
}
    argument :max_width, ::GraphQL::Types::Int, required: false, default_value: nil, description: %q{Image width in pixels between 1 and 5760.}
    argument :max_height, ::GraphQL::Types::Int, required: false, default_value: nil, description: %q{Image height in pixels between 1 and 5760.}
    argument :crop, ::Spree::GraphQL::Schema::Types::CropRegion, required: false, default_value: nil, description: %q{Crops the image according to the specified region.}
    argument :scale, ::GraphQL::Types::Int, required: false, default_value: 1, description: %q{Image size multiplier for high-resolution retina displays. Must be between 1 and 3.}
    argument :preferred_content_type, ::Spree::GraphQL::Schema::Types::ImageContentType, required: false, default_value: nil, description: %q{Best effort conversion of image into content type (SVG -> PNG, Anything -> JGP, Anything -> WEBP are supported).}
  end
end
