class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update]
  # before_action :set_profile, only: [:show, :edit, :update, :destroy]

  def index
    @profiles = Profile.all
  end

  def show
  end

  def new
    @profile = Profile.new
  end

  def edit
  end

  # def create
  #   @profile = Profile.new(profile_params)
  #
  #   respond_to do |format|
  #     if @profile.save
  #       format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
  #       format.json { render :show, status: :created, location: @profile }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @profile.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def update

    params[:profile][:whished_minors_id].delete_at(0)

    @profile.whished_minors.each { |minor| minor.destroy}
    params[:profile][:whished_minors_id].each do |minor_id|
      WhishedMinor.create!(profile_id:@profile.id, minor_id:minor_id)
    end


    exchange_minor_id = ExchangeMinor.where(profile_id: @profile.id).first.id
    ExchangeMinor.update(exchange_minor_id, minor_id:params[:profile][:minor_id])

    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # def destroy
  #   @profile.destroy
  #   respond_to do |format|
  #     format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callb acks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    def profile_params
      params.require(:profile).permit(:first_name, :middle_name, :last_name, :program_id, :minor_id, :published, :education_year, :whished_minors_id)
    end
end
