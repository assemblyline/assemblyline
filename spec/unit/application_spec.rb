require "spec_helper"
require "assemblyline/application"

RSpec.describe Assemblyline::Application do
  subject { described_class.new("spec/fixture/basic/Assemblyfile") }

  describe ".load" do
    it "loads all of the Assemblyfiles in scope" do
      expect(described_class.load.size).to eq(2)
    end
  end

  describe ".new" do
    it "sets up the path correctly" do
      expect(subject.path).to eq("spec/fixture/basic")
    end

    it "sets up the name correctly" do
      expect(subject.name).to eq("test-application")
    end

    it "sets up the repo correctly" do
      expect(subject.repo).to eq("quay.io/assemblyline/test-application")
    end
  end

  describe "#system_packages" do
    it "lists the required build and runtime packages" do
      expect(subject.system_packages.build).to eq ["build-base", "postgresql-dev"]
      expect(subject.system_packages.runtime).to eq []
    end
  end

  describe "#install" do
    it "returns the commands to install the application" do
      expect(subject.install).to eq ["bundle install -j4 -r3 --deployment"]
    end
  end

  context "git source" do
    subject { described_class.new("spec/fixture/git/Assemblyfile") }
    it "adds git to the build packages" do
      expect(subject.system_packages.build).to include "git"
    end
  end
end
