require 'curb'

@minor_list_url = 'https://electives.hse.ru/catalog2019'
@program_list_url = 'https://www.hse.ru/education/'

def seed
  # get_minor_list
  clean_db
  get_program_list
  #
  # create_organisation
  # create_program
  # create_minor
  #
  # create_course(
  #   'Восточная Азия: цивилизации и современные процессы в обществе',
  #   2020,
  #   [1, 2],
  #   'https://www.hse.ru/edu/courses/416019985'
  # )
  #
  # create_course(
  #   'Южная и Юго-Восточная Азия: духовная культура',
  #   2020,
  #   [3, 4],
  #   'https://www.hse.ru/edu/courses/416017184'
  # )
  #
  # create_course(
  #   'Южная и Юго-Восточная Азия: экономика и политика',
  #   2021,
  #   [1, 2],
  #   'https://www.hse.ru/edu/courses/346231893'
  # )
  #
  # create_course(
  #   'Деловая культура и бизнес стратегии в Азии',
  #   2021,
  #   [3, 4],
  #   'https://www.hse.ru/edu/courses/346231673'
  # )
  #
  # create_user(1)
  # create_user(2)
  #
  # create_exchange_minor(Profile.first)
  # create_exchange_minor(Profile.last)
  # create_exchange_request
  # approve_exchange_request
end

def clean_db
  Rake::Task['db:drop'].invoke
  Rake::Task['db:create'].invoke
  Rake::Task['db:migrate'].invoke
end

def get_program_list
  @city = ''
  @organisasion = ''
  @name = ''
  @url = ''

  html = Curl.get(@program_list_url)
  body_html = Nokogiri::HTML(html.body_str)
  post_text_html = body_html.css('.edu-programm__bachelor')

  post_text_html.children.each do |group|
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
                @organisasion = Organisation.find_or_create_by!(name: entry.css('.grey')[0].content)
              end
            end

            program = Program.create!(
              name: @name,
              url: @url,
              city_id: @city.id,
              organisation_id: @organisasion.id
            )

            puts "Program just created with id #{program.id}"
          end
        end
      end
    end
  end
end

# def get_minor_list
#   @city = ''
#   @faculty = ''
#
#   html = Curl.get(@minor_list_url)
#   body_html = Nokogiri::HTML(html.body_str)
#   post_text_html = body_html.css('.post__text')
#
#   post_text_html.children.each do |entry|
#     puts entry.name
#
#     if entry.name == 'h3'
#       @city = entry.content.split.map(&:capitalize).join(' ')
#       puts @city
#     end
#
#     if entry.name == 'h4'
#       @faculty = entry.content.capitalize
#       puts @faculty
#     end
#
#     if entry.name == 'p'
#       entry.children.each do |paragraph_entry|
#         if paragraph_entry.name == 'a'
#           puts @city
#           puts @faculty
#           name = paragraph_entry.content
#           url = paragraph_entry[:href]
#
#           # City
#           # name
#
#           # Faculty
#           # name
#
#           # Как поправить Санкт-Петербург
#
#           # Вывести по группам, как на сайте Вышки
#
#           minor = Minor.create!(city: @city, faculty: @faculty, name: name, url: url)
#
#           puts name
#           puts url
#           puts minor.id
#         end
#       end
#     end
#
#     puts "========="
#   end
# end

def create_organisation
  o = Organisation.create!(
    name: 'Департамент зарубежного регионоведения',
    url: 'https://we.hse.ru/irs/'
  )

  puts "Organisation just created with id #{o.id}"
end

def create_program
  organisation = Organisation.first

  p = organisation.programs.create!(
    name: 'Какая-то там программа',
    url: 'Какая-то ссылка'
  )

  puts "Program just created with id #{p.id}"
end

def create_minor
  program = Program.first

  m = program.minors.create!(
    start_year: 2019,
    name: 'Азия – модели альтернативной глобализации',
    description: 'Департамент зарубежного регионоведения предлагает уникальную возможность расширить границы своей предметной области в приложении профильных знаний к региональному компоненту.',
    url: 'https://electives.hse.ru/minor_asia/'
  )

  puts "Minor just created with id #{m.id}"
end

def create_course(name, year, modules, url)
  minor = Minor.first
  organisation = Organisation.first

  c = minor.courses.create(
    organisation_id: organisation.id,
    name: name,
    year: year,
    modules: modules,
    url: url
  )

  puts "Course just created with id #{c.id}"
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
