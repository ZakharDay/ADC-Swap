class Api::V1::ProfilesController < Api::V1::ApplicationController
  def index
    puts '_______________________________'
    puts params
    if params[:authenticity_token]
      profile = Profile.find_by(device_token: params[:device_token])
      exchange_minor = profile.exchange_minors.first
      if profile
        puts profile.user.email
        puts '============================'
        whished_minors = []
        exchange_minor = profile.exchange_minors.first
        exchange_minor.whished_minors.each do |whished_minor|
          whished_minors.push(Minor.find(whished_minor.minor_id).name)
        end
        # whishedMinors = exchange_minor.whished_minors.all.collect { |minor| Minor.find(minor.minor_id).name}

        profile_data = {
          id: profile.id,
          year: profile.education_year,
          minor: Minor.find(profile.minor_id).name,
          city: City.find(Minor.find(profile.minor_id).city_id).name,
          whishedMinors: whished_minors,
          isPublished: exchange_minor.published,
          email: profile.user.email,
          exchangeMinorId: exchange_minor.id
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
    if params[:data][:action] == "update"
      data = params[:data][:update_data]
      puts data
      u = Profile.find_by(device_token: params[:device_token])
      puts " UPDATE PROFILE witd #{u.id} ID"
      program_id = Minor.find(data[:minor_id]).program_id
      u.update(education_year: data[:year], minor_id: data[:minor_id], program_id:program_id)

      exchange_minor = ExchangeMinor.where(profile_id: u.id).first
      exchange_minor.update(minor_id: data[:minor_id], published: params[:data][:isOpen])

      data[:wishList].each do |wm|
        WhishedMinor.create!(exchange_minor_id: exchange_minor.id, minor_id: wm)
      end
      render json: {result: true}
    end
    # profile_data = params[:id]
    # render json: profile_data
  end
end
