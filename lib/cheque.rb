require 'prawn'
require 'cheque/version'

class Cheque
  extend Forwardable

  autoload :Copy, 'cheque/copy'

  def_delegators :formater, :filename

  def initialize(data, document)
    @data = data
    @document = document
  end

  def render
    formater.data
  end

  private

  attr_reader :data, :document

  def formater
    @formater ||= Cheque.const_get(document.capitalize).new(data)
  end
end
