require 'spec_helper'

describe Album do
  it { should validate_presence_of(:name) }
  it { should have_db_column(:name).of_type(:string).with_options(null: false) }
  it { should have_db_column(:tracks_count).of_type(:integer).with_options(nil: false, default: 0) }
  it { should have_db_index(:name) }
  it { should belong_to(:artist) }
  it { should have_many(:tracks) }
  it { should have_and_belong_to_many(:users) }
end
