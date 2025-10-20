# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
admin_email = ENV.fetch("ADMIN_EMAIL", "admin@example.com")
admin_password = ENV.fetch("ADMIN_PASSWORD", "password123")

puts "Seeding default admin user #{admin_email} and workspace..."

user = User.find_or_create_by!(email: admin_email) do |u|
  u.password = admin_password
  u.password_confirmation = admin_password
end

workspace = Workspace.find_or_create_by!(name: "Default Workspace")

Membership.find_or_create_by!(user: user, workspace: workspace) do |m|
  m.role = "admin"
end

puts "Seed completed."
