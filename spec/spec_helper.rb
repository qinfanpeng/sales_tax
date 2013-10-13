require 'sales_tax'
require 'factory_girl'
FactoryGirl.find_definitions

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.order = 'mtime'

  # Include Factory Girl syntax to simplify calls to factories
  config.include FactoryGirl::Syntax::Methods
end
