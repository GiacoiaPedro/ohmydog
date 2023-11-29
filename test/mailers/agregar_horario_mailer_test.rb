require "test_helper"

class AgregarHorarioMailerTest < ActionMailer::TestCase
  test "agregar" do
    mail = AgregarHorarioMailer.agregar
    assert_equal "Agregar", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
