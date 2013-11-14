require 'spec_helper'

describe Track do
  it { should have_db_column(:position).of_type(:integer).with_options(null: false) }
  it { should have_db_column(:name).of_type(:string).with_options(null: false) }
  it { should belong_to(:album) }
  it { should validate_presence_of(:name) }
end
