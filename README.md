## Log parser

Parses multiline file logs that follow the format `/endpoint 1.1.1.1`

## Requirements

- Ruby 2.7.4
- Bundler 2.1.4

## Run
Clone and `cd` to the project folder

Run `bundle install`

Then run `./parser.rb spec/fixtures/webserver.log`

### Running tests and linting:

run `rspec`
or
run `bundle exec rspec`

For linting:

run `rubocop lib/ parser.rb`
or
run `bundle exec rubocop lib/ parser.rb`


`Coverage report generated for RSpec to weblog/coverage. 43 / 43 LOC (100.0%) covered.`

### Troubleshooting

If some permission related issue:
`chmod u+x ./parser.rb`

Make sure you're under the project folder.

## Tested under Ubuntu
Should work well under any UNIX.

## Some explanation

We have some structured (not formally defined but implied) data that is sourced from the local disk file 'webserver.log'.

We want to process this data and extract something out of it. In this case, we want to count unique views.

- The data is sourced from the local disk but it could be sourced from anywhere. It could be sourced from an endpoint we pool each 30s. It could be sourced from some server that pushes it to us through a webhook. It could be sourced from some websocket we constantly listen to.

- We could use stream semantics to process the data. Even if we want to only read log files for now, we'd avoid out-of-memory issues when reading large files by treating it as a stream. For now we'll just stick with whatever Ruby's standard library "File" gives to us.

- For now, we just want to count unique views. But we might want to extract some other information from the data in the future. We might want to know which pages some ipv4 address visits the most, for instance. Other devs might have to work on it. We can make things easier bit by encapsulating the "extract" logic into a "strategy" class and follow a combination of command and strategy design patterns. In this case, the other devs wouldn't have to touch the other files, except for writing a new strategy and maybe connect a command to it. It makes our app stay more in the line of the SOLID principles.

### lib/parser.rb
A parse reads some structured data and turns into a data structure, like an AST. In our case, our Parser.rb turns into a simple data structure we can pass around. Notice how the class doesn't care where the data is coming from or what happens to it. The single responsibility is to turn a string into a data structure.

### ./parser.rb
The script that glues everything together. Takes the command line arguments, checks it, reads the file, feeds the actual Parser with it, feeds the Parser output to the Strategy and prints the result.

### lib/strategies/count_unique_views_strategy.rb
We extracted the logic of what happens to the "data structure" Parser gives us to this class. CountUniqueViewsStrategy expects a array of arrays, the data structure we chose to pass around our app. It then makes something out of it, counting the unique views. It also does something extra which is formatting the data for printing. This "extra" logic could maybe be extracted to a print strategy, but for now we can let the strategy also be concerned about how the data is going to be presented.

## Improvements

- We can use chunking to avoid going out-of-memory when parsing big log files
- Parser can use a regex to better validate the data
- Command pattern with a command line gem can make it easy to have multiple strategies
- We could pass options to strategies so we could implement things like sort by views ascending or descending
- We could use a lib like Sorbet or Dry for type checking. Helps avoiding type errors as the codebase grows, and helps devs figure out what's going on at a few glances