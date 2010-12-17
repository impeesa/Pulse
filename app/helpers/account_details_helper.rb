module AccountDetailsHelper

  def positive_representation(float)
    return unless float
    float < 0 ? "(#{float.abs})" : float
  end
end
