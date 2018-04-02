class ChargesController < ApplicationController
  include ApplicationHelper
  
  before_action :authenticate_user!
  
  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Blocipedia Premium Membership - #{user_name(current_user)}",
      amount: Amount.default
    }
  end
  
  def create
    # Creates a Stripe Customer object, for associating with the charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )
    
    # Create the stripe charge object.
    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: Amount.default,
      description: "Blocipedia Premium Membership - #{user_name(current_user)}",
      currency: 'usd'
    )
    
    flash[:success] = { 
      heading: "Upgraded to premium",
      message: "Thank you, #{user_name(current_user)}! We know you'll enjoy using Blocipedia Premium."
    }
    
    # actually change user's role.
    current_user.premium!
    redirect_to root_path
    
    # Stripe will send back CardErrors, with friendly messages when something goes wrong.
    # This `rescue block` catches and displays those errors.
    rescue Stripe::CardError => e
      flash[:Error] = e.message
      redirect_to charges_new
  end
end

class Amount
  def self.default
    1500
  end
end
