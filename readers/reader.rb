# frozen_string_literal: true

# An abstract class to enforce readers to implement the read method
class Reader
  def read
    raise NotImplementedError
  end
end
