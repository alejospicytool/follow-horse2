# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "open-uri"

User.destroy_all
puts "Destroyed Users"

puts "Creatting Users"
user1 = User.new(email: "clari@gmail.com", password: "123456", nombre: "Clari", apellido: "Ursini", age: 34, pais: "Argentina", provincia: "Capital Federal", ciudad: "Capital Federal", direccion: "Viamonte 2040", phone: "+5491149608212", description: "I love horses", establishment: "Haras La Clari")
file = URI.open("https://ca.slack-edge.com/T02NE0241-U03PQPPGXUG-abbe6fa51dcc-512")
user1.photo.attach(io: file, filename: "clari.png", content_type: "image/png")
user1.save!

user2 = User.new(email: "nacho@gmail.com", password: "123456", nombre: "Nacho", apellido: "Zanotto", age: 27, pais: "Argentina", provincia: "Buenos Aires", ciudad: "Moreno", direccion: "La Rioja 2020", phone: "+5491159614875", description: "I love horses", establishment: "Haras El Nacho")
file = URI.open("https://ca.slack-edge.com/T02NE0241-U03NVDNP02Z-8e39c56cb377-512",)
user2.photo.attach(io: file, filename: "nacho.png", content_type: "image/png")
user2.save!

user3 = User.new(email: "sofi@gmail.com", password: "123456", nombre: "Sofi", apellido: "Larrea", age: 33, pais: "Argentina", provincia: "Mendoza", ciudad: "Mendoza", direccion: "Av. Lastarria 2045", phone: "+54926456148954", description: "I love horses", establishment: "Haras La Sofi")
file = URI.open("https://ca.slack-edge.com/T02NE0241-U03NNS0RVHV-360467752b45-512")
user3.photo.attach(io: file, filename: "sofi.png", content_type: "image/png")
user3.save

user4 = User.new(email: "beni@gmail.com", password: "123456", nombre: "Beni", apellido: "Yuchi Hsueh", age: 27, pais: "Argentina", provincia: "Capital Federal", ciudad: "Capital Federal", direccion: "Av. Santa Fe 3894", phone: "+54911515611234", description: "I love horses", establishment: "Haras El Beni")
file = URI.open("https://ca.slack-edge.com/T02NE0241-U03NY6P9V52-c21424e32e07-512")
user4.photo.attach(io: file, filename: "beni.png", content_type: "image/png")
user4.save!

user5 = User.new(email: "maki@gmail.com", password: "123456", nombre: "Ryusei", apellido: "Makiguchi", age: 30, pais: "Argentina", provincia: "Capital Federal", ciudad: "Capital Federal", direccion: "Av. Montes de Oca 2945", phone: "+5491149851247", description: "I love horses", establishment: "Haras El Maki")
file = URI.open("https://ca.slack-edge.com/T02NE0241-U03PTAN9ARE-e0ff21331654-512")
user5.photo.attach(io: file, filename: "piova.png", content_type: "image/png")
user5.save!

puts "Created users"
