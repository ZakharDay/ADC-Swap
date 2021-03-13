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
    exchange_request_data[:requests_for_profile_data] = filling_index_data(requests_for_profile)

    requests_from_profile = ExchangeRequest.where requester_id: profile.id
    exchange_request_data[:requests_from_profile_data] = filling_index_data(requests_from_profile)

    render json: exchange_request_data
  end

  def show
    exchange_request = ExchangeRequest.find(params[:id])
    exchange_request_data = { data: exchange_request, messages: exchange_request.messages}
    render json: exchange_request_data
  end

  def filling_index_data(requests)
    request_data = []
    requests.each do |exchange_request|
      data = {requester_id: exchange_request.requester_id,
              requester_minor_id: exchange_request.requester_minor_id,
              responder_id: exchange_request.responder_id,
              responder_name: Profile.find(exchange_request.responder_id).first_name,
              responder_minor_id: exchange_request.responder_minor_id,
              responder_minor_name: Minor.find(Profile.find(exchange_request.responder_id).minor_id).name,
              exchange_minor_id: exchange_request.exchange_minor_id,
              approved_by_responder: exchange_request.approved_by_responder,
              url: api_v1_exchange_request_url(exchange_request)
            }
      request_data << data
    end
    return request_data
  end
end
