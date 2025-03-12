require_relative '../app'
require_relative '../models/order'
require_relative '../models/product'

# Clear existing records
Order.destroy_all
Product.destroy_all

# Create products
products = [
  { name: "Blue Lightsaber", description: "Used by Jedi Knights.", price: 199.99 },
  { name: "Red Lightsaber", description: "A weapon of the Sith Lords.", price: 199.99 },
  { name: "Blaster E-11", description: "Standard weapon of the Stormtroopers.", price: 149.99 },
  { name: "X-Wing Miniature", description: "A replica of the Rebel Alliance starfighter.", price: 99.99 },
  { name: "TIE Fighter Miniature", description: "A replica of the Empire's starfighter.", price: 99.99 },
  { name: "Jedi Holocron", description: "Contains the secrets of the Force.", price: 299.99 },
  { name: "Jedi Robe", description: "Traditional clothing of the Jedi Order.", price: 79.99 },
  { name: "Darth Vader Helmet", description: "An iconic piece of Sith Lord armor.", price: 249.99 },
  { name: "Hyperfuel (Refined Coaxium)", description: "Essential for starship hyperdrives.", price: 499.99 },
  { name: "Astromech Droid R2", description: "A reliable droid for navigation and repairs.", price: 899.99 }
]

product_records = products.map { |p| Product.create!(p) }

# Create orders
orders = [
  { customer_name: "Luke Skywalker", product: product_records[0] },
  { customer_name: "Darth Vader", product: product_records[1] },
  { customer_name: "Han Solo", product: product_records[2] },
  { customer_name: "Collector", product: product_records[3] },
  { customer_name: "Imperial Officer", product: product_records[4] },
  { customer_name: "Obi-Wan Kenobi", product: product_records[5] },
  { customer_name: "Young Jedi", product: product_records[6] },
  { customer_name: "Vader Fan", product: product_records[7] },
  { customer_name: "Smuggler", product: product_records[8] },
  { customer_name: "Resistance Mechanic", product: product_records[9] }
]

orders.each { |o| Order.create!(o) }

puts "✅ Database successfully seeded!"
