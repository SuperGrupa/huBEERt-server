require 'rails_helper'

RSpec.describe Address, :type => :model do
    describe 'validations' do
        it { should validate_presence_of :postcode }
        it { should validate_presence_of :number   }
        it { should     allow_value('00-999').for(:postcode)  }
        it { should_not allow_value('4w-999').for(:postcode)  }
        it { should_not allow_value('11_999').for(:postcode)  }
        it { should_not allow_value('000-999').for(:postcode) }
    end
end
