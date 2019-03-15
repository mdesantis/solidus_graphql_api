# frozen_string_literal: true
module Spree::GraphQL::Types::Comment

  # author: The comment’s author.
  # @return [Types::CommentAuthor!]
  def author()
    raise ::Spree::GraphQL::NotImplementedError.new
  end

  # content: Stripped content of the comment, single line with HTML tags removed.
  # @param truncate_at [Types::Int] (nil) Truncates string after the given length.
  # @return [Types::String!]
  def content(truncate_at:)
    raise ::Spree::GraphQL::NotImplementedError.new
  end

  # contentHtml: The content of the comment, complete with HTML formatting.
  # @return [Types::HTML!]
  def content_html()
    raise ::Spree::GraphQL::NotImplementedError.new
  end
end
