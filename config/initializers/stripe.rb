Rails.configuration.stripe = {
  publishable_key: ENV['STRIPE_PUBLISHABLE_KEY'],
  secret_key: ENV['STRIPE_SECRET_KEY']
}

# Set our app-stored secret key with Stripe
Stripe.api_key = Rails.configuration.stripe[:secret_key]
# Stripe.api_key = Figaro.env.secret_key
Stripe.api_key = "sk_test_JY7itKHzmMZQAjUI9hSUjGFW"
