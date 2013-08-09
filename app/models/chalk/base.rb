class Chalk::Base < ActiveRecord::Base
  establish_connection :chalk_production
end
