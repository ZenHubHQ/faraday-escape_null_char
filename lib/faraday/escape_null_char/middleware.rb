# frozen_string_literal: true

module Faraday
  module EscapeNullChar
    # This class provides the main implementation for your middleware.
    # Your middleware can implement any of the following methods:
    # * on_request - called when the request is being prepared
    # * on_complete - called when the response is being processed
    #
    # Optionally, you can also override the following methods from Faraday::Middleware
    # * initialize(app, options = {}) - the initializer method
    # * call(env) - the main middleware invocation method.
    #   This already calls on_request and on_complete, so you normally don't need to override it.
    #   You may need to in case you need to "wrap" the request or need more control
    #   (see "retry" middleware: https://github.com/lostisland/faraday/blob/main/lib/faraday/request/retry.rb#L142).
    #   IMPORTANT: Remember to call `@app.call(env)` or `super` to not interrupt the middleware chain!
    class Middleware < Faraday::Middleware
      # This method will be called when the request is being prepared.
      # You can alter it as you like, accessing things like request_body, request_headers, and more.
      # Refer to Faraday::Env for a list of accessible fields:
      # https://github.com/lostisland/faraday/blob/main/lib/faraday/options/env.rb
      #
      # @param env [Faraday::Env] the environment of the request being processed
      def on_request(env)
        # Do something with the request environment...
        # This method is optional.
      end

      # This method will be called when the response is being processed.
      # You can alter it as you like, accessing things like response_body, response_headers, and more.
      # Refer to Faraday::Env for a list of accessible fields:
      # https://github.com/lostisland/faraday/blob/main/lib/faraday/options/env.rb
      #
      # @param env [Faraday::Env] the environment of the response being processed.
      def on_complete(env)
        # Do something with the response environment...
        # This method is optional.
      end

      def call(environment)
        @app.call(environment).on_complete do |env|
          self.class.escape_str(env[:body])
        end
      end
  
      def self.escape_str(str)
        str.gsub!(/(\\+)u0000/) do |match|
          first_group = Regexp.last_match(1)
          first_group.length.odd? ? "\\#{match}" : match
        end
      end
    end
  end
end
