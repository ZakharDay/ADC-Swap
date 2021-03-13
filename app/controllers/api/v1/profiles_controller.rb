class Api::V1::ProfilesController < Api::V1::ApplicationController
  def index
    profile_id = rand(Profile.count)

    if profile_id == 0
      profile_id = 1
    end

    profile = Profile.find(profile_id)

    whishedMinors = profile.whished_minors.all.collect

    profile_data = {
      id: profile.id,
      first_name: profile.first_name,
      middle_name: profile.middle_name,
      last_name: profile.last_name,
      year: profile.education_year,
      minor: Minor.find(profile.minor_id).name,
      city: City.find(Program.find(profile.program_id).city_id).name,
      whished_minors: profile.whished_minors.collect { |wm| wm.minor.name },
      isPublished: profile.published,
      email: profile.user.email,
      # update_url: api_v1_profile_url(profile)
      # update_url: api_v1_profile_url(profile, method: :PATH)
    }

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
