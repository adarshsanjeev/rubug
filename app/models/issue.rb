class Issue < ActiveRecord::Base
  belongs_to :user
  belongs_to :projects
end
