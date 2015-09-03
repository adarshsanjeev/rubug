class PermissionController < ApplicationController
  def new
    @permission = Permission.new
  end
end
