require "test_helper"

class SolicitarTurnoMailerTest < ActionMailer::TestCase
  test "confirm" do
    mail = SolicitarTurnoMailer.confirm
    assert_equal "Confirm", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
