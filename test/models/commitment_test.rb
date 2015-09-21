require "test_helper"

class CommitmentTest < ActiveSupport::TestCase
  def commitment
    @commitment ||= Commitment.new
  end

  def test_valid
    assert commitment.valid?
  end
end
