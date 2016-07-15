require "json"

module Assemblyline
  class SystemPackages
    def initialize(options = {})
      @package_manager = options.fetch(:package_manager)
      @platform        = options.fetch(:platform)
      @packages        = options.fetch(:packages)
      @options         = options
    end

    def build
      dependencies("build")
    end

    def runtime
      dependencies("runtime")
    end

    private

    attr_reader :package_manager, :platform, :packages, :options

    def dependencies(context)
      detected = deps.map { |dep| dep[context] }.flatten
      explicit = options.fetch(context.intern, [])
      (detected + explicit).uniq.compact.sort
    end

    def deps
      packages.map do |pkg|
        data.select do |dep|
          pkg == dep["name"]
        end
      end.flatten
    end

    def data
      @data ||= JSON.parse(
        File.read(
          File.join(
            Gem.datadir("assemblyline"),
            package_manager,
            platform.name,
            platform.version,
            "dependencies.json",
          ),
        ),
      )
    end
  end
end
