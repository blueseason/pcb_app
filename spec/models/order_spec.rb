require 'spec_helper'

describe Order do
  let(:user) { FactoryGirl.create(:user) }
  before do
    @order = user.orders.build(length: 20, width: 15, user_id: user.id)
  end

  subject { @order}
  it { should respond_to(:length) }
  it { should respond_to(:width) }
  it { should respond_to(:user_id) }

  its(:user) { should eq user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @order.user_id = nil }
    it { should_not be_valid }
  end
end
