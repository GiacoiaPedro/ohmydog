require "test_helper"

class ContactarServicioMailerTest < ActionMailer::TestCase
  test "contactar" do
    mail = ContactarServicioMailer.contactar
    assert_equal "Contactar", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
