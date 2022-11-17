# frozen_string_literal: true

require_relative 'escape_null_char/middleware'
require_relative 'escape_null_char/version'

module Faraday
  # This will be your middleware main module, though the actual middleware implementation will go
  # into Faraday::EscapeNullChar::Middleware for the correct namespacing.
  module EscapeNullChar
    # Faraday allows you to register your middleware for easier configuration.
    # This step is totally optional, but it basically allows users to use a
    # custom symbol (in this case, `:escape_null_char`), to use your middleware in their connections.
    # After calling this line, the following are both valid ways to set the middleware in a connection:
    # * conn.use Faraday::EscapeNullChar::Middleware
    # * conn.use :escape_null_char
    # Without this line, only the former method is valid.
    Faraday::Middleware.register_middleware(escape_null_char: Faraday::EscapeNullChar::Middleware)

    # Alternatively, you can register your middleware under Faraday::Request or Faraday::Response.
    # This will allow to load your middleware using the `request` or `response` methods respectively.
    #
    # Load middleware with conn.request :escape_null_char
    # Faraday::Request.register_middleware(escape_null_char: Faraday::EscapeNullChar::Middleware)
    #
    # Load middleware with conn.response :escape_null_char
    # Faraday::Response.register_middleware(escape_null_char: Faraday::EscapeNullChar::Middleware)
  end
end
