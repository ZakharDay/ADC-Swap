class ProfilesController < ApplicationController
  layout :resolve_layout
  before_action :authenticate_user!
  before_action :set_profile, only: [:show, :edit, :update, :new]

  def new
  end

  def show
  end

  def edit
  end

  def update
   profile = params[:profile]
   puts profile

   if profile[:type] == 'registration'

     profile[:whished_minors_id].delete_at(0)
     exchange_minor = ExchangeMinor.create!(profile_id: @profile.id, minor_id: profile[:minor_id], published: profile[:published])
     # @profile.whished_minors.each { |minor| minor.destroy}
     profile[:whished_minors_id].each do |minor_id|
       WhishedMinor.create!(exchange_minor_id:exchange_minor.id, minor_id:minor_id)
     end

     program_id = Minor.find(profile[:minor_id]).program_id
     puts Minor.find(profile[:minor_id]).to_json
     respond_to do |format|
       if @profile.update(education_year: profile[:education_year], program_id:program_id, minor_id:profile[:minor_id] )
         format.html { redirect_to welcome_index_path, notice: 'Profile was successfully updated.' }
         format.json { render :show, status: :ok, location: @profile }
       else
         format.html { render :edit }
         format.json { render json: @profile.errors, status: :unprocessable_entity }
       end
     end

   elsif profile[:type] == 'update'
     # puts params
     #
     #
     exchange_minor = ExchangeMinor.where(profile_id: @profile.id)
     exchange_minor.update(minor_id: profile[:minor_id])

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
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = current_user.profile
    end

    def resolve_layout
      case action_name
      when "new"
        "registration"
      else
        "application"
      end
    end

    def profile_params
      params.require(:profile).permit(:name, :program_id, :minor_id, :published, :education_year, :whished_minors_id)
    end
end
