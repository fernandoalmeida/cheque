require 'ostruct'

module Cheque
  class Copy
    extend Forwardable

    include Prawn::View

    attr_reader :params, :errors

    def_delegators :params, *[
      :id
    ]

    def initialize(params)
      @params = OpenStruct.new(params)
      @errors = {}
    end

    def data
      return unless valid?

      generate
      render
    end

    private

    def generate
      valid?

      padded_bounding_box(10, [30, cursor], width: 500) do
        text("Cheque Copy Number: #{id}")
      end
    end

    def padded_bounding_box(padding, *args)
      bounding_box(
        [padding, bounds.height - padding],
        width: bounds.width - (2 * padding),
        heidht: bounds.height - (2 * padding)
      ) do
        yield
      end
    end

    def valid?
      errors.size == 0
    end

    attr_reader :params
  end
end
