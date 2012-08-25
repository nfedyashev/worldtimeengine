require 'worldtimeengine/client'
require 'worldtimeengine/configurable'

module WorldTimeEngine
  class << self
    include WorldTimeEngine::Configurable

    # Delegate to a WorldTimeEngine::Client
    #
    # @return [WorldTimeEngine::Client]
    def client
      if @client
        @client
      else
        @client = WorldTimeEngine::Client.new(options)
      end
    end

  private

    def method_missing(method_name, *args, &block)
      return super unless client.respond_to?(method_name)
      client.send(method_name, *args, &block)
    end

  end
end

WorldTimeEngine.setup
