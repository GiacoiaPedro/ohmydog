require "test_helper"

class CancelarTurnoMailerTest < ActionMailer::TestCase
  test "cancelar" do
    mail = CancelarTurnoMailer.cancelar
    assert_equal "Cancelar", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
