# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) do
    described_class.new(
      name: 'Example User',
      email: 'user@example.com',
      password: 'foobar',
      password_confirmation: 'foobar'
    )
  end

  describe 'User' do
    it 'is valid' do
      expect(user).to be_valid
    end
  end

  describe 'name' do
    it 'is present' do
      user.name = '  '
      expect(user).to be_invalid
    end

    it 'is too long' do
      user.name = 'a' * 51
      expect(user).to be_invalid
    end
  end

  describe 'email' do
    it 'is present' do
      user.email = '  '
      expect(user).to be_invalid
    end

    it 'is too long' do
      user.name = 'a' * 244 + '@example.com'
      expect(user).to be_invalid
    end

    it 'is unique' do
      duplicate_user = user.dup
      duplicate_user.email = user.email.upcase
      user.save
      expect(duplicate_user).to be_invalid
    end

    it 'is saved as lower-case' do
      user.email = 'Foo@ExAMPle.CoM'
      user.save
      expect(user.reload.email).to eq 'foo@example.com'
    end
  end

  describe 'password and password_confirmation' do
    it 'is present (nonblank)' do
      user.password = user.password_confirmation = ' ' * 6
      expect(user).to be_invalid
    end

    context '5 characters' do
      it 'is short' do
        user.password = user.password_confirmation = 'a' * 5
        expect(user).to be_invalid
      end
    end

    context '6 characters' do
      it 'is not short' do
        user.password = user.password_confirmation = 'a' * 6
        expect(user).to be_valid
      end
    end
  end
end
