module Validation
  def validate
    validators.flat_map do |validator|
      validator.run(self)
    end
  end

  private

  def validators
    [GridPositionValidator.new(:position)]
  end
end
