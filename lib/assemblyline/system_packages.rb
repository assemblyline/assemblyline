require "json"

module Assemblyline
  class SystemPackages
    def initialize(package_manager:, platform:, version:, packages:)
      @package_manager = package_manager
      @platform = platform
      @version = version
      @packages = packages
    end

    def build
      dependencies("build")
    end

    def run
      dependencies("run")
    end

    private

    attr_reader :package_manager, :platform, :packages, :version

    def dependencies(context)
      deps.map { |dep| dep[context] }.flatten.uniq.compact.sort
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
            platform,
            version,
            "dependencies.json",
          ),
        ),
      )
    end
  end
end
