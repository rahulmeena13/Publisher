# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create :username => "administrator", :email => "admisitrator@publisher.com", :password => "12345678"
Role.create :name => 'Admin'
Role.create :name => 'Editor'
Role.create :name => 'Reporter'
admin = User.find_by_username('administrator')
admin.roles << Role.find_by_name('Admin')
