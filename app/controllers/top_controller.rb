class TopController < ApplicationController
  def index
    
    ActiveRecord::Base.connection.migration_context.migrate

    
  end
end
