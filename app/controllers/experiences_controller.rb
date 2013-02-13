class ExperiencesController < ApplicationController
  before_filter :signed_in_user, only: [:create, :update, :destroy]
  before_filter :correct_user, only: [:update, :destroy]

  # GET /experiences
  # GET /experiences.json
  # list of experiences
  def index
    @experiences = Experience.paginate(page: params[:page])

    respond_to do |format|
      # format.html # index.html.erb
      format.json { render json: @experiences }
    end
  end

  # GET /experiences/:id
  # GET /experiences/:id.json
  # show details of specific experience
  def show
    @experience = Experience.find(params[:id])

    respond_to do |format|
      # format.html # index.html.erb
      format.json { render :json => @experience.to_json(:include => :chapters ) }
    end
  end

  # GET /experiences/new
  # GET /experiences/new.json
  # show create 'new' experience form - excluded from route.
  def new
  end

  # GET /experiences/1/edit
  # show edit experience form - excluded from route
  def edit
  end

  # POST /experiences
  # POST /experiences.json
  # creation of a new experience.
  def create
    @experience = current_user.experiences.build(params[:experience])
    if @experience.save
      render json: {}, :status => 201 
    else
      render json: {}, :status => :unprocessable_entity
    end
  end

  # PUT /experiences/1
  # PUT /experiences/1.json
  def update
    @experience = Experience.find(params[:id])

    respond_to do |format|
      if @experience.update_attributes(params[:experience])
        # format.html { redirect_to @experience, notice: 'Experience was successfully updated.' }
        format.json { head :no_content }
      else
        # format.html { render action: "edit" }
        format.json { render json: @experience.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /experiences/1
  # DELETE /experiences/1.json
  # delete an experience
  def destroy
    @experience = Experience.find(params[:id])
    respond_to do |format|
      if @experience.destroy
        format.json { head :no_content }
      else
        # format.html { render action: "edit" }
        format.json { render json: @experience.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def correct_user
      @experience = current_user.experiences.find_by_id(params[:id])
      render json: {}, :status => :forbidden if @experience.nil?
    end

end