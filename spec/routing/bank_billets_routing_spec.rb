require "rails_helper"

RSpec.describe BankBilletsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/bank_billets").to route_to("bank_billets#index")
    end

    it "routes to #new" do
      expect(get: "/bank_billets/new").to route_to("bank_billets#new")
    end

    it "routes to #show" do
      expect(get: "/bank_billets/1").to route_to("bank_billets#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/bank_billets/1/edit").to route_to("bank_billets#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/bank_billets").to route_to("bank_billets#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/bank_billets/1").to route_to("bank_billets#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/bank_billets/1").to route_to("bank_billets#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/bank_billets/1").to route_to("bank_billets#destroy", id: "1")
    end
  end
end
