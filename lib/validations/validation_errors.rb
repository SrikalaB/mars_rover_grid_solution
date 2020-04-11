class ValidationErrors
  attr_accessor :all

  def initialize
    @all = {}
  end

  def add(name, msg)
    (@all[name] ||= []) << msg
  end

  def full_messages
    @all.map do |e|
      "#{e.first.capitalize} #{e.last.join(' & ')}. "
    end.join
  end
end