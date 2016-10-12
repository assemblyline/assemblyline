require "json"

module Assemblyline
  class SystemPackages
    def build
      dependencies("build")
    end

    def runtime
      dependencies("runtime")
    end

    private

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

    def packages
      lockfile.specs.map(&:name)
    end

    def lockfile
      @_lockfile ||= Bundler::LockfileParser.new(File.read("Gemfile.lock"))
    end


    def data
      @data ||= JSON.parse(File.read("/etc/a10e/dependencies.json"))
    end
  end
end
