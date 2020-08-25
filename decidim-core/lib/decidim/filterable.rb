# frozen_string_literal: true

module Decidim
  module Filterable
    extend ActiveSupport::Concern

    included do
      scope :official_origin, lambda {
        where(decidim_author_type: "Decidim::Organization")
      }

      scope :user_group_origin, lambda {
        where(decidim_author_type: "Decidim::UserBaseEntity")
          .where.not(decidim_user_group_id: nil)
      }

      scope :citizens_origin, lambda {
        where(decidim_author_type: "Decidim::UserBaseEntity")
          .where(decidim_user_group_id: nil)
      }
    end
  end
end
