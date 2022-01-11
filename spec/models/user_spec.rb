require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    before(:each) do  
      @user = User.create(first_name: "Mike",
                      last_name: "Smith",
                      email: "flast@email.com",
                      password: "123456",
                      password_confirmation: "123456")
    end

    it "is valid with valid attributes" do
      expect(@user).to be_valid
    end

    it "is not valid without a first name" do
      @user.first_name = nil
      expect(@user).to_not be_valid
    end

    it "is not valid without a last name" do
      @user.last_name = nil
      expect(@user).to_not be_valid
    end

    it "is not valid without a email" do
      @user.email = nil
      expect(@user).to_not be_valid
    end

    it "is not valid without a password" do
      @user.password = nil
      expect(@user).to_not be_valid
    end

    it "is not valid with password different than password_confirmation" do
      @user.password = "12345789"
      expect(@user).to_not be_valid
    end

    it "is not valid with a password less than 6 characters" do
      @user.password = "12345"
      @user.password_confirmation = "12345"
      expect(@user).to_not be_valid
    end

    it "is not valid when a password and a password confirmation are not equal because of case sensitivity" do
      @user.password = "ABCDEFG"
      @user.password_confirmation = "ABCDEFg"
      expect(@user).to_not be_valid
    end

    it "is not valid with an existing email" do
      user2 = User.create(first_name: "Mike",
        last_name: "Smith",
        email: "flast@email.com",
        password: "123456",
        password_confirmation: "123456")

      expect(user2).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    it "Authenticated with an existing email" do
      User.create!(first_name:'first', last_name:'last', email:'flast@email.com',password: '1235678', password_confirmation:'1235678')
      user = User.authenticate_with_credentials("flast@email.com","1235678")
      expect(user).to_not be_nil
    end

    it "Authenticated with an existing email with leading and trailing spaces" do
      User.create!(first_name:'first', last_name:'last', email:'flast@email.com',password: '1235678', password_confirmation:'1235678')
      @user = User.authenticate_with_credentials("   flast@email.com   ","1235678")
      expect(@user).to be_truthy
    end

    it "Authenticated with an existing email with some different character cases" do
      thisUser = User.create(first_name:'first', last_name:'last', email:'flasT@email.com'.downcase,password: '1235678', password_confirmation:'1235678')
      puts thisUser
      @user = User.authenticate_with_credentials("fLAST@email.COM","1235678")
      expect(@user).to be_truthy
    end

    it "is not valid with an email that does not exist" do
      @user = User.authenticate_with_credentials("flastxxxxxxxxx@email.com","123")
      expect(@user).to be_nil
    end
  end

end
