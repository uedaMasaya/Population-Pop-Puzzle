class Contact < ApplicationRecord
    # バリデーションの追加
    validates :name, presence: true
    validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :message, presence: true
  end