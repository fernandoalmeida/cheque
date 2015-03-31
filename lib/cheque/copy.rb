require 'ostruct'
require 'tmpdir'

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

    def file
      return unless valid?

      @file ||= lambda do
        generate
        save_as(path)

        path
      end.call
    end

    private

    attr_reader :params

    def generate
      valid?

      padded_bounding_box(10, [30, cursor], width: 500) do
        text("Cheque Copy Number: #{id}")
      end
    end

    def padded_bounding_box(padding, *args)
      bounding_box(*args) do
        stroke_bounds

        bounding_box(
          [padding, bounds.height - padding],
          width: bounds.width - (2 * padding),
          heidht: bounds.height - (2 * padding)
        ) do
          yield
        end
      end
    end

    def valid?
      errors.size == 0
    end

    def path
      @path ||= (params.filepath || tempfilepath)
    end

    def tempfilepath
      @tempfilepath ||= File.join(
        Dir.tmpdir,
        Dir::Tmpname.make_tmpname('cheque_copy', "#{id}.pdf")
      )
    end
  end
end
