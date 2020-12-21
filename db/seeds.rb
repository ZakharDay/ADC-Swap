require 'curb'

@minor_list_url = 'https://electives.hse.ru/catalog2019'
@minor_start_year = 2020
@program_list_url = 'https://www.hse.ru/education/'
@piter_minor_list = ''

def seed
  clean_db
  get_program_list
  get_minor_list

  create_user(1)
  create_user(2)

  create_exchange_minor(Profile.first)
  create_exchange_minor(Profile.last)
  create_exchange_request
  approve_exchange_request

  create_wished_minors
end

def clean_db
  Rake::Task['db:drop'].invoke
  Rake::Task['db:create'].invoke
  Rake::Task['db:migrate'].invoke
end

def get_program_list
  @city = ''
  @organisation = ''
  @name = ''
  @url = ''

  html = Curl.get(@program_list_url)
  body_html = Nokogiri::HTML(html.body_str)
  text_html = body_html.css('.edu-programm__bachelor')

  # puts body_html
  # puts text_html

  text_html.children.each do |group|
    group.children.each do |entry|
      if entry.name == 'div'
        entry.children.each_with_index do |row, index|
          if index == 0
            row.children.each do |entry|
              if entry.name == 'a'
                @name = entry.content
                @url = entry['href']
              elsif entry.name == 'div'
                @city = City.find_or_create_by!(name: entry.css('.edu-programm__city')[0].content)
                @organisation = Organisation.find_or_create_by!(name: entry.css('.grey')[0].content)
              end
            end

            program = Program.create!(
              name: @name,
              url: @url,
              city_id: @city.id,
              organisation_id: @organisation.id
            )

            puts "Program just created with id #{program.id}"
          end
        end
      end
    end
  end
end

def get_minor_list
  @city = ''
  @program = ''
  @organisation

  @name = ''
  @description
  @url = ''

  html = Curl.get(@minor_list_url)
  body_html = Nokogiri::HTML(html.body_str)
  text_html = body_html.css('.post__text')

  text_html.children.each do |entry|
    if entry.name == 'h3'
      city_name = entry.content.downcase
      @city = City.where("LOWER(name) = ?", city_name)[0]
    end

    if entry.name == 'p'
      entry.children.each do |paragraph_entry|
        if paragraph_entry.name == 'a'
          @name = paragraph_entry.content
          @url = paragraph_entry[:href]

          if @city.name.downcase == 'санкт-петербург'
            @piter_minor_list = @url
          else
            get_minor(@city, @name, @url)
          end
        end
      end
    end
  end
end

def get_minor(city, name, url)
  @notice = false

  html = Curl.get(url)
  body_html = Nokogiri::HTML(html.body_str)
  text_html = body_html.css('.lead-in a')[0]

  unless text_html
    text_html = body_html.css('.builder-section.builder-section--with_indent0 p:first-child a')[0]
  end

  organisation = find_or_create_organisation(text_html.content, text_html[:href])

  description_block = body_html.css('.lead-in + p')[0]

  if description_block
    description = description_block.content
  else
    description = 'Занести руками'
    @notice = true
  end

  details_url = body_html.css('.promo-section a')[0][:href]

  puts name
  puts organisation.name

  responsible_block = body_html.css('.promo-section + div .link_dark2')[0]

  unless responsible_block
    responsible_block = body_html.css('.promo-section + div + div .link_dark2')[0]

    unless responsible_block
      responsible_block = body_html.css('.promo-section + div + div h4 span')[0]

      unless responsible_block
        responsible_block = body_html.css('.fa-person__item')[0]

        if responsible_block
          responsible_block = responsible_block.css('.fa-person__box a')[0]
        else
          responsible_block = body_html.css('.white-card h3 a')[0]
        end
      end
    end
  end

  # if responsible_block && responsible_block.css('.span')[0]
    # puts "TRUE"
    # responsible_block = responsible_block.css('.span')[0].remove
    # responsible_block.search('span').each(&:remove)
  # end

  responsible = responsible_block.content.strip

  puts responsible

  minor = organisation.minors.create!(
    city_id: city.id,
    name: name,
    description: description,
    start_year: @minor_start_year,
    responsible: responsible,
    url: url,
    details_url: details_url,
    notice: @notice
  )

  puts "Minor just created with id #{minor.id}"

  # credits
  # address
end

def find_or_create_organisation(name, url)
  organisation = Organisation.create_with(url: url).find_or_create_by!(name: name)
  puts "Organisation just created with id #{organisation.id}"

  return organisation
end

def create_user(number)
  u = User.create!(email: "test#{number}@test.com", password: 'testtest', password_confirmation: 'testtest')
  puts "User just created with id #{u.id}"

  create_profile(u)
end

def create_profile(user)
  p = Profile.create!(
    first_name: 'first_name',
    middle_name: 'middle_name',
    last_name: 'last_name',
    education_year: 2,
    program_id: Program.first.id,
    minor_id: Minor.first.id,
    user_id: user.id,
    published: true,
  )

  puts "Profile just created with id #{p.id} for user with id #{p.user.id}"
end

def create_wished_minors
  profiles = Profile.all

  profiles.each do |profile|
    minors = Minor.all.sample(3)

    minors.each do |minor|
      w = WhishedMinor.create!(profile_id: profile.id, minor_id: minor.id)
      puts "WhishedMinor just created with id #{w.id}"
    end
  end
end

def create_exchange_minor(profile)
  e = profile.exchange_minors.create!(
    minor_id: profile.minor_id
  )

  puts "ExchangeMinor just created with id #{e.id}"
end

def create_exchange_request
  exchange_minor = ExchangeMinor.first
  first_user = User.first
  second_user = User.last

  e = ExchangeRequest.create!(
    requester_id: first_user.id,
    requester_minor_id: first_user.profile.minor_id,
    responder_id: second_user.id,
    responder_minor_id: second_user.profile.minor_id,
    exchange_minor_id: exchange_minor.id,
    approved_by_responder: false,
  )

  puts "ExchangeRequest just created with id #{e.id} and is not approved #{e.approved_by_responder}"
end

def approve_exchange_request
  e = ExchangeRequest.first
  e.update_attribute(:approved_by_responder, true)

  puts "ExchangeRequest with id #{e.id} just updated and is not approved #{e.approved_by_responder}"
end

seed
