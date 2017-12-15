class User < ActiveRecord::Base
    has_secure_password

    validates :first, :last,
        length: { in: 2..20, message: "Names must be between 2 and 20 characters." },
        format: { with: /\A[a-zA-Z.\s]+\z/, message: "Names may only contain letters, periods, or spaces." }
    validates :email,
        length: { in: 5..75, message: "Email must be between 5 and 75 characters." },
        format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i, message: "Email format invalid." },
        uniqueness: { message: "Email already registered." }
    validates :password, format: { 
        with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%&?]).{8,72}\z/, 
        message: "Password format invalid." 
    },
        length: { minimum: 8, message: "Password must be at least 8 characters." }, allow_blank: true
    
    before_save :set_cases

    has_many :add
    has_many :added_songs, through: :add, source: :song

    private
        def set_cases
            self.email.downcase!
            self.first = self.first.titleize
            self.last = self.last.titleize
        end
end
