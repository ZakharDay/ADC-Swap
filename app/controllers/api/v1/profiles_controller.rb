class Api::V1::ProfilesController < Api::V1::ApplicationController
  def index
    puts current_user
    if current_user
      profile = Profile.find(current_user.id)

      whishedMinors = profile.whished_minors.all.collect

      profile_data = {
        id: profile.id,
        year: profile.education_year,
        minor: Minor.find(profile.minor_id).name,
        city: City.find(Program.find(profile.program_id).city_id).name,
        whished_minors: profile.whished_minors.collect { |wm| wm.minor.name },
        isPublished: profile.published,
        email: profile.user.email,
        # update_url: api_v1_profile_url(profile)
        # update_url: api_v1_profile_url(profile, method: :PATH)
      }

    else
      profile_data = {error: 'Current user is not found'}
    end
    render json: profile_data
  end

  def create
    if params[:data][:action] = "update"
      data = params[:data][:update_data]
      puts " UPDATE PROFILE witd #{data[:id]} ID"

      profile = Profile.find(data[:id])

      profile.update(first_name: data[:first_name], last_name:data[:last_name], middle_name:data[:middle_name])
    end
    # profile_data = params[:id]
    # render json: profile_data
  end
end
