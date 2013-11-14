require 'spec_helper'

describe Artist do
  it { should validate_presence_of(:name) }
  it { should have_db_column(:name).of_type(:string).with_options(null: false) }
  it { should have_db_index(:name) }
  it { should have_many(:albums) }
end
