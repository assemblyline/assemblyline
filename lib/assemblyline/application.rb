require "toml"
require "assemblyline/system_packages"
require "assemblyline/platform"
require "bundler"

module Assemblyline
  class Application
    def self.load
      Dir.glob("**/Assemblyfile*").map { |path| new(path) }
    end

    def initialize(path)
      @path = File.dirname(path)
      @assemblyfile = TOML.load_file(path)
    end

    attr_reader :path, :assemblyfile

    def name
      assemblyfile["application"].fetch("name")
    end

    def repo
      assemblyfile["application"].fetch("repo")
    end

    def install
      ["bundle install -j4 -r3 --deployment"]
    end

    def system_packages
      @_system_packages ||= SystemPackages.new(
        package_manager: "rubygems",
        platform: platform,
        packages: packages,
        build:    builddeps,
      )
    end

    def packages
      lockfile.specs.map(&:name)
    end

    def builddeps
      return [] unless lockfile.sources.any? { |source| source.is_a? Bundler::Source::Git }
      ["git"]
    end

    def lockfile
      @_lockfile ||= Bundler::LockfileParser.new(File.read(File.join(path, "Gemfile.lock")))
    end

    def platform
      Platform.new
    end
  end
end
