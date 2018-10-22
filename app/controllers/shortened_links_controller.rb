class ShortenedLinksController < ApplicationController
  before_action :set_shortened_link, only: [:show, :edit, :update, :destroy]

  # GET /shortened_links
  # GET /shortened_links.json
  def index
    @shortened_links = ShortenedLink.all
  end

  # GET /shortened_links/1
  # GET /shortened_links/1.json
  def show
  end

  # GET /shortened_links/new
  def new
    @shortened_link = ShortenedLink.new
  end

  # GET /shortened_links/1/edit
  def edit
  end

  # POST /shortened_links
  # POST /shortened_links.json
  def create
    @shortened_link = ShortenedLink.new(shortened_link_params)

    respond_to do |format|
      if @shortened_link.save
        format.html { redirect_to @shortened_link, notice: 'Shortened link was successfully created.' }
        format.json { render :show, status: :created, location: @shortened_link }
      else
        format.html { render :new }
        format.json { render json: @shortened_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shortened_links/1
  # PATCH/PUT /shortened_links/1.json
  def update
    respond_to do |format|
      if @shortened_link.update(shortened_link_params)
        format.html { redirect_to @shortened_link, notice: 'Shortened link was successfully updated.' }
        format.json { render :show, status: :ok, location: @shortened_link }
      else
        format.html { render :edit }
        format.json { render json: @shortened_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shortened_links/1
  # DELETE /shortened_links/1.json
  def destroy
    @shortened_link.destroy
    respond_to do |format|
      format.html { redirect_to shortened_links_url, notice: 'Shortened link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def shortened
    @shortened_link = find_shortend_link or not_found
    unless @shortened_link.is_expired
      increment_visits
      redirect_to @shortened_link.original_url, :status => 301
    else
      not_found
    end
  end

  def expire_link
    @shortened_link = find_shortend_link
    @shortened_link.is_expired = true
    @shortened_link.save
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shortened_link
      @shortened_link = ShortenedLink.find(params[:id])
    end

    def find_shortend_link
      @shotened_link = ShortenedLink.find_by_short_url_slug(params[:short_url_slug])
    end

    def increment_visits
      @shortened_link.increment(:visit_count, 1)
      @shortened_link.save
    end 

    # Never trust parameters from the scary internet, only allow the white list through.
    def shortened_link_params
      params.require(:shortened_link).permit(:original_url, :is_expired)
    end
end
