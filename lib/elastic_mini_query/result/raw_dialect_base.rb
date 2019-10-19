require_relative "raw_dialect_v00"
require_relative "raw_dialect_v71"

module ElasticMiniQuery
  module Result
    class RawDialectBase
      class << self
        def dialector(version)
          case version
          when :latest
            return RawDialectV00.new
          else
          end
        end
      end
    end
  end
end
