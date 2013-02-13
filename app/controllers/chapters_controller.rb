class ChaptersController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  # POST /experiences/:experience_id/chapters
  # POST /experiences/:experience_id/chapters.json
  def create
    @experience = Experience.find(params[:experience_id])
    @chapter = @experience.chapters.build(params[:chapter])
    if @chapter.save
      render json: {}, :status => 201 
    else
      render json: {}, :status => :unprocessable_entity
    end
  end

  # PUT /experiences/:experience_id/chapters/1
  # PUT /experiences/:experience_id/chapters/1.json
  def update
    @experience = Experience.find(params[:experience_id])
    @chapter = Chapter.find(params[:id])

    respond_to do |format|
      if @chapter.update_attributes(params[:chapter])
        # format.html { redirect_to @chapter, notice: 'Chapter was successfully updated.' }
        format.json { head :no_content }
      else
        # format.html { render action: "edit" }
        format.json { render json: @chapter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /experiences/:experience_id/chapters/1
  # DELETE /experiences/:experience_id/chapters/1.json
  def destroy
    @chapter = Chapter.find(params[:id])
    @chapter.destroy

    respond_to do |format|
      format.html { redirect_to chapters_url }
      format.json { head :no_content }
    end
  end

  private
    def correct_user
      @experience = current_user.experiences.find_by_id(params[:experience_id])
      render json: {}, :status => :forbidden if @experience.nil?
    end  
end