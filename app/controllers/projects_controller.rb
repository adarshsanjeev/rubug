class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    if Project.find(params[:id]).is_public == false
      if !user_signed_in?
        authenticate_user!
      end
      if !(Project.find(params[:id]).user_id == current_user.id || (Permission.find_by user_id: current_user.id, projects_id: params[:id]))
        respond_to do |format|
          if @project.update(project_params)
            format.html { redirect_to @project, notice: 'You don\' have permission to view this page' }
            format.json { render :show, status: :ok, location: @project }
          else
            format.html { render :edit }
            format.json { render json: @project.errors, status: :unprocessable_entity }
          end
        end
      end
    end
    @permission_list = []
    @comments_list = []
    Permission.find_each do |record|
      if record.projects_id == params[:id].to_i
        @permission_list += [User.find(record.user_id).email]
      end
    end
    @issue_list = []
    Issue.find_each do |record|
      if record.projects_id == params[:id].to_i
        @issue_list += [record]
        Comment.find_each do |comm|
          if comm.issue_id == record.id
            @comments_list += [comm]
          end
      end
    end
    end
  end

  def close_issue
    if !user_signed_in?
      authenticate_user!
    end
    Issue.find(params[:format]).destroy
    redirect_to :back
  end
  
  def add_comment
    if !user_signed_in?
      authenticate_user!
    end
  end
  
  def process_comment
    if !user_signed_in?
      authenticate_user!
    end
    object = Comment.new
    object.user_id = current_user.id
    object.issue_id = params[:issueid]
    object.message = params[:message]
    object.save
    redirect_to :back
  end

  def add_issue
    if !user_signed_in?
      authenticate_user!
    end
  end

  def assign_to
    if !user_signed_in?
      authenticate_user!
    end

  end

  def assign_to_process
    if !user_signed_in?
      authenticate_user!
    end
    object = Issue.find(params[:issueid])
    object.assigned_to = User.find_by_email(params[:useremail]).id
    object.save
    redirect_to :back
  end
  
  def process_add_issue
    if !user_signed_in?
      authenticate_user!
    end
    object = Issue.new
    object.user_id = current_user.id
    object.projects_id = params[:projectid]
    object.title = params[:title]
    object.content = params[:content]
    object.tags = params[:tags]
    object.save
    redirect_to :back
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  def add_user
    if !user_signed_in?
      authenticate_user!
    end
  end

  def revoke_user
    if !user_signed_in?
      authenticate_user!
    end
  end

  def process_req
    if !user_signed_in?
      authenticate_user!
    end
    object = Permission.new
    object.user_id = User.find_by_email(params[:useremail]).id
    object.projects_id = params[:projectid]
    object.save
    redirect_to :back
  end

  def revoke_req
    if !user_signed_in?
      authenticate_user!
    end    
    User.find_by_email(params[:useremail]).destroy
    redirect_to :back
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    if !user_signed_in?
      authenticate_user!
    end
    @project = Project.new(project_params)
    @project.user = current_user
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:title, :description, :is_public, :user_id)
    end
end
