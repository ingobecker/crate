require 'spec_helper'

describe Track do
  it { should have_db_column(:position).of_type(:integer).with_options(null: false) }
  it { should have_db_column(:name).of_type(:string).with_options(null: false) }
  it { should belong_to(:album) }
  it { should validate_presence_of(:name) }

  describe 'with duration only' do
    before do
      @t = Track.new name: 'Foo', duration: 123
    end

    it 'should generate correct duration_str' do
      expect(@t.duration_str).to eq('00:02:03')
    end

    it 'should not be valid' do
      expect(@t.valid?).to be_false
      expect(@t.errors[:duration_str].count).to eq(1)
    end
  end

  describe 'with duration_str' do
    before do
      @t = Track.new name: 'foo'
    end
    
    describe 'in format mm:ss' do
      it 'should be valid' do
        @t.duration_str = '02:03'
        expect(@t.valid?).to be_true
      end
    end

    describe 'in format hh:mm:ss' do
      it 'should be valid' do
        @t.duration_str = '00:02:03'
        expect(@t.valid?).to be_true
      end
    end

    describe 'blank' do
      it 'should not be valid' do
        @t.duration_str = ""
        expect(@t.valid?).to be_false
      end
    end

    describe 'filled with crap' do
      it 'should not be valid' do
        @t.duration_str = 'f$%&i'
        expect(@t.valid?).to be_false
      end
    end


  end
end
