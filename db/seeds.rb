# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
User.create([
        { 
            first_name: "Super",
            last_name: "Admin",
            email: "admin@job_board.com",
            password: "admin",
            is_admin: true
        }
    ])
