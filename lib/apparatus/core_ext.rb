class Hash
  def >>(rhs)
    rhs << self
  end
end

class Array
  def >>(rhs)
    rhs << self
  end
end

class String
  def >>(rhs)
    rhs << self
  end
end
