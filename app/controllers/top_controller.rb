class TopController < ApplicationController
  def index
    
    ActiveRecord::Tasks::DatabaseTasks.migrate

    
  end
end

