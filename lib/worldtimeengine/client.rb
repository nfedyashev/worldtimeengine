require 'httparty'
require 'hashie'
require 'worldtimeengine/configurable'

module WorldTimeEngine
  # Wrapper for the WorldTimeEngine API
  class Client
    #include WorldTimeEngine::API
    include WorldTimeEngine::Configurable

    # Initializes a new Client object
    #
    # @return [WorldTimeEngine::Client]
    def initialize(options={})
    end

    # Perform an HTTP GET request
    def get(path, params={}, options={})
      request(:get, path, params, options)
    end

    def api(ip)
      endpoint = WorldTimeEngine.instance_variable_get(:@endpoint)
      api_key = WorldTimeEngine.instance_variable_get(:@api_key)

      timezone_hash = HTTParty.get("#{endpoint}/api/ip/#{api_key}/#{ip}").to_hash['timezone']
      timezone_hash.delete('xmlns:xsi')
      timezone_hash.delete('xsi:noNamespaceSchemaLocation')

      Hashie::Mash.new(timezone_hash).tap do |mash|

        mash.time.utc = to_time mash.time.utc
        mash.time.local = to_time mash.time.local

        mash.location.latitude = mash.location.latitude.to_f
        mash.location.longitude = mash.location.longitude.to_f

        mash.time.zone.has_dst = to_boolean mash.time.zone.hasDST

        mash.time.zone.current.is_dst = to_boolean mash.time.zone.current.isdst
        mash.time.zone.current.utc_offset = mash.time.zone.current.utcoffset
        mash.time.zone.current.effective_until = to_time mash.time.zone.current.effectiveUntil

        mash.time.zone.next.is_dst = to_boolean mash.time.zone.next.isdst
        mash.time.zone.next.utc_offset = mash.time.zone.next.utcoffset
        mash.time.zone.next.effective_until = to_time mash.time.zone.next.effectiveUntil
      end
    end

    private

      def to_time(string)
        Time.parse string
      end

      def to_boolean(string)
        string == 'true' ? true : false
      end
  end
end
