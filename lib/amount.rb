require 'fixed'

# An amount of money with currency and 18-digit precision.


class Amount < Fixed

  attr_reader :currency


  #------- constructors ---------------------------------------------

  private_class_method :new

  def initialize(currency, fractions)
    raise unless Symbol === currency
    @currency = currency
    super fractions
  end

  def self.create(value, currency = nil)
    if currency.nil?
      case value
      when Amount
        return value
      when String
        return self.parse(value)
      when Hash
        case value.size
        when 1
          currency, value = value.first
        when 2
          return Amount.create value.fetch(:amount), value.fetch(:currency)
        else
          raise ArgumentError, "expected amount, got #{value.inspect}"
        end
      end
    end

    case value
    when String
      new currency.to_sym, string_as_fractions(value)
    when Fixed
      new currency.to_sym, value.fractions
    when Numeric
      new currency.to_sym, number_as_fractions(value)
    else
      raise ArgumentError, "expected amount, got #{[value,currency].inspect}"
    end
  end

  def self.parse(string)
    raise "expect amount and currency, got #{string.inspect}" unless string =~ /\A(\S+)\s+(\S+)\Z/
    new $2.to_sym, string_as_fractions($1)
  end

  def self.from_number(currency, units)
    new currency, number_as_fractions(units)
  end

  def self.from_fractions(currency, fractions, precision: nil)
    if precision
      raise unless (0..18) === precision
      fractions = fractions * (10 ** (18 - precision))
    end

    new currency, fractions
  end

  def self.smallest(currency)
    new currency, 1
  end

  def self.zero(currency)
    new currency, 0
  end

  #------- arithmetics ----------------------------------------------

  def +(amount)
    raise "expected curreny #{self.currency}, got #{amount.currency}" unless self.currency == amount.currency
    super
  end

  def -(amount)
    raise "expected curreny #{self.currency}, got #{amount.currency}" unless self.currency == amount.currency
    super
  end

  def *(number)
    raise "expected curreny #{self.currency}, got #{number.currency}" unless self.currency == number.currency if Amount === number
    super
  end

  def /(number)
    raise "expected curreny #{self.currency}, got #{number.currency}" unless self.currency == number.currency if Amount === number
    super
  end


  # ------- comparing -----------------------------------------------

  def dollar?
    self.currency == :USD
  end

  def ==(amount)
    Amount === amount && self.currency == amount.currency && self.fractions == amount.fractions
  end


  # ------- printing ------------------------------------------------

  def inspect
    "#{super} #{currency}"
  end

  def format(precision = 8)
    "#{super precision} #{currency}"
  end


  # ------- helpers -------------------------------------------------

  def to_amount
    self
  end

  def eps
    self.fractions
  end

  def without_currency
    Fixed.from_fractions self.fractions
  end

  protected

  def make(new_fractions)
    Amount.from_fractions self.currency, new_fractions
  end

end

module Kernel
  def Amount(value, currency = nil)
    Amount.create value, currency
  end
end

class String
  def to_amount
    Amount.parse self
  end
end

