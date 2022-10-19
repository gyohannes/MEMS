require 'rails_helper'

RSpec.describe UserDecorator do
    
    let(:first_name) {"Abebe"}
    let(:father_name) {"Kebede"}
    let(:grand_father_name) { "Haile" } 

    let(:user) { build(:user) }

    let(:decorator) { user.decorate }

    describe ".full_name" do
        context "with first name, father name and grand father name" do
            it 'should return the full name' do
                expect(decorator.full_name).to eq("#{first_name} #{father_name} #{grand_father_name}")  
            end
        end

        context "without first, father or grand father name" do
            before do
                user.first_name = ''
                user.father_name = ''
                user.grand_father_name = ''
            end
            it 'should return no name provided' do
                expect(decorator.full_name).to eq('No name provided') 
            end
        end
        
        
        
    end
    
end
