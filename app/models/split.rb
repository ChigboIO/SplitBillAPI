class Split < ApplicationRecord
  belongs_to :payer, class_name: 'User'
  belongs_to :bill
end
