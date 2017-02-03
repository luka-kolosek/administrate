class Customer < ActiveRecord::Base
  has_many :orders, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true

  default_scope -> { where(kind: "vip") }

  KINDS = [
    :standard,
    :vip,
  ].freeze

  def lifetime_value
    orders.map(&:total_price).reduce(0, :+)
  end
end
