class Api::V1::ProfilesController < Api::V1::ApplicationController
  def index
    puts '_______________________________'
    puts params
    if params[:authenticity_token]
      profile = Profile.find_by(device_token: params[:device_token])
      if profile
        puts profile
        # whishedMinors = profile.whished_minors.all.collect

        profile_data = {
          id: profile.id,
          year: profile.education_year,
          minor: Minor.find(profile.minor_id).name,
          # city: City.find(Program.find(profile.program_id).city_id).name,
          # whished_minors: profile.whished_minors.collect { |wm| wm.minor.name },
          isPublished: profile.published,
          email: profile.user.email
          # update_url: api_v1_profile_url(profile)
          # update_url: api_v1_profile_url(profile, method: :PATH)
        }
      else
        profile_data = {error: 'User is not found'}
      end
    end
    puts '******************'
    puts profile_data
    puts '******************'
    render json: profile_data
  end

  def create
    if params[:data][:action] = "update"
      data = params[:data][:update_data]
      puts data
      u = Profile.find_by(device_token: params[:device_token])
      data = params[:data][:update_data]
      puts " UPDATE PROFILE witd #{u.id} ID"
      puts u.to_json
      program_id = Minor.find(data[:minor_id]).program_id
      u.update(education_year: data[:year], minor_id: data[:minor_id], program_id:program_id, published: data[:isOpen])

      exchange_minor_id = ExchangeMinor.where(profile_id: u.id).first.id
      ExchangeMinor.update(exchange_minor_id, minor_id:data[:minor_id])

      render json: {result: true}
    end
    # profile_data = params[:id]
    # render json: profile_data
  end
end
