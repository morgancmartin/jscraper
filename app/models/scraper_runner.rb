class ScraperRunner

  def locations
    {
      'Georgia' => ['Atlanta', 'Savannah', 'Columbus', 'Athens', 'Sandy Springs', 'Macon', 'Roswell', 'Albany', 'Johns Creek', 'Warner Robins'],
      'Florida' => ['Miami', 'Jacksonville', 'Tampa', 'Orlando', 'Saint Petursburg', 'Hialeah', 'Tallahassee', 'Fort Lauderdale', 'Port Saint Lucie', 'Pembroke Pines'],
      'North Carolina' => ['Charlotte', 'Raleigh', 'Greensboro', 'Durham', 'Winston-Salem', 'Fayetteville', 'West Raleigh', 'Cary', 'Wilmington', 'High Point'],
      'Tennessee' => ['Memphis', 'Nashville', 'New South Memphis', 'Knoxville', 'Chattanooga', 'East Chattanooga', 'Clarksville', 'Murfreesboro', 'Jackson', 'Johnson City'],
      'DC' => ['Washington'],
      'Maryland' => ['Baltimore', 'Columbia', 'Germantown', 'Silver Spring', 'Waldorf', 'Glen Burnie', 'Ellicott City', 'Frederick'],
      'Kentucky' => ['Louisville', 'Lexington', 'Bowling Green', 'Owensboro', 'Covington', 'Hopkinsville', 'Richmond', 'Georgetown', 'Elizabethtown'],
      'Virginia' => ['Virginia Beach', 'Norfolk', 'Chesapeake', 'Richmond', 'Newport News', 'East Hampton', 'Alexandria', 'Hampton', 'Portsmouth Heights'],
      'Louisiana' => ['New Orleans', 'Baton Rouge', 'Shreveport', 'Metairie Terrace', 'Metairie', 'Lafayette', 'Lake Charles', 'Kenner', 'Bossier City', 'Monroe'],
      'Alabama' => ['Birmingham', 'Montgomery', 'Mobile', 'Huntsville', 'Tuscaloosa', 'Hoover', 'Dothan', 'Decatur', 'Auburn', 'Madison'],
      'California' => ['San Francisco', 'Los Angeles', 'San Diego', 'San Jose', 'Freson', 'Sacramento', 'Long Beach', 'Oakland', 'Bakersfield', 'Anaheim', 'Santa Ana', 'Riverside', 'Stockton', 'Chula Vista', 'Irvine', 'Fremont', 'San Bernadino', 'Modesto', 'Fontana', 'Oxnard', 'Moreno Valley', 'Huntington Beach', 'Glendale', 'Santa Clarita', 'Oceanside', 'Garden Grove', 'Rancho Cucamonga', 'Santa Rosa', 'Ontario', 'Elk Grove', 'Corona', 'Lancaster', 'Palmdale', 'Hayward', 'Salinas', 'Pomona', 'Sunnyvale', 'Escondido', 'Torrance', 'Pasadena', 'Orange', 'Fullerton', 'Roseville', 'Visalia', 'Thousand Oaks', 'Concord', 'Simi Valley', 'Santa Clara', 'Victorville', 'Vallejo', 'Berkely', 'El Monte', 'Downey', 'Carlsbad', 'Costa Mesa', 'Fairfield', 'Temecula', 'Inglewood', 'Antioch', 'Murrieta', 'Richmond', 'Ventura', 'West Covina', 'Norwalk', 'Daly City', 'Burbank', 'Santa Maria', 'Clovis', 'El Cajon', 'San Mateo', 'Rialto', 'Vista', 'Jurupa Valley', 'Compton', 'Mission Viejo', 'Vacaville', 'South Gate', 'Hesperia', 'Carson', 'Santa Monica', 'San Marcos', 'Westminster', 'Santa Barbara', 'Redding', 'San Leandro', 'Chico', 'Hawthorne', 'Livermore', 'Indio', 'Whittier', 'Menifee', 'Newport Beach', 'Tracy', 'Citrus Heights', 'Chino', 'Alhambra', 'Redwood City', 'Hemet', 'Buena Park', 'Lake Forest'],
      'Washington' => ['Seattle'],
      'New York' => ['New York'],
      'Massachusetts' => ['Boston'],
      'Illinois' => ['Chicago'],
      'Utah' => ['Salt Lake']
    }
  end

  def search_terms
    [
      'Web Developer',
      'Junior Developer',
      'Rails Developer',
      'Full Stack Developer'
    ]
  end

  def scrapers
    [
      IndeedScraper.new,
      DiceScraper.new
    ]
  end

  def run
    puts 'scraping...'
    locations.each do |state, cities|
      cities.each do |city|
        search_terms.each do |search_term|
          scrapers.each do |scraper|
            sleep(rand / 2)
            options = { city: city, state: state, search_term: search_term }
            scraper.options = options
            scraper.run
          end
        end
      end
    end
  end
end
