# Flight processor
Flight processor is a Ruby application, which reads flight data form CSV input file, classifies if the flight 
is operating with an IATA or ICAO flight number and outputs results into different file.

## Getting started

Prerequisites
  * Ruby 2.0.0 or later https://www.ruby-lang.org/en/
  * Bundler 1.9.6 or later http://bundler.io/
  * Git 2.4.9 or later https://git-scm.com/

Clone repository
```
$ git clone git@github.com:maciekkolodziej/flight_processor.git
```

Install required gems
```
$ cd flight_processor
$ bundle install
```

Run
```
$ thor fp start
```

More options
```
$ thor fp help start
```

Run tests
```
$ bundle exec rspec
```

## Options
Change input file path
```
$ thor fp start -i sample/input.csv
```

Change output file path
```
$ thor fp start -o sample/output.csv
```

Quiet mode
```
$ thor fp start -q
```
