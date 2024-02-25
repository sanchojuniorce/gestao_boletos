require 'rails_helper'

RSpec.describe "bank_billets/index", type: :view do
  before(:each) do
    assign(:bank_billets, [
      BankBillet.create!(),
      BankBillet.create!()
    ])
  end

  it "renders a list of bank_billets" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
  end
end
