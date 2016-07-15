require "spec_helper"
require "assemblyline/system_packages"

RSpec.describe Assemblyline::SystemPackages do
  subject { described_class.new(package_manager: "rubygems", platform: "alpine", version: "3.4", packages: packages) }
  let(:packages) { [] }

  context "with a listed package" do
    let(:packages) { ["pg"] }

    it "lists the build deps" do
      expect(subject.build).to eq ["build-base", "postgresql-dev"]
    end

    context "and some unlisted ones" do
      let(:packages) { %w(pg rake) }

      it "lists the build deps" do
        expect(subject.build).to eq ["build-base", "postgresql-dev"]
      end
    end

    context "no explicit rundeps" do
      it "empty run deps" do
        expect(subject.run).to eq []
      end
    end
  end

  context "with different deps" do
    let(:packages) { %w(json rake) }

    it "lists the build deps" do
      expect(subject.build).to eq ["build-base"]
    end
  end

  context "with no deps" do
    let(:packages) { ["rake"] }

    it "lists the build deps" do
      expect(subject.build).to eq []
    end
  end
end
