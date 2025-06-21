module PayrollCalculatorHelper
  def format_currency(amount)
    number_with_delimiter(amount)
  end
end