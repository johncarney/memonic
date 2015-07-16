require "spec_helper"
require "memonic"

describe Memonic do
  describe ".memoize" do
    let(:klass) do
      Class.new do
        include Memonic

        def compute_value
        end

        memoize :value do
          compute_value
        end
      end
    end

    let(:instance) { klass.new }

    before do
      allow(instance).to receive(:compute_value).and_return(result)
    end

    context "with a truthy result" do
      let(:result) { Object.new }

      it "returns the computation result" do
        expect(instance.value).to be result
      end

      it "invokes the computation only once" do
        2.times { instance.value }
        expect(instance).to have_received(:compute_value).once
      end
    end

    context "with a falsey result" do
      let(:result) { nil }

      it "returns the computation result" do
        expect(instance.value).to be result
      end

      it "invokes the computation only once" do
        2.times { instance.value }
        expect(instance).to have_received(:compute_value).once
      end
    end
  end
end
