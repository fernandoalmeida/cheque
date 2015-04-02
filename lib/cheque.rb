require 'prawn'
require 'cheque/version'

class Cheque
  autoload :Copy, 'cheque/copy'

  def initialize(data, document)
    @data = data
    @document = document
  end

  def render
    formater.render
  end

  private

  attr_reader :data, :document

  def formater
    @formater ||= Cheque.const_get(document.capitalize).new(data)
  end
end
