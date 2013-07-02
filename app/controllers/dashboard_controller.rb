class DashboardController < ApplicationController
  before_filter :authenticate_user!
  def index
    
  end
  
  def editors    
    @editors = User.joins(:roles).where(roles: {name: 'Editor'})
    authorize! :manage, User.new
  end
  
  def unpublished    
    @articles = Article.where("published = ?", false)
    authorize! :manage, Article.new
  end
  
  def myarticles   
    @myArticles = Article.where("user_id = ?", current_user.id)
    authorize! :update, Article.new({"user_id"=>current_user.id})
  end
  
  def new
    @editor = User.new
    authorize! :manage, @editor
  end
  
  def create
    @editor = User.new(params[:editor].permit(:username,:email, :password, :password_confirmation))
    @editor.roles << Role.find_by_name('Editor')
    respond_to do |format|
      if @editor.save
        format.html { redirect_to editors_path, notice: 'Editor was successfully created.' }
        format.json { render action: 'index', status: :created, location: @editor }
      else
        format.html { render action: 'new' }
        format.json { render json: @editor.errors, status: :unprocessable_entity }
      end
    end 
    authorize! :manage, @editor
  end
  
  def edit
    @editor = User.find(params[:id])
    authorize! :manage, @editor
  end

  def update
    @editor = User.find(params[:id])
     if params[:editor][:password].blank?
       [:password,:password_confirmation,:current_password].collect{|p| params[:editor].delete(p) }
     else
       @editor.errors[:base] << "Current Password is incorrect" unless @editor.valid_password?(params[:editor][:current_password])
     end
 
     respond_to do |format|
       if @editor.errors[:base].empty? and @editor.update_attributes(params[:editor].permit(:username, :email, :password))
         flash[:notice] = "User has been updated"
         format.json { render :json => @editor.to_json, :status => 200 }
         format.xml  { head :ok }
        format.html { redirect_to editors_path, notice: 'Editor was successfully updated.' }
       else
         format.json { render :text => "Could not update user", :status => :unprocessable_entity } #placeholder
         format.xml  { render :xml => @editor.errors, :status => :unprocessable_entity }
         format.html { render :action => :edit, :status => :unprocessable_entity }
       end
     end
    authorize! :manage, @editor
    
    rescue ActiveRecord::RecordNotFound
     respond_to_not_found(:js, :xml, :html)
  end
  
  def destroy
    @editor = User.find(params[:id])
    @editor.destroy!
 
    respond_to do |format|
      format.html { redirect_to editors_path }
      format.json { head :no_content }
    end
    
    authorize! :manage, @editor
 
    rescue ActiveRecord::RecordNotFound
     respond_to_not_found(:json, :xml, :html)
    end
end
