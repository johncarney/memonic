require "spec_helper"
require "memonic"

describe Memonic do
  shared_context "memoize the result" do
    before do
      allow(memoizer).to receive(:computation).and_call_original
    end

    it "returns the computation result on the first call" do
      expect(memoizer.value).to be result
    end

    it "returns the same result on subsequent calls" do
      memoizer.value
      expect(memoizer.value).to be result
    end

    it "invokes the computation only once" do
      2.times { memoizer.value }
      expect(memoizer).to have_received(:computation).once
    end
  end

  shared_context "a memoizer" do
    let(:memoizer) { memoizer_class.new(result) }

    context "with a truthy result" do
      let(:result) { Object.new }

      it_will "memoize the result"
    end

    context "with a nil result" do
      let(:result) { nil }

      it_will "memoize the result"
    end

    context "with a false result" do
      let(:result) { false }

      it_will "memoize the result"
    end
  end

  describe ".memoize" do
    let(:memoizer_class) do
      Struct.new(:computation) do
        include Memonic

        memoize :value do
          computation
        end
      end
    end

    let(:memoizer) { memoizer_class.new(result) }

    it_behaves_like "a memoizer"
  end

  describe "#memoize" do
    let(:memoizer_class) do
      Struct.new(:computation) do
        include Memonic

        def value
          memoize(:@value) { computation }
        end
      end
    end

    it_behaves_like "a memoizer"
  end
end
