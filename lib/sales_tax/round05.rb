class Numeric
  # round a given number to the nearest 0.05
  def round_nearest_05
    (self * 20).ceil / 20.0
  end
end
