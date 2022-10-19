require 'rails_helper'

describe '/devices' do
    let(:version) {'v1'}
    context "Get api/:version/devices" do
        it 'responds with status 200' do
            get "/api/#{version}/devices"
            expect(response.status).to eq(200)  
        end
    end
    
end