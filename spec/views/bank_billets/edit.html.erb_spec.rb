require 'rails_helper'

RSpec.describe "bank_billets/edit", type: :view do
  let(:bank_billet) {
    BankBillet.create!()
  }

  before(:each) do
    assign(:bank_billet, bank_billet)
  end

  it "renders the edit bank_billet form" do
    render

    assert_select "form[action=?][method=?]", bank_billet_path(bank_billet), "post" do
    end
  end
end
