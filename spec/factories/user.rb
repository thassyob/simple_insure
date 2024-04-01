# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'Usuario Teste' }
    email { 'teste@teste.com' }
    password { '123123123' }
    password_confirmation { '123123123' }
  end
end
