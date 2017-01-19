require 'net/http'
require 'digest/md5'
require 'openssl'

class Email < ActiveRecord::Base
	attr_accessible :email
	validates :email, :confirmation => true
end
