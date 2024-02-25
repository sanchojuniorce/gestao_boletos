require 'rails_helper'

RSpec.describe "bank_billets/new", type: :view do
  before(:each) do
    assign(:bank_billet, BankBillet.new())
  end

  it "renders new bank_billet form" do
    render

    assert_select "form[action=?][method=?]", bank_billets_path, "post" do
    end
  end
end
