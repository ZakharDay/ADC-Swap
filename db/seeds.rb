require 'curb'

@minor_list_url = 'https://electives.hse.ru/catalog2019'
@minor_start_year = 2020
@program_list_url = 'https://www.hse.ru/education/'
@piter_minor_list = []

def seed
  clean_db
  get_program_list
  get_minor_list

  create_user(1)
  create_user(2)

  create_exchange_minor(Profile.first)
  create_exchange_minor(Profile.last)
  create_exchange_request
  # approve_exchange_request

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
            spb_minors(@url)
            puts @piter_minor_list
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

  if text_html
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

    if responsible_block
      if responsible_block.content
        responsible = responsible_block.content.strip

        puts responsible

        minor = organisation.minors.create!(
          city_id: city.id,
          name: name,
          description: 'Заполнить руками',
          start_year: @minor_start_year,
          responsible: responsible,
          url: url,
          details_url: details_url,
          notice: true
        )

        puts "Minor just created with id #{minor.id}"
      end
    end
  end

  # credits
  # address
end

def spb_minors(url)
  html = Curl.get(url)
  body_html = Nokogiri::HTML(html.body_str)
  items = body_html.css('.b-row__item')
  i = 0
  items.each do |item|
    unless i==0 || i==1
      y = 0
      item.children.each do |entry|
        if entry.name == 'div' && y==5
          entry.children.each do |div_entry|
            j = 0
            if div_entry.name = 'p'
              div_entry.children.each do |paragraph_entry|
                if paragraph_entry.name == "strong"
                  paragraph_entry.children.each do |a|
                    if a.name == 'a'
                      a.each do |a_it|
                        if j == 0
                          @piter_minor_list.push(a.content)
                          create_spb_minors(a[:href], a.content)
                        end
                        j+=1
                      end
                    end
                  end
                end
              end
            end
          end
        end
        y += 1
      end
    end
    i += 1
  end
end

def create_spb_minors(url, name)
  html = Curl.get(url)
  body_html = Nokogiri::HTML(html.body_str)
  content = body_html.css('.content__inner')
  promo = content.css('.button')


  responsible = ""
  details_url = ""
  description = ""
  organisation = ""


  i=0
  y=0
  content.children.each do |child|
    # puts child
    if child.name == 'div'
      div_classes = child[:class].gsub(/\s+/m, ' ').strip.split(" ")
      div_classes.each do |div_class|
        if div_class == 'builder-section--with_indent0'
          child.children.each do |p|
            if p.name == 'p'
              if i==0
                p.children.each do |point|
                  if point.name == 'a'
                    organisation = find_or_create_organisation(point.content, point[:href])
                    puts organisation.name
                  end
                end
              elsif i==1
                description = p.content
                i+=1
              end
              i+=1
            end
          end
        elsif div_class == 'builder-section' && div_classes.count == 1
          if y==0
            child.children.each do |children|
              if children.name == 'h4'
                children.children.each do |a|
                  responsible = a.content
                end
              end
            end
            y+=1
          end
        end
      end
    elsif child.name == 'p'
      child.children.each do |point|
        if point.name == 'a'
          details_url =  point[:href]
        end
      end
    end
  end

  if i!=0
    if organisation != ''
      minor = organisation.minors.create!(
        city_id: @city.id,
        name: name,
        description: description,
        start_year: @minor_start_year,
        responsible: responsible,
        url: url,
        details_url: details_url,
        notice: @notice
      )
      puts "Mionr created with #{minor.name}"

      create_courses(minor.details_url, minor)
    end
  else
    # minor = organisation.minors.create!(
    #   city_id: @city.id,
    #   name: name,
    #   description: description,
    #   start_year: @minor_start_year,
    #   responsible: responsible,
    #   url: url,
    #   details_url: details_url,
    #   notice: true
    # )
    puts "Error"
  end
end

def create_courses(url, minor)
  page = Nokogiri::HTML(open(url))
  links = page.css('a').map{ |sublink| sublink['href']}

  courses = []


  links.each do |sublink|
    if sublink
      if sublink.include? "hse.ru/edu/"
        courses.push(sublink)
      end
    end
  end

  courses.each do |course|
    get_cours_information(course, minor)
  end

end

def get_cours_information(url, minor)
  page = Nokogiri::HTML(open(url))
  courses_info = {}
  page.css('.with-indent1').each do |div_cont|
    class_arr = div_cont[:class].gsub(/\s+/m, ' ').strip.split(" ")
    if class_arr.length == 1
      div_text = div_cont.text
      div_text = div_text.sub! "\n", ""
      prop_name, prop_val = div_text.split(':')
      courses_info[prop_name] = prop_val
    end
  end

  course_create(courses_info, url, minor)
end

def course_create(course, course_url, minor)
  url= course_url
  credits = [course["Кредиты"][0], course["Кредиты"][3]]
  name = ''
  year = 0
  organisation_id = minor.organisation.id
  minor_id = minor.id
  mobules = course["Когда читается"]

  puts credits[0]

  puts "00000000000000000000000000"
  puts credits, organisation_id, minor_id, mobules, url
  # course = Courses.create!(name: name, year:year, organisation_id:organisation_id, minor_id:minor_id, modules:mobules, url:url)
end

def find_or_create_organisation(name, url)
  organisation = Organisation.create_with(url: url).find_or_create_by!(name: name)
  puts "Organisation just created with id #{organisation.id}"

  return organisation
end

def create_user(number)
  u = User.create!(email: "test#{number}@edu.hse.ru", password: '1111', password_confirmation: '1111')
  puts "User just created with id #{u.id}"

  create_profile(u)
end

def create_profile(user)
  p = Profile.create!(
    education_year: 2,
    program_id: Program.first.id,
    minor_id: Minor.first.id,
    user_id: user.id,
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
    minor_id: profile.minor_id,
    published: true,
    
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
    status: 'start',
    approved_by_responder: false,
  )

  puts "ExchangeRequest just created with id #{e.id} and is not approved #{e.approved_by_responder}"
end

# def approve_exchange_request
#   e = ExchangeRequest.first
#   e.update_attribute(:approved_by_responder, true)
#
#   puts "ExchangeRequest with id #{e.id} just updated and is not approved #{e.approved_by_responder}"
# end

seed
