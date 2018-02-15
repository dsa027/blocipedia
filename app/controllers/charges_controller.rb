class ChargesController < ApplicationController
  include ChargesHelper
  before_action :authenticate_user!

  def create
    # Creates a Stripe Customer object, for associating
    # with the charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    # Where the real magic happens
    charge = Stripe::Charge.create(
      customer: customer.id, # Note -- this is NOT the user_id in your app
      amount: Amount.default,
      description: "BigMoney Membership - #{current_user.email}",
      currency: 'usd'
    )

    User.find(current_user.id).premium!
    flash[:notice] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
    redirect_to root_path

    # Stripe will send back CardErrors, with friendly messages
    # when something goes wrong.
    # This `rescue block` catches and displays those errors.
    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "BigMoney Membership - #{current_user.name}",
      amount: Amount.default
    }
  end

  def edit
  end

  def update
    begin
      User.find(current_user.id).standard!
      private_to_public

      flash[:notice] = "Congratulations! You have been downgraded by request! Be sure to upgrade again sometime for $#{sprintf("%0.2f", Amount.default/100)}!"
      redirect_to root_path
    rescue
      flash.now[:alert] = "There was a problem downgrading your account. Please try again later."
      render :edit
    end
  end
end
