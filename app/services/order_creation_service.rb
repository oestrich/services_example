class OrderCreationService
  include ActiveModel::Validations

  validates :name, :presence => true

  attr_reader :user, :params, :order, :name

  delegate :as_json, :to => :order

  def initialize(user, params)
    @user = user
    @params = params

    params ||= []
    params.each do |param, value|
      instance_variable_set("@#{param}", value) if respond_to?(param)
    end
  end

  def perform
    return unless valid?

    @order = user.orders.create(params)
  end

  def successful?
    valid? && order.persisted?
  end
end
