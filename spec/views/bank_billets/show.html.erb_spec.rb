require 'rails_helper'

RSpec.describe "bank_billets/show", type: :view do
  before(:each) do
    assign(:bank_billet, BankBillet.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
