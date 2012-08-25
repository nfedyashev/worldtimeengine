module WorldTimeEngine
  module Configurable
    attr_writer :api_key
    attr_accessor :endpoint

    class << self

      def keys
        @keys ||= [
          :api_key,
          :endpoint
        ]
      end

    end

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
      self
    end

    # @return [Boolean]
    def credentials?
      credentials.values.all?
    end

    def reset!
      @api_key = nil
      @endpoint = 'http://worldtimeengine.com'
      self
    end
    alias setup reset!

  private

    # @return [Hash]
    def credentials
      { :api_key => @api_key }
    end

    # @return [Hash]
    def options
      Hash[WorldTimeEngine::Configurable.keys.map{|key| [key, instance_variable_get(:"@#{key}")]}]
    end
  end
end
