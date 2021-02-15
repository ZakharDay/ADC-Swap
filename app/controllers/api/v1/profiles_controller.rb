class Api::V1::ProfilesController < ApplicationController
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
      email: profile.user.email
    }

    render json: profile_data
  end

  def update
    profile_data = params[:id]
    render json: profile_data
  end
end
