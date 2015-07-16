require "spec_helper"
require "memonic"

describe Memonic do
  describe ".memoize" do
    let(:klass) do
      Struct.new(:computation) do
        include Memonic

        memoize :value do
          computation
        end
      end
    end

    let(:instance) { klass.new(result) }

    before do
      allow(instance).to receive(:computation).and_call_original
    end

    context "with a truthy result" do
      let(:result) { Object.new }

      it "returns the computation result" do
        expect(instance.value).to be result
      end

      it "invokes the computation only once" do
        2.times { instance.value }
        expect(instance).to have_received(:computation).once
      end
    end

    context "with a nil result" do
      let(:result) { nil }

      it "returns the computation result" do
        expect(instance.value).to be result
      end

      it "invokes the computation only once" do
        2.times { instance.value }
        expect(instance).to have_received(:computation).once
      end
    end

    context "with a false result" do
      let(:result) { false }

      it "returns the computation result" do
        expect(instance.value).to be result
      end

      it "invokes the computation only once" do
        2.times { instance.value }
        expect(instance).to have_received(:computation).once
      end
    end
  end

  describe "#memoize" do
    let(:klass) do
      Struct.new(:computation) do
        include Memonic

        def value
          memoize(:@value) { computation }
        end
      end
    end

    let(:instance) { klass.new(result) }

    before do
      allow(instance).to receive(:computation).and_call_original
    end

    context "with a truthy result" do
      let(:result) { Object.new }

      it "returns the computation result" do
        expect(instance.value).to be result
      end

      it "invokes the computation only once" do
        2.times { instance.value }
        expect(instance).to have_received(:computation).once
      end
    end

    context "with a nil result" do
      let(:result) { nil }

      it "returns the computation result" do
        expect(instance.value).to be result
      end

      it "invokes the computation only once" do
        2.times { instance.value }
        expect(instance).to have_received(:computation).once
      end
    end

    context "with a false result" do
      let(:result) { false }

      it "returns the computation result" do
        expect(instance.value).to be result
      end

      it "invokes the computation only once" do
        2.times { instance.value }
        expect(instance).to have_received(:computation).once
      end
    end
  end
end
