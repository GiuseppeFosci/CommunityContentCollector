require "test_helper"

class UserTest < ActiveSupport::TestCase

def setup
  @user = User.new(name: "Name User", surname:"User surname", email: "user.user@uniroma1.it", password: "foobar", password_confirmation: "foobar")
end

test "should be valid" do
assert @user.valid?
end

test "name should be present" do
@user.name = ""
assert_not @user.valid?
end

test "email should be present" do
@user.email = "
"
assert_not @user.valid?
end

test "name should not be too long" do
@user.name = "a" * 51
assert_not @user.valid?
end

test "email should not be too long" do
@user.email = "a" * 244 + "@example.com"
assert_not @user.valid?
end

test "email validation should accept valid addresses" do
valid_addresses = %w[user.surname@uniroma1.it name.1234567@studenti.uniroma1.it]
valid_addresses.each do |valid_address|
@user.email = valid_address
assert @user.valid?, "#{valid_address.inspect} should be
valid"
end
end

test "email addresses should be unique" do
duplicate_user = @user.dup
@user.save
assert_not duplicate_user.valid?
end

test "email addresses should be saved as lowercase" do
mixed_case_email = "NaMe.SunE@UnIRoMa1.iT"
@user.email = mixed_case_email
@user.save
assert_equal mixed_case_email.downcase, @user.reload.email
end

test "password should be present (nonblank)" do
@user.password = @user.password_confirmation = " " * 6
assert_not @user.valid?
end

test "password should have a minimum length" do
@user.password = @user.password_confirmation = "a" * 5
assert_not @user.valid?
end

test "authenticated? should return false for a user with nil digest" do
  assert_not @user.authenticated?(:remember, '')
end

test "associated microposts should be destroyed" do
  @user.save
  @user.posts.create!(content: "Lorem ipsum")
  assert_difference 'Post.count', -1 do
    @user.destroy
  end
end

end
