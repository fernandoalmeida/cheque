require 'ostruct'
require 'tmpdir'
require_relative '../../config/initializers/setup_i18n.rb'

class Cheque
  class Copy
    extend Forwardable

    include Prawn::View

    def_delegators :I18n, :t, :l

    attr_accessor *[
      :id,
      :title,
      :bank,
      :agency_number,
      :account_number,
      :cheque_number,
      :account_holder,
      :nominal_to,
      :amount,
      :location,
      :date,
      :filepath,
      :errors
    ]

    def initialize(params)
      params.each do |param, value|
        send("#{param}=", value)
      end

      self.errors = {}
    end

    def data
      return unless valid?

      prepare
      render
    end

    def file
      return unless valid?

      @file ||= lambda do
        prepare
        save_as(path)

        path
      end.call
    end

    private

    def prepare
      title_box
      cheque_copy_box(20)
    end

    def title_box(padding = 0)
      move_down(padding)
      text('CHEQUE COPY', align: :center, style: :bold, size: 14)
    end

    def cheque_copy_box(padding = 0)
      move_down(padding)
      padded_bounding_box(20, [30, cursor], width: 500, height: 300) do
        id_box
        bank_data_box(20)
        cheque_data_box(10)
        date_box(15)
        signatures_boxes(5)
      end
    end

    def id_box(padding = 0)
      move_down(padding)

      text_attribute('Cheque copy number', id)
      stroke_horizontal_rule
    end

    def bank_data_box(padding = 0)
      move_down(padding)

      text_attribute('Bank', bank)
      text_attribute('Agency', agency_number)
      text_attribute('Account', account_number)
      text_attribute('Account holder', account_holder)
    end

    def cheque_data_box(padding = 0)
      move_down(padding)

      text_attribute('Cheque number', cheque_number)
      text_attribute('Amount', "$ #{amount}")
      text_attribute('Nominal to', nominal_to)
    end

    def date_box(padding = 0)
      move_down(padding)

      centered_text("#{location}, #{l(date, format: :long)}")
    end

    def signatures_boxes(padding = 0)
      move_down(padding)

      pad(20) do
        position = cursor
        width = bounds.width / 2

        authorizer_signature_box(0, position, width - 10)
        payer_signature_box(width + 10, position + 24, width - 10)
      end
    end

    def authorizer_signature_box(x, y, width)
      bounding_box [x, y], width: width do
        stroke_horizontal_rule
        move_down 10
        centered_text('Authorizer signature')
      end
    end

    def payer_signature_box(x, y, width)
      bounding_box [x, y], width: width do
        stroke_horizontal_rule
        move_down 10
        centered_text('Payer signature')
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

    def centered_text(s)
      text(s, align: :center)
    end

    def text_attribute(name, value)
      text(
        "#{name}: <b>#{value}</b>",
        inline_format: true,
        size: 12,
        leading: 5
      )
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
