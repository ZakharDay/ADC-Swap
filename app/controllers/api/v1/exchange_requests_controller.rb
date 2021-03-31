class Api::V1::ExchangeRequestsController < Api::V1::ApplicationController

  def index
    profile_count = User.count
    random_id = rand(profile_count) + 1
    if random_id == 3
      random_id = 2
    end

    profile = Profile.find(random_id)

    exchange_request_data = {requests_for_profile_data: {}, requests_from_profile_data: {}, profile_id: profile.id}

    requests_for_profile = ExchangeRequest.where responder_id: profile.id
    exchange_request_data[:requests_for_profile_data] = filling_index_data(requests_for_profile, profile)

    requests_from_profile = ExchangeRequest.where requester_id: profile.id
    exchange_request_data[:requests_from_profile_data] = filling_index_data(requests_from_profile, profile)

    render json: exchange_request_data
  end

  def show
    exchange_request = ExchangeRequest.find(params[:id])
    exchange_request_data = { data: exchange_request, messages: exchange_request.messages}
    render json: exchange_request_data
  end



  def filling_index_data(requests, user)
    request_data = []
    requests.each do |exchange_request|
      student_id = exchange_request.responder_id == user.id ? exchange_request.requester_id : exchange_request.responder_id
      student = Profile.find(student_id)
      data = {
              id: exchange_request.id,
              requester_id: exchange_request.requester_id,
              requester_status: exchange_request.requester_status,
              requester_minor_id: exchange_request.requester_minor_id,
              responder_id: exchange_request.responder_id,
              responder_status: exchange_request.responder_status,
              responder_minor_id: exchange_request.responder_minor_id,
              responder_minor_name: Minor.find(Profile.find(exchange_request.responder_id).minor_id).name,
              exchange_minor_id: exchange_request.exchange_minor_id,
              approved_by_responder: exchange_request.approved_by_responder,
              status: exchange_request.status,
              student_name: student.first_name,
              url: api_v1_exchange_request_url(exchange_request)
            }
      request_data << data
    end
    return request_data
  end

  def create
    puts '000000000000000000000000000000000000'
    if params[:action] == 'update'
      puts params
    #   exchange_request = ExchangeRequest.find(params[:id])
    #   puts exchange_request
    #   if params[:role] == 'requester'
    #     exchange_request.update!(requester_status: params[:newStatus])
    #   else
    #     exchange_request.update!(responder_status: params[:newStatus])
    #   end
    #   puts exchange_request
    end
  end
end
