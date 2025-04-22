class Cellphone
  attr_reader :value

  def initialize(value)
    formatted_cellphone = value.gsub(/\D/, '')

    unless formatted_cellphone.start_with?('55')
      formatted_cellphone = formatted_cellphone.insert(0, '55')
    end

    if formatted_cellphone.length == 12
      formatted_cellphone = formatted_cellphone.insert(4, '9')
    end

    if formatted_cellphone.length != 13
      raise ActiveRecord::RecordInvalid, 'Cellphone must be 13 digits'
    end

    @value = formatted_cellphone
  end

  def to_s
    @value
  end
end
