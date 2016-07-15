require "spec_helper"
require "assemblyline/application"

RSpec.describe Assemblyline::Application do
  describe ".load" do
    it "loads all of the Assemblyfiles in scope" do
      expect(described_class.load.size).to eq(1)
    end
  end

  describe ".new" do
    subject { described_class.new("spec/fixture/Assemblyfile") }

    it "sets up the path correctly" do
      expect(subject.path).to eq("spec/fixture")
    end

    it "sets up the name correctly" do
      expect(subject.name).to eq("test-application")
    end

    it "sets up the repo correctly" do
      expect(subject.repo).to eq("quay.io/assemblyline/test-application")
    end

    it "sets up the builder correctly" do
      expect(subject.builder).to eq("ruby")
    end
  end
end
