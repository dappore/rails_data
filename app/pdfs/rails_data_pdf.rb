require 'prawn'
require 'prawn/measurement_extensions'

class RailsDataPdf < Prawn::Document

  def initialize
    default_config = {
      page_size: 'A4'
    }
    super(default_config)
  end

  def run
    return self unless self.empty?

    once_header beginning_data if beginning_data
    repeat_header header_data if header_data
    table_data.each_with_index do |value, index|
      start_new_page unless index == 0
      custom_table value
    end
    once_footer ending_data if ending_data
    repeat_footer footer_data if footer_data
    self
  end

  # todo hack for a bug, need confirm ?
  def empty?
    page.content.stream.length <= 2
  end

end
