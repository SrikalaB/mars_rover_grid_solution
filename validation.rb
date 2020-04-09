Dir["./*validator.rb"].each {|file| require file }

module Validation
  def valid?
    klass = Object.const_get("#{self.class.name}Validator") #Create Validator classes with target class name as prefix
    @validator = klass.new(self)
    @validator.valid?
  end

  def errors
    return {} unless defined?(@validator)
    @validator.errors.all
  end
end