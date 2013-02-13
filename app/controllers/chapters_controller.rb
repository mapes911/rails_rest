class ChaptersController < ApplicationController

  # GET /experiences/:experience_id/chapters
  # GET /experiences/:experience_id/chapters.json
  def index
    @experience = Experience.find(params[:experience_id])
    @chapters = @experience.chapters

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @chapters }
    end
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
      flash[:success] = "New Chapter created!!"
    end
    # for now we always redirect back to the experience page
    # this will not be when we go to an ajax creation
    redirect_to @experience
  end

  # PUT /chapters/1
  # PUT /chapters/1.json
  def update
    @chapter = Chapter.find(params[:id])

    respond_to do |format|
      if @chapter.update_attributes(params[:chapter])
        format.html { redirect_to @chapter, notice: 'Chapter was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @chapter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chapters/1
  # DELETE /chapters/1.json
  def destroy
    @chapter = Chapter.find(params[:id])
    @chapter.destroy

    respond_to do |format|
      format.html { redirect_to chapters_url }
      format.json { head :no_content }
    end
  end
end