require 'mysql2'
require 'debugger'

class Dog
  attr_accessor :name, :id, :color
  @@db = Mysql2::Client.new(:host => "localhost", :username => "root", :database => "dogs")

	def initialize(name, color, id)
		@name = name
		@color = color
		@id =  id
	end

	def self.db
		@@db
	end

	def db
		@@db
	end

	def self.find_by_name(name)
		results = db.query ("SELECT * FROM dogs WHERE name = '#{name}'")
		
	end
	
	def self.find(id)
		results = db.query("SELECT * FROM dogs WHERE id = '#{id}'")
		if results.first.nil?
		 	puts "not found"
		else
			self.new_from_db(results.first)
		end
 	end

	def self.new_from_db(row)
	 	dog = Dog.new(row["name"], row["color"], row["id"])
	 	dog
	 end
 	
 	def self.insert(id, name, color)
 		self.db.query("INSERT INTO dogs (id, name, color)
 			VALUES (#{id}, '#{name}', '#{color}') ")
 	end

 	def update
 		self.db.query(
 			"UPDATE dogs
 			SET name = '#{self.name}', color = '#{self.color}'
 			WHERE id = '#{self.id}'")
 	end

 	def delete
 		self.db.query("DELETE FROM dogs
 			WHERE id = '#{self.id}' ")
 	end
end

dog = Dog.find(3)
dog.delete

 # color, name, id x
  # db x
  # find _by_att x
  # find x
  # insert x
  # update x
  # delete/destroy x
 
  # refactorings?
  # new_from_db? x
  # saved?
  # save! (a smart method that knows the right thing to do)
  # unsaved?
  # mark_saved!
  # ==
  # inspect
  # reload
  # attributes