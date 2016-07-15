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
      assemblyfile = TOML.load_file(path)
      @name = assemblyfile["application"].fetch("name")
      @repo = assemblyfile["application"].fetch("repo")
    end

    attr_reader :path, :name, :repo

    def install
      ["bundle install -j4 -r3 --deployment"]
    end

    def system_packages
      @_system_packages ||= SystemPackages.new(
        package_manager: "rubygems",
        platform: platform,
        packages: packages,
      )
    end

    def packages
      Bundler::LockfileParser.new(File.read(File.join(path, "Gemfile.lock"))).specs.map(&:name)
    end

    def platform
      Platform.new
    end
  end
end
