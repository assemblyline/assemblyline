require "toml"

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
      @builder = assemblyfile["application"].fetch("builder")
    end

    attr_reader :path, :name, :repo, :builder
  end
end
