class Api::V1::ExchangeRequestsController < Api::V1::ApplicationController

  def index
    profile = Profile.find(1)

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
      # student_id = exchange_request.responder_id == user.id ? exchange_request.requester_id : exchange_request.responder_id
      # student = Profile.find(student_id)
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
              url: api_v1_exchange_request_url(exchange_request)
            }
      request_data << data
    end
    return request_data
  end

  def create
    if params[:process] == 'changeUSerStatus'
      exchange_request = ExchangeRequest.find(params[:id])
      if params[:userID] == exchange_request.requester_id
        exchange_request.update!(requester_status: params[:newStatus])
      else
        exchange_request.update!(responder_status: params[:newStatus])
      end
    elsif params[:process] == 'approved'
      puts params
      exchange_request = ExchangeRequest.find(params[:id])
      if params[:approved]
        exchange_request.update!(approved_by_responder: true, responder_status: 1, requester_status: 1, status:"process")
      else
        exchange_request.update!(approved_by_responder: false, status:"rejected")
      end
    elsif params[:process] == 'create'
      puts params
      @exchange_request = ExchangeRequest.create!(
        requester_id: params[:userID],
        requester_minor_id: Profile.find(params[:userID]).minor.id,
        responder_id: params[:student_id],
        responder_minor_id: params[:id],
        exchange_minor_id: params[:id],
        status: 'start'
      #   # approved_by_responder: null,
      )
    end
  end
end
