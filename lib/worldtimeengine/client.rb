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

      timezone_hash = HTTParty.get("#{endpoint}/api/ip/#{api_key}/#{ip}", :format => :xml).to_hash['timezone']
      timezone_hash.delete('xmlns:xsi')
      timezone_hash.delete('xsi:noNamespaceSchemaLocation')

      Hashie::Mash.new(timezone_hash).tap do |mash|
        mash.time.utc = Time.parse "#{mash.time.utc} UTC"
        mash.time.local = Time.parse "#{mash.time.local} #{mash.time.zone.current.abbreviation} #{mash.time.zone.current.utcoffset}"

        mash.location.latitude = mash.location.latitude.to_f
        mash.location.longitude = mash.location.longitude.to_f

        mash.time.zone.has_dst = to_boolean mash.time.zone.hasDST

        mash.time.zone.current.is_dst = to_boolean mash.time.zone.current.isdst
        mash.time.zone.current.utc_offset = mash.time.zone.current.utcoffset
        mash.time.zone.current.effective_until = Time.parse "#{mash.time.zone.current.effectiveUntil} #{mash.time.zone.current.abbreviation} #{mash.time.zone.current.utcoffset}"

        mash.time.zone.next.is_dst = to_boolean mash.time.zone.next.isdst
        mash.time.zone.next.utc_offset = mash.time.zone.next.utcoffset
        mash.time.zone.next.effective_until = Time.parse "#{mash.time.zone.next.effectiveUntil} #{mash.time.zone.next.abbreviation} #{mash.time.zone.next.utcoffset}"
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
