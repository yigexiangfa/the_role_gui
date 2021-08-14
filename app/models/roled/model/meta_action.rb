module Roled
  module Model::MetaAction
    extend ActiveSupport::Concern

    included do
      has_many :role_rules, ->(o) { where(controller_path: o.controller_path) }, foreign_key: :action_name, primary_key: :identifier, dependent: :delete_all
      has_many :roles, through: :role_rules
    end

    def role_path
      {
        business_identifier.to_s => {
          namespace_identifier.to_s => {
            controller_path => { action_name => id }
          }
        }
      }
    end

  end
end
