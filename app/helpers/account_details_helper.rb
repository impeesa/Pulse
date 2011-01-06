module AccountDetailsHelper

  def positive_representation(float)
    return unless float
    # I have no idea why, but with a list of foats with at most 2 declimals,
    # the rounding of the numbers was returning long decimals.
    # You'll see with importing_sample_account_details and looking at the summaries.
    # Manually avoid them by rounding here.
    float = float.round(2)
    float < 0 ? "(#{float.abs})" : float
  end

  def extract_sub_group(column)
    'sub_group_' + column.split('_').last
  end

end
