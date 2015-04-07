require 'ostruct'
require 'tmpdir'
require_relative '../../config/initializers/setup_i18n.rb'

class Cheque
  class Copy
    extend Forwardable

    include Prawn::View

    attr_accessor :id, :filepath, :errors
    def_delegators :I18n, :t, :l

    def initialize(params)
      params.each do |param, value|
        send("#{param}=", value)
      end

      self.errors = {}
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
      [
        :id
      ].each do |p|
        if send(p).to_s.empty?
          errors[p] = t('cheque.errors.required_param_not_found')
        end
      end

      errors.size == 0
    end

    def path
      @path ||= (filepath || tempfilepath)
    end

    def tempfilepath
      @tempfilepath ||= File.join(
        Dir.tmpdir,
        Dir::Tmpname.make_tmpname('cheque_copy', "#{id}.pdf")
      )
    end
  end
end
