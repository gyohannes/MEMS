module API
    module Entities
        class Device < Grape::Entity
            expose :id, :inventory_number, :equipment_name_id, :maintenance_requirement_id, :model, :status_id
        end
    end
    module V1
        class Devices < Grape::API
            rescue_from :all
            before do
                header 'abc', 'test header'
            end
            helpers do
                def logger
                  API::V1.logger
                end
            end
            format :json
            resources :devices do
                desc 'Returns all devices'
                get do
                    #devices = Equipment.all.limit(10)
                    #present devices, with: API::Entities::Device
                end

                desc "Returns a device"
                params do
                    requires :id, type: String, desc: 'Device ID'
                end
                route_param :id do
                    get do
                        device = Equipment.find(params[:id])
                        present device, with: API::Entities::Device
                    end
                end

                desc "Create a device"
                params do
                    requires :inventory_number, type: String, desc: "Device's inventory number"
                    requires :equipment_name_id, type: :String, desc: "Device's generic name"
                    requires :maintenance_requirement_id, type: :String, desc: "Device's maintenance requirement; eg. Monthly, Quarterly"
                    requires :model, type: String, desc: "Device's model"
                    requires :status_id, type: String, desc: "Device's status"
                end
                post do
                    Equipment.create!({
                        inventory_number: params[:inventory_number],
                        equipment_name_id: params[:equipment_name_id],
                        maintenance_requirement_id: params[:maintenance_requirement_id],
                        model: params[:model],
                        status_id: params[:status_id]
                    })
                end

                desc 'Update a device'
                params do
                    requires :id, type: String, desc: 'Device ID'
                    requires :status_id, type: String, desc: 'Device status'
                end
                put ':id' do
                    Equipment.find(params[:id]).update({status_id: params[:status_id]})
                end

                desc 'Delete a device'
                params do
                    requires :id, type: String, desc: 'Device ID'
                end
                delete ':id' do
                    Equipment.find(params[:id]).destroy
                end
                
                params do
                    optional :json, type: JSON do
                        optional :num, type: Integer, values: [1, 2, 3]
                    end
                end
                post 'get_params' do
                    request.body
                end
            end
        end
    end
end